import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/AllJobs/widgets/helper_new_jobs_card.dart';
import 'package:neighbour_app/pages/newJobDetail/new_job_detail.dart';
import 'package:neighbour_app/presentation/bloc/address/address_bloc.dart';
import 'package:neighbour_app/presentation/bloc/helperJobs/helper_jobs_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';
import 'package:neighbour_app/widgets/no_jobs_widget.dart';

class HelperNewJobsPage extends StatefulWidget {
  const HelperNewJobsPage({super.key});

  static const routeName = '/helper-new-jobs';

  @override
  State<HelperNewJobsPage> createState() => _HelperNewJobsPageState();
}

class _HelperNewJobsPageState extends State<HelperNewJobsPage> {
  int selectedCardIndex = -1;

  Future<void> onrefresh() async {
    sl<HelperJobsBloc>().add(const GetHelperAllJobsEvent());
  }

  @override
  void initState() {
    sl<AddressBloc>().add(GetAddressEvent());
    onrefresh();
    super.initState();
  }

  bool address = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gallery,
      appBar: backButtonAppbar(
        context,
        icon: const Icon(Icons.arrow_back),
        backgroundColor: Colors.white,
        text: 'New Jobs',
      ),
      body: BlocBuilder<HelperJobsBloc, HelperJobsState>(
        builder: (context, state) {
          final addressState = BlocProvider.of<AddressBloc>(context).state;
          if (addressState is AddressesState) {
            address = addressState.list.isNotEmpty;
          }
          var isAllPendingJobsListEmpty = false;
          if (state is GetHelperAllJobsSuccessfull) {
            isAllPendingJobsListEmpty = state.pendingList.isEmpty;
          }
          return RefreshIndicator(
            onRefresh: onrefresh,
            child: SingleChildScrollView(
              child: address
                  ? Column(
                      children: [
                        if (state is GetHelperAllJobsInprogress)
                          Container(
                            margin: EdgeInsets.only(
                              top: SizeHelper.moderateScale(30),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        if (state is GetHelperAllJobsSuccessfull)
                          isAllPendingJobsListEmpty
                              ? const NoJobsWidget(
                                  text: 'No Jobs availabe at the moment',
                                )
                              : Container(
                                  padding: EdgeInsets.all(
                                    SizeHelper.moderateScale(20),
                                  ),
                                  child: Column(
                                    children: state.pendingList
                                        .toList()
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      final index = entry.key;
                                      return GestureDetector(
                                        onTap: () {
                                          final budget = state
                                              .pendingList[index].budget
                                              .toString();
                                          final rating = double.parse(
                                            state.pendingList[index].neighbourId
                                                .helper.rating
                                                .toStringAsFixed(1),
                                          ).toString();
                                          final lat = state
                                              .pendingList[index].address.lat
                                              .toString();
                                          final long = state
                                              .pendingList[index].address.long
                                              .toString();
                                          final neighborId = state
                                              .pendingList[index]
                                              .neighbourId
                                              .id;

                                          final pickupType = state
                                                      .pendingList[index]
                                                      .pickupType
                                                      .length ==
                                                  1
                                              ? state.pendingList[index]
                                                  .pickupType[0].pascalCase
                                              : '''${state.pendingList[index].pickupType[0].pascalCase} & ${state.pendingList[index].pickupType[1].pascalCase}''';
                                          final query = Uri(
                                            queryParameters: {
                                              'jobId':
                                                  state.pendingList[index].id,
                                              'firstName': state
                                                  .pendingList[index]
                                                  .neighbourId
                                                  .firstName,
                                              'lastName': state
                                                  .pendingList[index]
                                                  .neighbourId
                                                  .lastName,
                                              'name':
                                                  '''${state.pendingList[index].neighbourId.firstName} ${state.pendingList[index].neighbourId.lastName}''',
                                              'rating': rating,
                                              'description': state
                                                  .pendingList[index]
                                                  .description,
                                              'title': state
                                                  .pendingList[index].title,
                                              'helperDistance': state
                                                  .pendingList[index]
                                                  .helperDistance
                                                  .toStringAsFixed(1),
                                              'distanceUnit': state
                                                  .pendingList[index]
                                                  .distanceUnit,
                                              'type':
                                                  state.pendingList[index].type,
                                              'pickup_type': pickupType,
                                              'size': state
                                                  .pendingList[index].size[0],
                                              'budget': budget,
                                              'neighborId': neighborId,
                                              'lat': lat,
                                              'long': long,
                                              'image': state.pendingList[index]
                                                  .neighbourId.imageUrl,
                                            },
                                          ).query;
                                          context.push(
                                            '''${NewJobDetailPage.routeName}?$query''',
                                          );
                                        },
                                        child: HelperNewJobsCard(
                                          allJobslist: state.pendingList[index],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                      ],
                    )
                  : const NoJobsWidget(
                      text: 'Add your address to see available jobs',
                    ),
            ),
          );
        },
      ),
    );
  }
}
