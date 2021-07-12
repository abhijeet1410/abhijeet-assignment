import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:god_flutter/utils/snackbar_helper.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

///
/// Created by Sunil Kumar on 22-01-2021 08:29 PM.
///

class PhotoChooser extends StatelessWidget {
  final String? title;
  const PhotoChooser({this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 22,
          ),
          Text(
            title ?? 'Choose from a source',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10),
          DefaultTextStyle(
            style: DefaultTextStyle.of(context)
                .style
                .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _chooseImage(ImageSource.camera, context),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/camera.svg',
                          height: 60,
                          width: 60,
                        ),
                        Text('Camera')
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 38,
                ),
                GestureDetector(
                  onTap: () => _chooseImage(ImageSource.gallery, context),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 16, 16, 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/gallery.svg',
                          height: 60,
                          width: 60,
                        ),
                        Text('Gallery')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Divider(height: 0, color: Colors.grey),
          TextButton(
            style: ButtonStyle(),
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: Center(child: Text('Cancel')),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  _chooseImage(ImageSource source, BuildContext context) {
    ImagePicker.pickImage(
      source: source,
    ).then((file) {
      if (file != null && file.path != null && file.path.isNotEmpty) {
        ImageCropper.cropImage(
                sourcePath: file.path,
                // maxWidth: 500,
                // maxHeight: 500,
                aspectRatioPresets: [
                  // CropAspectRatioPreset.square,
                ],
                androidUiSettings: AndroidUiSettings(
                  toolbarTitle: 'Crop Your Image',
                  toolbarColor: Get.theme!.primaryColor,
                  toolbarWidgetColor: Colors.white,
                  // initAspectRatio: CropAspectRatioPreset.square,
                  // lockAspectRatio: true,
                ),
                iosUiSettings: IOSUiSettings(
                    minimumAspectRatio: 1.0,
                    title: 'Crop Your Image',
                    aspectRatioLockEnabled: true,
                    showCancelConfirmationDialog: true))
            .then((File? value) {
          if (value != null && value.path != null && value.path.isNotEmpty) {
            Navigator.pop(context, value);
          }
        });
      }
    }).catchError((error) {
      SnackBarHelper.show('Error', 'Please allow permission to upload image.');
    });
  }
}
