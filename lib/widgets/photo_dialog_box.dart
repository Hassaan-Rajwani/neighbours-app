// ignore_for_file: inference_failure_on_function_invocation
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/presentation/bloc/helperPackage/helper_package_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/app_input.dart';
import 'package:neighbour_app/widgets/custom_dialog_box.dart';
import 'package:neighbour_app/widgets/gap.dart';

class PhotoDialogBox extends StatefulWidget {
  const PhotoDialogBox({
    required this.onCancelPressed,
    required this.jobId,
    super.key,
  });
  final void Function() onCancelPressed;
  final String jobId;

  @override
  State<PhotoDialogBox> createState() => _PhotoDialogBoxState();
}

File? _pickedImage;
String base64SelectedImage = '';

class _PhotoDialogBoxState extends State<PhotoDialogBox> {
  UploadedPhoto? uploadedPhotos;
  final ImagePicker _picker = ImagePicker();

  void addUploadedPhoto(String name, String fileSize) {}

  String _formatFileSize(int fileSizeInBytes) {
    const kb = 1024;
    const mb = kb * 1024;
    const gb = mb * 1024;

    if (fileSizeInBytes >= gb) {
      return '${(fileSizeInBytes / gb).toStringAsFixed(2)} Gb';
    } else if (fileSizeInBytes >= mb) {
      return '${(fileSizeInBytes / mb).toStringAsFixed(2)} Mb';
    } else if (fileSizeInBytes >= kb) {
      return '${(fileSizeInBytes / kb).toStringAsFixed(2)} Kb';
    } else {
      return '$fileSizeInBytes B';
    }
  }

  Future<void> _pickImage({required bool isCamera}) async {
    final pickedFile = await _picker.pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 20,
    );
    if (pickedFile != null) {
      final name = pickedFile.name;
      final imageFile = File(pickedFile.path);
      final imageBytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(imageBytes);
      final fileSize = await imageFile.length();
      final formattedFileSize = _formatFileSize(fileSize);

      setState(() {
        base64SelectedImage = base64Image;
        _pickedImage = imageFile;
        uploadedPhotos = UploadedPhoto(name, formattedFileSize);
      });
    }
  }

  void removeUploadedPhoto() {
    setState(() {
      _pickedImage = null;
      uploadedPhotos = null;
    });
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

  Future<void> onPackageConfirm() async {
    final body = <String, dynamic>{
      'image_url': base64SelectedImage,
    };
    sl<HelperPackageBloc>().add(
      CreatePackageEvent(
        jobId: widget.jobId,
        body: body,
      ),
    );
    context.pop();
    _pickedImage = null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: SizeHelper.moderateScale(20),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: SizedBox(
        width: SizeHelper.screenWidth,
        height: SizeHelper.moderateScale(330),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColoredBox(
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    'Add New Package',
                    style: TextStyle(
                      fontSize: SizeHelper.moderateScale(16),
                      fontFamily: urbanistBold,
                    ),
                  ),
                  const Gap(gap: 30),
                  const AppInput(
                    horizontalMargin: 0,
                    label: 'Package Title',
                    placeHolder: 'Package no #187283728',
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      width: SizeHelper.moderateScale(500),
                      height: SizeHelper.moderateScale(45),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        _cameraDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(
                          width: SizeHelper.moderateScale(1),
                          color: cornflowerBlue,
                        ),
                        shadowColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Upload Photo',
                        style: TextStyle(
                          color: cornflowerBlue,
                          fontFamily: urbanistBold,
                          fontSize: SizeHelper.moderateScale(14),
                        ),
                      ),
                    ),
                  ),
                  const Gap(gap: 15),
                  if (uploadedPhotos == null)
                    Container(
                      width: SizeHelper.getDeviceWidth(80) +
                          SizeHelper.moderateScale(1),
                      padding: EdgeInsets.symmetric(
                        vertical: SizeHelper.moderateScale(5),
                        horizontal: SizeHelper.moderateScale(16),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: silver),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.image,
                            color: silver,
                            size: SizeHelper.moderateScale(36),
                          ),
                          SizedBox(width: SizeHelper.moderateScale(10)),
                          Text(
                            'No photo uploaded',
                            style: TextStyle(
                              fontSize: SizeHelper.moderateScale(12),
                              fontFamily: ralewaySemibold,
                              color: silver,
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: SizeHelper.moderateScale(36),
                            child: const IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: null,
                              color: silver,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    UploadedPhotoContainer(
                      photo: uploadedPhotos!,
                      onDelete: removeUploadedPhoto,
                    ),
                  const Gap(gap: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          widget.onCancelPressed();
                        },
                        child: Container(
                          height: SizeHelper.moderateScale(40),
                          width: SizeHelper.moderateScale(140),
                          padding: EdgeInsets.symmetric(
                            vertical: SizeHelper.moderateScale(13),
                            horizontal: SizeHelper.moderateScale(15),
                          ),
                          decoration: BoxDecoration(
                            color: silverColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: doveGray,
                              fontSize: SizeHelper.moderateScale(14),
                              fontFamily: urbanistBold,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _pickedImage != null ? onPackageConfirm : () {},
                        child: Container(
                          height: SizeHelper.moderateScale(40),
                          width: SizeHelper.moderateScale(140),
                          padding: EdgeInsets.symmetric(
                            vertical: SizeHelper.moderateScale(13),
                            horizontal: SizeHelper.moderateScale(15),
                          ),
                          decoration: BoxDecoration(
                            color: _pickedImage != null
                                ? cornflowerBlue
                                : silverColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Confirm',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: _pickedImage == null
                                  ? doveGray
                                  : Colors.white,
                              fontSize: SizeHelper.moderateScale(14),
                              fontFamily: urbanistBold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UploadedPhoto {
  UploadedPhoto(this.name, this.fileSize);
  final String name;
  final String fileSize;
}

class UploadedPhotoContainer extends StatelessWidget {
  const UploadedPhotoContainer({
    required this.photo,
    required this.onDelete,
    super.key,
  });
  final UploadedPhoto photo;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeHelper.moderateScale(10),
        vertical: SizeHelper.moderateScale(5),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: subTextColor),
        color: scafColor,
        borderRadius: BorderRadius.circular(
          SizeHelper.moderateScale(8),
        ),
      ),
      child: Row(
        children: [
          if (_pickedImage != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(
                SizeHelper.moderateScale(8),
              ),
              child: Image.file(
                _pickedImage!,
                width: SizeHelper.moderateScale(40),
                height: SizeHelper.moderateScale(40),
                fit: BoxFit.cover,
              ),
            )
          else
            SizedBox(
              width: SizeHelper.moderateScale(80),
              height: SizeHelper.moderateScale(60),
              // child: Image.asset('assets/images/profileFour.png'),
            ),
          const SizedBox(width: 10),
          SizedBox(
            width: SizeHelper.moderateScale(150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  photo.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: ralewaySemibold,
                    fontSize: SizeHelper.moderateScale(12),
                  ),
                ),
                const Gap(gap: 5),
                Text(
                  overflow: TextOverflow.ellipsis,
                  photo.fileSize,
                  style: TextStyle(
                    fontFamily: interRegular,
                    fontSize: SizeHelper.moderateScale(10),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDelete,
            color: cinnabar,
          ),
        ],
      ),
    );
  }
}
