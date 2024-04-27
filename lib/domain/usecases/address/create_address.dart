import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/address_repository.dart';

class CreateAddressParms {
  CreateAddressParms({
    required this.body,
    required this.token,
  });

  Map<String, dynamic> body;
  String token;
}

class CreateAddressUseCase
    implements UseCase<DataState<String?>, CreateAddressParms> {
  CreateAddressUseCase(this._addressRepository);

  final AddressRepository _addressRepository;

  @override
  Future<DataState<String?>> call(CreateAddressParms parms) {
    return _addressRepository.createAddress(
      body: parms.body,
      token: parms.token,
    );
  }
}
