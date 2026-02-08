import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class ErrorEntityResponse extends Equatable {
  const ErrorEntityResponse({this.message});

  factory ErrorEntityResponse.fromJson(Map<String, dynamic> json) {
    return ErrorEntityResponse(
      message: json.containsKey('message') ? json['message'] as String : null,
    );
  }

  final String? message;

  @override
  List<Object?> get props => [message];
}

extension ErrorEntityResponseX on Response<dynamic>? {
  ErrorEntityResponse? error() {
    final response = this;

    if (response?.data is Map<String, dynamic> && response?.data != null) {
      final responseData = response?.data as Map<String, dynamic>;

      final error = ErrorEntityResponse.fromJson(responseData);

      return error;
    }

    return null;
  }
}
