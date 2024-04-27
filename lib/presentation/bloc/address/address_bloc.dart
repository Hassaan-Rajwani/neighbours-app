import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/data/models/address.dart';
import 'package:neighbour_app/domain/usecases/address/active_address.dart';
import 'package:neighbour_app/domain/usecases/address/create_address.dart';
import 'package:neighbour_app/domain/usecases/address/delete_address.dart';
import 'package:neighbour_app/domain/usecases/address/edit_address.dart';
import 'package:neighbour_app/domain/usecases/address/get_address.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/presentation/bloc/getAllHelpers/all_helper_bloc.dart';
import 'package:neighbour_app/utils/storage.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc(
    this._createAddressUseCase,
    this._getAddressListUseCase,
    this._deleteAddressUseCase,
    this._editAddressUseCase,
    this._activeAddressUseCase,
  ) : super(AddressInitial()) {
    on<CreateAddressEvent>(_createAddress);
    on<GetAddressEvent>(_getAddressList);
    on<DeleteAddressEvent>(_deleteAddress);
    on<EditAddressEvent>(_editAddress);
    on<ActiveAddressEvent>(_activeAddress);
  }

  final CreateAddressUseCase _createAddressUseCase;
  final GetAddressUseCase _getAddressListUseCase;
  final DeleteAddressUseCase _deleteAddressUseCase;
  final EditAddressUseCase _editAddressUseCase;
  final ActiveAddressUseCase _activeAddressUseCase;

  Future<Map<String, dynamic>?> _createAddress(
    CreateAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(CreateAddressInProgress());
    final params = CreateAddressParms(
      body: event.body,
      token: event.token,
    );
    final dataState = await _createAddressUseCase(params);
    if (dataState.data == null) {
      emit(CreateAddressSuccessfull());
      sl<AllHelperBloc>().add(GetAllHelpersEvent(miles: 0, rating: 0));
    } else {
      emit(CreateAddressError(error: dataState.error!.message!));
    }
    return null;
  }

  Future<Map<String, dynamic>?> _editAddress(
    EditAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(EditAddressInProgress());
    final params = EditAddressParms(
      body: event.body,
      token: event.token,
      addressId: event.addressId,
    );
    final dataState = await _editAddressUseCase(params);
    if (dataState.data == null) {
      emit(EditAddressSuccessfull());
      sl<AllHelperBloc>().add(GetAllHelpersEvent(miles: 0, rating: 0));
    } else {
      emit(EditAddressError(error: dataState.error!.message!));
    }
    return null;
  }

  Future<Map<String, dynamic>?> _deleteAddress(
    DeleteAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    final params = DeleteAddressParms(
      id: event.id,
    );
    await _deleteAddressUseCase(params);
    return null;
  }

  Future<Map<String, dynamic>?> _activeAddress(
    ActiveAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    final params = ActiveAddressParms(
      id: event.id,
      token: event.token,
    );
    await _activeAddressUseCase(params);
    return null;
  }

  Future<void> _getAddressList(
    GetAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(GetAddressInProgress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final dataState = await _getAddressListUseCase(token);
      if (dataState.data != null) {
        emit(AddressesState(list: dataState.data!));
      } else {
        emit(GetAddressError(error: dataState.error!.message!));
      }
    }
  }
}
