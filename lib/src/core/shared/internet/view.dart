import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/network_bloc.dart';

class NetworkWidget extends StatelessWidget {
  final Widget onlineWidget;

  const NetworkWidget({super.key, required this.onlineWidget});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (context, state) {
        if (state is NetworkConnected) {
          return onlineWidget;
        } else {
          return _offlineWidget(context);
        }
      },
    );
  }

  Widget _offlineWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off, size: 50, color: Colors.red),
          SizedBox(height: 10),
          Text("No Internet Connection", style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<NetworkBloc>().add(CheckNetworkStatus());
            },
            child: Text("Try Again"),
          ),
        ],
      ),
    );
  }
}
