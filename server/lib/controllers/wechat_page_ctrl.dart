import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aqueduct/aqueduct.dart';

class WechatPageController extends ResourceController {

  final String appID ="wx95129b9615825957";
  final String appSecret = "3268923f3b1d643634b5ba2d5a47c7e3";
  static String access_token = "";

  @Operation.get("api")
  Future<Response> testWechatPageAPI() async {
    final apiType = request.path.variables['api'];
    print("testWechatAPI: $apiType");
    return askUserAuthCode();

    //return Response.ok("fake ok");
  }

  Future<Response> askUserAuthCode() async {
    const redictUri = "onth3road.github.io";
    const respType ="code";
    const scope ="snsapi_base";
    const state ="whatever_state";

    final uri = Uri.https("open.weixin.qq.com", 
      "/connect/oauth2/authorize", {
      "appid" :appID, "redirect_uri" :redictUri,
      "response_type": respType, "scope":scope, 
      "state" :state
    });
    final uriStr = uri.toString() + "#wechat_redirect";
    print("url: $uriStr");
    final resp = await http.get(uriStr);
    print("resp body: ${resp.body}");
    print("--------------------");
    final head = json.encode(resp.headers);
    print("resp head: $head" );
    print("--------------------");
    /*final jsonMap =json.decode(resp.body) as Map<String, dynamic>;
    for (String key in jsonMap.keys) {
      print("key:   $key");
      print("value: ${jsonMap[key]}    type:  ${jsonMap[key].runtimeType}");
  }*/

    return Response.ok(resp.body)
      ..contentType =ContentType.html
      ..encodeBody = true;
  }
  
  Future<Map<String, dynamic>> 
  getJsonMapFromUri(Uri uri) async {
    final req =await HttpClient().getUrl(uri);
    // sends the request
    final resp = await req.close(); 

    final jsonStr =await resp.transform(const Utf8Decoder()).toList();
    final jsonMap =json.decode(jsonStr[0]) as Map<String, dynamic>;
    for (String key in jsonMap.keys) {
      print("key:   $key");
      print("value: ${jsonMap[key]}    type:  ${jsonMap[key].runtimeType}");
    }
    return jsonMap;
  }
}