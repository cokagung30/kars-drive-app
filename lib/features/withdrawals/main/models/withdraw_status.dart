import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kars_driver_app/core/models/color_status.dart';

enum WithdrawStatus {
  pending,
  queue,
  approved,
  finish,
  rejected,
  processing,
  canceled,
  failed,
}

class WithdrawStatusModel extends Equatable {
  const WithdrawStatusModel({
    required this.label,
    required this.color,
  });

  final String label;

  final Color color;

  @override
  List<Object?> get props => [label, color];
}

extension WithdrawStatusStringX on String {
  WithdrawStatus get withdrawStatus {
    return switch (this) {
      == 'APPROVED' => WithdrawStatus.finish,
      == 'PROCESSED' => WithdrawStatus.processing,
      == 'REJECTED' => WithdrawStatus.rejected,
      == 'CANCELLED' => WithdrawStatus.canceled,
      == 'QUEUED' => WithdrawStatus.queue,
      == 'FAILED' => WithdrawStatus.failed,
      == 'APPROVED' => WithdrawStatus.approved,
      _ => WithdrawStatus.pending,
    };
  }
}

extension WithdrawStatusX on WithdrawStatus {
  WithdrawStatusModel get model {
    switch (this) {
      case WithdrawStatus.canceled:
        return WithdrawStatusModel(
          label: 'Dibatalkan',
          color: ColorStatus.danger.color,
        );
      case WithdrawStatus.rejected:
        return WithdrawStatusModel(
          label: 'Ditolak',
          color: ColorStatus.danger.color,
        );
      case WithdrawStatus.processing:
        return WithdrawStatusModel(
          label: 'Dalam Process',
          color: ColorStatus.info.color,
        );
      case WithdrawStatus.finish:
        return WithdrawStatusModel(
          label: 'Selesai',
          color: ColorStatus.success.color,
        );
      case WithdrawStatus.queue:
        return WithdrawStatusModel(
          label: 'Dalam Antrean',
          color: ColorStatus.warning.color,
        );
      case WithdrawStatus.failed:
        return WithdrawStatusModel(
          label: 'Gagal',
          color: ColorStatus.danger.color,
        );
      case WithdrawStatus.approved:
        return WithdrawStatusModel(
          label: 'Disetujui',
          color: ColorStatus.success.color,
        );
      case WithdrawStatus.pending:
        return WithdrawStatusModel(
          label: 'Pending',
          color: ColorStatus.init.color,
        );
    }
  }
}
