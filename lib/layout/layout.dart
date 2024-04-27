import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighbour_app/global/networkBloc/network_bloc.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/widgets/no_internet.dart';

class Layout extends StatefulWidget {
  const Layout({required this.child, super.key});

  final Widget child;

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      sl<NetworkBloc>().add(NetworkEventDisconnected());
    } else {
      sl<NetworkBloc>().add(NetworkEventConnected());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (context, state) {
        if (state is NetworkStateDisconnected) {
          return const NoInternetSplash();
        }

        return widget.child;
      },
    );
  }
}
