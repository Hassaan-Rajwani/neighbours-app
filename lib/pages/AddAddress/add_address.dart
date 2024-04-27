// ignore_for_file: use_named_constants, depend_on_referenced_packages, avoid_dynamic_calls, lines_longer_than_80_chars
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:neighbour_app/config/environments.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/AddAddress/apis/map_apis.dart';
import 'package:neighbour_app/pages/AddAddress/widget/bottomsheetWidget.dart';
import 'package:neighbour_app/pages/AddAddress/widget/ciricle_icon_with_label.dart';
import 'package:neighbour_app/presentation/bloc/address/address_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/image_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/storage.dart';
import 'package:neighbour_app/widgets/app_button.dart';
import 'package:neighbour_app/widgets/app_input.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/snackbar.dart';
import 'package:uuid/uuid.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({
    required this.addressData,
    super.key,
  });

  final Map<String, dynamic> addressData;

  static const routeName = '/add-address';

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  bool isExtended = false;
  bool isContracted = false;
  final Completer<GoogleMapController> _controller = Completer();
  List<Marker> _markers = [];
  List<dynamic> _placeLists = [];
  dynamic sessionToken;
  List<dynamic> userAddressData = [];
  final String mapApiKey = '${dotenv.env[Environments.mapApiKey]}';
  BitmapDescriptor customMarker = BitmapDescriptor.defaultMarker;
  String selectedLabel = 'HOME';
  final _formKey = GlobalKey<FormState>();
  final uuid = const Uuid();
  GlobalKey<ExpandableBottomSheetState> bottomSheetKey = GlobalKey();
  TextEditingController searchController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  String selectedHouseNumber = '';
  String selectedStreetName = '';
  String selectedState = '';
  String selectedCountry = '';
  String selectedZip = '';
  double lat = 0.1;
  double long = 0.1;

  @override
  void initState() {
    super.initState();
    setCustomMarker();
    if (widget.addressData.isEmpty) {
      getCurrentLocation();
      searchController.addListener(onChangeText);
    } else {
      searchController.addListener(onChangeText);
      addressFromBack();
    }
  }

  void onChangeText() {
    if (sessionToken == null) {
      setState(() {
        sessionToken = uuid.v4();
      });
    }
    getSuggestion(searchController.text);
  }

  Future<void> getSuggestion(String input) async {
    try {
      const baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      final request =
          '$baseURL?input=$input&key=$mapApiKey&sessiontoken=$sessionToken';
      final response = await http.get(Uri.parse(request));
      if (response.statusCode == 200) {
        setState(() {
          _placeLists =
              jsonDecode(response.body)['predictions'] as List<dynamic>;
        });
      }
    } catch (e) {
      debugPrint('$e Failed to load data ');
    }
  }

  // getAddress flow
  Future<void> getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final controller = await _controller.future;

      final userLocation = LatLng(position.latitude, position.longitude);
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: userLocation,
            zoom: 14.151926040649414,
          ),
        ),
      );
      await updateAddress(userLocation);
      setState(() {
        _markers
          ..clear()
          ..add(
            Marker(
              markerId: const MarkerId('value'),
              position: userLocation,
              icon: customMarker,
            ),
          );
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<Map<String, String>> getAddress(
    double latitude,
    double longitude,
  ) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        final houseNumber = placemark.subThoroughfare ?? '';
        final streetName = placemark.street ?? '';
        final state = placemark.administrativeArea ?? '';
        final country = placemark.country ?? '';
        final city = placemark.subAdministrativeArea ?? '';
        final zipCode = placemark.postalCode ?? '';

        streetController = TextEditingController(
          text: streetName,
        );
        cityController = TextEditingController(
          text: city,
        );
        stateController = TextEditingController(
          text: state,
        );
        zipCodeController = TextEditingController(
          text: zipCode,
        );

        return {
          'houseNumber': houseNumber,
          'streetName': streetName,
          'state': state,
          'city': city,
          'country': country,
          'zipCode': zipCode,
        };
      } else {
        return {
          'houseNumber': 'No house number found',
          'streetName': 'No street found',
          'state': 'No state found',
          'country': 'No country found',
        };
      }
    } catch (e) {
      return {
        'houseNumber': 'No house number found',
        'streetName': 'No street found',
        'state': 'No state found',
        'country': 'Error retrieving address',
      };
    }
  }

  Future<void> addressFromBack() async {
    final latitude = double.parse(widget.addressData['lat'] as String);
    final longitude = double.parse(widget.addressData['long'] as String);

    final controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 14.151926040649414,
        ),
      ),
    );

    setState(() {
      selectedHouseNumber = widget.addressData['city'].toString();
      selectedStreetName = widget.addressData['state'].toString();
      selectedState = widget.addressData['state'].toString();
      selectedCountry = widget.addressData['city'].toString();

      streetController = TextEditingController(
        text: widget.addressData['street'].toString(),
      );
      stateController = TextEditingController(
        text: widget.addressData['state'].toString(),
      );
      cityController = TextEditingController(
        text: widget.addressData['city'].toString(),
      );
      zipCodeController = TextEditingController(
        text: widget.addressData['zip'].toString(),
      );
      floorController = TextEditingController(
        text: widget.addressData['floor'].toString(),
      );
      selectedLabel = widget.addressData['label'].toString();

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

  Future<void> updateGetAddress() async {
    final latitude = double.parse(widget.addressData['lat'] as String);
    final longitude = double.parse(widget.addressData['long'] as String);

    final address = await getAddress(latitude, longitude);

    final controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 14.151926040649414,
        ),
      ),
    );

    setState(() {
      selectedHouseNumber = address['houseNumber']!;
      selectedStreetName = address['streetName']!;
      selectedState = address['state']!;
      selectedCountry = address['country']!;

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
  // till here

  // Update Address flow
  Future<void> updateAddress(LatLng latLng) async {
    final addressInfo =
        await getAddressFromLatLng(latLng.latitude, latLng.longitude);
    setState(() {
      selectedHouseNumber = addressInfo['houseNumber']!;
      selectedStreetName = addressInfo['streetName']!;
      selectedState = addressInfo['state']!;
      selectedCountry = addressInfo['country']!;
      lat = latLng.latitude;
      long = latLng.longitude;
    });
  }

  Future<Map<String, String>> getAddressFromLatLng(
    double latitude,
    double longitude,
  ) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;

        final houseNumber = placemark.subThoroughfare ?? '';
        final streetName = placemark.street ?? '';
        final state = placemark.administrativeArea ?? '';
        final country = placemark.country ?? '';
        final city = placemark.subAdministrativeArea ?? '';
        final zipCode = placemark.postalCode ?? '';

        streetController = TextEditingController(
          text: streetName,
        );
        cityController = TextEditingController(
          text: city,
        );
        stateController = TextEditingController(
          text: state,
        );
        zipCodeController = TextEditingController(
          text: zipCode,
        );

        return {
          'houseNumber': houseNumber,
          'streetName': streetName,
          'state': state,
          'city': city,
          'country': country,
          'zipCode': zipCode,
        };
      } else {
        return {
          'houseNumber': 'No house number found',
          'streetName': 'No street found',
          'state': 'No state found',
          'country': 'No country found',
        };
      }
    } catch (e) {
      return {
        'houseNumber': 'No house number found',
        'streetName': 'No street found',
        'state': 'No state found',
        'country': 'Error retrieving address',
      };
    }
  }
  // till here

  Future<void> setCustomMarker() async {
    customMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      // mapMarkerNew,
      platformChecker(
        mapMarker,
        mapMarkerIos,
      ),
    );
  }

  final _cameraPosition = const CameraPosition(
    target: LatLng(37.422131, -122.084801),
    zoom: 14,
  );

  String getButtonText() {
    return isExtended ? 'Save and Continue' : 'Apply Changes';
  }

  void onExtendedChanged() {
    setState(() {
      isExtended = true;
    });
  }

  void onClose() {
    setState(() {
      isExtended = false;
    });
  }

  Future<void> onCreateAddress() async {
    bottomSheetKey.currentState?.expand();
    final token = await getDataFromStorage(StorageKeys.userToken);
    final label = selectedLabel;
    final street = streetController.value.text;
    final city = cityController.value.text;
    final state = stateController.value.text;
    final floor = floorController.value.text;
    final zipCode = zipCodeController.value.text == ''
        ? zipCodeController.value.text
        : int.parse(zipCodeController.value.text);
    final body = <String, dynamic>{
      'street_name': street,
      'unit_number': floor == '' ? ' ' : floor,
      'city': city,
      'state': state,
      'zip_code': zipCode,
      'label': label,
      'coordinates': [long, lat],
    };
    if (_formKey.currentState!.validate()) {
      sl<AddressBloc>().add(
        CreateAddressEvent(
          body: body,
          token: token!,
        ),
      );
    }
  }

  Future<void> onEditAddress() async {
    setState(() {
      lat = double.parse('${widget.addressData['lat']}');
      long = double.parse('${widget.addressData['long']}');
    });
    bottomSheetKey.currentState?.expand();
    final token = await getDataFromStorage(StorageKeys.userToken);
    final label = selectedLabel;
    final street = streetController.value.text;
    final city = cityController.value.text;
    final state = stateController.value.text;
    final floor = floorController.value.text;
    final zipCode = zipCodeController.value.text == ''
        ? zipCodeController.value.text
        : int.parse(zipCodeController.value.text);
    final body = <String, dynamic>{
      'street_name': street,
      'unit_number': floor == '' ? ' ' : floor,
      'city': city,
      'state': state,
      'zip_code': zipCode,
      'label': label,
      'coordinates': [long, lat],
    };
    if (_formKey.currentState!.validate()) {
      sl<AddressBloc>().add(
        EditAddressEvent(
          body: body,
          token: token!,
          addressId: widget.addressData['id'].toString(),
        ),
      );
    }
  }

  Future<void> onSearchAddress({
    required Map<String, dynamic> data,
    required double lat,
    required double long,
  }) async {
    if (data.isNotEmpty) {
      final streetName = data['street'].toString();
      final state = data['state'].toString();
      final country = data['country'].toString();
      final city = data['city'].toString();
      final zipCode = data['zipcode'].toString();

      streetController = TextEditingController(
        text: streetName,
      );
      cityController = TextEditingController(
        text: city,
      );
      stateController = TextEditingController(
        text: state,
      );
      zipCodeController = TextEditingController(
        text: zipCode,
      );

      setState(() {
        selectedStreetName = streetName;
        selectedState = state;
        selectedCountry = country;
        lat = lat;
        long = long;
      });
    }
    final controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, long),
          zoom: 14,
        ),
      ),
    );
    setState(
      () {
        _markers = [
          ..._markers,
          Marker(
            markerId: const MarkerId('search_location'),
            position: LatLng(lat, long),
            icon: customMarker,
          ),
        ];
        _placeLists.clear();
        keyboardDismissle(context: context);
      },
    );
  }

  Future<void> userAddress({required String userSelectedAddress}) async {
    final data = await getDataFromPlaces(userSelectedAddress);
    setState(() {
      lat = double.parse(data!['latitude'].toString());
      long = double.parse(data['longitude'].toString());
    });
    await onSearchAddress(
      data: data!['address'] as Map<String, dynamic>,
      lat: lat,
      long: long,
    );
  }

  Widget _backgroundWidget() {
    return Container(
      height: SizeHelper.screenHeight,
      width: SizeHelper.screenWidth,
      color: Colors.white,
      child: Stack(
        children: [
          //==========
          //GOOGLE MAP
          SizedBox(
            height: SizeHelper.screenHeight,
            width: SizeHelper.screenWidth,
            child: GoogleMap(
              initialCameraPosition: _cameraPosition,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              onMapCreated: _controller.complete,
              markers: Set<Marker>.of(_markers),
              onTap: (LatLng latLng) {
                setState(() {
                  _markers.clear();
                });
                updateAddress(latLng);
                setState(() {
                  lat = latLng.latitude;
                  long = latLng.longitude;
                });
                setState(() {
                  _markers.add(
                    Marker(
                      markerId: const MarkerId('value'),
                      position: latLng,
                      icon: customMarker,
                    ),
                  );
                });
              },
            ),
          ),

          Column(
            children: [
              Gap(gap: Platform.isAndroid ? 15 : 45),
              AppInput(
                placeHolder: 'Search Places',
                controller: searchController,
                bottomMargin: 5,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                color: athensGray,
                child: Column(
                  children: List.generate(
                    _placeLists.length,
                    (index) => ListTile(
                      onTap: () async {
                        await userAddress(
                          userSelectedAddress:
                              _placeLists[index]['place_id'].toString(),
                        );
                        searchController.text =
                            _placeLists[index]['description'].toString();
                      },
                      title: Text(_placeLists[index]['description'].toString()),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _expandedWidget() {
    final iconTapList = [
      {'label': 'Home', 'icon': 'assets/svgs/home.svg'},
      {'label': 'Work', 'icon': 'assets/svgs/work.svg'},
      {'label': 'Other', 'icon': 'assets/svgs/labellocation.svg'},
    ];
    return GestureDetector(
      onTap: () {
        keyboardDismissle(context: context);
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: MapBottomSheet(
          floor: floorController,
          house: houseController,
          street: streetController,
          city: cityController,
          state: stateController,
          postalCode: zipCodeController,
          formKey: _formKey,
          floorData: selectedHouseNumber,
          houseData: selectedCountry,
          streetData: selectedState,
          labels: Row(
            children: iconTapList.asMap().entries.map((entry) {
              final index = entry.key;
              final labelData = entry.value;
              return CircleIconWithLabel(
                icon: labelData['icon']!,
                label: labelData['label']!,
                onTap: (tappedIndex) {
                  setState(() {
                    selectedLabel = checkAddressSelectedTab(tappedIndex);
                  });
                },
                index: index,
                circleColor:
                    checkAddressSelectedTabFromName(selectedLabel) == index
                        ? cornflowerBlue
                        : Colors.white,
                iconColor:
                    checkAddressSelectedTabFromName(selectedLabel) == index
                        ? Colors.white
                        : cornflowerBlue,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressBloc, AddressState>(
      listener: (context, state) {
        if (state is CreateAddressSuccessfull) {
          sl<AddressBloc>().add(GetAddressEvent());
          context.pop();
          return;
        }
        if (state is EditAddressSuccessfull) {
          sl<AddressBloc>().add(GetAddressEvent());
          context.pop();
          return;
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
            resizeToAvoidBottomInset: false,
            body: GestureDetector(
              onTap: () {
                keyboardDismissle(context: context);
              },
              child: ExpandableBottomSheet(
                key: bottomSheetKey,
                persistentContentHeight: 130,
                persistentFooter: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: SizeHelper.moderateScale(20),
                    horizontal: SizeHelper.moderateScale(20),
                  ),
                  color: Colors.white,
                  child: AppButton(
                    onPress: widget.addressData.isEmpty
                        ? onCreateAddress
                        : onEditAddress,
                    horizontalMargin: 0,
                    text: getButtonText(),
                    buttonLoader: state is CreateAddressInProgress ||
                        state is EditAddressInProgress,
                  ),
                ),
                onIsExtendedCallback: onExtendedChanged,
                onIsContractedCallback: onClose,
                background: _backgroundWidget(),
                enableToggle: true,
                persistentHeader: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(SizeHelper.moderateScale(50)),
                      topRight: Radius.circular(SizeHelper.moderateScale(50)),
                    ),
                  ),
                ),
                expandableContent: _expandedWidget(),
              ),
            ),
          );
        },
      ),
    );
  }
}
