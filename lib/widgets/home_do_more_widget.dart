import 'package:flutter/material.dart';
import 'package:neighbour_app/pages/Home/widgets/home_box.dart';
import 'package:neighbour_app/pages/Home/widgets/home_link_box.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class HomeBoxesCall extends StatelessWidget {
  const HomeBoxesCall({
    required this.data,
    this.isDashboard = true,
    this.isNavigate = true,
    super.key,
  });
  final List<Map<String, dynamic>> data;
  final bool? isDashboard;
  final bool? isNavigate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: SizeHelper.moderateScale(20),
        right: SizeHelper.moderateScale(10),
      ),
      height: SizeHelper.moderateScale(isDashboard! ? 100 : 120),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return isDashboard!
              ? HomeBox(
                  icon: data[index]['icon'].toString(),
                  title: data[index]['title'].toString(),
                  onTap: () {
                    if (isNavigate!) {
                      boxOnTap(
                        route: data[index]['route'].toString(),
                        launchUrl: data[index]['launchUrl'].toString(),
                        context: context,
                      );
                    }
                  },
                )
              : HomeLinkBox(
                  icon: data[index]['icon'].toString(),
                  title: data[index]['title'].toString(),
                  onTap: () {
                    if (isNavigate!) {
                      boxOnTap(
                        route: data[index]['route'].toString(),
                        launchUrl: data[index]['launchUrl'].toString(),
                        context: context,
                      );
                    }
                  },
                );
        },
      ),
    );
  }
}
