import 'dart:math';

import 'dart:convert';
import 'package:aves/architecture/environment.dart';
import 'package:aves/data/networks/network.dart' as network;
import 'package:aves/data/networks/response.dart';
import 'package:flutter/services.dart' show rootBundle;

class Request<Success> {
  String method = 'GET';
  String? url = '/';
  String? baseUrl;
  bool? isIncludeBaseUrl = true;
  RequestContentType? contentType;
  Success Function(dynamic body)? mappingResponse;
  RequestInterceptor<dynamic>? requestInterceptor;
  ResponseInterceptor<dynamic>? responseInterceptor;

  RequestBody? body;
  Map<String, dynamic> headers = {};

  @override
  String toString() {
    return 'Request{method: $method, url: $url, baseUrl: $baseUrl, isIncludeBaseUrl: $isIncludeBaseUrl, contentType: $contentType, mappingResponse: $mappingResponse, body: $body}';
  }

  Request._internal();

  factory Request.http() {
    return Request._internal();
  }

  factory Request.copyWith(Request<Success> request) {
    var newRequest = Request<Success>._internal();
    newRequest
      ..method = request.method
      ..url = request.url
      ..baseUrl = request.baseUrl
      ..isIncludeBaseUrl = true
      ..body = request.body;
    return newRequest;
  }

// Future<Response<Success>> fetch() async {
//   var req = this;
//
//   if (requestInterceptor != null) {
//     requestInterceptor!.interceptor.call(req);
//   }
//
//   if (app().auth.isLogin) {
//     app().auth.user!.performNetworkRequest(req);
//   }
//
//   if (app().env.isUsingNetworkMockData) {
//     return callMock();
//   }
//
//   // appLog.d('app().env is ${app().env}');
//   // appLog.d('req is $req');
//
//   dio.Response<String> dioResponse = await dio.Dio().request<String>(
//     isIncludeBaseUrl == true ? '${req.baseUrl}${req.url}' : '${req.url}',
//     data: req.body,
//     options: dio.Options(
//       headers: {
//         if (req.accessToken != null) 'Authorization': 'Bearer ${req.accessToken}',
//       },
//     ),
//   );
//
//   Response res = Response<String>(
//     data: dioResponse.data,
//     body: dioResponse.data,
//     statusCode: dioResponse.statusCode ?? 0,
//   );
//   if (responseInterceptor != null) {
//     var responseFlow = responseInterceptor!.interceptor(res);
//     if (responseFlow.terminate) {
//       // return responseFlow.response;
//     }
//     res = responseFlow.response;
//   }
//
//   try {
//     Response<Success> finalResponse = Response<Success>(
//       data: mappingResponse?.call(res.data ?? '{}'),
//       body: '',
//       statusCode: res.statusCode ?? 0,
//     );
//     return finalResponse;
//   } catch (e) {
//     sysLog.w('network response mapping fail: cannot parse "${res.data}" to model "$Success"');
//     return ResponseMappingFail();
//   }
// }
//
// Future<Response<Success>> callMock() async {
//   await Future.delayed(Duration(milliseconds: mockResponse?.responseTime ?? 0));
//   try {
//     return Response(
//       data: mappingResponse?.call(mockResponse?.body ?? '{}'),
//       body: mockResponse?.body,
//       statusCode: mockResponse?.statusCode ?? 0,
//     );
//   } catch (e) {
//     sysLog.w('network response mapping fail: cannot parse "${mockResponse?.body}" to model "$Success"');
//     return ResponseMappingFail();
//   }
// }
}

extension RequestFetch<Success> on Request<Success> {
  Future<Response<Success>> fetch() {
    return network.fetch(this);
  }
}

enum RequestContentType {
  json,
}

class RequestBody {}

class RequestBodyJson extends RequestBody {
  final Map<String, dynamic> body;

  RequestBodyJson(this.body);
}

class RequestInterceptor<T> {
  RequestInterceptor<T>? next;
  Future<RequestInterceptorFlow<T>> Function(Request<T> request) interceptor;

  RequestInterceptor({required this.interceptor, this.next});

  RequestInterceptor operator +(next) {
    this.next = next;
    return this;
  }
}

class RequestInterceptorFlow<T> {
  final Request<T> request;
  final Response<T>? response;
  final bool terminate;

  RequestInterceptorFlow(this.request, this.terminate, {this.response});
}

class MockResponse<T> {
  int statusCode = 0;
  T? body;
  int responseTime = 1;
}

RequestInterceptor useNothing() {
  return RequestInterceptor(interceptor: (Request request) async {
    return RequestInterceptorFlow(request, false);
  });
}

RequestInterceptor useJustJson({
  required String jsonString,
  Duration? responseTime,
  int statusCode = 200,
}) {
  return RequestInterceptor(interceptor: (Request request) async {
    var m = jsonDecode(jsonString);
    return RequestInterceptorFlow(request, true,
        response: Response(
          statusCode: statusCode,
          data: m,
          body: jsonString,
        ));
  });
}

RequestInterceptor useMockData({
  required String fileName,
  required Environment env,
  Duration? responseTime,
  int statusCode = 200,
}) {
  if (!env.isUsingNetworkMockData) {
    return useNothing();
  }
  int randInt(int from, int to) => Random().nextInt(to - from + 1) + from;
  responseTime ??= Duration(milliseconds: randInt(200, 800));
  return RequestInterceptor(interceptor: (Request request) async {
    if (responseTime!.isNegative == false) {
      await Future.delayed(responseTime);
    }
    final content = await rootBundle.loadString(fileName);
    var m = jsonDecode(content);
    return RequestInterceptorFlow(request, true,
        response: Response(
          statusCode: statusCode,
          data: m,
          body: content,
        ));
  });
}
