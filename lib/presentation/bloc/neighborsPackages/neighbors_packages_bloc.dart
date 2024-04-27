// ignore_for_file: body_might_complete_normally_nullable
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/data/models/get_neighbors_package.dart';
import 'package:neighbour_app/domain/usecases/neighborsPacakge/get_neighbors_packages_usecase.dart';
import 'package:neighbour_app/domain/usecases/neighborsPacakge/give_tip_usecase.dart';
import 'package:neighbour_app/domain/usecases/neighborsPacakge/update_neighbor_package_usecase.dart';
import 'package:neighbour_app/utils/storage.dart';
part 'neighbors_packages_event.dart';
part 'neighbors_packages_state.dart';

class NeighborsPackagesBloc
    extends Bloc<NeighborsPackagesEvent, NeighborsPackagesState> {
  NeighborsPackagesBloc(
    this._getNeighborsPackageUseCase,
    this._updateNeighborsPackageUseCase,
    this._giveTipUseCase,
  ) : super(NeighborsPackagesInitial()) {
    on<GetNeighborsPackage>(_getNeighborsPackage);
    on<UpdateNeighborsPackage>(_updateNeighborsPackage);
    on<GiveTip>(_giveTip);
  }

  final GetNeighborPackageUseCase _getNeighborsPackageUseCase;
  final UpdateNeighborPackageUseCase _updateNeighborsPackageUseCase;
  final GiveTipUseCase _giveTipUseCase;

  Future<void> _getNeighborsPackage(
    GetNeighborsPackage event,
    Emitter<NeighborsPackagesState> emit,
  ) async {
    emit(GetNeighborsPackageInProgress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final params = GetNeighborsPackageParms(
        jobId: event.jobId,
        token: token,
      );
      final dataState = await _getNeighborsPackageUseCase(params);
      if (dataState.data != null) {
        emit(GetNeighborsSuccessfull(packageData: dataState.data!));
      }
    }
  }

  Future<void> _updateNeighborsPackage(
    UpdateNeighborsPackage event,
    Emitter<NeighborsPackagesState> emit,
  ) async {
    emit(UpdateNeighborsPackageInProgress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final params = UpdateNeighborsPackageParms(
        jobId: event.jobId,
        token: token,
        packageId: event.packageId,
      );
      await _updateNeighborsPackageUseCase(params);
    }
  }

  Future<String?> _giveTip(
    GiveTip event,
    Emitter<NeighborsPackagesState> emit,
  ) async {
    emit(TipInProgress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final params = TipBody(
        token: token,
        tipBody: event.tipBody,
      );
      final dataState = await _giveTipUseCase(params);
      if (dataState.data == null) {
        emit(GiveTipSuccessfull());
      } else {
        emit(GiveTipError(error: dataState.error!.message!));
      }
    }
  }
}
