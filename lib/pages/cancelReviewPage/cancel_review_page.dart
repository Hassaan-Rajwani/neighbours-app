import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/presentation/bloc/cancelReviewBloc/cancel_review_bloc.dart';
import 'package:neighbour_app/presentation/bloc/getAllHelpers/all_helper_bloc.dart';
import 'package:neighbour_app/presentation/bloc/helperJobs/helper_jobs_bloc.dart';
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
import 'package:neighbour_app/widgets/snackbar.dart';

class CancelReviewPage extends StatefulWidget {
  const CancelReviewPage({
    required this.data,
    super.key,
  });

  final Map<String, dynamic> data;
  static const routeName = '/cancel-review-page';

  @override
  State<CancelReviewPage> createState() => _CancelReviewPageState();
}

class _CancelReviewPageState extends State<CancelReviewPage> {
  double ratingCount = 1;
  TextEditingController reasonController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bytes = widget.data['image'] != '' &&
            widget.data['image'] != 'null' &&
            widget.data['image'] != null
        ? base64Decode(widget.data['image'].toString())
        : null;
    return BlocListener<CancelReviewBloc, CancelReviewState>(
      listener: (context, state) {
        if (state is CreateCancelReviewSuccessfull) {
          sl<AllHelperBloc>().add(GetAllHelpersEvent(miles: 0, rating: 0));
          sl<HelperJobsBloc>().add(const GetHelperAllJobsEvent());
          context.pop();
          snackBarComponent(
            context,
            color: chateauGreen,
            message: 'Review send successfully',
            floating: true,
          );
          return;
        }
      },
      child: BlocBuilder<CancelReviewBloc, CancelReviewState>(
        builder: (context, state) {
          if (state is CreateCancelReviewInprogress) {
            return const CircularLoader();
          }
          return Scaffold(
            appBar: backButtonAppbar(
              context,
              icon: const Icon(Icons.arrow_back),
              backgroundColor: Colors.white,
              text: 'Give Rating',
            ),
            backgroundColor: Colors.white,
            body: Container(
              margin: EdgeInsets.symmetric(
                vertical: SizeHelper.moderateScale(30),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            width: SizeHelper.screenWidth,
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeHelper.moderateScale(20),
                            ),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: SizeHelper.moderateScale(50),
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    backgroundColor: bytes != null
                                        ? Colors.transparent
                                        : codGray,
                                    backgroundImage: bytes != null
                                        ? MemoryImage(bytes)
                                        : null,
                                    radius: SizeHelper.moderateScale(45),
                                    child: bytes == null
                                        ? Text(
                                            getInitials(
                                              firstName: widget
                                                  .data['firstName']
                                                  .toString(),
                                              lastName: widget.data['lastName']
                                                  .toString(),
                                            ),
                                            style: TextStyle(
                                              fontFamily: ralewayBold,
                                              fontSize:
                                                  SizeHelper.moderateScale(40),
                                              color: Colors.white,
                                            ),
                                          )
                                        : null,
                                  ),
                                ),
                                Text(
                                  widget.data['helperName'].toString(),
                                  style: TextStyle(
                                    fontFamily: ralewayBold,
                                    fontSize: SizeHelper.moderateScale(16),
                                    color: codGray,
                                  ),
                                ),
                                const Gap(gap: 10),
                                Text(
                                  '''Give Feedback. It will improve our\nApp Experience''',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: interRegular,
                                    color: doveGray,
                                    height: 2,
                                    fontSize: SizeHelper.moderateScale(14),
                                  ),
                                ),
                                const Gap(gap: 15),
                              ],
                            ),
                          ),
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
                        ],
                      ),
                    ),
                    AppButton(
                      text: 'Submit',
                      onPress: () {
                        final body = <String, dynamic>{
                          'rating': int.parse(
                            ratingCount.toString().substring(0, 1),
                          ),
                          'review': reasonController.value.text,
                        };
                        if (_formKey.currentState!.validate()) {
                          sl<CancelReviewBloc>().add(
                            CreateCancelReviewEvent(
                              jobId: widget.data['jobId'].toString(),
                              reviewBody: body,
                              isNeighbor: widget.data['isNeighbr'] == 'true',
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
