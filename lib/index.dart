import 'package:pharaoh/pharaoh.dart';
import 'package:shelf_enforces_ssl/shelf_enforces_ssl.dart';

void main() async {
  try {
    Pharaoh()
      ..use(useShelfMiddleware(enforceSSL()))
      ..use((req, res, next) {
        print(res.contentLength);
        print(res.body?.contentLength);
        next();
      })
      ..get('/hello', (_, res) {
        print(res.contentLength);
        return res.ok('Hello, World!');
      })
      ..listen();
  } catch (e, str) {
    print(e);
    print(str);
  }
}
