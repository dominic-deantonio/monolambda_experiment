import 'package:aws_lambda_dart_runtime/events/alb_event.dart';
import 'package:shelf/src/request.dart' as Shelf;
import 'package:shelf/src/response.dart' as Shelf;

import 'context.dart';
import 'convert.dart';
import 'request.dart';
import 'response.dart';
import 'route.dart';

class Cumulus {
  final AwsALBEvent _event;
  late final Context _context;
  late final Map<String, Route> routes = {};

  Cumulus(this._event) {
    this._context = Context(request: Request.fromAwsALBEvent(_event));
  }

  static Cumulus fromShelf(Shelf.Request request, Iterable<Route> routes) => Cumulus(Convert.toAwsALBEvent(request))..addRoutes(routes);

  Future<Response> _respond() async {
    Route? route = _getRoute();
    if (route == null) return Response.notFound();
    await route.process(_context);
    return _context.response;
  }

  void addRoutes(Iterable<Route> routes) => routes.forEach((route) => this.routes[route.key] = route);

  void addRoute(Route route) => addRoutes([route]);

  Future<AwsALBResponse> getAwsAlbResponse() async => (await _respond()).toAwsAlbResponse();

  Future<Shelf.Response> getShelfResponse() async => (await _respond()).toShelfResponse();

  Route? _getRoute() {
    // Should improve this in the future to support real URI schemes
    String key = Convert.toRouteKey(_context.requestMethod, _context.path);
    return routes[key];
  }
}
