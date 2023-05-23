import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  final String status;
  final String errorMsg;

  ServerFailure(this.status, this.errorMsg);

  @override
  List<Object> get props => [
        status,
        errorMsg,
      ];
}

class ConnectionFailure extends Failure {}

class LocalStorageFailure extends Failure {}

class UnknownFailure extends Failure {}
