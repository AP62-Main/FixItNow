import http.server
import socketserver
import os
import mimetypes

PORT = 8080
DIRECTORY = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'build', 'web')

# Ensure standard Flutter web MIME types
mimetypes.add_type('application/javascript', '.js')
mimetypes.add_type('application/wasm', '.wasm')
mimetypes.add_type('application/json', '.json')
mimetypes.add_type('font/otf', '.otf')
mimetypes.add_type('font/ttf', '.ttf')

class FlutterWebHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)

    def end_headers(self):
        # Enable CORS and standard web headers
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Cache-Control', 'no-cache')
        super().end_headers()

    def do_GET(self):
        # SPA routing fallback: if file doesn't exist, serve index.html
        path = self.translate_path(self.path)
        if not os.path.exists(path) or os.path.isdir(path):
            index_path = os.path.join(DIRECTORY, 'index.html')
            if not os.path.exists(path):
                self.path = '/index.html'
        return super().do_GET()

if __name__ == '__main__':
    socketserver.TCPServer.allow_reuse_address = True
    with socketserver.TCPServer(('0.0.0.0', PORT), FlutterWebHandler) as httpd:
        print(f"FixItNow Web Server running at http://localhost:{PORT}")
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            pass
