// ignore_for_file: inference_failure_on_function_invocation
import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/data/models/helpers_pending_job.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/Addresses/new_addresses.dart';
import 'package:neighbour_app/pages/AllJobs/widgets/helper_package_details.dart';
import 'package:neighbour_app/pages/stripe/add_stripe.dart';
import 'package:neighbour_app/presentation/bloc/address/address_bloc.dart';
import 'package:neighbour_app/presentation/bloc/helperBids/helper_bid_bloc.dart';
import 'package:neighbour_app/presentation/bloc/profile/profile_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/storage.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/app_button_small.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/place_bid_modal_sheet.dart';
import 'package:neighbour_app/widgets/rating_box.dart';
import 'package:neighbour_app/widgets/snackbar.dart';

class HelperNewJobsCard extends StatefulWidget {
  const HelperNewJobsCard({
    required this.allJobslist,
    super.key,
  });
  final HelpersPendingJobModel allJobslist;

  @override
  State<HelperNewJobsCard> createState() => _HelperNewJobsCardState();
}

class _HelperNewJobsCardState extends State<HelperNewJobsCard> {
  bool isButtonClicked = false;
  bool isUserIdFound = false;
  String bidStatus = '';
  bool bankDetailsSubmitted = false;

  void resetButtonClickedState() {
    setState(() {
      isButtonClicked = false;
    });
  }

  void activeButtonClickedState() {
    setState(() {
      isButtonClicked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bytes = widget.allJobslist.neighbourId.imageUrl != '' &&
            widget.allJobslist.neighbourId.imageUrl != 'null' &&
            widget.allJobslist.neighbourId.imageUrl != null
        ? base64Decode(widget.allJobslist.neighbourId.imageUrl.toString())
        : null;
    final userState = BlocProvider.of<ProfileBloc>(context).state;

    final singleType = widget.allJobslist.pickupType[0].pascalCase;
    var doubleType = singleType;
    if (widget.allJobslist.pickupType.length > 1) {
      doubleType =
          '''$singleType & ${widget.allJobslist.pickupType[1].pascalCase}''';
    }

    if (userState is ProfileInitial) {
      final userId = userState.id;
      setState(() {
        bankDetailsSubmitted = userState.bankDetails;
      });
      for (final bid in widget.allJobslist.bids) {
        if (bid.helperId == userId) {
          isUserIdFound = true;
          bidStatus = bid.status;
          break;
        }
      }

      return Container(
        margin: EdgeInsets.only(
          bottom: isButtonClicked ? SizeHelper.moderateScale(20) : 0,
        ),
        padding: EdgeInsets.only(bottom: SizeHelper.moderateScale(10)),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(SizeHelper.moderateScale(8))),
          boxShadow: isButtonClicked
              ? [const BoxShadow(color: cornflowerBlue, offset: Offset(0, 4))]
              : null,
          border: Border.all(
            color: isButtonClicked ? cornflowerBlue : Colors.transparent,
            width: SizeHelper.moderateScale(1),
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(SizeHelper.moderateScale(15)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              SizeHelper.moderateScale(
                8,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            bytes != null ? MemoryImage(bytes) : null,
                        backgroundColor:
                            bytes != null ? Colors.transparent : codGray,
                        child: bytes == null
                            ? Text(
                                getInitials(
                                  firstName:
                                      widget.allJobslist.neighbourId.firstName,
                                  lastName:
                                      widget.allJobslist.neighbourId.lastName,
                                ),
                                style: TextStyle(
                                  fontFamily: ralewayBold,
                                  fontSize: SizeHelper.moderateScale(16),
                                  color: Colors.white,
                                ),
                              )
                            : null,
                      ),
                      const Gap(
                        gap: 15,
                        axis: 'x',
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '''${widget.allJobslist.neighbourId.firstName} ${widget.allJobslist.neighbourId.lastName}''',
                            style: TextStyle(
                              fontFamily: interMedium,
                              fontSize: SizeHelper.moderateScale(14),
                              color: codGray,
                            ),
                          ),
                          const Gap(gap: 5),
                          RatingBox(
                            rating: widget.allJobslist.neighbourId.helper.rating
                                .toStringAsFixed(1),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Dist.',
                        style: TextStyle(
                          fontFamily: interSemibold,
                          fontSize: SizeHelper.moderateScale(12),
                          color: codGray,
                        ),
                      ),
                      const Gap(gap: 5),
                      Text(
                        '''${widget.allJobslist.helperDistance.toStringAsFixed(1)} ${widget.allJobslist.distanceUnit}''',
                        style: TextStyle(
                          fontFamily: interMedium,
                          fontSize: SizeHelper.moderateScale(12),
                          color: cornflowerBlue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(gap: 10),
              Container(
                margin: EdgeInsets.only(
                  left: SizeHelper.moderateScale(2),
                ),
                child: Text(
                  widget.allJobslist.title,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontFamily: interSemibold,
                    fontSize: SizeHelper.moderateScale(14),
                    color: codGray,
                  ),
                ),
              ),
              const Gap(gap: 10),
              Row(
                children: [
                  SvgPicture.asset(locationIconBlue),
                  const Gap(
                    gap: 5,
                    axis: 'x',
                  ),
                  SizedBox(
                    width: SizeHelper.getDeviceWidth(75),
                    child: Text(
                      '''${widget.allJobslist.address.streetName} ${formatedAddress(widget.allJobslist.address)}''',
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontFamily: interMedium,
                        fontSize: SizeHelper.moderateScale(12),
                        color: codGray,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(gap: 10),
              Row(
                children: [
                  HelperPackageDetails(
                    borderDirectional: const BorderDirectional(
                      end: BorderSide(color: silver),
                      bottom: BorderSide(color: silver),
                    ),
                    image: amountIcon,
                    title: 'Amount',
                    amount: true,
                    typeText: '\$${widget.allJobslist.budget}',
                  ),
                  HelperPackageDetails(
                    borderDirectional: const BorderDirectional(
                      bottom: BorderSide(color: silver),
                    ),
                    image: recurringIcon,
                    padding: true,
                    imageColor: baliHai,
                    title: 'Job Type',
                    typeText: checkJobTypeFormat(widget.allJobslist.type),
                  ),
                ],
              ),
              Row(
                children: [
                  HelperPackageDetails(
                    borderDirectional: const BorderDirectional(
                      end: BorderSide(color: silver),
                    ),
                    image: packageIconTwo,
                    imageColor: baliHai,
                    title: 'Type',
                    typeText: widget.allJobslist.pickupType.length == 1
                        ? 'Parcel $singleType'
                        : 'Parcel $doubleType',
                  ),
                  HelperPackageDetails(
                    borderDirectional: const BorderDirectional(),
                    image: sizeIcon,
                    title: 'Size',
                    typeText: widget.allJobslist.size[0].pascalCase,
                    padding: true,
                  ),
                ],
              ),
              const Gap(gap: 15),
              if (widget.allJobslist.bids.isNotEmpty && isUserIdFound)
                Align(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: SizeHelper.moderateScale(14),
                        color: Colors.black,
                      ),
                      children: [
                        const TextSpan(
                          text:
                              '''You have been placed your bid for this job\nand your bid status is ''',
                          style: TextStyle(),
                        ),
                        TextSpan(
                          text: bidStatus.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Row(
                  children: [
                    SizedBox(
                      child: AnimatedContainer(
                        width: widget.allJobslist.isRejected
                            ? SizeHelper.getDeviceWidth(80)
                            : SizeHelper.getDeviceWidth(37),
                        duration: const Duration(milliseconds: 500),
                        child: AppButtonSmall(
                          isSelected: false,
                          text: widget.allJobslist.isRejected
                              ? 'Apply'
                              : 'Reject',
                          btnColor: persimmon,
                          isImage: false,
                          isBorder: false,
                          textColor: Colors.white,
                          onPress: () async {
                            final token = await getDataFromStorage(
                              StorageKeys.userToken,
                            );
                            sl<HelperBidBloc>().add(
                              HelperRejectBidEvent(
                                token: token!,
                                jobId: widget.allJobslist.id,
                              ),
                            );
                            setState(() {
                              widget.allJobslist.isRejected =
                                  !widget.allJobslist.isRejected;
                            });
                          },
                        ),
                      ),
                    ),
                    if (!widget.allJobslist.isRejected)
                      const Gap(
                        gap: 30,
                        axis: 'x',
                      ),
                    if (!widget.allJobslist.isRejected)
                      Expanded(
                        child: SizedBox(
                          height: SizeHelper.moderateScale(45),
                          child: AppButtonSmall(
                            isSelected: false,
                            text: 'Place Bid',
                            btnColor: widget.allJobslist.isRejected
                                ? silverColor
                                : cornflowerBlue,
                            isImage: false,
                            isBorder: false,
                            textColor: Colors.white,
                            onPress: onPress,
                          ),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      );
    }
    return Container();
  }

  Future<void> onPress() async {
    final addressState = BlocProvider.of<AddressBloc>(context).state;
    final profileState = BlocProvider.of<ProfileBloc>(context).state;
    if (profileState is ProfileInitial) {
      setState(() {
        bankDetailsSubmitted = profileState.bankDetails;
      });
    }
    if (addressState is AddressesState) {
      if (addressState.list.isNotEmpty && bankDetailsSubmitted) {
        activeButtonClickedState();
        await showModalBottomSheet(
          isScrollControlled: true,
          useRootNavigator: true,
          backgroundColor: Colors.transparent,
          context: context,
          enableDrag: false,
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: PlaceBidSheet(
                controller: TextEditingController(
                  text: widget.allJobslist.budget.toString(),
                ),
                id: widget.allJobslist.id,
                amount: widget.allJobslist.budget,
              ),
            );
          },
        ).whenComplete(resetButtonClickedState);
      } else if (addressState.list.isEmpty) {
        snackBarComponent(
          context,
          color: Colors.red,
          message: '''Please add address before biding a job''',
        );
        Future.delayed(const Duration(milliseconds: 1000), () async {
          await context.push('${NewAddresses.routeName}?isFromJobPage=false');
        });
      } else if (!bankDetailsSubmitted) {
        snackBarComponent(
          context,
          color: Colors.red,
          message: '''Please add bank details before biding a job''',
        );
        Future.delayed(const Duration(milliseconds: 1000), () async {
          await context.push(AddStripe.routeName);
        });
      }
    }
  }
}
