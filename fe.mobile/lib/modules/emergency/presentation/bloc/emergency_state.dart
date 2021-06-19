part of 'emergency_bloc.dart';

abstract class EmergencyState extends Equatable {
  const EmergencyState();
  
  @override
  List<Object> get props => [];
}

class EmergencyInitial extends EmergencyState {}
