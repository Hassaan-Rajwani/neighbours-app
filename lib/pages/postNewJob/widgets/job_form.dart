// ignore_for_file: use_build_context_synchronously, avoid_bool_literals_in_conditional_expressions, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/Addresses/new_addresses.dart';
import 'package:neighbour_app/pages/Home/home.dart';
import 'package:neighbour_app/pages/payment/payment.dart';
import 'package:neighbour_app/presentation/bloc/address/address_bloc.dart';
import 'package:neighbour_app/presentation/bloc/cards/cards_bloc.dart';
import 'package:neighbour_app/presentation/bloc/jobs/jobs_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/regex_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/storage.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/app_button.dart';
import 'package:neighbour_app/widgets/app_button_small.dart';
import 'package:neighbour_app/widgets/app_input.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/snackbar.dart';
import 'package:neighbour_app/widgets/tip_box.dart';

class JobForm extends StatefulWidget {
  const JobForm({
    this.data,
    super.key,
  });

  final Map<String, dynamic>? data;

  @override
  State<JobForm> createState() => _JobFormState();
}

class _JobFormState extends State<JobForm> {
  TextEditingController reasonController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController numberOfPackageController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isParcelPickupSelected = true;
  bool isParcelDelieveredSelected = false;
  int _selectedTypeIndex = 0;
  int _selectedSizeIndex = 0;
  String selectedItem = '';
  bool isData = false;

  final List<Map<String, dynamic>> typeData = [
    {
      'label': 'One Time',
      'image': mingcutewhite,
    },
    {
      'label': 'Recurring',
      'image': recurringIcon,
    },
  ];
  final List<String> selectedImages = [mingcutewhite, recurringIcon];
  final List<String> unselectedImages = [mingcute, recurringBlue];

  final List<Map<String, dynamic>> sizeData = [
    {
      'label': 'Small(0-3lbs)',
      'image': mingcutewhite,
    },
    {
      'label': 'Medium(4-10lbs)',
      'image': sizeBoxMediumBlue,
    },
    {
      'label': 'Large(11+lbs)',
      'image': sizeBoxLargeBlue,
    },
  ];

  final List<String> selectedSizeImages = [
    sizeBoxWhite,
    sizeBoxMediumBlue,
    sizeBoxLargeBlue,
  ];

  final List<String> unselectedSizeImages = [
    sizeBoxBlue,
    sizeBoxMediumWhite,
    sizeBoxLargeWhite,
  ];

  @override
  void initState() {
    final state = BlocProvider.of<AddressBloc>(context).state;
    if (state is AddressesState && state.list.isNotEmpty) {
      selectedItem = state.list
          .where((e) {
            return e.isDefault;
          })
          .first
          .id;
    }
    sl<AddressBloc>().add(GetAddressEvent());
    isData = widget.data.toString() != '{}';
    if (isData) {
      jobTitleController = TextEditingController(
        text: widget.data!['title'].toString(),
      );
      amountController = TextEditingController(
        text: widget.data!['budget'].toString(),
      );
      reasonController = TextEditingController(
        text: widget.data!['description'].toString(),
      );
      numberOfPackageController = TextEditingController(
        text: widget.data!['jobType'] == 'ONE_TIME'
            ? '1'
            : widget.data!['numberOfPackage'].toString(),
      );
      _selectedSizeIndex = checkParcelSizeInt(widget.data!['size'].toString());
      _selectedTypeIndex = checkJobTypeInt(widget.data!['jobType'].toString());

      final parcelType =
          checkPickupTypeForJob(widget.data!['parcelType'].toString());

      isParcelPickupSelected =
          parcelType == 0 || parcelType == 2 ? true : false;
      isParcelDelieveredSelected =
          parcelType == 1 || parcelType == 2 ? true : false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<JobsBloc, JobsState>(
      listener: (context, state) {
        if (state is CreateJobSuccessfull) {
          sl<JobsBloc>().add(
            const GetPendingJobEvent(),
          );
          context.pop();
          snackBarComponent(
            context,
            color: chateauGreen,
            message: 'Job created successfully',
            floating: true,
          );
          return;
        }
        if (state is EditJobSuccessfull) {
          sl<JobsBloc>().add(const GetPendingJobEvent());
          context.go(HomePage.routeName);
          snackBarComponent(
            context,
            color: chateauGreen,
            message: 'Job edit successfully',
            floating: true,
          );
          return;
        }
        if (state is CreateJobError) {
          snackBarComponent(
            context,
            color: Colors.red,
            message: state.error,
          );
        }
        if (state is EditJobError) {
          snackBarComponent(
            context,
            color: Colors.red,
            message: state.error,
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeHelper.moderateScale(
            20,
          ),
          vertical: SizeHelper.moderateScale(
            25,
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              SizeHelper.moderateScale(
                16,
              ),
            ),
            topRight: Radius.circular(
              SizeHelper.moderateScale(
                16,
              ),
            ),
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter Job Details',
                style: TextStyle(
                  fontFamily: interSemibold,
                  fontSize: SizeHelper.moderateScale(14),
                  color: codGray,
                ),
              ),
              const Gap(gap: 20),
              AppInput(
                horizontalMargin: 0,
                placeHolder: 'Title..',
                label: 'Title',
                controller: jobTitleController,
                validator: ProjectRegex.jobTitleValidator,
              ),
              Text(
                'Type',
                style: TextStyle(
                  fontFamily: ralewaySemibold,
                  fontSize: SizeHelper.moderateScale(12),
                  color: codGray,
                ),
              ),
              const Gap(gap: 8),
              Row(
                children: typeData.asMap().entries.map((entry) {
                  final index = entry.key;
                  final itemData = entry.value;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTypeIndex = index;
                      });
                    },
                    child: TipBox(
                      tipBox: true,
                      tipLabel: itemData['label'] as String,
                      image: _selectedTypeIndex == index
                          ? selectedImages[index]
                          : unselectedImages[index],
                      isSelected: _selectedTypeIndex == index,
                    ),
                  );
                }).toList(),
              ),
              const Gap(gap: 20),
              if (_selectedTypeIndex != 0)
                AppInput(
                  textarea: false,
                  placeHolder: 'Enter Parcels',
                  horizontalMargin: 0,
                  label: 'Estimated number of packages',
                  keyboardType: TextInputType.number,
                  controller: numberOfPackageController,
                  validator: ProjectRegex.numberOfPackageValidator,
                ),
              Text(
                'Select Size',
                style: TextStyle(
                  fontFamily: ralewaySemibold,
                  fontSize: SizeHelper.moderateScale(12),
                  color: codGray,
                ),
              ),
              const Gap(gap: 8),
              Wrap(
                children: [
                  Row(
                    children: sizeData.asMap().entries.map((entry) {
                      final index = entry.key;
                      final itemData = entry.value;
                      return Row(
                        children: [
                          AppButtonSmall(
                            isSelected: true,
                            onPress: () {
                              setState(() {
                                _selectedSizeIndex = index;
                              });
                            },
                            btnColor: _selectedSizeIndex == index
                                ? cornflowerBlue
                                : Colors.white,
                            image: _selectedSizeIndex == index
                                ? selectedSizeImages[index]
                                : unselectedSizeImages[index],
                            imageSize: SizeHelper.moderateScale(12),
                            imageColor: _selectedSizeIndex == index
                                ? Colors.white
                                : cornflowerBlue,
                            text: itemData['label'] as String,
                            textColor: _selectedSizeIndex == index
                                ? Colors.white
                                : cornflowerBlue,
                          ),
                          const Gap(
                            gap: 5,
                            axis: 'x',
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
              const Gap(gap: 20),
              AppInput(
                textarea: false,
                placeHolder: 'Enter Amount',
                horizontalMargin: 0,
                label: "What's your budget for this job?",
                controller: amountController,
                validator: ProjectRegex.jobAmountValidator,
                keyboardType: TextInputType.number,
                maxLenght: 5,
              ),
              Text(
                'Pickup - Type',
                style: TextStyle(
                  fontFamily: ralewaySemibold,
                  fontSize: SizeHelper.moderateScale(12),
                  color: codGray,
                ),
              ),
              const Gap(gap: 8),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeHelper.moderateScale(10),
                      vertical: SizeHelper.moderateScale(20),
                    ),
                    decoration: BoxDecoration(
                      color: cornflowerBlue.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(
                        SizeHelper.moderateScale(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Parcel Pickup',
                          style: TextStyle(
                            fontFamily: interMedium,
                            fontSize: SizeHelper.moderateScale(
                              12,
                            ),
                            color: codGray,
                          ),
                        ),
                        const Gap(
                          gap: 10,
                          axis: 'x',
                        ),
                        SizedBox(
                          height: SizeHelper.moderateScale(16),
                          width: SizeHelper.moderateScale(16),
                          child: Checkbox(
                            side: const BorderSide(color: silverColor),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: isParcelPickupSelected,
                            onChanged: (value) {
                              setState(() {
                                isParcelPickupSelected = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(
                    gap: 10,
                    axis: 'x',
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeHelper.moderateScale(10),
                      vertical: SizeHelper.moderateScale(20),
                    ),
                    decoration: BoxDecoration(
                      color: cornflowerBlue.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(
                        SizeHelper.moderateScale(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Parcel Delivery',
                          style: TextStyle(
                            fontFamily: interMedium,
                            fontSize: SizeHelper.moderateScale(
                              12,
                            ),
                            color: codGray,
                          ),
                        ),
                        const Gap(
                          gap: 10,
                          axis: 'x',
                        ),
                        SizedBox(
                          height: SizeHelper.moderateScale(16),
                          width: SizeHelper.moderateScale(16),
                          child: Checkbox(
                            side: const BorderSide(
                              color: silverColor,
                            ),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: isParcelDelieveredSelected,
                            onChanged: (value) {
                              setState(() {
                                isParcelDelieveredSelected = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(gap: 20),
              _buildDropdown(),
              const Gap(gap: 10),
              AppInput(
                label: 'Description',
                textarea: false,
                placeHolder: 'Description',
                maxLines: 5,
                controller: reasonController,
                maxLenght: 200,
                keyboardType: TextInputType.multiline,
                validator: ProjectRegex.descriptionValidator,
                isCounterText: true,
                horizontalMargin: 0,
              ),
              Padding(
                padding: EdgeInsets.zero,
                child: BlocBuilder<JobsBloc, JobsState>(
                  builder: (context, state) {
                    return AppButton(
                      horizontalMargin: 0,
                      onPress: onCreateJob,
                      buttonLoader: state is CreatejobInprogress ||
                              state is EditjobInprogress
                          ? true
                          : false,
                      text: isData ? 'Edit Job' : 'Post Job',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onCreateJob() async {
    final numberOfPackage = numberOfPackageController.value.text == ''
        ? '1'
        : numberOfPackageController.value.text;
    final amount =
        amountController.value.text == '' ? '0' : amountController.value.text;
    final jobBody = <String, dynamic>{
      'title': jobTitleController.value.text,
      'type': checkJobType(_selectedTypeIndex),
      'number_of_package': int.parse(numberOfPackage),
      'size': [checkParcelSize(_selectedSizeIndex)],
      'budget': int.parse(amount),
      'pickup_type': checkPickupType(
        isParcelPickupSelected && isParcelDelieveredSelected
            ? 'both'
            : isParcelDelieveredSelected
                ? 'delivery'
                : 'pickup',
      ),
      'address': selectedItem,
      'description': reasonController.value.text,
    };
    final addressState = BlocProvider.of<AddressBloc>(context).state;
    final cardState = BlocProvider.of<CardsBloc>(context).state;

    final token = await getDataFromStorage(StorageKeys.userToken);
    if (_formKey.currentState!.validate()) {
      if (!isData) {
        if (addressState is AddressesState && cardState is GetCardListState) {
          if (addressState.list.isNotEmpty && cardState.list.isNotEmpty) {
            if (isParcelPickupSelected || isParcelDelieveredSelected) {
              sl<JobsBloc>().add(
                CreateJobEvent(
                  token: token!,
                  jobBody: jobBody,
                ),
              );
            } else {
              snackBarComponent(
                context,
                color: Colors.red,
                message: 'Please select pickup type',
              );
            }
          } else if (addressState.list.isEmpty) {
            snackBarComponent(
              context,
              color: Colors.red,
              message: 'Please add address before posting job',
            );
          } else if (cardState.list.isEmpty) {
            snackBarComponent(
              context,
              color: Colors.red,
              message: 'Please add bank details before posting job',
            );
            Future.delayed(const Duration(milliseconds: 1000), () async {
              await context.push('${PaymentPage.routeName}?isFromJobPage=true');
            });
          }
        }
      } else {
        if (isParcelPickupSelected || isParcelDelieveredSelected) {
          sl<JobsBloc>().add(
            EditJobEvent(
              token: token!,
              jobBody: jobBody,
              jobId: widget.data!['jobId'].toString(),
            ),
          );
        } else {
          snackBarComponent(
            context,
            color: Colors.red,
            message: 'Please select pickup type',
          );
        }
      }
    }
  }

  Widget _buildDropdown() {
    return BlocBuilder<AddressBloc, AddressState>(
      builder: (context, state) {
        if (state is AddressesState) {
          final list = state.list.map((e) => e.streetName).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: SizeHelper.moderateScale(8),
                ),
                child: Text(
                  'Address',
                  style: TextStyle(
                    fontFamily: ralewaySemibold,
                    fontSize: SizeHelper.moderateScale(12),
                    color: codGray,
                  ),
                ),
              ),
              if (state.list.isEmpty)
                Container(
                  padding: EdgeInsets.all(SizeHelper.moderateScale(10)),
                  decoration: BoxDecoration(
                    color: cornflowerBlue.withOpacity(0.05),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        SizeHelper.moderateScale(8),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Add Your Address',
                        style: TextStyle(
                          color: cornflowerBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: cornflowerBlue,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            context.push(
                              '${NewAddresses.routeName}?isFromJobPage=true',
                            );
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                Container(
                  margin: EdgeInsets.only(bottom: SizeHelper.moderateScale(10)),
                  decoration: BoxDecoration(
                    color: athensGray,
                    border: Border.all(
                      color: const Color(0xFFECF0F3),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: SizeHelper.moderateScale(2),
                      horizontal: SizeHelper.moderateScale(15),
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      onChanged: (addressID) {
                        if (addressID != null) {
                          setState(() => selectedItem = addressID);
                        }
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: cornflowerBlue,
                      ),
                      iconEnabledColor: const Color(0xFFD4DDE5),
                      underline: const SizedBox(),
                      value: selectedItem.isEmpty || selectedItem == ''
                          ? list[0]
                          : selectedItem,
                      items: state.list.map((e) {
                        return DropdownMenuItem(
                          value: e.id,
                          child: Text(
                            '${e.streetName} ${formatedAddress(e)}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: SizeHelper.moderateScale(12),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
