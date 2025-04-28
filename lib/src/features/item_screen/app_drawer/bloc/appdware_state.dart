part of 'appdware_bloc.dart';

sealed class AppdwareState extends Equatable {
  const AppdwareState();

  @override
  List<Object> get props => [];
}

final class AppdwareInitial extends AppdwareState {}

final class AppdwareLoadedState extends AppdwareState {
  User userInfo;
  AppdwareLoadedState({required this.userInfo});
  @override
  List<Object> get props => [userInfo];
}
