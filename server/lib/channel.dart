import 'package:server/controllers/wechat_authorizer.dart';
import 'package:server/controllers/wechat_controller.dart';

import 'server.dart';

class ServerChannel extends ApplicationChannel {

  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
  }

  @override
  Controller get entryPoint {
    final router = Router();

    /*router
      .route("/example")
      .linkFunction((request) async {
        return Response.ok({"key": "value"});
      });*/

    router.route("/wechat/[:api]")
      .link(() => WechatAuthorizer());
      //.link(() => WechatController());

    return router;
  }
}