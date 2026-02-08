part of 'order_update_bloc.dart';

class OrderUpdateState with FormzMixin, EquatableMixin {
  const OrderUpdateState({
    this.firstImageAttachment = const AttachmentFormz.pure(),
    this.secondImageAttachment = '',
    this.status = SubmitStatus.initial,
  });

  final AttachmentFormz firstImageAttachment;

  final String secondImageAttachment;

  final SubmitStatus status;

  OrderUpdateState copyWith({
    AttachmentFormz? firstImageAttachment,
    String? secondImageAttachment,
    SubmitStatus? status,
  }) {
    return OrderUpdateState(
      firstImageAttachment: firstImageAttachment ?? this.firstImageAttachment,
      secondImageAttachment:
          secondImageAttachment ?? this.secondImageAttachment,
      status: status ?? this.status,
    );
  }

  @override
  bool get isValid => firstImageAttachment.value.isNotEmpty;

  @override
  List<Object?> get props => [
    firstImageAttachment,
    secondImageAttachment,
    status,
  ];

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [firstImageAttachment];
}
