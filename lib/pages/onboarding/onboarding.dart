import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/pages/MainAuth/main_auth.dart';
import 'package:neighbour_app/pages/onboarding/widgets/backward_button.dart';
import 'package:neighbour_app/pages/onboarding/widgets/forward_button.dart';
import 'package:neighbour_app/pages/onboarding/widgets/indicators.dart';
import 'package:neighbour_app/pages/onboarding/widgets/onboarding_card.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/image_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/storage.dart';
import 'package:neighbour_app/widgets/gap.dart';

final List<Map<String, String>> pages = [
  {
    'heading': 'Find a Helper',
    'text':
        '''Find a “Helper” near you, or post a job asking for a “Helper” to help you get your packages''',
    'image': onboardingOne,
  },
  {
    'heading': 'Sending address to the Helper',
    'text':
        '''Change your sending address to the “Helper” you selected and then watch for updates for when they arrive.''',
    'image': onboardingTwo,
  },
  {
    'heading': 'Pickup or Delivered',
    'text': '''You can pick them up yourself or have them delivered.''',
    'image': onboardingThree,
  },
];

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  static const routeName = '/onboarding';

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController pageController = PageController();
  int activePage = 0;
  int pageIndex = 0;

  void _next() {
    if (activePage == 2) {
      setDataToStorage(
        StorageKeys.onboardingComplete,
        StorageKeys.onboardingComplete,
      );
      context.go(MainAuthPage.routeName);
      return;
    }
    pageController.animateToPage(
      activePage + 1,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeIn,
    );
  }

  void _goBack() {
    if (activePage == 0) return;

    pageController.animateToPage(
      activePage - 1,
      curve: Curves.easeIn,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
  }

  void _skip() {
    if (activePage != 2) {
      pageController.animateToPage(
        activePage + 2,
        curve: Curves.easeIn,
        duration: const Duration(
          milliseconds: 300,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: SizeHelper.moderateScale(20),
        ),
        child: Column(
          children: [
            const Gap(gap: 40),
            Container(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: _skip,
                child: activePage == 2
                    ? const SizedBox(height: 20)
                    : Text(
                        'Skip',
                        style: TextStyle(
                          fontFamily: interMedium,
                          fontSize: SizeHelper.moderateScale(18),
                        ),
                      ),
              ),
            ),
            const Gap(gap: 20),
            SizedBox(
              width: SizeHelper.screenWidth,
              height: SizeHelper.getDeviceHeight(70),
              child: PageView.builder(
                itemCount: pages.length,
                controller: pageController,
                onPageChanged: (int page) {
                  setState(() {
                    activePage = page;
                  });
                },
                itemBuilder: (context, index) {
                  final item = pages[index];
                  return OnboardingCard(item: item);
                },
              ),
            ),
            OnboardingIndicators(
              pages: pages,
              pageIndex: pageIndex,
              activePage: activePage,
            ),
            const Gap(gap: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackwardButton(
                  onTap: _goBack,
                  activePage: activePage,
                ),
                ForwardButton(
                  isText: activePage == 2,
                  onTap: _next,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
