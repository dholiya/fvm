import 'dart:io';

class Headers {
  Headers._privateConstructor();

  static final Headers _singleton = Headers._privateConstructor();

  static Headers get instance => _singleton;

  var _deviceToken = "";
  var _loginToken="";
  var _userId="";
  var _deviceId="";


  get deviceToken => _deviceToken;

  set deviceToken(value) {
    _deviceToken = value;
  }

  get loginToken => _loginToken;

  set loginToken(value) {
    _loginToken = value;
  }

  get userId => _userId;

  set userId(value) {
    _userId = value;
  }

  get deviceId => _deviceId;
  set deviceId(value) {
    _deviceId = value;
  }


  Map<String, String> getCommonHeader() {
    Map<String, String> _headers = <String, String>{};
    _headers['Content-Type'] = "application/x-www-form-urlencoded";
    return _headers;
  }



  Map<String, String> getHeaderAuthOnly() {
    Map<String, String> _headers = <String, String>{};
    _headers['Authorization']= _loginToken;
    return _headers;
  }

  Map<String, String> getHeaders({required Map<String, String> additionalHeaders}) {
    Map<String, String> _headers = <String, String>{};
    if (additionalHeaders != null) _headers = additionalHeaders;
    _headers['Content-Type'] = "application/json";
    _headers['Accept'] = "application/json";
    _headers[HttpHeaders.authorizationHeader]= _loginToken;
    return _headers;
  }


  Map<String, String> getHeaderForUpload() {
    Map<String, String> _headers = <String, String>{};
    _headers['Content-Type'] = "multipart/form-data";
    _headers['Authorization']= _loginToken;
    return _headers;
  }

}
