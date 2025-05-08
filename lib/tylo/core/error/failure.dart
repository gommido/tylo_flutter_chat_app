
abstract class Failure {
  final String message;

  const Failure({
    required this.message,
  });
}

class FireBaseFailure extends Failure{
  const FireBaseFailure({required super.message});

}

class LocalFailure extends Failure{
  const LocalFailure({required super.message});

}