import 'package:aws_lambda_dart_runtime/aws_lambda_dart_runtime.dart';
import 'package:aws_lambda_dart_runtime/runtime/context.dart' as aws;

import 'cumulus/cumulus.dart';
import 'routes.dart';

void main() async {
  // This demo's handling an ALB request.
  final Handler<AwsALBEvent> albHandler = (aws.Context context, AwsALBEvent event) async {
    Cumulus app = Cumulus(event);    
    app.addRoutes(routes);
    return await app.getAwsAlbResponse();
  };

  // The Runtime is a singleton.
  // You can define the handlers as you wish.
  Runtime()
    ..registerHandler<AwsALBEvent>("alb.handler", albHandler)
    ..invoke();
}
