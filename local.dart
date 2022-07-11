import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'bin/cumulus/cumulus.dart';
import 'bin/routes.dart';

void main() async {
  var handler = const Pipeline().addMiddleware(logRequests()).addHandler(_handleRequest);
  var server = await shelf_io.serve(handler, 'localhost', 10000);
  print('Testing Cumulus at http://${server.address.host}:${server.port}');
}

Future<Response> _handleRequest(Request request) async {
  Cumulus app = Cumulus.fromShelf(request, routes);
  return await app.getShelfResponse();
}
