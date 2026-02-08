part of 'order_update_bloc.dart';

abstract class OrderUpdateEvent extends Equatable {
  const OrderUpdateEvent();

  @override
  List<Object?> get props => [];
}

class FirstAttachmentChanged extends OrderUpdateEvent {
  const FirstAttachmentChanged(this.attachment);

  final String attachment;

  @override
  List<Object?> get props => [attachment];
}

class SecondAttachmentChanged extends OrderUpdateEvent {
  const SecondAttachmentChanged(this.attachment);

  final String attachment;

  @override
  List<Object?> get props => [attachment];
}

class FinishOrderSubmitted extends OrderUpdateEvent {
  const FinishOrderSubmitted();
}
