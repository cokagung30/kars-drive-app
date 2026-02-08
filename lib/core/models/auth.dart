import 'package:equatable/equatable.dart';
import 'package:kars_driver_app/core/models/models.dart';

class Auth extends Equatable {
  const Auth({
    required this.accessToken,
    required this.user,
  });

  factory Auth.formJson(Map<String, dynamic> json) {
    final status = json['available_status'] as bool;

    final user = User.fromJson(json['user'] as Map<String, dynamic>);

    return Auth(
      accessToken: json['access_token'] as String,
      user: user.copyWith(status: status),
    );
  }

  final String accessToken;

  final User user;

  @override
  List<Object?> get props => [accessToken, user];
}
