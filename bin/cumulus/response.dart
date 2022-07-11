import 'dart:convert';

import 'package:aws_lambda_dart_runtime/aws_lambda_dart_runtime.dart';
import 'package:shelf/src/response.dart' as Shelf;

import 'convert.dart';

class Response {
  Map<String, String> headers;
  String body;
  int statusCode;

  Response({
    this.body = '',
    this.statusCode = 200,
    this.headers = const {},
  });

  static Response notFound() {
    print('Route not found');
    return Response(body: jsonEncode({'error': 'route not found'}));
  }

  void setContentType(String s) => headers['content-type'] = s;

  void setBody(String result) => body = result;

  AwsALBResponse toAwsAlbResponse() => Convert.toAlbResponse(this);

  Shelf.Response toShelfResponse() => Convert.toShelfResponse(this);
}
