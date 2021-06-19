abstract class Failure {
  final String message;

  Failure({required this.message});
}

class ApplicationFailure extends Failure {
  ApplicationFailure({required String message}) : super(message: message);
}
