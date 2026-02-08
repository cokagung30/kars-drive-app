import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_bus/event_bus.dart';
import 'package:formz/formz.dart';
import 'package:kars_driver_app/core/api/api.dart';
import 'package:kars_driver_app/core/repositories/repositories.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/event/event.dart';
import 'package:kars_driver_app/features/orders/update/order_update.dart';
import 'package:kars_driver_app/injection/injection.dart';

part 'order_update_event.dart';
part 'order_update_state.dart';

class OrderUpdateBloc extends Bloc<OrderUpdateEvent, OrderUpdateState> {
  OrderUpdateBloc({
    required String orderId,
    required String status,
    EventBus? eventBus,
    OrderRepository? repository,
  }) : _orderId = orderId,
       _status = status,
       _eventBus = eventBus ?? inject(),
       _repository = repository ?? inject(),
       super(const OrderUpdateState()) {
    on<FirstAttachmentChanged>(_onFirstAttachmentChanged);
    on<SecondAttachmentChanged>(_onSecondAttachmentChanged);
    on<FinishOrderSubmitted>(_onFinishOrderSubmitted);
  }

  final String _orderId;

  final String _status;

  final EventBus _eventBus;

  final OrderRepository _repository;

  void _onFirstAttachmentChanged(
    FirstAttachmentChanged event,
    Emitter<OrderUpdateState> emit,
  ) {
    emit(
      state.copyWith(
        firstImageAttachment: AttachmentFormz.pure(value: event.attachment),
      ),
    );
  }

  void _onSecondAttachmentChanged(
    SecondAttachmentChanged event,
    Emitter<OrderUpdateState> emit,
  ) {
    emit(state.copyWith(secondImageAttachment: event.attachment));
  }

  Future<void> _onFinishOrderSubmitted(
    FinishOrderSubmitted _,
    Emitter<OrderUpdateState> emit,
  ) async {
    final firstAttachment = AttachmentFormz.dirty(
      value: state.firstImageAttachment.value,
    );

    if (!state.isValid) {
      emit(
        state.copyWith(
          firstImageAttachment: firstAttachment,
          secondImageAttachment: state.secondImageAttachment,
        ),
      );

      return;
    }

    emit(state.copyWith(status: SubmitStatus.loading));

    try {
      final request = FinishOrderRequest(
        firstAttachment: File(firstAttachment.value),
        secondAttachment: state.secondImageAttachment.isNotEmpty
            ? File(state.secondImageAttachment)
            : null,
        status: _status,
      );

      await _repository.finishOrder(id: _orderId, request: request);
      emit(state.copyWith(status: SubmitStatus.success));

      _eventBus.fire(const UpdateOrderEvent());
    } on FinishOrderApiFailure catch (error, stackTrace) {
      emit(state.copyWith(status: SubmitStatus.error));

      addError(error, stackTrace);
    } catch (error, stackTrace) {
      emit(state.copyWith(status: SubmitStatus.error));

      addError(error, stackTrace);
    }
  }
}
