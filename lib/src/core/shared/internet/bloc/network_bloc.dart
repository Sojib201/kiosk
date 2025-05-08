import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _subscription;

  NetworkBloc() : super(NetworkConnected()) {
    on<CheckNetworkStatus>(_checkConnectivity);

    _connectivity.onConnectivityChanged.listen((result) {
      add(CheckNetworkStatus());
    });
  }

  Future<void> _checkConnectivity(CheckNetworkStatus event, Emitter<NetworkState> emit) async {
    final result = await _connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.none)) {
      emit(NetworkDisconnected());
    } else {
      emit(NetworkConnected());
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
