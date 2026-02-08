part of 'landing_bloc.dart';

abstract class LandingEvent extends Equatable {
  const LandingEvent();

  @override
  List<Object?> get props => [];
}

class IntroDoneSaved extends LandingEvent {
  const IntroDoneSaved();
}
