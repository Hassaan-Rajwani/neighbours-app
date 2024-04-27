// ignore_for_file: unrelated_type_equality_checks
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/pages/Addresses/search_new_address.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class SearchAddressButton extends StatelessWidget {
  const SearchAddressButton({
    required this.isFromJobPage,
    super.key,
  });

  final bool isFromJobPage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(
          '''${SearchNewAddress.routeName}?isFromJobPage=${isFromJobPage == true ? 'true' : 'false'}''',
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          left: SizeHelper.moderateScale(20),
          right: SizeHelper.moderateScale(20),
          top: SizeHelper.moderateScale(15),
        ),
        width: SizeHelper.screenWidth,
        height: SizeHelper.moderateScale(50),
        decoration: BoxDecoration(
          color: athensGray,
          borderRadius: BorderRadius.all(
            Radius.circular(
              SizeHelper.moderateScale(10),
            ),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeHelper.moderateScale(10),
              ),
              child: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
            const Text(
              'Search for an address',
              style: TextStyle(
                color: Colors.grey,
                fontFamily: interSemibold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
