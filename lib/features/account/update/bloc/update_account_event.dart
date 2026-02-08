part of 'update_account_bloc.dart';

abstract class UpdateAccountEvent extends Equatable {
  const UpdateAccountEvent();

  @override
  List<Object?> get props => [];
}

class ProfileFetched extends UpdateAccountEvent {
  const ProfileFetched();
}

class NameChanged extends UpdateAccountEvent {
  const NameChanged(this.name);

  final String name;

  @override
  List<Object?> get props => [name];
}

class NameFocused extends UpdateAccountEvent {
  const NameFocused({required this.isFocus});

  final bool isFocus;

  @override
  List<Object?> get props => [isFocus];
}

class EmailChanged extends UpdateAccountEvent {
  const EmailChanged(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

class EmailFocused extends UpdateAccountEvent {
  const EmailFocused({required this.isFocus});

  final bool isFocus;

  @override
  List<Object?> get props => [isFocus];
}

class PhoneNumberChanged extends UpdateAccountEvent {
  const PhoneNumberChanged(this.phoneNumber);

  final String phoneNumber;

  @override
  List<Object?> get props => [phoneNumber];
}

class PhoneNumberFocused extends UpdateAccountEvent {
  const PhoneNumberFocused({required this.isFocus});

  final bool isFocus;

  @override
  List<Object?> get props => [isFocus];
}

class AvatarChanged extends UpdateAccountEvent {
  const AvatarChanged(this.avatar);

  final String? avatar;

  @override
  List<Object?> get props => [avatar];
}

class FormSubmitted extends UpdateAccountEvent {
  const FormSubmitted();
}
