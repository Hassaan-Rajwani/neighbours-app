// ignore_for_file: avoid_dynamic_calls
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/data/models/get_neighbors_package.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/Home/home.dart';
import 'package:neighbour_app/pages/cancelReviewPage/cancel_review_page.dart';
import 'package:neighbour_app/presentation/bloc/cancelJob/cancel_job_bloc.dart';
import 'package:neighbour_app/presentation/bloc/dispute/dispute_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/enum_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/widgets/snackbar.dart';

void outerCancelJobOnTap({
  required BuildContext context,
  required String jobId,
  required bool isNeighbor,
  required int packageLength,
  required String status,
  required dynamic helperData,
  String? raisedBy,
  String? user,
}) {
  twoButtonDialog(
    context: context,
    heading: 'Need Help?',
    isHelpText: true,
    subHeading: packageLength > 0 || status == jobStatus.PENDING_CANCEL.name
        ? '''You have one available option regarding your open job issue with neighbour:\n\n'''
        : '''You have two options regarding your open job issue with neighbour:\n\n''',
    subHeading2: packageLength > 0
        ? ''' if you believe the problem requires our mediation for resolution. This process can help reach a fair outcome but requires evidence and may take time.\n\n'''
        : ''' if you believe the problem requires our mediation for resolution. This process can help reach a fair outcome but requires evidence and may take time.\n\n''',
    subHeading3: packageLength > 0
        ? ''' option is not available because some work or payment has already been completed'''
        : status == jobStatus.PENDING_CANCEL.name &&
                (raisedBy != null && raisedBy == user)
            ? ''' option is not available because the job has already been cancelled by you.'''
            : ''' if you prefer to immediately end the contract because no work or payment has been done yet, this option is quicker but may affect your platform reputation and have financial implications.''',
    leftButtonText:
        status == jobStatus.DISPUTE.name ? 'Disputed' : 'Open Dispute',
    leftButtonColor: status == jobStatus.DISPUTE.name ? inactiveGray : olivine,
    rightButtonText: status == jobStatus.PENDING_CANCEL.name &&
            (raisedBy != null && raisedBy == user)
        ? 'Cancelled'
        : 'Cancel Job',
    rightButtonColor: packageLength > 0 ||
            (status == jobStatus.PENDING_CANCEL.name &&
                (raisedBy != null && raisedBy == user))
        ? inactiveGray
        : persimmon,
    leftOnTap: () {
      if (status != jobStatus.DISPUTE.name) {
        context.pop();
        _disputeReasonOnTap(
          context: context,
          jobId: jobId,
        );
      }
    },
    rightOnTap: () {
      if (packageLength > 0 ||
          (status == jobStatus.PENDING_CANCEL.name &&
              (raisedBy != null && raisedBy == user))) {
      } else {
        context.pop();
        cancelReasonOnTap(
          context: context,
          jobId: jobId,
          helperData: helperData,
          isNeighbr: isNeighbor,
        );
      }
    },
  );
}

void cancelReasonOnTap({
  required BuildContext context,
  required String jobId,
  required dynamic helperData,
  required bool isNeighbr,
}) {
  final cancelController = TextEditingController();
  twoButtonDialog(
    context: context,
    heading: 'Reason for cancellation?',
    subHeading: isNeighbr
        ? '''Please tell us why you are cancelling, using as much detail as possible.'''
        : '''If no work has been done, no money has been paid out, and you no longer wish to complete this job, you can cancel it. If you want to double-check with the neighbor first, click cancel and message them. If you want to cancel, click confirm. You will be able to leave feedback if you choose to.''',
    leftButtonText: 'Cancel',
    leftButtonColor: silverColor,
    rightButtonText: 'Confirm',
    rightButtonColor: persimmon,
    leftOnTap: () {
      context.pop();
    },
    rightOnTap: () {
      final cancelReason = cancelController.value.text;
      final body = <String, dynamic>{
        'reason': cancelReason,
      };
      sl<CancelJobBloc>().add(
        PostCancelJobEvent(
          jobId: jobId,
          reason: body,
        ),
      );
      snackBarComponent(
        context,
        color: chateauGreen,
        message: 'Job Cancelled Successfully',
        floating: true,
      );
      final query = Uri(
        queryParameters: {
          'helperName': '''${helperData.firstName} ${helperData.lastName}''',
          'image': helperData.imageUrl.toString(),
          'jobId': jobId,
          'firstName': helperData.firstName,
          'lastName': helperData.lastName,
          'isNeighbr': isNeighbr ? 'true' : 'false',
        },
      ).query;
      context
        ..pop()
        ..pop()
        ..push('${CancelReviewPage.routeName}?$query');
    },
    inputArea: true,
    controller: cancelController,
  );
}

void _disputeReasonOnTap({
  required BuildContext context,
  required String jobId,
}) {
  final disputeController = TextEditingController();
  twoButtonDialog(
    context: context,
    heading: 'Reason for dispute?',
    subHeading:
        '''Please tell us why you are opening a dispute, and please be as detailed as possible.''',
    leftButtonText: 'Cancel',
    leftButtonColor: silverColor,
    rightButtonText: 'Confirm',
    rightButtonColor: cornflowerBlue,
    leftOnTap: () {
      context.pop();
    },
    rightOnTap: () {
      final disputeMessage = disputeController.value.text;
      final body = <String, dynamic>{
        'description': disputeMessage,
      };
      sl<DisputeBloc>().add(
        CreateDisputeEvent(
          jobId: jobId,
          message: body,
        ),
      );
      snackBarComponent(
        context,
        color: chateauGreen,
        message: 'Dispute Done',
        floating: true,
      );
      context
        ..pop()
        ..go(HomePage.routeName);
    },
    inputArea: true,
    controller: disputeController,
  );
}

bool areAllPackagesConfirmed(List<NeighborsPackageModel> responses) {
  if (responses.isEmpty) {
    return false;
  } else {
    for (final response in responses) {
      if (response.status != 'CONFIRMED') {
        return false;
      }
    }
    return true;
  }
}

dynamic statusAndRaisedByCheck({
  required dynamic ifTrue,
  required dynamic ifFalse,
  String? status,
  String? raisedBy,
  String? isNeighbor = 'NEIGHBOUR',
}) {
  if (status == 'CANCELLED' ||
      status == 'COMPLETED' ||
      status == 'DISPUTE' ||
      raisedBy != null && raisedBy == isNeighbor) {
    return ifTrue;
  } else {
    return ifFalse;
  }
}

dynamic statusAndPackagesCheck({
  required dynamic ifTrue,
  required dynamic ifFalse,
  int? numberOfPackages,
  int? packageLength,
  String? status,
  bool? button,
}) {
  if (status == 'COMPLETED' ||
      status == 'PENDING_CANCEL' ||
      status == 'DISPUTE') {
    return ifTrue;
  } else {
    if (numberOfPackages == packageLength && button!) {
      return ifFalse;
    } else {
      return ifTrue;
    }
  }
}

Widget addPackageCheck({
  required Widget ifTrue,
  required Widget ifFalse,
  required bool isNotEmpty,
  required String jobType,
  required int numberOfPackages,
  required int packageLength,
  required String status,
}) {
  if (isNotEmpty && jobType == 'ONE_TIME' ||
      numberOfPackages == packageLength ||
      status != jobStatus.ONGOING.name) {
    return ifTrue;
  } else {
    return ifFalse;
  }
}

bool showButtons({
  required String status,
}) {
  if (status != jobStatus.CANCELLED.name &&
      status != jobStatus.COMPLETED.name &&
      status != jobStatus.DISPUTE.name) {
    return true;
  } else {
    return false;
  }
}
