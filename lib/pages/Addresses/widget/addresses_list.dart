import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/Addresses/add_new_address.dart';
import 'package:neighbour_app/pages/Addresses/widget/new_address_card.dart';
import 'package:neighbour_app/presentation/bloc/address/address_bloc.dart';
import 'package:neighbour_app/presentation/bloc/getAllHelpers/all_helper_bloc.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/storage.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';

class AddressesList extends StatefulWidget {
  const AddressesList({
    required this.isFromJobPage,
    super.key,
  });

  final String isFromJobPage;

  @override
  State<AddressesList> createState() => _AddressesListState();
}

class _AddressesListState extends State<AddressesList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressBloc, AddressState>(
      builder: (context, state) {
        if (state is GetAddressInProgress) {
          return const CircularLoader(
            height: 40,
          );
        }
        if (state is AddressesState) {
          if (state.list.isEmpty) {
            return Container(
              margin: EdgeInsets.only(
                top: SizeHelper.moderateScale(20),
              ),
              child: const Center(
                child: Text('No addresses available'),
              ),
            );
          }
          return Expanded(
            child: ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                final addressData = state.list[index];
                return InkWell(
                  onTap: () async {
                    final token = await getDataFromStorage(
                      StorageKeys.userToken,
                    );
                    sl<AddressBloc>().add(
                      ActiveAddressEvent(
                        id: addressData.id,
                        token: token!,
                      ),
                    );
                    setState(() {
                      final targetId = state.list[index].id;
                      for (final item in state.list) {
                        item.isDefault = item.id == targetId;
                      }
                    });
                    sl<AllHelperBloc>()
                        .add(GetAllHelpersEvent(miles: 0, rating: 0));
                  },
                  child: NewAddressCard(
                    isDefault: addressData.isDefault,
                    text1: addressData.streetName,
                    text2: formatedAddress(addressData),
                    onDelete: () async {
                      sl<AddressBloc>().add(
                        DeleteAddressEvent(
                          id: addressData.id,
                        ),
                      );
                      setState(() {
                        state.list.removeAt(index);
                      });
                    },
                    onEdit: () {
                      final selectedAddressData = state.list[index];
                      final query = Uri(
                        queryParameters: {
                          'lat': selectedAddressData.lat.toString(),
                          'long': selectedAddressData.long.toString(),
                          'street': selectedAddressData.streetName,
                          'city': selectedAddressData.city,
                          'state': selectedAddressData.state,
                          'zipCode': '${selectedAddressData.zipCode}',
                          'label': selectedAddressData.label,
                          'floor': selectedAddressData.floor,
                          'id': selectedAddressData.id,
                          'onEdit': 'true',
                          'onCurrent': 'false',
                          'isFromJobPage':
                              widget.isFromJobPage == 'true' ? 'true' : 'false',
                        },
                      ).query;
                      context.push(
                        '${AddNewAddress.routeName}?$query',
                      );
                    },
                  ),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}
