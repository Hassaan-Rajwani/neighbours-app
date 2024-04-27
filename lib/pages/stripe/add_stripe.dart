import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/presentation/bloc/helperJobs/helper_jobs_bloc.dart';
import 'package:neighbour_app/presentation/bloc/profile/profile_bloc.dart';
import 'package:neighbour_app/presentation/bloc/stripe/stripe_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/image_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/app_button.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/launcher.dart';
import 'package:neighbour_app/widgets/snackbar.dart';

class AddStripe extends StatefulWidget {
  const AddStripe({
    required this.stripeData,
    super.key,
  });
  static const routeName = '/add-stripe';

  final Map<String, dynamic> stripeData;
  @override
  State<AddStripe> createState() => _AddStripeState();
}

class _AddStripeState extends State<AddStripe> with WidgetsBindingObserver {
  @override
  void initState() {
    sl<StripeBloc>().add(
      AddStripeEvent(
        token: widget.stripeData['token'].toString(),
      ),
    );
    getProfile();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getProfile();
      sl<StripeBloc>().add(
        AddStripeEvent(
          token: widget.stripeData['token'].toString(),
        ),
      );
    }
  }

  Future<void> getProfile() async {
    sl<ProfileBloc>().add(
      GetUserProfileEvent(),
    );
    sl<HelperJobsBloc>().add(const GetHelperAllJobsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StripeBloc, AccountLoginState>(
      builder: (context, state) {
        String? stripeUrl;
        if (state is AccountLoginInProgress) {
          return const Center(
            child: CircularLoader(),
          );
        }
        if (state is AccountLoginSuccessfull) {
          stripeUrl = state.data.loginUrl;
          return WillPopScope(
            onWillPop: () async {
              await getProfile();
              return true;
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: backButtonAppbar(
                customOntap: true,
                onTap: () {
                  getProfile();
                  context.pop();
                },
                context,
                icon: const Icon(Icons.arrow_back),
                backgroundColor: Colors.white,
              ),
              body: Container(
                margin: EdgeInsets.only(bottom: SizeHelper.moderateScale(50)),
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, profileState) {
                    if (profileState is ProfileInitial) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const Gap(gap: 90),
                              if (profileState.bankDetails)
                                Column(
                                  children: [
                                    Image.asset(stripeDashboard),
                                    const Gap(gap: 53),
                                    Text(
                                      'Stripe Dashbaord',
                                      style: TextStyle(
                                        fontFamily: urbanistSemiBold,
                                        fontSize: SizeHelper.moderateScale(20),
                                        color: mineShaft,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeHelper.moderateScale(40),
                                      ),
                                      child: Text(
                                        '''Thank you for connecting your Stripe account. ''',
                                        style: TextStyle(
                                          fontFamily: urbanistRegular,
                                          fontSize:
                                              SizeHelper.moderateScale(14),
                                          height: 3,
                                          color: doveGray,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              if (!profileState.bankDetails)
                                Column(
                                  children: [
                                    SvgPicture.asset(stripeIcon),
                                    Text(
                                      'Stripe Account',
                                      style: TextStyle(
                                        fontFamily: urbanistSemiBold,
                                        fontSize: SizeHelper.moderateScale(20),
                                        color: mineShaft,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeHelper.moderateScale(60),
                                      ),
                                      child: Text(
                                        '''In order to see a new job you need to add Stripe account details to transfer funds.''',
                                        style: TextStyle(
                                          fontFamily: urbanistRegular,
                                          fontSize:
                                              SizeHelper.moderateScale(14),
                                          height: 3,
                                          color: doveGray,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          AppButton(
                            text: profileState.bankDetails
                                ? 'Stripe Dashboard'
                                : 'Add Stripe',
                            onPress: () async {
                              if (stripeUrl != null) {
                                await LaunchFunction().openLink(
                                  link: stripeUrl,
                                  context: context,
                                );
                              } else {
                                snackBarComponent(
                                  context,
                                  color: cinnabar,
                                  message: 'url is empty',
                                );
                              }
                            },
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
