// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/presentation/bloc/cards/cards_bloc.dart';
import 'package:neighbour_app/presentation/bloc/paymentIntents/payment_intents_bloc.dart';
import 'package:neighbour_app/widgets/app_button.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';
import 'package:neighbour_app/widgets/snackbar.dart';

class AddCard extends StatefulWidget {
  const AddCard({
    required this.isFromJobPage,
    super.key,
  });

  final String isFromJobPage;
  static const routeName = '/addCard';

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  CardFieldInputDetails? _card;
  bool isLoading = false;

  @override
  void initState() {
    sl<PaymentIntentsBloc>().add(
      SetPaymentIntentEvent(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backButtonAppbar(
        context,
        icon: const Icon(Icons.arrow_back),
        backgroundColor: Colors.white,
        text: 'Add Card',
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CardField(
              autofocus: true,
              onCardChanged: (card) {
                setState(() {
                  _card = card;
                });
              },
            ),
          ),
          BlocBuilder<PaymentIntentsBloc, PaymentIntentsState>(
            builder: (context, state) {
              return AppButton(
                text: 'Save Card',
                onPress: _handleSavePress,
                buttonLoader: isLoading,
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _handleSavePress() async {
    final data = _card!;
    if (!data.complete) {
      snackBarComponent(
        context,
        color: Colors.red,
        message: 'Please enter details',
      );
    } else {
      try {
        setState(() {
          isLoading = true;
        });
        final stripeState = BlocProvider.of<PaymentIntentsBloc>(context).state;
        if (stripeState is PaymentIntentSuccessfully) {
          final clientSecret = stripeState.data.setupIntent.clientSecret;
          const billingDetails = BillingDetails();

          final setupIntentResult = await Stripe.instance.confirmSetupIntent(
            paymentIntentClientSecret: clientSecret,
            params: const PaymentMethodParams.card(
              paymentMethodData: PaymentMethodData(
                billingDetails: billingDetails,
              ),
            ),
          );
          if (setupIntentResult.status == 'Succeeded') {
            setState(() {
              isLoading = false;
            });
            snackBarComponent(
              context,
              color: Colors.green,
              message: 'Card created successfully',
            );
            if (widget.isFromJobPage == 'true') {
              context
                ..pop()
                ..pop();
              sl<CardsBloc>().add(GetCardsListEvent());
            } else {
              context.pop();
              sl<CardsBloc>().add(GetCardsListEvent());
            }
          }
        }
      } catch (error) {
        setState(() {
          isLoading = false;
        });
        debugPrint('$error');
      }
    }
  }
}
