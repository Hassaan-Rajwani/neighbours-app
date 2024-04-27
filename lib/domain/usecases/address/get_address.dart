import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/models/address.dart';
import 'package:neighbour_app/domain/repository/address_repository.dart';

class GetAddressUseCase
    implements UseCase<DataState<List<AddressModel>>, String> {
  GetAddressUseCase(this._addressRepository);

  final AddressRepository _addressRepository;

  @override
  Future<DataState<List<AddressModel>>> call(String token) {
    return _addressRepository.getAddressList(token);
  }
}
