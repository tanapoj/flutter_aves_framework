
import 'package:aves/common/syslog.dart';
import 'package:aves/data/networks/request.dart';
import 'package:aves/data/networks/response.dart';
import 'package:dio/dio.dart' as dio;

class Network {
  Request<T> request<T>() {
    return Request<T>.http()
      ..method = 'GET'
      ..baseUrl = 'https://www.api.com/'
      ..url = ''
      ..body = RequestBody();
  }
}

int _requestRunningId = 1;

Response<String> _getResponseByDioError(dio.DioError e) {
  // if (..no internet..) {
  //   return ResponseNoInternetConnection<String>(
  //     message: e.message,
  //     data: e.response?.data,
  //     body: e.response?.data,
  //     statusCode: e.response?.statusCode ?? 0,
  //     headers: e.response?.headers.map,
  //   );
  // }
  if (e.type == dio.DioErrorType.connectTimeout ||
      e.type == dio.DioErrorType.sendTimeout ||
      e.type == dio.DioErrorType.receiveTimeout) {
    return ResponseConnectionTimeout<String>(
      message: e.message,
      data: e.response?.data,
      body: e.response?.data,
      statusCode: e.response?.statusCode ?? 0,
      headers: e.response?.headers.map,
    );
  }
  if (e.type == dio.DioErrorType.cancel) {
    return ResponseCancel<String>(
      message: e.message,
      data: e.response?.data,
      body: e.response?.data,
      statusCode: e.response?.statusCode ?? 0,
      headers: e.response?.headers.map,
    );
  }
  return ResponseUnknownFail<String>(
    message: e.message,
    data: e.response?.data,
    body: e.response?.data,
    statusCode: e.response?.statusCode ?? 0,
    headers: e.response?.headers.map,
  );
}

Future<Response<Success>> fetch<Success>(Request<Success> req) async {
  Response? res;
  int limit;

  RequestInterceptor<dynamic>? requestInterceptor = req.requestInterceptor;
  limit = 10;
  while (limit > 0 && requestInterceptor != null) {
    RequestInterceptorFlow flow = await requestInterceptor.interceptor.call(req);
    if (flow.terminate) {
      res = flow.response!;
    }
    req = flow.request as Request<Success>;
    requestInterceptor = requestInterceptor.next;
    limit--;
  }

  if (res == null) {
    int id = _requestRunningId++;
    String url = req.isIncludeBaseUrl == true ? '${req.baseUrl}${req.url}' : '${req.url}';

    sysLog.i('($id) network request: [${req.method}] $url\n'
        '        body: ${req.body}\n'
        '        headers: ${req.headers}');

    try {
      dio.Response<String> dioResponse = await dio.Dio().request<String>(
        url,
        data: req.body,
        options: dio.Options(
          method: req.method,
          headers: req.headers,
          validateStatus: (int? status) => status != null,
        ),
      );

      res = Response<String>(
        data: dioResponse.data,
        body: dioResponse.data,
        statusCode: dioResponse.statusCode ?? 0,
        headers: dioResponse.headers.map,
      );
    } on dio.DioError catch (e) {
      res = _getResponseByDioError(e);
    }

    sysLog.i('($id) network response: statusCode=${res.statusCode}\n'
        '        header: ${res.headers}\n'
        '        body: ${res.body}\n');
  }

  if (res == null) throw StateError('response is null state');

  ResponseInterceptor<dynamic>? responseInterceptor = req.responseInterceptor;
  limit = 10;
  while (limit > 0 && responseInterceptor != null) {
    var responseFlow = await responseInterceptor.interceptor(res!);
    if (responseFlow.terminate) {
      return responseFlow.response as Response<Success>;
    }
    res = responseFlow.response;
    responseInterceptor = responseInterceptor.next;
    limit--;
  }

  try {
    Response<Success> finalResponse = Response<Success>(
      data: req.mappingResponse?.call(res!.data ?? '{}'),
      body: '',
      statusCode: res!.statusCode,
    );
    return finalResponse;
  } catch (e) {
    String errorMessage = 'network response mapping fail: cannot parse "${res!.data}" to model "$Success"';
    sysLog.w(errorMessage);
    return ResponseMappingFail(
      message: errorMessage,
      // TODO
    );
  }
}
