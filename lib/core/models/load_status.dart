enum LoadStatus { initial, loading, success, error }

extension LoadstatusX on LoadStatus {
  bool get isSuccess => this == LoadStatus.success;

  bool get isError => this == LoadStatus.error;

  bool get isLoading => this == LoadStatus.loading;
}
