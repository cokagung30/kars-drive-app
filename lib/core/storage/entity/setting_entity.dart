import 'package:equatable/equatable.dart';

class SettingEntity extends Equatable {
  const SettingEntity({
    this.isIntroDone = false,
  });

  factory SettingEntity.fromJson(Map<String, dynamic> json) {
    return SettingEntity(
      isIntroDone: json['is_intro_done'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {'is_intro_done': isIntroDone};
  }

  final bool isIntroDone;

  @override
  List<Object?> get props => [isIntroDone];
}
