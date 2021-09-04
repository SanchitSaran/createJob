import 'package:dio/dio.dart';
import 'package:jobwale/utils/constants.dart';

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = Constants.cancelIssue;
        break;
      case DioErrorType.connectTimeout:
        message = Constants.connectTimeout;
        break;
      case DioErrorType.other:
        message = Constants.internetIssue;
        break;
      case DioErrorType.receiveTimeout:
        message = Constants.receiveTimeout;
        break;
      case DioErrorType.response:
        message = _handleError(
            dioError.response!.statusCode!, dioError.response!.data);
        break;
      case DioErrorType.sendTimeout:
        message = Constants.sendTimeout;
        break;
      default:
        message = Constants.serverError;
        break;
    }
  }

  String? message;

  String _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 404:
        return error["message"];
      case 401:
        return error["message"];
      case 422:
        return error["message"];
      case 500:
        return Constants.serverError;
      default:
        return Constants.serverError;
    }
  }

  @override
  String toString() => message!;
}
