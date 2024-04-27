part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class CreateAddressEvent extends AddressEvent {
  const CreateAddressEvent({required this.body, required this.token});

  final String token;
  final Map<String, dynamic> body;
}

class EditAddressEvent extends AddressEvent {
  const EditAddressEvent({
    required this.body,
    required this.token,
    required this.addressId,
  });

  final String token;
  final String addressId;
  final Map<String, dynamic> body;
}

class DeleteAddressEvent extends AddressEvent {
  const DeleteAddressEvent({required this.id});

  final String id;
}

class ActiveAddressEvent extends AddressEvent {
  const ActiveAddressEvent({required this.id, required this.token});

  final String id;
  final String token;
}

class GetAddressEvent extends AddressEvent {}
