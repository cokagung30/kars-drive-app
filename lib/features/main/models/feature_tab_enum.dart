enum FeatureTabEnum { orders, dashboard, withdraw }

extension FeatureTabEnumX on FeatureTabEnum {
  String get label {
    switch (this) {
      case FeatureTabEnum.orders:
        return 'Pesanan';
      case FeatureTabEnum.withdraw:
        return 'Penarikan';
      case FeatureTabEnum.dashboard:
        return 'Dashboard';
    }
  }
}
