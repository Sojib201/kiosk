part of 'appdware_bloc.dart';

sealed class AppdwareEvent extends Equatable {
  const AppdwareEvent();

  @override
  List<Object> get props => [];
}

final class LoaddedUserInfoEvent extends AppdwareEvent {}
