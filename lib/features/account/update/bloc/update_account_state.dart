part of 'update_account_bloc.dart';

class UpdateAccountState with FormzMixin, EquatableMixin {
  const UpdateAccountState({
    this.hasNameFocus = false,
    this.hasEmailFocus = false,
    this.hasPhoneNumberFocus = false,
    this.name = const NameFormz.pure(),
    this.email = const EmailFormz.pure(),
    this.phoneNumber = const PhoneNumberFormz.pure(),
    this.avatar = '',
    this.submitStatus = LoadStatus.initial,
    this.fetchStatus = LoadStatus.initial,
    this.profile,
  });

  final bool hasNameFocus;

  final bool hasEmailFocus;

  final bool hasPhoneNumberFocus;

  final NameFormz name;

  final EmailFormz email;

  final PhoneNumberFormz phoneNumber;

  final String avatar;

  final Profile? profile;

  final LoadStatus submitStatus;

  final LoadStatus fetchStatus;

  @override
  bool get isValid =>
      name.value.isNotEmpty &&
      email.value.isNotEmpty &&
      phoneNumber.value.isNotEmpty;

  UpdateAccountState copyWith({
    bool? hasNameFocus,
    bool? hasEmailFocus,
    bool? hasPhoneNumberFocus,
    NameFormz? name,
    EmailFormz? email,
    PhoneNumberFormz? phoneNumber,
    String? avatar,
    LoadStatus? submitStatus,
    LoadStatus? fetchStatus,
    Profile? profile,
  }) {
    return UpdateAccountState(
      hasNameFocus: hasNameFocus ?? this.hasNameFocus,
      hasEmailFocus: hasEmailFocus ?? this.hasEmailFocus,
      hasPhoneNumberFocus: hasPhoneNumberFocus ?? this.hasPhoneNumberFocus,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatar: avatar ?? this.avatar,
      submitStatus: submitStatus ?? this.submitStatus,
      fetchStatus: fetchStatus ?? this.fetchStatus,
      profile: profile ?? this.profile,
    );
  }

  @override
  List<Object?> get props => [
    name,
    email,
    phoneNumber,
    avatar,
    submitStatus,
    fetchStatus,
    profile,
    hasNameFocus,
    hasEmailFocus,
    hasPhoneNumberFocus,
  ];

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [
    name,
    email,
    phoneNumber,
  ];
}
