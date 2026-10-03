import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/provider_model.dart';
import '../models/booking_model.dart';
import '../providers/booking_provider.dart';
import '../theme/app_theme.dart';
import '../utils/validators.dart';
import 'booking_confirmation_screen.dart';

class BookingScreen extends ConsumerStatefulWidget {
  final ProviderModel provider;

  const BookingScreen({super.key, required this.provider});

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _detailsController = TextEditingController();
  
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int _selectedDuration = 1;
  bool _isLoading = false;

  final List<String> _quickTimeSlots = [
    '09:00 AM',
    '11:30 AM',
    '02:00 PM',
    '04:30 PM',
    '06:00 PM',
  ];

  @override
  void initState() {
    super.initState();
    // Default to tomorrow
    _selectedDate = DateTime.now().add(const Duration(days: 1));
    _selectedTime = const TimeOfDay(hour: 10, minute: 0);
  }

  @override
  void dispose() {
    _addressController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  double get _estimatedCost => widget.provider.hourlyRate * _selectedDuration;

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: AppTheme.darkTheme,
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _selectCustomTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: AppTheme.darkTheme,
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  void _setTimeFromSlotString(String slot) {
    try {
      final format = DateFormat.jm();
      final dt = format.parse(slot);
      setState(() {
        _selectedTime = TimeOfDay.fromDateTime(dt);
      });
    } catch (_) {}
  }

  Future<void> _submitBooking() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a date for service appointment'),
          backgroundColor: AppTheme.error,
        ),
      );
      return;
    }
    
    if (_selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a preferred arrival time'),
          backgroundColor: AppTheme.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final bookingId = 'FXN-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';
      
      final booking = BookingModel(
        id: bookingId,
        userId: 'demo-user-123',
        providerId: widget.provider.id,
        providerName: widget.provider.name,
        serviceType: widget.provider.serviceType,
        date: _selectedDate!,
        time: _selectedTime!.format(context),
        address: _addressController.text.trim(),
        durationHours: _selectedDuration,
        hourlyRate: widget.provider.hourlyRate,
        estimatedCost: _estimatedCost,
        additionalDetails: _detailsController.text.trim(),
        status: 'confirmed',
        createdAt: DateTime.now(),
      );

      await ref.read(bookingRepositoryProvider).createBooking(booking);
      
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BookingConfirmationScreen(booking: booking),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to book: $e'),
            backgroundColor: AppTheme.error,
          ),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEE, dd MMM yyyy');

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Schedule Service'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Provider Summary Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.borderColor),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.borderSubtle),
                      ),
                      child: Center(
                        child: Text(
                          widget.provider.name.substring(0, 1),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.provider.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.verified, size: 14, color: AppTheme.primaryColor),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.provider.serviceType,
                            style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '₹${widget.provider.hourlyRate.toInt()}',
                          style: const TextStyle(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const Text(
                          '/ hour',
                          style: TextStyle(color: AppTheme.textDim, fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Date Selection Section
              const Text(
                '1. Select Service Date',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: _selectDate,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppTheme.cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.borderColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_month_outlined, size: 20, color: AppTheme.primaryColor),
                          const SizedBox(width: 12),
                          Text(
                            _selectedDate == null ? 'Choose appointment date' : dateFormat.format(_selectedDate!),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppTheme.textSecondary),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Time Selection Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '2. Select Preferred Time',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                      letterSpacing: -0.2,
                    ),
                  ),
                  TextButton(
                    onPressed: _selectCustomTime,
                    child: const Text('Custom Time', style: TextStyle(color: AppTheme.primaryColor, fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _quickTimeSlots.map((slot) {
                  final isSelected = _selectedTime != null && _selectedTime!.format(context) == slot;
                  return InkWell(
                    onTap: () => _setTimeFromSlotString(slot),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.primaryGlow : AppTheme.cardColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected ? AppTheme.primaryColor : AppTheme.borderColor,
                        ),
                      ),
                      child: Text(
                        slot,
                        style: TextStyle(
                          color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondary,
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              // Duration Chips
              const Text(
                '3. Estimated Job Duration',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [1, 2, 3, 4, 5].map((hours) {
                  final isSelected = _selectedDuration == hours;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedDuration = hours),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? AppTheme.primaryGlow : AppTheme.cardColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected ? AppTheme.primaryColor : AppTheme.borderColor,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${hours}h',
                            style: TextStyle(
                              color: isSelected ? AppTheme.primaryColor : AppTheme.textPrimary,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              // Service Address Input
              const Text(
                '4. Service Address',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _addressController,
                style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'e.g. Flat 402, Skyline Residency, 5th Main Road',
                  prefixIcon: Icon(Icons.location_on_outlined, color: AppTheme.textSecondary, size: 20),
                ),
                maxLines: 2,
                validator: Validators.validateAddress,
              ),

              const SizedBox(height: 20),

              // Problem Details Prompt Input (ChatGPT style)
              const Text(
                '5. Describe the Issue (Optional)',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _detailsController,
                style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'e.g. The circuit breaker trips when running the geyser...',
                  prefixIcon: Icon(Icons.edit_note_rounded, color: AppTheme.textSecondary, size: 20),
                ),
                maxLines: 3,
              ),

              const SizedBox(height: 28),

              // Dynamic Cost Calculation Card
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppTheme.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.borderColor),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Rate per hour', style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
                        Text('₹${widget.provider.hourlyRate.toInt()}', style: const TextStyle(color: AppTheme.textPrimary, fontSize: 13, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Duration selected', style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
                        Text('$_selectedDuration hour${_selectedDuration > 1 ? 's' : ''}', style: const TextStyle(color: AppTheme.textPrimary, fontSize: 13, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Inspection & Safety Kit Fee', style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
                        Text('FREE', style: TextStyle(color: AppTheme.primaryColor, fontSize: 13, fontWeight: FontWeight.w700)),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(color: AppTheme.borderColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Estimated Total', style: TextStyle(color: AppTheme.textPrimary, fontSize: 15, fontWeight: FontWeight.w700)),
                        Text(
                          '₹${_estimatedCost.toInt()}',
                          style: const TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitBooking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isLoading 
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Confirm & Dispatch Booking'),
                            SizedBox(width: 8),
                            Icon(Icons.check_circle_outline, size: 18),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }
}
