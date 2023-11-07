import 'dart:io';
import 'package:dio/dio.dart';
import 'package:foodie/core/util/enum.dart';
import 'network_exception.dart';

NetworkException parseNetworkException(DioException e) {
  late NetworkException networkException;
  if (e.error is SocketException) {
    networkException =
        NetworkException(NetworkExceptionType.noInternetConnection);
  } else if (e.error is FormatException) {
    networkException = NetworkException(NetworkExceptionType.invalidFormat);
  }
  switch (e.type) {
    case DioExceptionType.unknown:
      networkException = NetworkException(NetworkExceptionType.unExpected);
      break;
    case DioExceptionType.connectionTimeout:
      networkException = NetworkException(NetworkExceptionType.requestTimeOut);
      break;
    case DioExceptionType.sendTimeout:
      networkException = NetworkException(NetworkExceptionType.sendTimeOut);
      break;
    case DioExceptionType.receiveTimeout:
      networkException = NetworkException(NetworkExceptionType.sendTimeOut);
      break;
    case DioExceptionType.cancel:
      networkException =
          NetworkException(NetworkExceptionType.requestCancelled);
      break;
    case DioExceptionType.badResponse:
      switch (e.response!.statusCode) {
        case 401:
        case 403:
          networkException = NetworkException(
            NetworkExceptionType.unauthorizedRequest,
            errorMessage: e.response!.data['msg'],
          );
          break;
        case 404:
          networkException = NetworkException(
            NetworkExceptionType.notFound,
            errorMessage: 'Not Found',
          );
          break;
        case 408:
          networkException = NetworkException(
            NetworkExceptionType.requestTimeOut,
            errorMessage: e.response!.data['error_message'],
          );
          break;
        case 409:
          networkException = NetworkException(
            NetworkExceptionType.conflict,
            errorMessage: e.response!.data['msg'],
          );
          break;
        case 500:
          networkException = NetworkException(
            NetworkExceptionType.internalServerError,
            errorMessage: e.response!.data['msg'],
          );
          break;
        case 503:
          networkException = NetworkException(
            NetworkExceptionType.serviceUnavailable,
            errorMessage: e.response!.data['msg'],
          );
          break;
        default:
          networkException = NetworkException(
            NetworkExceptionType.unExpected,
            errorMessage: e.response?.data['msg'],
          );
      }
      break;
    default:
      networkException = NetworkException(
        NetworkExceptionType.unExpected,
        errorMessage: e.response?.data['msg'],
      );
  }
  return networkException;
}
