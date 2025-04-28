import 'package:equatable/equatable.dart';

abstract class RegistrationState extends Equatable {}

class RegistrationInitial extends RegistrationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegistrationLoading extends RegistrationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegistrationSuccess extends RegistrationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegistrationFailure extends RegistrationState {
  final String errorMessage;
  RegistrationFailure(this.errorMessage);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
