import 'package:equatable/equatable.dart';

enum NotificationType { share, invite, monitor, alert, alarm }

class Notification extends Equatable {
  final String id;
  final DateTime when;
  final NotificationType type;

  Notification(this.id, this.when, this.type) : super();

  @override
  List<Object?> get props => [this.id];
}
