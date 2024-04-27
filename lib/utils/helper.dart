// ignore_for_file: unused_element
import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:neighbour_app/data/models/address.dart';
import 'package:neighbour_app/pages/Addresses/new_addresses.dart';
import 'package:neighbour_app/pages/AllJobs/helper_new_jobs.dart';
import 'package:neighbour_app/pages/allPendingJobs/all_pending_jobs.dart';
import 'package:neighbour_app/pages/jobsHistory/jobs_history.dart';
import 'package:neighbour_app/pages/payment/payment.dart';
import 'package:neighbour_app/pages/postNewJob/post_new_job.dart';
import 'package:neighbour_app/pages/stripe/add_stripe.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/app_button.dart';
import 'package:neighbour_app/widgets/custom_dialog_box.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;

void keyboardDismissle({required BuildContext context}) {
  FocusScope.of(context).requestFocus(FocusNode());
}

String platformChecker(String android, String ios) {
  return Platform.isAndroid ? android : ios;
}

String checkAddressSelectedTab(int selectedCircleIndex) {
  switch (selectedCircleIndex) {
    case 0:
      return 'HOME';
    case 1:
      return 'WORK';
    case 2:
      return 'OTHER';
    default:
      return 'HOME';
  }
}

int checkAddressSelectedTabFromName(String selectedCircleName) {
  switch (selectedCircleName) {
    case 'HOME':
      return 0;
    case 'WORK':
      return 1;
    case 'OTHER':
      return 2;
    default:
      return 0;
  }
}

String checkJobType(int type) {
  switch (type) {
    case 0:
      return 'ONE_TIME';
    case 1:
      return 'RECURRING';
    default:
      return 'ONE_TIME';
  }
}

int checkJobTypeInt(String type) {
  switch (type) {
    case 'ONE_TIME':
      return 0;
    case 'RECURRING':
      return 1;
    default:
      return 0;
  }
}

String checkParcelSize(int type) {
  switch (type) {
    case 0:
      return 'SMALL';
    case 1:
      return 'MEDIUM';
    case 2:
      return 'LARGE';
    default:
      return 'SMALL';
  }
}

int checkParcelSizeInt(String type) {
  switch (type) {
    case 'SMALL':
      return 0;
    case 'MEDIUM':
      return 1;
    case 'LARGE':
      return 2;
    default:
      return 1;
  }
}

List<String> checkPickupType(String type) {
  switch (type) {
    case 'pickup':
      return ['PICKUP'];
    case 'delivery':
      return ['DELIVERY'];
    case 'both':
      return ['PICKUP', 'DELIVERY'];
    default:
      return ['PICKUP'];
  }
}

int checkPickupTypeForJob(String type) {
  switch (type) {
    case 'PICKUP,DELIVERY' || 'DELIVERY,PICKUP':
      return 2;
    case 'DELIVERY':
      return 1;
    case 'PICKUP':
      return 0;
    default:
      return 0;
  }
}

String checkJobTypeFormat(String jobType) {
  switch (jobType) {
    case 'RECURRING':
      return 'Recurring';
    default:
      return 'One Time';
  }
}

String getInitials({required String firstName, required String lastName}) {
  final firstInitial = firstName.isNotEmpty ? firstName[0] : '';
  final lastInitial = lastName.isNotEmpty ? lastName[0] : '';
  final initials = '$firstInitial$lastInitial'.toUpperCase();
  return initials;
}

String extractDateAndTime(String timestamp) {
  final dateTime = DateTime.parse(timestamp);
  final formattedDateTime =
      '''${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}''';
  return formattedDateTime;
}

String extractDateAndTime2(String timestamp) {
  final dateTime = DateTime.parse(timestamp);
  final formatter = DateFormat('d MMMM yyyy, h:mma');
  return formatter.format(dateTime);
}

String formatedAddress(
  AddressModel address,
) {
  final fomattedAddress = address;
  return '''${fomattedAddress.city} ${fomattedAddress.state} ${fomattedAddress.zipCode}''';
}

int? formatTip(int index) {
  switch (index) {
    case 0:
      return 0;
    case 1:
      return 1;
    case 2:
      return 3;
    case 3:
      return null;
    default:
      return 0;
  }
}

String capitalizeFirstLetter(String input) {
  if (input.isEmpty) {
    return input;
  }
  return input[0].toUpperCase() + input.substring(1);
}

String checkSize(int type) {
  switch (type) {
    case 0:
      return 'small';
    case 1:
      return 'medium';
    case 2:
      return 'large';
    default:
      return 'null';
  }
}

String checkDistanceText(String text) {
  switch (text) {
    case '5-10 minutes walk':
      return '05 - 10 mins';
    case '10-15 minutes walk':
      return '10 - 15 mins';
    case 'Driving distance':
      return 'More than 20 mins';
    case 'null':
      return 'More than 60 mins';
    default:
      return 'Less than 05 mins';
  }
}

String checkPackageType(int type) {
  switch (type) {
    case 0:
      return 'PICKUP';
    case 1:
      return 'DELIVERY';
    default:
      return 'null';
  }
}

String checkOrder(int type) {
  switch (type) {
    case 0:
      return 'desc';
    case 1:
      return 'asc';
    default:
      return 'null';
  }
}

Map<String, String> extractAddress(String input) {
  final document = parseFragment(input);
  final addressMap = <String, String>{};

  document.querySelectorAll('span').forEach((element) {
    final classAttribute = element.attributes['class'];
    final text = element.text.trim();

    if (classAttribute != null) {
      if (classAttribute.contains('street-address')) {
        addressMap['street'] = text;
      } else if (classAttribute.contains('locality')) {
        addressMap['city'] = text;
      } else if (classAttribute.contains('region')) {
        addressMap['state'] = text;
      } else if (classAttribute.contains('postal-code')) {
        addressMap['zipcode'] = text;
      } else if (classAttribute.contains('country-name')) {
        addressMap['country'] = text;
      }
    }
  });

  addressMap
    ..putIfAbsent('street', () => '')
    ..putIfAbsent('city', () => '')
    ..putIfAbsent('state', () => '')
    ..putIfAbsent('zipcode', () => '')
    ..putIfAbsent('country', () => '');
  return addressMap;
}

bool isAddressComplete(Map<String, String> address) {
  return address['street']!.isNotEmpty &&
      address['city']!.isNotEmpty &&
      address['state']!.isNotEmpty &&
      address['zipcode']!.isNotEmpty &&
      address['country']!.isNotEmpty;
}

bool isAddressCompleteForCurrent(Map<String, String> address) {
  return address['houseNumber']!.isNotEmpty &&
      address['streetName']!.isNotEmpty &&
      address['state']!.isNotEmpty &&
      address['city']!.isNotEmpty &&
      address['zipCode']!.isNotEmpty &&
      address['country']!.isNotEmpty;
}

dynamic extractNumber(dynamic input) {
  if (input is List) {
    if (input.isNotEmpty && input[0] is num) {
      return input[0].toString();
    }
  } else if (input is num) {
    return input.toString();
  }
  return null;
}

String getCountryAndState(String address) {
  if (address.isEmpty) {
    return '';
  }
  final parts = address.split(', ');
  if (parts.length >= 2) {
    return '${parts[parts.length - 2]}, ${parts[parts.length - 1]}';
  } else {
    return address;
  }
}

String extractZipCode(String input) {
  if (input.contains('-')) {
    return input.substring(0, 5);
  } else {
    final numericPart = input.replaceAll(RegExp('[^0-9]'), '');
    return numericPart;
  }
}

String jobStatusCheck({required String status}) {
  if (status == 'PENDING_CANCEL') {
    return 'Pending Cancel';
  }
  return status.pascalCase;
}

Color statusCheckForColor({required String status}) {
  switch (status) {
    case 'CANCELLED':
      return cinnabar;
    case 'PENDING_CANCEL':
      return cinnabar;
    case 'COMPLETED':
      return chateauGreen;
    case 'ONGOING':
      return cornflowerBlue;
    default:
      return casablanca;
  }
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
      final street = placemark.street ?? '';
      final state = placemark.administrativeArea ?? '';
      final country = placemark.country ?? '';
      final city = placemark.subAdministrativeArea ?? '';
      final zip = placemark.postalCode ?? '';

      return {
        'houseNumber': houseNumber,
        'streetName': street,
        'state': state,
        'city': city,
        'country': country,
        'zipCode': zip,
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

void showAddressErrorBottomSheet({required BuildContext context}) {
  // ignore: inference_failure_on_function_invocation
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            SizeHelper.moderateScale(16),
          ),
          topRight: Radius.circular(
            SizeHelper.moderateScale(16),
          ),
        ),
        child: Container(
          height: 230,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                SizeHelper.moderateScale(16),
              ),
              topRight: Radius.circular(
                SizeHelper.moderateScale(16),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(gap: 15),
              Container(
                alignment: Alignment.center,
                transformAlignment: Alignment.center,
                margin: EdgeInsets.only(left: SizeHelper.moderateScale(170)),
                height: 5,
                width: 40,
                decoration: const BoxDecoration(
                  color: gallery,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              const Gap(gap: 20),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeHelper.moderateScale(20),
                ),
                child: Text(
                  'Whoops',
                  style: TextStyle(
                    fontFamily: interBold,
                    fontSize: SizeHelper.moderateScale(16),
                    color: mineShaft,
                  ),
                ),
              ),
              const Gap(gap: 10),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeHelper.moderateScale(20),
                ),
                child: Text(
                  'Failed to retrieve address details. Please try again later.',
                  style: TextStyle(
                    fontFamily: interRegular,
                    fontSize: SizeHelper.moderateScale(14),
                    color: mineShaft,
                  ),
                ),
              ),
              const Gap(gap: 20),
              AppButton(
                text: 'OK',
                backgroundColor: persimmon,
                onPress: () {
                  context.pop();
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

void twoButtonDialog({
  required BuildContext context,
  required String heading,
  required String subHeading,
  required String leftButtonText,
  required Color leftButtonColor,
  required String rightButtonText,
  required Color rightButtonColor,
  required VoidCallback leftOnTap,
  required VoidCallback rightOnTap,
  String subHeading2 = '',
  String subHeading3 = '',
  bool inputArea = false,
  bool isHelpText = false,
  TextEditingController? controller,
}) {
  // ignore: inference_failure_on_function_invocation
  showDialog(
    barrierDismissible: true,
    useSafeArea: false,
    context: context,
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {
          context.pop();
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            GlassContainer(
              blur: 5,
              child: Container(
                height: SizeHelper.getDeviceHeight(100),
                width: SizeHelper.getDeviceWidth(100),
                color: Colors.transparent,
              ),
            ),
            CustomDialogBox(
              isHelpText: isHelpText,
              description2: subHeading2,
              description3: subHeading3,
              inputArea: inputArea,
              controller: controller,
              verticalHeight: inputArea
                  ? Platform.isAndroid
                      ? 22
                      : 26
                  : Platform.isAndroid
                      ? 35
                      : 36,
              onConfirmPressed: rightOnTap,
              onCancelPressed: leftOnTap,
              confirmText: rightButtonText,
              cancelText: leftButtonText,
              confirmTextColor: Colors.white,
              cancelTextColor: Colors.white,
              confirmBtnBackgroundColor: rightButtonColor,
              cancelBtnBackgroundColor: leftButtonColor,
              heading: heading,
              description: subHeading,
            ),
          ],
        ),
      );
    },
  );
}

List<Map<String, dynamic>> homeData({bool isNeighbr = true}) {
  return [
    {
      'title': '${isNeighbr ? 'Post a' : 'Search'} New Job',
      'icon': postNewJobIcon,
      'route':
          isNeighbr ? PostNewJobPage.routeName : HelperNewJobsPage.routeName,
      'launchUrl': '',
    },
    {
      'title': '${isNeighbr ? 'Pending' : 'Open'} Jobs',
      'icon': pendingJob,
      'route':
          isNeighbr ? AllPendingJobsPage.routeName : JobsHistoryPage.routeName,
      'launchUrl': '',
    },
    {
      'title': isNeighbr ? 'Your Jobs' : 'Job History',
      'icon': packageBidIcon,
      'route': isNeighbr
          ? JobsHistoryPage.routeName
          : '${JobsHistoryPage.routeName}?currentTab=Closed Jobs',
      'launchUrl': '',
    },
    {
      'title': 'Update Address',
      'icon': updateAddress,
      'route': '${NewAddresses.routeName}?isFromJobPage=false',
      'launchUrl': '',
    },
    {
      'title': 'Update Payment Info',
      'icon': updatePaymentInfo,
      'route': isNeighbr
          ? '${PaymentPage.routeName}?isFromJobPage=false'
          : AddStripe.routeName,
      'launchUrl': '',
    },
  ];
}

List<Map<String, dynamic>> homeDataLink({bool isNeighbr = true}) {
  return [
    {
      'title': 'What is\nNeighbrs?',
      'icon': whatNeighbr,
      'route': '',
      'launchUrl': 'https://www.neighbrs.com/about',
    },
    {
      'title': 'How we Help\nCommunities',
      'icon': helpCommunity,
      'route': '',
      'launchUrl': 'https://www.neighbrs.com/how-we-help',
    },
    {
      'title': 'Refer a Friend',
      'icon': inviteOthersIconTwo,
      'route': '',
      'launchUrl': 'https://www.neighbrs.com/refer-friends',
    },
    {
      'title': 'Feedback\nUsing the App',
      'icon': feedbackIcon,
      'route': '',
      'launchUrl': 'https://www.neighbrs.com/feedback',
    },
    {
      'title': 'FAQ',
      'icon': faq,
      'route': '',
      'launchUrl': 'https://www.neighbrs.com/about',
    },
    {
      'title': 'Feedback New\nJob Type Idea',
      'icon': feedbackIdea,
      'route': '',
      'launchUrl': 'https://www.neighbrs.com/feedback',
    },
  ];
}

Future<void> boxOnTap({
  required String route,
  required String launchUrl,
  required BuildContext context,
}) async {
  if (route != '' && launchUrl == '') {
    await context.push(route);
  } else if (route == '' && launchUrl == '') {
    // TODO need to change link
    await Share.share('here is the app link');
  } else {
    await LaunchFunction().openLink(
      link: launchUrl,
      context: context,
    );
  }
}

String formatDateTimeToAgo(String dateTimeString) {
  final dateTime = DateTime.parse(dateTimeString);
  final now = DateTime.now();

  final difference = now.difference(dateTime);

  return timeago.format(now.subtract(difference), locale: 'en_short');
}

String ratingRoundof({required String rating}) {
  if (rating == '0.0') {
    return '0.0';
  } else {
    return double.parse(rating).toStringAsFixed(1);
  }
}
