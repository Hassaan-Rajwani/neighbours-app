import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class OnboardingIndicators extends StatelessWidget {
  const OnboardingIndicators({
    required this.pages,
    required this.pageIndex,
    required this.activePage,
    super.key,
  });
  final List<Map<String, String>> pages;
  final int pageIndex;
  final int activePage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pages.length,
        (index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeHelper.moderateScale(3),
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: SizeHelper.moderateScale(
                activePage == index ? 30 : 10,
              ),
              width: SizeHelper.moderateScale(6),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: activePage == index ? Colors.black : Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }
}
