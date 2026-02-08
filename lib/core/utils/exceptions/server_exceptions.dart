import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kars_driver_app/core/models/models.dart';

sealed class ServerExceptions implements Exception {
  const ServerExceptions();
}

class RequestCancelled extends ServerExceptions {
  const RequestCancelled();
}

class UnauthorisedRequest extends ServerExceptions {
  const UnauthorisedRequest(this.response);
  final ErrorEntityResponse? response;
}

class BadRequest extends ServerExceptions {
  const BadRequest();
}

class NotFound extends ServerExceptions {
  const NotFound(this.response);

  final ErrorEntityResponse? response;
}

class MethodNotAllowed extends ServerExceptions {
  const MethodNotAllowed();
}

class RequestTimeout extends ServerExceptions {
  const RequestTimeout();
}

class SendTimeout extends ServerExceptions {
  const SendTimeout();
}

class InternalServerError extends ServerExceptions {
  const InternalServerError();
}

class NoInternetConnection extends ServerExceptions {
  const NoInternetConnection();
}

class DefaultError extends ServerExceptions {
  const DefaultError(this.error);
  final String error;
}

class UnexpectedError extends ServerExceptions {
  const UnexpectedError();
}

class EntityError extends ServerExceptions {
  const EntityError(this.response);
  final ErrorEntityResponse? response;
}

ServerExceptions serverExceptionFrom(dynamic error) {
  if (error is Exception) {
    try {
      if (error is DioException) {
        switch (error.type) {
          case DioExceptionType.cancel:
            return const RequestCancelled();
          case DioExceptionType.connectionTimeout:
            return const RequestTimeout();
          case DioExceptionType.unknown:
            return const NoInternetConnection();
          case DioExceptionType.receiveTimeout:
            return const SendTimeout();
          case DioExceptionType.badResponse:
            final response = error.response;
            if (response == null) return const UnexpectedError();

            switch (response.statusCode) {
              case 400:
                return EntityError(response.error());
              case 401:
                return UnauthorisedRequest(response.error());
              case 403:
                return UnauthorisedRequest(response.error());
              case 404:
                return NotFound(response.error());
              case 408:
                return const RequestTimeout();
              case 422:
                return EntityError(response.error());
              case 500:
                return const InternalServerError();
              default:
                final code = response.statusCode;
                return DefaultError('Received invalid status code: $code');
            }

          case DioExceptionType.sendTimeout:
            return const SendTimeout();
          case DioExceptionType.badCertificate:
          case DioExceptionType.connectionError:
            return const NoInternetConnection();
        }
      } else if (error is SocketException) {
        return const NoInternetConnection();
      } else {
        return const UnexpectedError();
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      return const UnexpectedError();
    }
  }
  return const UnexpectedError();
}

extension ServerExceptionX on ServerExceptions? {
  ErrorEntityResponse? get entity {
    return switch (this) {
      EntityError(response: final errorResponse) => errorResponse,
      UnauthorisedRequest(response: final errorResponse) => errorResponse,
      NotFound(response: final errorResponse) => errorResponse,
      _ => null,
    };
  }

  String? keyMessage(String key) {
    final r = entity;
    return r?.message;
  }
}
