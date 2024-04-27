// ignore_for_file: use_named_constants
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/presentation/bloc/address/address_bloc.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/image_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/storage.dart';
import 'package:neighbour_app/widgets/app_button.dart';
import 'package:neighbour_app/widgets/app_input.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/snackbar.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({
    required this.data,
    super.key,
  });

  static const routeName = '/add-new-address';
  final Map<String, dynamic> data;

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  final Completer<GoogleMapController> controller = Completer();
  final List<Marker> _markers = [];
  BitmapDescriptor customMarker = BitmapDescriptor.defaultMarker;
  TextEditingController unitController = TextEditingController();
  String streetName = '';
  String cityName = '';
  String stateName = '';
  String unitNumber = '';
  int zipCode = 0;
  double lat = 0;
  double long = 0;

  @override
  void initState() {
    super.initState();
    setCustomMarker();
    if (widget.data['onEdit'] == 'false') {
      if (widget.data['onCurrent'] == 'true') {
        whileCurrentAddress();
      } else {
        whileCreatingAddress();
      }
    } else {
      whileEditingAddress();
    }
  }

  Future<void> setCustomMarker() async {
    customMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      platformChecker(
        newMapMarkerAndroid,
        newMapMarker,
      ),
    );
  }

  Future<void> whileCreatingAddress() async {
    final latitude = double.parse(widget.data['lat'].toString());
    final longitude = double.parse(widget.data['long'].toString());

    final mapController = await controller.future;
    await mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 14,
        ),
      ),
    );

    setState(() {
      streetName = widget.data['street'].toString();
      cityName = widget.data['city'].toString();
      stateName = widget.data['state'].toString();
      zipCode = widget.data['zipcode'].toString() != ''
          ? int.parse(extractZipCode(widget.data['zipcode'].toString()))
          : 0;
      lat = double.parse(widget.data['lat'].toString());
      long = double.parse(widget.data['long'].toString());

      _markers
        ..clear()
        ..add(
          Marker(
            markerId: const MarkerId('value'),
            position: LatLng(latitude, longitude),
            icon: customMarker,
          ),
        );
    });
  }

  Future<void> whileCurrentAddress() async {
    final latitude = double.parse(widget.data['lat'].toString());
    final longitude = double.parse(widget.data['long'].toString());

    final mapController = await controller.future;
    await mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 14,
        ),
      ),
    );
    final addressData = await getAddressFromLatLng(
      double.parse(widget.data['lat'].toString()),
      double.parse(widget.data['long'].toString()),
    );
    setState(() {
      streetName = addressData['streetName'].toString();
      cityName = addressData['city'].toString();
      stateName = addressData['state'].toString();
      zipCode = addressData['zipCode'].toString() != ''
          ? int.parse(addressData['zipCode'].toString())
          : 0;
      lat = double.parse(widget.data['lat'].toString());
      long = double.parse(widget.data['long'].toString());

      _markers
        ..clear()
        ..add(
          Marker(
            markerId: const MarkerId('value'),
            position: LatLng(latitude, longitude),
            icon: customMarker,
          ),
        );
    });
  }

  Future<void> whileEditingAddress() async {
    final latitude = double.parse(widget.data['lat'].toString());
    final longitude = double.parse(widget.data['long'].toString());

    final mapController = await controller.future;
    await mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 14,
        ),
      ),
    );
    setState(() {
      unitController = TextEditingController(text: '${widget.data['floor']}');
      streetName = widget.data['street'].toString();
      cityName = widget.data['city'].toString();
      stateName = widget.data['state'].toString();
      zipCode = widget.data['zipCode'] != null
          ? int.parse(widget.data['zipCode'].toString())
          : 0;
      lat = double.parse(widget.data['lat'].toString());
      long = double.parse(widget.data['long'].toString());

      _markers
        ..clear()
        ..add(
          Marker(
            markerId: const MarkerId('value'),
            position: LatLng(latitude, longitude),
            icon: customMarker,
          ),
        );
    });
  }

  Future<void> onCreateAddress() async {
    final token = await getDataFromStorage(StorageKeys.userToken);
    final label = await getDataFromStorage(StorageKeys.addressLable);
    setState(() {
      lat = double.parse(widget.data['lat'].toString());
      long = double.parse(widget.data['long'].toString());
    });
    final body = <String, dynamic>{
      'street_name': streetName,
      'unit_number': unitController.value.text,
      'city': cityName,
      'state': stateName,
      'zip_code': zipCode,
      'label': label ?? 'OTHER',
      'coordinates': [long, lat],
    };
    sl<AddressBloc>().add(
      CreateAddressEvent(
        body: body,
        token: token!,
      ),
    );
  }

  Future<void> onEditAddress() async {
    final token = await getDataFromStorage(StorageKeys.userToken);
    final label = await getDataFromStorage(StorageKeys.addressLable);
    setState(() {
      lat = double.parse(widget.data['lat'].toString());
      long = double.parse(widget.data['long'].toString());
    });
    final body = <String, dynamic>{
      'street_name': streetName,
      'unit_number': unitController.value.text,
      'city': cityName,
      'state': stateName,
      'zip_code': zipCode,
      'label': label ?? 'OTHER',
      'coordinates': [long, lat],
    };
    sl<AddressBloc>().add(
      EditAddressEvent(
        body: body,
        token: token!,
        addressId: widget.data['id'].toString(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cameraPosition = CameraPosition(
      target: LatLng(
        double.parse(widget.data['lat'].toString()),
        double.parse(widget.data['long'].toString()),
      ),
      zoom: 14,
    );

    return BlocListener<AddressBloc, AddressState>(
      listener: (context, state) {
        if (state is CreateAddressSuccessfull) {
          sl<AddressBloc>().add(GetAddressEvent());
          if (widget.data['onEdit'] == 'true' ||
              widget.data['onCurrent'] == 'true') {
            if (widget.data['isFromJobPage'] == 'true') {
              context
                ..pop()
                ..pop();
            } else {
              context.pop();
            }
          } else if (widget.data['isFromJobPage'] == 'true') {
            context
              ..pop()
              ..pop()
              ..pop();
          } else {
            context
              ..pop()
              ..pop();
          }
        }
        if (state is EditAddressSuccessfull) {
          sl<AddressBloc>().add(GetAddressEvent());
          if (widget.data['onEdit'] == 'true') {
            context.pop();
          } else {
            context
              ..pop()
              ..pop();
          }
        }
        if (state is CreateAddressError) {
          snackBarComponent(
            context,
            color: Colors.red,
            message: state.error,
          );
        }
        if (state is EditAddressError) {
          snackBarComponent(
            context,
            color: Colors.red,
            message: state.error,
          );
        }
      },
      child: BlocBuilder<AddressBloc, AddressState>(
        builder: (context, state) {
          return Scaffold(
            appBar: backButtonAppbar(
              context,
              icon: const Icon(Icons.arrow_back),
              text: 'Save Address',
              backgroundColor: Colors.white,
              elevation: false,
            ),
            body: Container(
              margin: EdgeInsets.symmetric(
                horizontal: SizeHelper.moderateScale(20),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: SizeHelper.getDeviceHeight(75),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(gap: 20),
                        SizedBox(
                          height: SizeHelper.moderateScale(160),
                          width: SizeHelper.screenWidth,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              SizeHelper.moderateScale(16),
                            ),
                            child: GoogleMap(
                              initialCameraPosition: cameraPosition,
                              myLocationButtonEnabled: false,
                              zoomControlsEnabled: false,
                              onMapCreated: controller.complete,
                              markers: Set<Marker>.of(_markers),
                            ),
                          ),
                        ),
                        const Gap(gap: 20),
                        Text(
                          streetName,
                          style: TextStyle(
                            fontFamily: interBold,
                            fontSize: SizeHelper.moderateScale(16),
                            color: Colors.black,
                          ),
                        ),
                        const Gap(gap: 10),
                        Text(
                          '$cityName $stateName ${zipCode == 0 ? '' : zipCode}',
                          style: TextStyle(
                            fontFamily: interRegular,
                            fontSize: SizeHelper.moderateScale(14),
                            color: Colors.black,
                          ),
                        ),
                        const Gap(gap: 40),
                        AppInput(
                          placeHolder: 'Unit number',
                          label: 'Unit Number',
                          horizontalMargin: 0,
                          controller: unitController,
                        ),
                      ],
                    ),
                  ),
                  AppButton(
                    text: widget.data['onEdit'] == 'false'
                        ? 'Save Address'
                        : 'Edit Address',
                    horizontalMargin: 0,
                    onPress: widget.data['onEdit'] == 'false'
                        ? onCreateAddress
                        : onEditAddress,
                    buttonLoader: state is CreateAddressInProgress ||
                        state is EditAddressInProgress,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
