part of 'update_status_bloc.dart';

class UpdateStatusState with FormzMixin, EquatableMixin {
  UpdateStatusState({
    this.hasReasonFocus = false,
    this.reason = const ReasonFormz.pure(),
    this.submitStatus = LoadStatus.initial,
  });

  final bool hasReasonFocus;

  final ReasonFormz reason;

  final LoadStatus submitStatus;

  @override
  bool get isValid => reason.value.isNotEmpty;

  UpdateStatusState copyWith({
    bool? hasReasonFocus,
    ReasonFormz? reason,
    LoadStatus? submitStatus,
  }) {
    return UpdateStatusState(
      hasReasonFocus: hasReasonFocus ?? this.hasReasonFocus,
      reason: reason ?? this.reason,
      submitStatus: submitStatus ?? this.submitStatus,
    );
  }

  @override
  List<Object?> get props => [
    hasReasonFocus,
    reason,
    submitStatus,
  ];

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [reason];
}
