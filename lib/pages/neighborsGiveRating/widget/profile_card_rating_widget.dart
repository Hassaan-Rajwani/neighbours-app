// ignore_for_file: prefer_if_null_operators, lines_longer_than_80_chars, unused_local_variable, unnecessary_null_comparison
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/Home/home.dart';
import 'package:neighbour_app/pages/neighborsGiveRating/widget/default_card_list.dart';
import 'package:neighbour_app/presentation/bloc/cards/cards_bloc.dart';
import 'package:neighbour_app/presentation/bloc/getAllHelpers/all_helper_bloc.dart';
import 'package:neighbour_app/presentation/bloc/jobs/jobs_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/regex_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/app_button.dart';
import 'package:neighbour_app/widgets/app_input.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/snackbar.dart';
import 'package:neighbour_app/widgets/tip_box.dart';

class ProfileCardRatingWidget extends StatefulWidget {
  const ProfileCardRatingWidget({
    required this.helperName,
    required this.firstName,
    required this.lastName,
    required this.jobId,
    required this.image,
    super.key,
  });

  final String helperName;
  final String firstName;
  final String lastName;
  final String jobId;
  final String image;

  @override
  State<ProfileCardRatingWidget> createState() =>
      _ProfileCardRatingWidgetState();
}

class _ProfileCardRatingWidgetState extends State<ProfileCardRatingWidget> {
  TextEditingController reasonController = TextEditingController();
  TextEditingController tipController = TextEditingController();
  int _selectedTipIndex = 0;
  double ratingCount = 1;

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
    final bytes =
        widget.image != '' && widget.image != 'null' && widget.image != null
            ? base64Decode(widget.image)
            : null;
    return BlocListener<JobsBloc, JobsState>(
      listener: (context, state) {
        if (state is CreateReviewSuccessfull) {
          sl<JobsBloc>().add(
            const GetPendingJobEvent(),
          );
          sl<AllHelperBloc>().add(GetAllHelpersEvent(miles: 0, rating: 0));
          context.go(HomePage.routeName);
          snackBarComponent(
            context,
            color: chateauGreen,
            message: 'Job completed successfully',
            floating: true,
          );
          return;
        }
      },
      child: BlocBuilder<JobsBloc, JobsState>(
        builder: (context, state) {
          final cardState = context.watch<CardsBloc>().state;
          if (state is CreateReviewInprogress) {
            return const CircularLoader();
          }
          return Container(
            padding: EdgeInsets.only(
              bottom: SizeHelper.moderateScale(20),
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const Gap(gap: 37),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: gallery,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeHelper.moderateScale(20),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: SizeHelper.moderateScale(50),
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundColor:
                                bytes != null ? Colors.transparent : codGray,
                            backgroundImage:
                                bytes != null ? MemoryImage(bytes) : null,
                            radius: SizeHelper.moderateScale(45),
                            child: bytes == null
                                ? Text(
                                    getInitials(
                                      firstName: widget.firstName,
                                      lastName: widget.lastName,
                                    ),
                                    style: TextStyle(
                                      fontFamily: ralewayBold,
                                      fontSize: SizeHelper.moderateScale(40),
                                      color: Colors.white,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                        Text(
                          widget.helperName,
                          style: TextStyle(
                            fontFamily: ralewayBold,
                            fontSize: SizeHelper.moderateScale(16),
                            color: codGray,
                          ),
                        ),
                        const Gap(gap: 10),
                        Text(
                          'Give Feedback. It will improve our\nApp Experience',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: interRegular,
                            color: doveGray,
                            height: 2,
                            fontSize: SizeHelper.moderateScale(14),
                          ),
                        ),
                        const Gap(gap: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Do you want to leave a tip?',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: ralewayBold,
                                  color: codGray,
                                  fontSize: SizeHelper.moderateScale(16),
                                ),
                              ),
                              const Gap(gap: 10),
                              Text(
                                'The tip goes 100% to the helper',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: interRegular,
                                  color: doveGray,
                                  fontSize: SizeHelper.moderateScale(12),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(gap: 15),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      vertical: SizeHelper.moderateScale(15),
                    ),
                    child: RatingBar.builder(
                      initialRating: 1,
                      minRating: 1,
                      unratedColor: Colors.grey,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          ratingCount = rating;
                        });
                      },
                      updateOnDrag: true,
                    ),
                  ),
                  const Gap(gap: 15),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeHelper.moderateScale(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppInput(
                          label: 'Review',
                          textarea: false,
                          placeHolder: 'Review here',
                          maxLines: 5,
                          controller: reasonController,
                          maxLenght: 200,
                          keyboardType: TextInputType.multiline,
                          validator: ProjectRegex.reviewValidator,
                          isCounterText: true,
                          horizontalMargin: 0,
                        ),
                      ],
                    ),
                  ),
                  buildPaymentSection(context: context, state: cardState),
                  const Gap(gap: 50),
                  if (cardState is GetCardListState)
                    if (cardState.list.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: AppButton(
                          text: 'Submit',
                          onPress: () {
                            final tip = formatTip(_selectedTipIndex);
                            final selectedTip = tip == null
                                ? tipController.value.text == ''
                                    ? 0
                                    : int.parse(tipController.value.text)
                                : tip;
                            final body = <String, dynamic>{
                              'tip': selectedTip,
                              'rating': int.parse(
                                ratingCount.toString().substring(0, 1),
                              ),
                              'review': reasonController.value.text,
                            };
                            if (_formKey.currentState!.validate()) {
                              sl<JobsBloc>().add(
                                CreateReviewEvent(
                                  jobId: widget.jobId,
                                  reviewBody: body,
                                ),
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
