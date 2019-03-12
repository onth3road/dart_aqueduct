import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
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
  // todo add refresh every 90 min
  static String access_token = "19__1TKn4iC0uUQknB6XQCqSgJZP4GyF4cyvBtoR0aa5nREgwX1NsHhNHI7a97iU4rceUaENTc1J4pWTpVRzUwkQMrwfSZzg4RWL4ge--HXQs-dj7yhH0b_ONQt0ACcrJDxT-9jzSronwgnM1tUVSKjABALIA";

  // FOR TEST PART ------------------------------------------------
  @Operation.get("api")
  Future<Response> testWechatAPI() async {
    final apiType = request.path.variables['api'];
    print("testWechatAPI: $apiType");

    Map<String, dynamic> retMap;
    switch (apiType) {
      case "access_token":
        retMap =await getAccessToken(); break;
      case "wechat_server_ip":
        retMap =await getWechatServerIP(); break;
      case "network_detect":
        retMap =await detectNetworkStatus(); break;
      default:
        return Response.ok("$apiType api test is not currently supported.");
    }

    final title = "API: $apiType";
    final contents = json.encode(retMap);
    return Response.ok("$title\n$contents")..contentType =ContentType.text;
  }

  
  // util functions ----------------------------------------------
  Future<Map<String, dynamic>> detectNetworkStatus(
    {String action ="all", String checkOperator ="DEFAULT"}) async {

    final uri = Uri.https("api.weixin.qq.com", "/cgi-bin/callback/check", {
      "access_token" :access_token
    });
    final params = Map<String, String>();
    params["action"] = action;
    params["check_operator"] = checkOperator;
    
    return postRespWithData(uri, params);
  }

  Future<Map<String, dynamic>> 
  getWechatServerIP() async {
    final uri = Uri.https("api.weixin.qq.com", "/cgi-bin/getcallbackip", {
      "access_token" :access_token
    });
    return getRespFromUri(uri);
  }

  Future<Map<String, dynamic>> 
  getAccessToken() async {
    final uri = Uri.https("api.weixin.qq.com", "/cgi-bin/token", {
      "grant_type" :"client_credential",
      "appid" :appID, "secret" :appSecret
    });
    return getRespFromUri(uri);
  }

  Future<Map<String, dynamic>> 
  postRespWithData(Uri uri, Map<String, dynamic> params) async {
    final jsonStr = json.encode(params);
    final resp = await http.post(uri.toString(), body: jsonStr);
    
    final jsonStr2 =resp.body;
    final jsonMap =json.decode(jsonStr2) as Map<String, dynamic>;
    for (String key in jsonMap.keys) {
      print("key:   $key");
      print("value: ${jsonMap[key]}    type:  ${jsonMap[key].runtimeType}");
    }
    return jsonMap;
  }
 
  Future<Map<String, dynamic>> 
  getRespFromUri(Uri uri) async {
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