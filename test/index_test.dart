import 'package:spookie/spookie.dart';
import 'package:pharaoh_test/index.dart' as app;

void main() {
  group('no ssl', () {
    setUpAll(() => app.main());

    test('GET request results in a Staus Code of 301', () async {
      final uri = Uri(scheme: 'http', host: 'localhost', port: 3000);

      await Spookie.uri(uri).get('/test').expectStatus(301).test();
    });

    test('GET request results in a Staus Code of 200', () async {
      final uri = Uri(scheme: 'https', host: 'localhost', port: 3000);

      await Spookie.uri(uri).get('/test').expectStatus(200).test();
    });
  });
}
