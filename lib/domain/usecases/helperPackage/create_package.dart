// ignore_for_file: unused_field

import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/helpers_package_repository.dart';

class CreatePackageParms {
  CreatePackageParms({
    required this.body,
    required this.token,
    required this.jobId,
  });

  Map<String, dynamic> body;
  String token;
  String jobId;
}

class CreatePackageUseCase
    implements UseCase<DataState<String?>, CreatePackageParms> {
  CreatePackageUseCase(this._helpersPackageRepository);

  final HelpersPackageRepository _helpersPackageRepository;

  @override
  Future<DataState<String?>> call(CreatePackageParms parms) {
    return _helpersPackageRepository.createPackage(
      parms.body,
      parms.token,
      parms.jobId,
    );
  }
}
