import 'dart:convert';

import 'package:http/http.dart';

class _BaseRequest extends BaseClient {
  Map<String, String> _defaultHeaders;
  static final Client _httpClient = Client();

  _BaseRequest(this._defaultHeaders);

  void setDefaultHeaders(Map<String, String>? headers) {
    _defaultHeaders = {..._defaultHeaders, ...?headers};
  }

  void clearHeaders() {
    _defaultHeaders = {"Content-Type": "application/json"};
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    request..headers.addAll(_defaultHeaders);
    return _httpClient.send(request);
  }

  @override
  Future<Response> get(url, {Map<String, String>? headers}) async {
    // intercept the request before it is sent
    // intercept the response from the server
    return _httpClient.get(url, headers: _mergedHeaders(headers));
  }

  @override
  Future<Response> post(url,
      {Map<String, String>? headers, dynamic body, Encoding? encoding}) async {
    return _httpClient.post(url,
        headers: _mergedHeaders(headers), body: body, encoding: encoding);
  }

  @override
  Future<Response> patch(url,
      {Map<String, String>? headers, dynamic body, Encoding? encoding}) async {
    return _httpClient.patch(url,
        headers: _mergedHeaders(headers), body: body, encoding: encoding);
  }

  @override
  Future<Response> put(url,
      {Map<String, String>? headers, dynamic body, Encoding? encoding}) async {
    return _httpClient.put(url,
        headers: _mergedHeaders(headers), body: body, encoding: encoding);
  }

  @override
  Future<Response> head(url, {Map<String, String>? headers}) async {
    return _httpClient.head(url, headers: _mergedHeaders(headers));
  }

  @override
  Future<Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    return await _httpClient.delete(url, headers: _mergedHeaders(headers));
  }

  Map<String, String> _mergedHeaders(Map<String, String>? headers) =>
      {..._defaultHeaders, ...?headers};
}

final baseRequest = _BaseRequest({"Content-Type": "application/json"});
