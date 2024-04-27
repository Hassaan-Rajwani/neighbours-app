part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

class AddressInitial extends AddressState {}

class CreateAddressInProgress extends AddressState {}

class EditAddressInProgress extends AddressState {}

class DeleteAddressInProgress extends AddressState {}

class GetAddressInProgress extends AddressState {}

class CreateAddressError extends AddressState {
  const CreateAddressError({required this.error});
  final String error;
}

class EditAddressError extends AddressState {
  const EditAddressError({required this.error});
  final String error;
}

class CreateAddressSuccessfull extends AddressState {}

class EditAddressSuccessfull extends AddressState {}

class DeleteAddressSuccessfull extends AddressState {}

class AddressesState extends AddressState {
  const AddressesState({
    required this.list,
  });

  final List<AddressModel> list;
}

class GetAddressError extends AddressState {
  const GetAddressError({required this.error});
  final String error;
}
