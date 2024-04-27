import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/home_do_more_widget.dart';
import 'package:neighbour_app/widgets/home_heading_text.dart';
import 'package:neighbour_app/widgets/home_nearby_banner.dart';

class DashboardLoaderBoxes extends StatelessWidget {
  const DashboardLoaderBoxes({
    super.key,
    this.isNeighbr = true,
  });

  final bool? isNeighbr;

  @override
  Widget build(BuildContext context) {
    final data = homeData(isNeighbr: isNeighbr!);
    final dataLink = homeDataLink();
    return Column(
      children: [
        const HomeNearbyBanner(isNavigate: false),
        const Gap(gap: 30),
        const HomeHeadingText(text: 'Dashboard'),
        const Gap(gap: 10),
        HomeBoxesCall(
          data: data,
          isNavigate: false,
        ),
        const Gap(gap: 30),
        const HomeHeadingText(
          text: 'Do More With Neighbrs',
        ),
        const Gap(gap: 10),
        HomeBoxesCall(
          data: dataLink,
          isDashboard: false,
          isNavigate: false,
        ),
      ],
    );
  }
}
