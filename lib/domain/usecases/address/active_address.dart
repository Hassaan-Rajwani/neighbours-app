import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/address_repository.dart';

class ActiveAddressParms {
  ActiveAddressParms({
    required this.id,
    required this.token,
  });

  String id;
  String token;
}

class ActiveAddressUseCase
    implements UseCase<DataState<String?>, ActiveAddressParms> {
  ActiveAddressUseCase(this._addressRepository);

  final AddressRepository _addressRepository;

  @override
  Future<DataState<String?>> call(ActiveAddressParms parms) {
    return _addressRepository.activeAddress(
      id: parms.id,
      token: parms.token,
    );
  }
}
