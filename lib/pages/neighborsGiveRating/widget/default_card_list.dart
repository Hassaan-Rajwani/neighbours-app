import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/pages/payment/payment.dart';
import 'package:neighbour_app/presentation/bloc/cards/cards_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/payment_card.dart';

Widget buildPaymentSection({
  required BuildContext context,
  required CardsState state,
}) {
  if (state is GetCardListState) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(SizeHelper.moderateScale(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Payment Method',
                style: TextStyle(
                  fontFamily: ralewayBold,
                  fontSize: SizeHelper.moderateScale(16),
                ),
              ),
              InkWell(
                onTap: () {
                  context.push('${PaymentPage.routeName}?isFromJobPage=false');
                },
                child: Text(
                  'Change',
                  style: TextStyle(
                    fontFamily: interMedium,
                    fontSize: SizeHelper.moderateScale(14),
                    color: cornflowerBlue,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: state.list.length,
          itemBuilder: (context, index) {
            final item = state.list[index];
            return PaymentCard(
              cardIcon: item.card.brand == 'visa' ? visaIcon : masterIcon,
              cardTitle: 'Card Number',
              cardPin: '**** **** ${item.card.last4}',
              pinTextColor:
                  item.card.brand == 'visa' ? cornflowerBlue : cinnabar,
              isDefault: item.isDefault,
            );
          },
        ),
        if (state.list.every((item) => !item.isDefault))
          const Center(
            child: Text('Please select defalut card'),
          ),
      ],
    );
  }
  return Container();
}
