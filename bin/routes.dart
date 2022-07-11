import 'cumulus/context.dart';
import 'cumulus/enums.dart';
import 'cumulus/route.dart';
import 'roles.dart';

String? middleware1(Context c) {
  // Do stuff in here like authorization, logging
  // If you return a value from here, no subsequent routes will be processed.
  print('Middleware ran!');
  // return 'Middleware test';
  print(c.roles);
  return null;
}

String? before(Context c) {
  print('Before ran');
  // return 'before';
  return null;
}

String? after(Context c) {
  print('After ran');
  return 'after';
}

List<Route> routes = [
  Route(
    method: HttpMethod.GET,
    path: '/kenobi',
    handler: (c) => 'So uncivilized',
    middleware: [middleware1],
    before: [before],
    after: [after],
    roles: [Roles.loggedIn],
  ),
  Route(
    path: '/grevious',
    handler: (c) => 'YOU ARE A BOLD ONE',
    method: HttpMethod.GET,
    middleware: [middleware1],
    before: [before],
    after: [after],
  ),
];
