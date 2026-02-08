import 'package:bloc/bloc.dart';
import 'package:stream_transform/stream_transform.dart';

EventTransformer<Event> debounce<Event>() {
  const duration = Duration(milliseconds: 600);

  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}
