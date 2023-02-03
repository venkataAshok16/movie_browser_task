import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../modal/http_response_modal.dart';
import 'common_service.dart';

class UTILHttpService {
  static String token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlYzAzZjVkZGQ5YzljZjZkNDVkN2I1ODBmNDQ3NDk0YSIsInN1YiI6IjYzZDkzZjU2OTUxMmUxMDA3Y2Y2NjUzNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.uGFWpdAC54JtRiHR-Y27U2CX23DygchdIUvjRdRwYIc";
  static String apiKey = "ec03f5ddd9c9cf6d45d7b580f447494a";

  static postCallWithOutAuth(BuildContext context, String url, String json) async {
    bool isNetConnectivity = await CommonService.isNetworkAvailable();

    if (isNetConnectivity) {
      try {
        final response = await post(Uri.parse(url), body: json, headers: {"content-type": "application/json"});
        if (response.statusCode == 200) {
          if (jsonDecode(response.body) is List) {
            List<dynamic> decodeResp = jsonDecode(utf8.decode(response.bodyBytes, allowMalformed: true));
            if (decodeResp.isEmpty) {
              return HttpResponseModal(status: 201, message: "No data");
            } else {
              return HttpResponseModal(status: 200, message: decodeResp);
            }
          } else if (jsonDecode(response.body) is String) {
            dynamic decodeResp = jsonDecode(utf8.decode(response.bodyBytes, allowMalformed: true));
            if (decodeResp.isEmpty) {
              return HttpResponseModal(status: 201, message: "No data");
            } else {
              return HttpResponseModal(status: 200, message: decodeResp);
            }
          } else {
            return HttpResponseModal(status: 200, message: jsonDecode(response.body));
          }
        } else {
          if (response.body.contains("message")) {
            return HttpResponseModal.parseHttpResponse(jsonDecode(response.body));
          } else {
            return HttpResponseModal(status: response.statusCode, message: "");
          }
        }
      } on TimeoutException catch (_) {
        return HttpResponseModal(status: 100, message: "No internet connectivity");
      } on SocketException catch (_) {
        return HttpResponseModal(status: 100, message: "No internet connectivity");
      } on FormatException catch (r) {
        return HttpResponseModal(status: 400, message: "Some thing went wrong.");
      } catch (e) {
        return HttpResponseModal(status: 400, message: "Some thing went wrong.");
      }
    } else {
      return HttpResponseModal(status: 100, message: "No internet connectivity");
    }
  }

  static getCallWithAuth(String url, {bool isTokenCheckCall = false}) async {
    bool isNetConnectivity = await CommonService.isNetworkAvailable();

    if (isNetConnectivity) {
      try {
        final response = await get(Uri.parse(url), headers: {"content-type": "application/json", HttpHeaders.authorizationHeader: "Bearer $token"});
        if (response.statusCode == 200) {
          if (isTokenCheckCall) {
            return HttpResponseModal(status: 200, message: "Success");
          } else if (response.body.isEmpty) {
            return HttpResponseModal(status: 201, message: "No data");
          } else if (jsonDecode(response.body) is List) {
            List<dynamic> decodeResp = jsonDecode(utf8.decode(response.bodyBytes, allowMalformed: true));
            if (decodeResp.isEmpty) {
              return HttpResponseModal(status: 201, message: "No data");
            } else {
              return HttpResponseModal(status: 200, message: decodeResp);
            }
          } else if (jsonDecode(response.body) is String) {
            dynamic decodeResp = jsonDecode(utf8.decode(response.bodyBytes, allowMalformed: true));
            if (decodeResp.isEmpty) {
              return HttpResponseModal(status: 201, message: "No data");
            } else {
              return HttpResponseModal(status: 200, message: decodeResp);
            }
          } else {
            return HttpResponseModal(status: 200, message: jsonDecode(response.body));
          }
        } else {
          if (response.body.contains("message")) {
            return HttpResponseModal.parseHttpResponse(jsonDecode(response.body));
          } else {
            return HttpResponseModal(status: response.statusCode, message: "");
          }
        }
      } on TimeoutException catch (t) {
        return HttpResponseModal(status: 100, message: "No internet connectivity");
      } on SocketException catch (s) {
        return HttpResponseModal(status: 100, message: "No internet connectivity");
      } on FormatException catch (f) {
        return HttpResponseModal(status: 400, message: "Some thing went wrong.");
      } catch (e) {
        return HttpResponseModal(status: 400, message: "Some thing went wrong.");
      }
    } else {
      return HttpResponseModal(status: 100, message: "No internet connectivity");
    }
  }

  static postCallWithAuth(BuildContext context, String url, String json) async {
    bool isNetConnectivity = await CommonService.isNetworkAvailable();

    if (isNetConnectivity) {
      try {
        final response =
            await post(Uri.parse(url), body: json, headers: {"content-type": "application/json", HttpHeaders.authorizationHeader: "Bearer $token"});
        if (response.statusCode == 200) {
          if (jsonDecode(response.body) is List) {
            List<dynamic> decodeResp = jsonDecode(utf8.decode(response.bodyBytes, allowMalformed: true));
            if (decodeResp.isEmpty) {
              return HttpResponseModal(status: 201, message: "No data");
            } else {
              return HttpResponseModal(status: 200, message: decodeResp);
            }
          } else if (jsonDecode(response.body) is String) {
            dynamic decodeResp = jsonDecode(utf8.decode(response.bodyBytes, allowMalformed: true));
            if (decodeResp.isEmpty) {
              return HttpResponseModal(status: 201, message: "No data");
            } else {
              return HttpResponseModal(status: 200, message: decodeResp);
            }
          } else {
            return HttpResponseModal(status: 200, message: jsonDecode(response.body));
          }
        } else {
          if (response.body.contains("message")) {
            return HttpResponseModal.parseHttpResponse(jsonDecode(response.body));
          } else {
            return HttpResponseModal(status: response.statusCode, message: "");
          }
        }
      } on TimeoutException catch (_) {
        return HttpResponseModal(status: 100, message: "No internet connectivity");
      } on SocketException catch (_) {
        return HttpResponseModal(status: 100, message: "No internet connectivity");
      } on FormatException catch (_) {
        return HttpResponseModal(status: 400, message: "Some thing went wrong.");
      } catch (e) {
        return HttpResponseModal(status: 400, message: "Some thing went wrong.");
      }
    } else {
      return HttpResponseModal(status: 100, message: "No internet connectivity");
    }
  }

  /// Returns Uint8List from Url if exist
  static Future<Uint8List?> getUint8ListFromUrl(dynamic url) async {
    if (url is Uint8List) {
      return url;
    } else {
      Uint8List? byteData;
      await get(Uri.parse(url), headers: {"content-type": "application/json", HttpHeaders.authorizationHeader: "Bearer $token"}).then((value) async {
        byteData = value.bodyBytes;
      }).onError((error, stackTrace) {});
      return byteData;
    }
  }

  static Future<String?> preLoadUrl(String url) async {
    String? loadedUrl;
    final response = await get(Uri.parse(url), headers: {"content-type": "application/json", HttpHeaders.authorizationHeader: "Bearer $token"});
    if (response.statusCode == 200) {
      loadedUrl = url;
    } else {
      loadedUrl = null;
    }
    return loadedUrl;
  }
}
