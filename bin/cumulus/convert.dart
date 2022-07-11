import 'package:aws_lambda_dart_runtime/events/alb_event.dart';
import 'package:shelf/src/request.dart' as Shelf;
import 'package:shelf/src/response.dart' as Shelf;

import 'enums.dart';
import 'response.dart';

class Convert {
  static AwsALBResponse toAlbResponse(Response response) {
    return AwsALBResponse(
      body: response.body,
      statusCode: response.statusCode,
      isBase64Encoded: false,
      headers: response.headers,
    );
  }

  static Shelf.Response toShelfResponse(Response response) {
    return Shelf.Response(
      response.statusCode,
      body: response.body,
      headers: Map.castFrom(response.headers),
    );
  }

  static AwsALBEvent toAwsALBEvent(Shelf.Request request) {
    String body = '';
    request.readAsString().then((shelfBody) => body = shelfBody);
    return AwsALBEvent.fromJson({
      'context': null,
      'httpMethod': request.method,
      'path': '/${request.url.path}',
      'headers': request.headers,
      'queryStringParameters': request.url.queryParameters,
      'body': body,
      'isBase64Encoded': false,
    });
  }

  static String toRouteKey(HttpMethod m, String path) => '${m.toShortString()}-$path';
}
