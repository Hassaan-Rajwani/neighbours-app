// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/presentation/bloc/helperBids/helper_bid_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/storage.dart';
import 'package:neighbour_app/widgets/app_button.dart';
import 'package:neighbour_app/widgets/app_input.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/place_bid_input.dart';

// ignore: must_be_immutable
class PlaceBidSheet extends StatefulWidget {
  PlaceBidSheet({
    required this.id,
    required this.amount,
    required this.controller,
    super.key,
  });
  final TextEditingController controller;
  final String id;
  int amount;

  @override
  State<PlaceBidSheet> createState() => _PlaceBidSheetState();
}

class _PlaceBidSheetState extends State<PlaceBidSheet> {
  late TextEditingController _textEditingController;
  TextEditingController reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController(
      text: widget.amount.toString(),
    );
  }

  void incrementValue() {
    setState(() {
      final enteredValue = int.tryParse(_textEditingController.text) ?? 0;
      widget.amount = enteredValue + 1;
      _textEditingController.text = widget.amount.toString();
    });
  }

  void decrementValue() {
    setState(() {
      if (widget.amount > 1) {
        final enteredValue = int.tryParse(_textEditingController.text) ?? 0;
        if (enteredValue > 1) {
          widget.amount = enteredValue - 1;
          _textEditingController.text = widget.amount.toString();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      height: SizeHelper.getDeviceHeight(52),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(gap: 20),
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
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeHelper.moderateScale(20),
              vertical: SizeHelper.moderateScale(10),
            ),
            child: Text(
              'Enter Your Bid',
              style: TextStyle(
                fontFamily: interBold,
                fontSize: SizeHelper.moderateScale(14),
                color: mineShaft,
              ),
            ),
          ),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: SizeHelper.moderateScale(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ConstrainedBox(
                  constraints:
                      const BoxConstraints.tightFor(width: 65, height: 45),
                  child: ElevatedButton(
                    onPressed: decrementValue,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      r'-$1',
                      style: TextStyle(
                        fontFamily: interSemibold,
                        fontSize: SizeHelper.moderateScale(16),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                PlaceBidInput(
                  textEditingController: _textEditingController,
                ),
                ConstrainedBox(
                  constraints:
                      const BoxConstraints.tightFor(width: 65, height: 45),
                  child: ElevatedButton(
                    onPressed: incrementValue,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      r'+$1',
                      style: TextStyle(
                        fontFamily: interSemibold,
                        fontSize: SizeHelper.moderateScale(16),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(
              SizeHelper.moderateScale(20),
              SizeHelper.moderateScale(20),
              SizeHelper.moderateScale(20),
              SizeHelper.moderateScale(0),
            ),
            child: Text(
              'Description (Optional)',
              style: TextStyle(
                fontFamily: interBold,
                fontSize: SizeHelper.moderateScale(14),
                color: mineShaft,
              ),
            ),
          ),
          const Gap(gap: 10),
          AppInput(
            textarea: false,
            placeHolder: 'Description',
            maxLines: 5,
            controller: reasonController,
            maxLenght: 200,
            keyboardType: TextInputType.multiline,
            isCounterText: true,
          ),
          AppButton(
            onPress: () async {
              final amount = _textEditingController.text;
              final token = await getDataFromStorage(
                StorageKeys.userToken,
              );
              final body = {
                'amount': int.parse(amount),
                'description': reasonController.value.text,
              };
              sl<HelperBidBloc>().add(
                HelperCreateBidEvent(
                  token: token!,
                  bidId: widget.id,
                  body: body,
                ),
              );
              context.pop();
            },
            text: 'Bid',
          ),
          const Gap(gap: 10),
        ],
      ),
    );
  }
}
