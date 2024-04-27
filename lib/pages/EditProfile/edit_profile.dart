// ignore_for_file: inference_failure_on_function_invocation
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/presentation/bloc/profile/profile_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/regex_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/app_button.dart';
import 'package:neighbour_app/widgets/app_input.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';
import 'package:neighbour_app/widgets/custom_dialog_box.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/snackbar.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  static const routeName = '/edit-profile';

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController reasonController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final bool autoValidate = true;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  String base64SelectedImage = '';

  @override
  void initState() {
    final state = context.read<ProfileBloc>().state;
    if (state is ProfileInitial) {
      firstNameController = TextEditingController(text: state.firstName);
      lastNameController = TextEditingController(text: state.lastName);
      reasonController = TextEditingController(text: state.description);
    }
    super.initState();
  }

  Future<void> _pickImage({required bool isCamera}) async {
    final pickedFile = await _picker.pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 20,
    );
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final imageBytes = await file.readAsBytes();
      final base64Image = base64Encode(imageBytes);
      setState(() {
        base64SelectedImage = base64Image;
        selectedImage = file;
      });
    }
  }

  void _cameraDialog(BuildContext context) {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              GlassContainer(
                blur: 5,
                child: Container(
                  height: SizeHelper.getDeviceHeight(100),
                  width: SizeHelper.getDeviceWidth(100),
                  color: Colors.transparent,
                ),
              ),
              CustomDialogBox(
                onConfirmPressed: () {
                  _pickImage(isCamera: true);
                  context.pop();
                },
                onCancelPressed: () {
                  _pickImage(isCamera: false);
                  context.pop();
                },
                confirmText: 'Camera',
                cancelText: 'Gallery',
                confirmTextColor: Colors.white,
                cancelTextColor: Colors.white,
                confirmBtnBackgroundColor: cornflowerBlue,
                cancelBtnBackgroundColor: cornflowerBlue,
                heading: 'Choose Photo',
                verticalHeight: Platform.isAndroid ? 38 : 33,
                description: '',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget editImage({
    required String firstName,
    required String lastName,
    Uint8List? image,
  }) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundColor:
              image == null && selectedImage == null ? codGray : Colors.white,
          radius: SizeHelper.moderateScale(50),
          child: selectedImage != null
              ? CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: SizeHelper.moderateScale(50),
                  backgroundImage: FileImage(selectedImage!),
                )
              : image != null
                  ? CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: SizeHelper.moderateScale(50),
                      backgroundImage: MemoryImage(image),
                    )
                  : Text(
                      getInitials(
                        firstName: firstName,
                        lastName: lastName,
                      ),
                      style: TextStyle(
                        fontFamily: ralewayBold,
                        fontSize: SizeHelper.moderateScale(40),
                        color: Colors.white,
                      ),
                    ),
        ),
        Positioned(
          right: 0,
          bottom: 12,
          child: InkWell(
            onTap: () => _cameraDialog(context),
            child: CircleAvatar(
              radius: SizeHelper.moderateScale(12),
              backgroundColor: cornflowerBlue,
              child: SvgPicture.asset(
                editprofileIcon,
                height: SizeHelper.moderateScale(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is EditProfileSuccessfull) {
          snackBarComponent(
            context,
            color: chateauGreen,
            message: 'Profile updated successfully',
          );
          return;
        }
        if (state is EditProfileError) {
          snackBarComponent(
            context,
            color: Colors.red,
            message: state.error,
          );
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileInitial) {
            final bytes =
                state.imageUrl != null ? base64Decode(state.imageUrl!) : null;
            return SafeArea(
              top: false,
              bottom: false,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: backButtonAppbar(
                  context,
                  text: 'Edit Profile',
                  backgroundColor: Colors.white,
                  icon: const Icon(Icons.arrow_back),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: SizeHelper.moderateScale(30),
                            ),
                            child: Column(
                              children: [
                                editImage(
                                  image: bytes,
                                  firstName: state.firstName,
                                  lastName: state.lastName,
                                ),
                                const Gap(gap: 15),
                                Text(
                                  '${state.firstName} ${state.lastName}',
                                  style: TextStyle(
                                    fontFamily: ralewayBold,
                                    fontSize: SizeHelper.moderateScale(16),
                                    color: codGray,
                                  ),
                                ),
                                const Gap(gap: 15),
                                AppInput(
                                  placeHolder: 'First Name',
                                  label: 'First Name',
                                  isAutoValidate: autoValidate,
                                  controller: firstNameController,
                                  validator: ProjectRegex.firstNameValidator,
                                  maxLenght: 15,
                                ),
                                AppInput(
                                  placeHolder: 'Last Name',
                                  label: 'Last Name',
                                  isAutoValidate: autoValidate,
                                  controller: lastNameController,
                                  validator: ProjectRegex.lastNameValidator,
                                  maxLenght: 15,
                                ),
                                AppInput(
                                  placeHolder: state.email,
                                  label: 'Email',
                                  enabled: false,
                                ),
                                const Gap(gap: 7),
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
                                ),
                                const Gap(gap: 20),
                                AppButton(
                                  onPress: () => handleSaveAndContinue(
                                    state.imageUrl,
                                  ),
                                  text: 'Save and Continue',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const CircularLoader();
        },
      ),
    );
  }

  Future<void> handleSaveAndContinue(String? userImage) async {
    final body = <String, dynamic>{
      'first_name': firstNameController.value.text,
      'last_name': lastNameController.value.text,
      'description': reasonController.value.text,
    };
    final body2 = <String, dynamic>{
      'first_name': firstNameController.value.text,
      'last_name': lastNameController.value.text,
      'description': reasonController.value.text,
      'image_url': base64SelectedImage,
    };
    if (_formKey.currentState!.validate()) {
      sl<ProfileBloc>().add(
        EditProfileEvent(
          body: selectedImage != null ? body2 : body,
        ),
      );
    }
  }
}
