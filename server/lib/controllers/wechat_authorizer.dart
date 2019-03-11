import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:aqueduct/aqueduct.dart';
import 'package:crypto/crypto.dart';

class WechatAuthorizer extends ResourceController {
  
  static const String token = "ExprMandui";

  @Operation.get()
  Future<Response> getCityByName(
    @Bind.query('signature') String signature,
    @Bind.query('nonce') String nonce,
    @Bind.query('timestamp') String timestamp,
    @Bind.query('echostr') String echostr) async {

    if (fromWechat(timestamp, nonce, signature))
      return Response.ok(echostr)..contentType = ContentType.text;

    return Response.unauthorized();
  }

  final String appID ="wx95129b9615825957";
  final String appSecret = "3268923f3b1d643634b5ba2d5a47c7e3";
  static String access_token = "";

  @Operation.get("test", "access_token")
  Future<Response> testGetAccessToken() async {
    print("in post now");

    final url = Uri.https("api.weixin.qq.com", "/cgi-bin/token", {
      "grant_type" :"client_credential",
      "appid" :appID, "secret" :appSecret
    });

    final req =await HttpClient().getUrl(url);
    // sends the request
    final resp = await req.close(); 
    // transforms and prints the response
    List<String> jsonStr =await resp.transform(const Utf8Decoder()).toList();
    final jsonMap =json.decode(jsonStr[0]) as Map<String, dynamic>;
    for (String key in jsonMap.keys) {
      print("key:   $key");
      print("value: ${jsonMap[key]}");
      print("type:  ${jsonMap[key].runtimeType}");
    }

    //return Response.ok(ret.toString())..contentType =ContentType.text;
    return Response.ok("body");
  }
  
  // util functions
  bool fromWechat(String timestamp, String nonce, String signature) {
    final tokenArr = List<String>(3);
    tokenArr[0] =token;
    tokenArr[1] =timestamp;
    tokenArr[2] =nonce;
    tokenArr.sort();
    final String contactStr =tokenArr[0] + tokenArr[1] + tokenArr[2];

    final bytes = utf8.encode(contactStr);
    final digest = sha1.convert(bytes).toString();

    return digest ==signature;
  }
}