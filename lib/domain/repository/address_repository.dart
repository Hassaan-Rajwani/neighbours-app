import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/models/address.dart';

abstract class AddressRepository {
  Future<DataState<String?>> createAddress({
    required Map<String, dynamic> body,
    required String token,
  });
  Future<DataState<String?>> editAddress({
    required Map<String, dynamic> body,
    required String token,
    required String addressId,
  });
  Future<DataState<String?>> deleteAddress({
    required String id,
  });
  Future<DataState<String?>> activeAddress({
    required String id,
    required String token,
  });
  Future<DataState<List<AddressModel>>> getAddressList(String token);
}
