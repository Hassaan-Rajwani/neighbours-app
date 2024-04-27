// ignore_for_file: lines_longer_than_80_chars, omit_local_variable_types, no_leading_underscores_for_local_identifiers, use_named_constants, unused_local_variable, deprecated_member_use
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/Bids/widget/custom_profile_card.dart';
import 'package:neighbour_app/pages/Home/home.dart';
import 'package:neighbour_app/pages/postNewJob/post_new_job.dart';
import 'package:neighbour_app/presentation/bloc/bids/bids_bloc.dart';
import 'package:neighbour_app/presentation/bloc/cancelJob/cancel_job_bloc.dart';
import 'package:neighbour_app/presentation/bloc/getById/get_by_id_bloc.dart';
import 'package:neighbour_app/presentation/bloc/jobs/jobs_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/image_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/storage.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/snackbar.dart';

class BidsPage extends StatefulWidget {
  const BidsPage({
    required this.bidData,
    super.key,
  });

  static const routeName = '/bid-page';
  final Map<String, dynamic> bidData;

  @override
  State<BidsPage> createState() => _BidsPageState();
}

class _BidsPageState extends State<BidsPage> {
  bool isPickupContainerOpen = false;
  bool isJobCancelled = false;
  bool showChat = true;
  String currentTabbar = 'Bids';

  @override
  void initState() {
    super.initState();
    sl<GetByIdBloc>().add(
      GetJobByIdEvent(jobId: widget.bidData['jobId'].toString()),
    );
    sl<BidsBloc>().add(
      GetNeighborBidsEvent(
        jobId: widget.bidData['jobId'].toString(),
      ),
    );
    mapMarkersSet();
    setCustomMarker();
  }

  Widget appBarRightContainer(void Function() onTap) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: SizeHelper.moderateScale(20)),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Text(
          'Cancel Job',
          style: TextStyle(
            fontFamily: interSemibold,
            color: persimmon,
            fontSize: SizeHelper.moderateScale(16),
          ),
        ),
      ),
    );
  }

  Widget packagePickupJobContainer() {
    Widget packagePickupItem(
      String icon,
      String text, {
      MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
      CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
      bool isLeft = false,
      bool isRight = false,
    }) {
      return Container(
        width: SizeHelper.getDeviceWidth(16),
        height: SizeHelper.moderateScale(70),
        alignment: isLeft
            ? Alignment.centerLeft
            : isRight
                ? Alignment.centerRight
                : Alignment.center,
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: [
            SvgPicture.asset(icon),
            const Gap(gap: 15),
            Text(
              text,
              textAlign: isLeft
                  ? TextAlign.left
                  : isRight
                      ? TextAlign.right
                      : TextAlign.center,
              style: TextStyle(
                fontFamily: interRegular,
                color: codGray,
                fontSize: SizeHelper.moderateScale(12),
              ),
            ),
          ],
        ),
      );
    }

    return BlocBuilder<GetByIdBloc, GetByIdState>(
      builder: (context, state) {
        if (state is GetJobByIdSuccessfull) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isPickupContainerOpen = !isPickupContainerOpen;
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: SizeHelper.moderateScale(20),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeHelper.moderateScale(10),
                    vertical: SizeHelper.moderateScale(15),
                  ),
                  width: SizeHelper.screenWidth,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(SizeHelper.moderateScale(8)),
                    border: Border.all(
                      color: cornflowerBlue,
                      width: SizeHelper.moderateScale(1),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: SizeHelper.getDeviceWidth(67),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Parcel ${state.job.pickupType.toString().pascalCase} Job',
                                  style: TextStyle(
                                    color: codGray,
                                    fontFamily: ralewayExtrabold,
                                    fontSize: SizeHelper.moderateScale(16),
                                  ),
                                ),
                                const Gap(gap: 10),
                                RichText(
                                  text: TextSpan(
                                    text: r'$',
                                    style: TextStyle(
                                      color: cornflowerBlue,
                                      fontSize: SizeHelper.moderateScale(14),
                                      fontFamily: interMedium,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: state.job.budget.toString(),
                                        style: TextStyle(
                                          color: codGray,
                                          fontFamily: interBold,
                                          fontSize:
                                              SizeHelper.moderateScale(14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          BlocBuilder<BidsBloc, BidsState>(
                            builder: (context, bidState) {
                              if (bidState is GetNeighborBidsSuccessfull) {
                                return InkWell(
                                  onTap: () {
                                    final data = state.job.pickupType;
                                    final query = Uri(
                                      queryParameters: {
                                        'parcelType': data.length == 2
                                            ? '${data[0]},${data[1]}'
                                            : data,
                                        'budget': state.job.budget.toString(),
                                        'title': state.job.title,
                                        'description': state.job.description,
                                        'jobType': state.job.type,
                                        'size': state.job.size,
                                        'jobId': state.job.id,
                                        'numberOfPackage': state
                                            .job.numberOfPackage
                                            .toString(),
                                      },
                                    ).query;
                                    if (bidState.list.isEmpty) {
                                      context.push(
                                        '${PostNewJobPage.routeName}?$query',
                                      );
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      right: SizeHelper.moderateScale(10),
                                    ),
                                    child: SvgPicture.asset(
                                      editprofileIcon,
                                      color: bidState.list.isEmpty
                                          ? Colors.blue
                                          : Colors.transparent,
                                      height: SizeHelper.moderateScale(20),
                                      width: SizeHelper.moderateScale(20),
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            },
                          ),
                          SvgPicture.asset(
                            isPickupContainerOpen ? blueUpArrow : blueDownArrow,
                          ),
                        ],
                      ),
                      if (isPickupContainerOpen)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(gap: 15),
                            Text(
                              capitalizeFirstLetter(state.job.title),
                              style: TextStyle(
                                fontFamily: interRegular,
                                fontSize: SizeHelper.moderateScale(16),
                                height: 1.8,
                              ),
                            ),
                            const Gap(gap: 5),
                            Text(
                              state.job.description,
                              style: TextStyle(
                                color: doveGray,
                                fontFamily: interRegular,
                                fontSize: SizeHelper.moderateScale(12),
                                height: 1.8,
                              ),
                            ),
                            const Gap(gap: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                packagePickupItem(
                                  suitcaseIcon,
                                  checkJobTypeFormat(
                                    state.job.type,
                                  ),
                                ),
                                packagePickupItem(
                                  packageBidIcon,
                                  state.job.pickupType.length == 1
                                      ? state.job.pickupType[0].pascalCase
                                      : '''${state.job.pickupType[0].pascalCase} & ${state.job.pickupType[1].pascalCase}''',
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                ),
                                packagePickupItem(
                                  arrowWeightIcon,
                                  state.job.size.toString().pascalCase,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                ),
                              ],
                            ),
                          ],
                        )
                      else
                        Container(),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  Widget tabBar() {
    Widget tabBarItem(String text) {
      return GestureDetector(
        onTap: () {
          setState(() {
            currentTabbar = text;
          });
        },
        child: Container(
          alignment: Alignment.center,
          height: SizeHelper.moderateScale(50),
          width: SizeHelper.getDeviceWidth(43) + SizeHelper.moderateScale(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeHelper.moderateScale(8)),
            color: currentTabbar == text ? codGray : Colors.white,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: interBold,
              color: currentTabbar == text ? Colors.white : baliHai,
              fontSize: SizeHelper.moderateScale(14),
            ),
          ),
        ),
      );
    }

    return Container(
      height: SizeHelper.moderateScale(50),
      width: SizeHelper.getDeviceWidth(87),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: baliHai),
        borderRadius: BorderRadius.circular(SizeHelper.moderateScale(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [tabBarItem('Bids'), tabBarItem('Map View')],
      ),
    );
  }

  Widget divider() {
    return Container(
      width: SizeHelper.getDeviceWidth(100),
      height: 1,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 0.2,
            offset: const Offset(1, 1),
          ),
        ],
      ),
    );
  }

  // Map Flow
  List<Marker> markers = <Marker>[];

  BitmapDescriptor customMarker = BitmapDescriptor.defaultMarker;

  void mapMarkersSet() {
    final addressState = BlocProvider.of<BidsBloc>(context).state;
    if (addressState is GetNeighborBidsSuccessfull) {
      for (var index = 0; index < addressState.list.length; index++) {
        final helperAddress = addressState.list[index];
        // addMarkersToMap(
        //   lati: double.parse(
        //     helperAddress.helperInfo.address!.lat.toString(),
        //   ),
        //   longi: double.parse(
        //     helperAddress.helperInfo.address!.long.toString(),
        //   ),
        //   index: index,
        // );
      }
    }
  }

  Future<void> setCustomMarker() async {
    customMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      platformChecker(
        mapMarker,
        mapMarkerIos,
      ),
    );
  }

  // Future<void> addMarkersToMap({
  //   double? lati,
  //   double? longi,
  //   int? index,
  // }) async {
  //   // Perform the asynchronous operation outside of setState
  //   final BitmapDescriptor bitmapDescriptor =
  //       await BitmapDescriptor.fromAssetImage(
  //     const ImageConfiguration(),
  //     platformChecker(
  //       backFrame,
  //       backFrameIos,
  //     ),
  //   );
  //   // Update the state synchronously inside setState
  //   setState(() {
  //     markers
  //       ..clear()
  //       ..add(
  //         Marker(
  //           markerId: MarkerId('marker$index'),
  //           position: LatLng(lati!, longi!),
  //           icon: bitmapDescriptor,
  //           // infoWindow: const InfoWindow(title: ''),
  //         ),
  //       );
  //   });
  // }

  // Till Here

  @override
  Widget build(BuildContext context) {
    final jobState = context.watch<GetByIdBloc>().state;
    late CameraPosition _cameraPosition;
    if (jobState is GetJobByIdSuccessfull) {
      setState(() {
        _cameraPosition = CameraPosition(
          target: LatLng(
            double.parse(jobState.job.address.lat.toString()),
            double.parse(jobState.job.address.long.toString()),
          ),
          zoom: 10,
        );
      });
    }
    return BlocListener<BidsBloc, BidsState>(
      listener: (context, state) {
        if (state is NeighborBidAcceptSuccessfull) {
          sl<BidsBloc>().add(
            GetNeighborBidsEvent(
              jobId: widget.bidData['jobId'].toString(),
            ),
          );
          sl<JobsBloc>().add(
            const GetPendingJobEvent(),
          );
          context.pop();
          snackBarComponent(
            context,
            color: chateauGreen,
            floating: true,
            message: 'Bid accepted successfully',
          );
        }
      },
      child: BlocBuilder<BidsBloc, BidsState>(
        builder: (context, state) {
          return GestureDetector(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: backButtonAppbar(
                context,
                text: 'Bid Page',
                backgroundColor: Colors.white,
                rightSideWidget: appBarRightContainer(() {
                  final body = <String, dynamic>{
                    'reason':
                        'Neighbor cancelled the job before selecting the Helper.',
                  };
                  sl<CancelJobBloc>().add(
                    PostCancelJobEvent(
                      jobId: widget.bidData['jobId'].toString(),
                      reason: body,
                    ),
                  );
                  context.go(HomePage.routeName);
                  snackBarComponent(
                    context,
                    color: chateauGreen,
                    message: 'Job cancelled successfully',
                    floating: true,
                  );
                }),
                icon: const Icon(Icons.arrow_back),
              ),
              body: Column(
                children: [
                  const Gap(gap: 20),
                  packagePickupJobContainer(),
                  const Gap(gap: 44),
                  // tabBar(),
                  // const Gap(gap: 40),
                  divider(),
                  if (state is GetNeighborBidsInprogress)
                    const CircularLoader(height: 50),
                  if (state is GetNeighborBidsSuccessfull)
                    state.list.isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(
                              bottom: SizeHelper.moderateScale(10),
                              top: SizeHelper.moderateScale(10),
                            ),
                            child: const Text('No Bids Available'),
                          )
                        : Expanded(
                            child: SingleChildScrollView(
                              child: currentTabbar == 'Bids'
                                  ? Column(
                                      children: [
                                        Column(
                                          children: state.list
                                              .asMap()
                                              .entries
                                              .map((entry) {
                                            final itemData = entry.value;
                                            final index = entry.key;
                                            final text = '''
${itemData.helperInfo.firstName} ${itemData.helperInfo.lastName}''';
                                            return Column(
                                              children: [
                                                CustomProfileCard(
                                                  data: itemData,
                                                  onReject: () async {
                                                    final token =
                                                        await getDataFromStorage(
                                                      StorageKeys.userToken,
                                                    );
                                                    sl<BidsBloc>().add(
                                                      NeighborBidRejectEvent(
                                                        token: token!,
                                                        jobId: itemData.jobId,
                                                        bidId: itemData.id,
                                                      ),
                                                    );
                                                    setState(() {
                                                      itemData.status =
                                                          'CANCELLED';
                                                    });
                                                    Future.delayed(
                                                        const Duration(
                                                          milliseconds: 1000,
                                                        ), () {
                                                      setState(() {
                                                        state.list
                                                            .removeAt(index);
                                                      });
                                                      context.pop();
                                                    });
                                                  },
                                                  onAccept: () async {
                                                    final token =
                                                        await getDataFromStorage(
                                                      StorageKeys.userToken,
                                                    );
                                                    sl<BidsBloc>().add(
                                                      NeighborBidAcceptEvent(
                                                        token: token!,
                                                        jobId: itemData.jobId,
                                                        bidId: itemData.id,
                                                      ),
                                                    );
                                                    setState(() {
                                                      itemData.status =
                                                          'APPROVED';
                                                    });
                                                  },
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 20,
                                                  ),
                                                  child: Divider(
                                                    color: silverColor,
                                                    thickness: 1,
                                                    height: SizeHelper
                                                        .moderateScale(
                                                      0,
                                                    ),
                                                    indent: 0,
                                                    endIndent: 0,
                                                  ),
                                                ),
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    )
                                  :
                                  // Google Map
                                  SizedBox(
                                      height: SizeHelper.getDeviceHeight(60),
                                      width: SizeHelper.screenWidth,
                                      child: GoogleMap(
                                        initialCameraPosition: _cameraPosition,
                                        myLocationButtonEnabled: false,
                                        onCameraIdle: () {
                                          setState(() {
                                            if (jobState
                                                is GetJobByIdSuccessfull) {
                                              markers.add(
                                                Marker(
                                                  markerId:
                                                      const MarkerId('value'),
                                                  position: LatLng(
                                                    double.parse(
                                                      jobState.job.address.lat
                                                          .toString(),
                                                    ),
                                                    double.parse(
                                                      jobState.job.address.long
                                                          .toString(),
                                                    ),
                                                  ),
                                                  icon: customMarker,
                                                ),
                                              );
                                            }
                                          });
                                        },
                                        onMapCreated: (controller) {
                                          mapMarkersSet();
                                        },
                                        markers: Set<Marker>.of(markers),
                                      ),
                                    ),
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
