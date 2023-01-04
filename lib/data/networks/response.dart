import 'dart:convert';

class Response<Success> {
  final String message;
  final Success? data;
  final String? body;
  final int statusCode;
  final Map<String, List<String>>? headers;

  Response({
    this.message = 'ok',
    this.data,
    this.body,
    this.statusCode = 0,
    this.headers,
  });

  bool get ok => true;
}

class ResponseMappingFail<T> extends Response<T> {
  @override
  bool get ok => false;

  ResponseMappingFail({super.message, super.data, super.body, super.statusCode, super.headers});
}

class ResponseNoInternetConnection<T> extends Response<T> {
  @override
  bool get ok => false;

  ResponseNoInternetConnection({super.message, super.data, super.body, super.statusCode, super.headers});
}

class ResponseConnectionTimeout<T> extends Response<T> {
  @override
  bool get ok => false;

  ResponseConnectionTimeout({super.message, super.data, super.body, super.statusCode, super.headers});
}

class ResponseCancel<T> extends Response<T> {
  @override
  bool get ok => false;

  ResponseCancel({super.message, super.data, super.body, super.statusCode, super.headers});
}

class ResponseUnknownFail<T> extends Response<T> {
  @override
  bool get ok => false;

  ResponseUnknownFail({super.message, super.data, super.body, super.statusCode, super.headers});
}

///

class ResponseInterceptor<T> {
  ResponseInterceptor<T>? next;
  Future<ResponseInterceptorFlow> Function(Response response) interceptor;

  ResponseInterceptor({required this.interceptor, this.next});

  ResponseInterceptor operator +(next) {
    this.next = next;
    return this;
  }
}

class ResponseInterceptorFlow<T> {
  final Response response;
  final bool terminate;

  ResponseInterceptorFlow(this.response, this.terminate);
}

ResponseInterceptor useUnpackJSend() {
  return ResponseInterceptor(interceptor: (Response response) async {
    var data = response.data is String ? jsonDecode(response.data) : response.data;
    return ResponseInterceptorFlow(
        Response<Map<String, dynamic>>(
          data: data['payload'],
          body: response.body,
          statusCode: response.statusCode,
        ),
        false);
  });
}
