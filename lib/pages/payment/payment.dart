import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/payment/add_card.dart';
import 'package:neighbour_app/pages/payment/widget/credit_card_form.dart';
import 'package:neighbour_app/presentation/bloc/cards/cards_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/storage.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/add_cards.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';
import 'package:neighbour_app/widgets/gap.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({
    required this.isFromJobPage,
    super.key,
  });

  final String isFromJobPage;

  static const routeName = '/payment';

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isLoading = false;

  @override
  void initState() {
    sl<CardsBloc>().add(GetCardsListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardsBloc, CardsState>(
      builder: (context, state) {
        if (state is GetCardsInProgress) {
          return const CircularLoader();
        }
        if (state is GetCardListState) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: backButtonAppbar(
              context,
              icon: const Icon(Icons.arrow_back),
              backgroundColor: Colors.white,
              text: 'Payment',
            ),
            body: state.list.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Cards',
                                  style: TextStyle(
                                    fontFamily: ralewayBold,
                                    fontSize: SizeHelper.moderateScale(16),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context.push(
                                    '''${AddCard.routeName}?isFromJobPage=${widget.isFromJobPage}''',
                                  );
                                },
                                child: Container(
                                  width: 110,
                                  padding: EdgeInsets.symmetric(
                                    vertical: SizeHelper.moderateScale(10),
                                    horizontal: SizeHelper.moderateScale(8),
                                  ),
                                  decoration: BoxDecoration(
                                    color: cornflowerBlue,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: FittedBox(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: SizeHelper.moderateScale(20),
                                        ),
                                        SizedBox(
                                          width: SizeHelper.moderateScale(10),
                                        ),
                                        if (isLoading)
                                          const Row(
                                            children: [
                                              Gap(
                                                gap: 10,
                                                axis: 'x',
                                              ),
                                              SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          )
                                        else
                                          Text(
                                            'Add card',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: interBold,
                                              fontSize:
                                                  SizeHelper.moderateScale(12),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: state.list.asMap().entries.map(
                            (entry) {
                              final index = entry.key;
                              final itemData = entry.value;
                              return Column(
                                children: [
                                  CreditCardForm(
                                    cardIcon: itemData.card.brand == 'visa'
                                        ? visaIcon
                                        : masterIcon,
                                    cardTitle: 'Card Number',
                                    cardPin: '**** ${itemData.card.last4}',
                                    pinTextColor: itemData.card.brand == 'visa'
                                        ? cornflowerBlue
                                        : cinnabar,
                                    borderColor: itemData.card.brand == 'visa'
                                        ? cornflowerBlue
                                        : cinnabar,
                                    index: index,
                                    isDefault: itemData.isDefault,
                                    defaultLabel: itemData.isDefault == true
                                        ? 'Default'
                                        : ' ',
                                    onCardSelected: (int newIndex) async {
                                      sl<CardsBloc>().add(
                                        UpdateCardEvent(
                                          id: itemData.id,
                                        ),
                                      );
                                      setState(() {
                                        final targetId = state.list[index].id;
                                        for (final item in state.list) {
                                          item.isDefault = item.id == targetId;
                                        }
                                      });
                                    },
                                    onDeleteTap: () async {
                                      final token = await getDataFromStorage(
                                        StorageKeys.userToken,
                                      );
                                      sl<CardsBloc>().add(
                                        DeleteCardEvent(
                                          id: itemData.id,
                                          token: token.toString(),
                                        ),
                                      );
                                      setState(() {
                                        state.list.removeAt(index);
                                      });
                                    },
                                  ),
                                ],
                              );
                            },
                          ).toList(),
                        ),
                      ],
                    ),
                  )
                : AddCards(
                    onTap: () {
                      context.push(
                        '''${AddCard.routeName}?isFromJobPage=${widget.isFromJobPage}''',
                      );
                    },
                    isLoading: false,
                  ),
          );
        }
        return Container();
      },
    );
  }
}
