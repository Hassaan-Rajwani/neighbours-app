import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc() : super(NetworkStateConnected()) {
    on<NetworkEventDisconnected>(_onDisconnect);
    on<NetworkEventConnected>(_onConnect);
  }

  Future<void> _onDisconnect(
    NetworkEventDisconnected event,
    Emitter<NetworkState> emit,
  ) async {
    emit(NetworkStateDisconnected());
  }

  Future<void> _onConnect(
    NetworkEventConnected event,
    Emitter<NetworkState> emit,
  ) async {
    emit(NetworkStateConnected());
  }
}
