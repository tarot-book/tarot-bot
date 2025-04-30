// test/server_test.dart
import 'package:test/test.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:http/http.dart' as http;

void main() {
  test('GET /webhook returns ok', () async {
    final router = Router()
      ..get('/webhook', (Request req) => Response.ok('ok'));

    final server = await io.serve(router.call, 'localhost', 0);
    final url = Uri.parse('http://localhost:${server.port}/webhook');

    final response = await http.get(url);
    expect(response.statusCode, equals(200));
    expect(response.body, equals('ok'));

    await server.close();
  });

  test('POST /webhook returns ok for any payload', () async {
    final router = Router()
      ..post('/webhook', (Request req) async {
        await req.readAsString();
        return Response.ok('ok');
      });

    final server = await io.serve(router.call, 'localhost', 0);
    final url = Uri.parse('http://localhost:${server.port}/webhook');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: '{}',
    );
    expect(response.statusCode, equals(200));
    expect(response.body, equals('ok'));

    await server.close();
  });
}
