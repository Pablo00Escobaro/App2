import 'dart:core';
import 'package:app2/internal/time_bloc/time_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//без учета часовых поясов
//no time zones
class TimeBloc extends Bloc<TimeEvent, DateTime> {
  TimeBloc() : super(DateTime.now()) {
    on<InitTime>(_initTime);
  }
  void _initTime(InitTime event, Emitter<DateTime> emit) => emit(DateTime.now());
}
