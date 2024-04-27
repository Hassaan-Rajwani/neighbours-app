import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/address_repository.dart';

class EditAddressParms {
  EditAddressParms({
    required this.body,
    required this.token,
    required this.addressId,
  });

  Map<String, dynamic> body;
  String token;
  String addressId;
}

class EditAddressUseCase
    implements UseCase<DataState<String?>, EditAddressParms> {
  EditAddressUseCase(this._addressRepository);

  final AddressRepository _addressRepository;

  @override
  Future<DataState<String?>> call(EditAddressParms parms) {
    return _addressRepository.editAddress(
      body: parms.body,
      token: parms.token,
      addressId: parms.addressId,
    );
  }
}
