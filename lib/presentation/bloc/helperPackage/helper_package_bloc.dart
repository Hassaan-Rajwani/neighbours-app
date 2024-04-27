import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/data/models/get_neighbors_package.dart';
import 'package:neighbour_app/domain/usecases/helperPackage/create_package.dart';
import 'package:neighbour_app/domain/usecases/helperPackage/get_package.dart';
import 'package:neighbour_app/utils/storage.dart';
part 'helper_package_event.dart';
part 'helper_package_state.dart';

class HelperPackageBloc extends Bloc<HelperPackageEvent, HelperPackageState> {
  HelperPackageBloc(this._createPackageUsecase, this._getHelperPackageUseCase)
      : super(PackageInitial()) {
    on<CreatePackageEvent>(_createPackage);
    on<GetPackageEvent>(_getPackage);
  }

  final CreatePackageUseCase _createPackageUsecase;
  final GetHelperPackageUseCase _getHelperPackageUseCase;

  Future<void> _createPackage(
    CreatePackageEvent event,
    Emitter<HelperPackageState> emit,
  ) async {
    emit(CreatePackageInprogress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final params = CreatePackageParms(
        body: event.body,
        jobId: event.jobId,
        token: token,
      );
      await _createPackageUsecase(params);
    }
  }

  Future<void> _getPackage(
    GetPackageEvent event,
    Emitter<HelperPackageState> emit,
  ) async {
    emit(GetPackageInprogress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final params = GetHelperPackageParams(
        token: token,
        jobId: event.jobId,
      );
      final dataState = await _getHelperPackageUseCase(params);
      if (dataState.data != null) {
        emit(GetPackageSuccessfull(package: dataState.data!));
      } else {
        emit(GetPackageError(error: dataState.error!.message!));
      }
    }
  }
}
