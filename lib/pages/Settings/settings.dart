// ignore_for_file: unused_label, lines_longer_than_80_chars, use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/global/authBloc/auth_bloc.dart';
import 'package:neighbour_app/pages/Addresses/new_addresses.dart';
import 'package:neighbour_app/pages/EditProfile/edit_profile.dart';
import 'package:neighbour_app/pages/Favorites/favorites.dart';
import 'package:neighbour_app/pages/Settings/menu_setting.dart';
import 'package:neighbour_app/pages/Settings/setting_loader.dart';
import 'package:neighbour_app/pages/Settings/widget/tappable.dart';
import 'package:neighbour_app/pages/jobsHistory/jobs_history.dart';
import 'package:neighbour_app/pages/payment/payment.dart';
import 'package:neighbour_app/pages/stripe/add_stripe.dart';
import 'package:neighbour_app/presentation/bloc/profile/profile_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/storage.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:skeletons/skeletons.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static const routeName = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

enum homeScreenType { Neighbor, Helper }

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final authState = BlocProvider.of<AuthBloc>(context).state;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: backButtonAppbar(
        context,
        text: 'Settings',
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const Gap(gap: 30),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeHelper.moderateScale(20),
            ),
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileInitial) {
                  final bytes = state.imageUrl != null
                      ? base64Decode(state.imageUrl!)
                      : null;

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            bytes != null ? Colors.transparent : codGray,
                        backgroundImage:
                            bytes != null ? MemoryImage(bytes) : null,
                        radius: SizeHelper.moderateScale(25),
                        child: bytes == null
                            ? Text(
                                getInitials(
                                  firstName: state.firstName,
                                  lastName: state.lastName,
                                ),
                                style: TextStyle(
                                  fontFamily: ralewayBold,
                                  fontSize: SizeHelper.moderateScale(20),
                                  color: Colors.white,
                                ),
                              )
                            : null,
                      ),
                      SizedBox(width: SizeHelper.moderateScale(15)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome',
                            style: TextStyle(
                              fontSize: SizeHelper.moderateScale(12),
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                              color: dustyGray,
                            ),
                          ),
                          const Gap(gap: 10),
                          SizedBox(
                            width: SizeHelper.getDeviceWidth(45),
                            child: Text(
                              '${state.firstName} ${state.lastName}',
                              style: TextStyle(
                                fontSize: SizeHelper.moderateScale(16),
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w700,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        radius: 0.5,
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onTap: () {
                          context.push(EditProfilePage.routeName);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeHelper.moderateScale(15),
                            vertical: SizeHelper.moderateScale(10),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(64),
                            border: Border.all(
                              width: SizeHelper.moderateScale(1),
                            ),
                          ),
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: SizeHelper.moderateScale(12),
                              color: Colors.black,
                              fontFamily: ralewayMedium,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const SkeletonItem(child: SettingLoader());
              },
            ),
          ),
          const Gap(gap: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              color: silver,
              thickness: 1.5,
              height: SizeHelper.moderateScale(0),
              indent: 0,
              endIndent: 0,
            ),
          ),
          Tappable(
            svgIconPath: jobHistory,
            text: 'Job History',
            onTap: () {
              context.push(JobsHistoryPage.routeName);
            },
          ),
          Tappable(
            svgIconPath: editAddress,
            text: 'Edit Address',
            onTap: () {
              context.push('${NewAddresses.routeName}?isFromJobPage=false');
            },
          ),
          if (authState is AuthStateUserType)
            Tappable(
              svgIconPath: authState.userType == homeScreenType.Neighbor.name
                  ? wallet
                  : bankIcon,
              text: authState.userType == homeScreenType.Neighbor.name
                  ? 'Payment'
                  : 'Bank Details',
              onTap: () async {
                final token = await getDataFromStorage(StorageKeys.userToken);
                final query = Uri(
                  queryParameters: {
                    'token': token,
                  },
                );
                text:
                authState.userType == homeScreenType.Neighbor.name
                    ? context.push('${PaymentPage.routeName}?isFromJobPage=false')
                    : await context.push('${AddStripe.routeName}?$query');
              },
            ),
          if (authState is AuthStateUserType &&
              authState.userType == homeScreenType.Neighbor.name)
            Tappable(
              svgIconPath: favourites,
              text: 'Favorites',
              onTap: () {
                context.push(FavoritesPage.routeName);
              },
            ),
          Tappable(
            svgIconPath: setting,
            text: 'Settings',
            onTap: () {
              context.push(MenuSettingsPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}
