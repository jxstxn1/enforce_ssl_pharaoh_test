import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_enforces_ssl/shelf_enforces_ssl.dart';

void main() async {
  final handler = const Pipeline()
      .addMiddleware(
        enforceSSL(
          errorResponse: Response(
            403,
            body: 'Only use HTTPS when you try to send data to this API',
          ),
        ),
      )
      .addMiddleware(logRequests())
      .addHandler(_echoRequest);

  final server = await shelf_io.serve(handler, 'localhost', 8080);

  // Enable content compression
  server.autoCompress = true;

  print('Serving at http://${server.address.host}:${server.port}');
}

Response _echoRequest(Request request) =>
    Response.ok('Request for "${request.url}"');
