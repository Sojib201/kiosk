import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {}

class LoginPerform extends LoginEvent {
  final String cid;
  final String userId;
  final String password;

  LoginPerform(
      {required this.cid, required this.userId, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
