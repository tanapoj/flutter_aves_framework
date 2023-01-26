import 'package:aves/common/syslog.dart';
import 'package:aves/data/networks/request.dart';
import 'package:aves/data/networks/response.dart';
import 'package:dio/dio.dart' as dio_package;

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

Response<String> _getResponseByDioError(dio_package.DioError e) {
  // if (..no internet..) {
  //   return ResponseNoInternetConnection<String>(
  //     message: e.message,
  //     data: e.response?.data,
  //     body: e.response?.data,
  //     statusCode: e.response?.statusCode ?? 0,
  //     headers: e.response?.headers.map,
  //   );
  // }
  if (e.type == dio_package.DioErrorType.connectTimeout ||
      e.type == dio_package.DioErrorType.sendTimeout ||
      e.type == dio_package.DioErrorType.receiveTimeout) {
    return ResponseConnectionTimeout<String>(
      message: e.message,
      data: e.response?.data,
      body: e.response?.data,
      statusCode: e.response?.statusCode ?? 0,
      headers: e.response?.headers.map,
    );
  }
  if (e.type == dio_package.DioErrorType.cancel) {
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

Future<Response<Success>> fetch<Success>(
  Request<Success> req, {
  dio_package.Dio? dio,
}) async {
  int startAgainLimit = 10;
  while (startAgainLimit > 0) {
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

      final queryParamsString = req.queryParametersString;
      final fullUrl = url.contains('?') ? '$url&$queryParamsString' : '$url?$queryParamsString';

      sysLog.i('($id) network request: [${req.method}] $fullUrl\n'
          '        body: ${req.body}\n'
          '        headers: ${req.headers}');

      try {
        dio ??= dio_package.Dio();
        dio_package.Response<String> dioResponse = await dio.request<String>(
          fullUrl,
          data: req.body,
          options: dio_package.Options(
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
      } on dio_package.DioError catch (e) {
        res = _getResponseByDioError(e);
      }

      sysLog.i('($id) network response: statusCode=${res.statusCode}\n'
          '        header: ${res.headers}\n'
          '        body: ${res.body}\n');
    }

    if (res == null) throw StateError('response is null state');

    ResponseInterceptor<dynamic>? responseInterceptor = req.responseInterceptor;
    limit = 10;
    bool startAgain = false;
    while (limit > 0 && responseInterceptor != null) {
      var responseFlow = await responseInterceptor.interceptor(res!);
      if (responseFlow.terminate) {
        return responseFlow.response as Response<Success>;
      }
      if (responseFlow.startAgain) {
        startAgain = true;
        break;
      }
      res = responseFlow.response;
      responseInterceptor = responseInterceptor.next;
      limit--;
    }

    if (startAgain) {
      startAgainLimit--;
      continue;
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
  throw Exception('startAgainLimit');
}
