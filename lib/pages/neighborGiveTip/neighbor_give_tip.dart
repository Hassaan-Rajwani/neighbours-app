// ignore_for_file: prefer_if_null_operators
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/neighborsGiveRating/widget/default_card_list.dart';
import 'package:neighbour_app/presentation/bloc/cards/cards_bloc.dart';
import 'package:neighbour_app/presentation/bloc/neighborsPackages/neighbors_packages_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/regex_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/app_button.dart';
import 'package:neighbour_app/widgets/app_input.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/tip_box.dart';

class NeighborGiveTipPage extends StatefulWidget {
  const NeighborGiveTipPage({
    required this.data,
    super.key,
  });

  final Map<String, dynamic> data;

  static const routeName = '/neighborgivetip';

  @override
  State<NeighborGiveTipPage> createState() => _NeighborGiveTipPageState();
}

class _NeighborGiveTipPageState extends State<NeighborGiveTipPage> {
  int _selectedTipIndex = 0;
  TextEditingController tipController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<Map<String, dynamic>> tipData = [
    {
      'label': 'No tip',
    },
    {
      'label': r'$1.00',
    },
    {
      'label': r'$3.00',
    },
    {
      'label': 'Other',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final cardState = context.watch<CardsBloc>().state;
    return BlocListener<NeighborsPackagesBloc, NeighborsPackagesState>(
      listener: (context, state) {
        if (state is GiveTipSuccessfull) {
          sl<NeighborsPackagesBloc>().add(
            GetNeighborsPackage(
              jobId: widget.data['jobId'].toString(),
            ),
          );
          context.pop();
          return;
        }
      },
      child: BlocBuilder<NeighborsPackagesBloc, NeighborsPackagesState>(
        builder: (context, state) {
          if (state is TipInProgress) {
            return const CircularLoader();
          }
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: backButtonAppbar(
              context,
              icon: const Icon(Icons.arrow_back),
              backgroundColor: Colors.white,
              text: 'Give Tip',
            ),
            body: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeHelper.moderateScale(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(gap: 30),
                        const Text(
                          'Do you want to leave a tip?',
                          style:
                              TextStyle(fontFamily: ralewayBold, fontSize: 16),
                        ),
                        const Gap(gap: 10),
                        Text(
                          'The tip goes 100% to the helper',
                          style: TextStyle(
                            fontFamily: interRegular,
                            fontSize: SizeHelper.moderateScale(12),
                            color: doveGray,
                          ),
                        ),
                        const Gap(gap: 15),
                        Row(
                          children: tipData.asMap().entries.map((entry) {
                            final index = entry.key;
                            final itemData = entry.value;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedTipIndex = index;
                                });
                              },
                              child: TipBox(
                                image: '',
                                tipBox: false,
                                tipLabel: itemData['label'] as String,
                                isSelected: _selectedTipIndex == index,
                              ),
                            );
                          }).toList(),
                        ),
                        const Gap(gap: 20),
                        if (_selectedTipIndex == 3)
                          AppInput(
                            placeHolder: 'Amount here',
                            label: 'Tip Amount',
                            horizontalMargin: 0,
                            controller: tipController,
                            validator: ProjectRegex.tipValidator,
                            keyboardType: TextInputType.number,
                          ),
                        const Gap(gap: 20),
                        buildPaymentSection(context: context, state: cardState),
                      ],
                    ),
                  ),
                  if (cardState is GetCardListState)
                    if (_selectedTipIndex != 0 && cardState.list.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(
                          bottom: SizeHelper.moderateScale(38),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeHelper.moderateScale(20),
                        ),
                        child: AppButton(
                          horizontalMargin: 0,
                          text: 'Submit',
                          onPress: () {
                            final tip = formatTip(_selectedTipIndex);
                            final selectedTip = tip == null
                                ? tipController.value.text == ''
                                    ? 0
                                    : int.parse(tipController.value.text)
                                : tip;
                            final body = <String, dynamic>{
                              'job_id': widget.data['jobId'],
                              'package_id': widget.data['packageId'],
                              'tip': selectedTip,
                            };
                            if (_formKey.currentState!.validate()) {
                              sl<NeighborsPackagesBloc>().add(
                                GiveTip(tipBody: body),
                              );
                            }
                          },
                        ),
                      ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
