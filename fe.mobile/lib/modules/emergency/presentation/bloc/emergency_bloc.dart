import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'emergency_event.dart';
part 'emergency_state.dart';

class EmergencyBloc extends Bloc<EmergencyEvent, EmergencyState> {
  EmergencyBloc() : super(EmergencyInitial());

  @override
  Stream<EmergencyState> mapEventToState(EmergencyEvent event) async* {}
}
