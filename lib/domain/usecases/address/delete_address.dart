import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/address_repository.dart';

class DeleteAddressParms {
  DeleteAddressParms({
    required this.id,
  });

  String id;
}

class DeleteAddressUseCase
    implements UseCase<DataState<String?>, DeleteAddressParms> {
  DeleteAddressUseCase(this._addressRepository);

  final AddressRepository _addressRepository;

  @override
  Future<DataState<String?>> call(DeleteAddressParms parms) {
    return _addressRepository.deleteAddress(
      id: parms.id,
    );
  }
}
