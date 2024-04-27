part of 'network_bloc.dart';

abstract class NetworkEvent extends Equatable {
  const NetworkEvent();

  @override
  List<Object> get props => [];
}

class NetworkEventConnected extends NetworkEvent {}

class NetworkEventDisconnected extends NetworkEvent {}
