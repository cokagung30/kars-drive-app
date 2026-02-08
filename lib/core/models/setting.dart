import 'package:equatable/equatable.dart';

class Setting extends Equatable {
  const Setting({
    this.isIntroDone = false,
  });

  final bool isIntroDone;

  @override
  List<Object?> get props => [isIntroDone];
}
