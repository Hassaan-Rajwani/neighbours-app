import 'package:flutter/material.dart';
import 'package:neighbour_app/pages/neighborsGiveRating/widget/profile_card_rating_widget.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';

class NeighborGiveRatingPage extends StatefulWidget {
  const NeighborGiveRatingPage({
    required this.data,
    super.key,
  });

  final Map<String, dynamic> data;
  static const routeName = '/neighbor-give-rating';

  @override
  State<NeighborGiveRatingPage> createState() => _NeighborGiveRatingPageState();
}

class _NeighborGiveRatingPageState extends State<NeighborGiveRatingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backButtonAppbar(
        context,
        icon: const Icon(Icons.arrow_back),
        backgroundColor: Colors.white,
        text: 'Give Rating',
      ),
      backgroundColor: Colors.white,
      body: ProfileCardRatingWidget(
        firstName: widget.data['firstName'].toString(),
        lastName: widget.data['lastName'].toString(),
        image: widget.data['image'].toString(),
        helperName: widget.data['helperName'].toString(),
        jobId: widget.data['jobId'].toString(),
      ),
    );
  }
}
