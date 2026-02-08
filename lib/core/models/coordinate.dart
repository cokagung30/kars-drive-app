import 'package:equatable/equatable.dart';

class Coordinate extends Equatable {
  const Coordinate({
    required this.latitude,
    required this.longitude,
  });

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    return Coordinate(
      latitude: num.parse(json['latitude'] as String),
      longitude: num.parse(json['longitude'] as String),
    );
  }

  final num latitude;

  final num longitude;

  @override
  List<Object?> get props => [latitude, longitude];
}
