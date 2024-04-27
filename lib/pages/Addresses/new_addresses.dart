// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/Addresses/add_new_address.dart';
import 'package:neighbour_app/pages/Addresses/widget/addresses_list.dart';
import 'package:neighbour_app/pages/Addresses/widget/label_row.dart';
import 'package:neighbour_app/pages/Addresses/widget/nearby_button.dart';
import 'package:neighbour_app/pages/Addresses/widget/search_button.dart';
import 'package:neighbour_app/presentation/bloc/address/address_bloc.dart';
import 'package:neighbour_app/presentation/bloc/helperJobs/helper_jobs_bloc.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/storage.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';
import 'package:neighbour_app/widgets/custom_divider.dart';
import 'package:neighbour_app/widgets/gap.dart';

class NewAddresses extends StatefulWidget {
  const NewAddresses({
    required this.isFromJobPage,
    super.key,
  });

  final String isFromJobPage;

  static const routeName = '/new-addresses';

  @override
  State<NewAddresses> createState() => _NewAddressesState();
}

class _NewAddressesState extends State<NewAddresses> {
  String selectedLabel = '';
  bool isLoading = false;

  @override
  void initState() {
    getLabel();
    sl<AddressBloc>().add(GetAddressEvent());
    super.initState();
  }

  Future<void> getLabel() async {
    final data = await getDataFromStorage(StorageKeys.addressLable);
    setState(() {
      selectedLabel = data!;
    });
  }

  Future<void> getJobUpadted() async {
    sl<HelperJobsBloc>().add(const GetHelperAllJobsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await getJobUpadted();
        return true;
      },
      child: Scaffold(
        appBar: backButtonAppbar(
          context,
          icon: const Icon(Icons.arrow_back),
          text: 'Addresses',
          backgroundColor: Colors.white,
          elevation: false,
          customOntap: true,
          onTap: () {
            getJobUpadted();
            context.pop();
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchAddressButton(
              isFromJobPage: widget.isFromJobPage == 'true',
            ),
            AddressLabelRow(selectedLabel: selectedLabel),
            const Gap(gap: 10),
            const CustomDivider(),
            NearByLocation(
              isLoading: isLoading,
              onTap: () async {
                await getLabel();
                setState(() {
                  isLoading = true;
                });
                final position = await Geolocator.getCurrentPosition(
                  desiredAccuracy: Platform.isAndroid
                      ? LocationAccuracy.high
                      : LocationAccuracy.lowest,
                );
                final addressData = await getAddressFromLatLng(
                  double.parse(position.latitude.toString()),
                  double.parse(position.longitude.toString()),
                );
                if (isAddressCompleteForCurrent(addressData)) {
                  final query = Uri(
                    queryParameters: {
                      'lat': '${position.latitude}',
                      'long': '${position.longitude}',
                      'onEdit': 'false',
                      'onCurrent': 'true',
                      'isFromJobPage':
                          widget.isFromJobPage == 'true' ? 'true' : 'false',
                    },
                  ).query;
                  setState(() {
                    isLoading = false;
                  });
                  await context.push(
                    '${AddNewAddress.routeName}?$query',
                  );
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  showAddressErrorBottomSheet(context: context);
                }
              },
            ),
            const Gap(gap: 10),
            const CustomDivider(),
            const Gap(gap: 10),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: SizeHelper.moderateScale(20),
              ),
              child: Text(
                'Saved Addresses',
                style: TextStyle(
                  fontFamily: interBold,
                  fontSize: SizeHelper.moderateScale(16),
                  color: Colors.black,
                ),
              ),
            ),
            const Gap(gap: 10),
            AddressesList(isFromJobPage: widget.isFromJobPage),
          ],
        ),
      ),
    );
  }
}
