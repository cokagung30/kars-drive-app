import 'package:equatable/equatable.dart';

class CarClass extends Equatable {
  const CarClass({
    required this.name,
    required this.exampleCar,
    required this.feature,
  });

  factory CarClass.fromJson(Map<String, dynamic> json) {
    return CarClass(
      name: json['name'] as String,
      exampleCar: json['example_cars'] as String,
      feature: json['features'] as String,
    );
  }

  final String name;

  final String exampleCar;

  final String feature;

  @override
  List<Object?> get props => [
    name,
    exampleCar,
    feature,
  ];
}
