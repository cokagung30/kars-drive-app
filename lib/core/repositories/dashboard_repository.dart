import 'package:equatable/equatable.dart';
import 'package:kars_driver_app/core/api/api.dart';
import 'package:kars_driver_app/core/models/models.dart';

class DashboardFailure with EquatableMixin implements Exception {
  DashboardFailure(this.error);

  final Object error;

  @override
  List<Object?> get props => [error];
}

class FetchSummaryFailure extends DashboardFailure {
  FetchSummaryFailure(super.error);
}

class DashboardRepository {
  DashboardRepository({required DashboardApi dashboardApi})
    : _dashboardApi = dashboardApi;

  final DashboardApi _dashboardApi;

  Future<Summary> getSummary() {
    try {
      final summary = _dashboardApi.summary().then((value) => value);

      return summary;
    } on FetchSummaryApiFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(FetchSummaryFailure(error), stackTrace);
    }
  }
}
