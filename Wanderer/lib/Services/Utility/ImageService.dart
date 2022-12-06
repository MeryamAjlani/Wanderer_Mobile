import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:photo_view/photo_view.dart';

import 'CustomColor.dart';

class ImageService {
  static final CloudinaryPublic _cloudinary =
      CloudinaryPublic('wanderer31', 'vmgnpg2a', cache: false);
  static final ImagePicker _imagePicker = ImagePicker();
  static final int _defaultImageSize = 128;

  static String imageUrl(String image, {int width, int height}) {
    var cloudinaryImage = _cloudinary.getImage(image);
    String url;
    if (width == null && height == null)
      url = cloudinaryImage.transform().generate();
    else if (width != null && height != null)
      url = cloudinaryImage.transform().width(width).height(height).generate();
    else if (width != null)
      url = cloudinaryImage.transform().width(width).generate();
    else //if(height != null)
      url = cloudinaryImage.transform().height(height).generate();
    return url;
  }

  static Future<File> pickImage(
      {ImageSource source: ImageSource.gallery,
      int maxWidth,
      int maxHeight,
      CropStyle cropStyle: CropStyle.rectangle}) async {
    double ratioX = 2;
    //make sure height and width are initialized
    if (maxWidth == null) {
      if (maxHeight == null) maxHeight = _defaultImageSize;
      maxWidth = maxHeight;
    }
    if (maxHeight == null) maxHeight = maxWidth;

    PickedFile image = await _imagePicker.getImage(source: source);
    if (image != null) {
      if (cropStyle == CropStyle.circle) {
        ratioX = 1;
      }
      return await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: ratioX, ratioY: 1),
          cropStyle: cropStyle,
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 350,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
              toolbarColor: Color(0xff491858),
              backgroundColor: Color(0xff2f0328),
              toolbarWidgetColor: Colors.white70,
              activeControlsWidgetColor: Color(0xffb606b4)));
    }
    return null;
  }

  static Future<FormData> prepareImageForUpload(File image, String id) async {
    FormData formData = new FormData.fromMap({
      "id": id,
      "image": await MultipartFile.fromFile(image.path,
          filename: basename(image.path))
    });
    return formData;
  }

  static Future<FormData> prepareImagesForUpload(
      List<File> images, Map data) async {
    FormData formData = new FormData();
    formData.fields.addAll(data.entries);
    int i = 0;
    for (var image in images) {
      formData.files.add(MapEntry(
          "image" + i.toString(), await MultipartFile.fromFile(image.path)));
      i++;
    }
    return formData;
  }

  static previewPicture(BuildContext context, String imageUrl) {
    showDialog(
        context: context,
        builder: (_) => Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            child: Container(
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(color: Colors.black26),
                    ),
                  ),
                  Center(
                    child: PhotoView(
                      minScale: 1.0,
                      maxScale: 3.0,
                      tightMode: true,
                      backgroundDecoration:
                          BoxDecoration(color: Colors.transparent),
                      imageProvider: NetworkImage(imageUrl),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 30),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: CustomColor.backgroundColor,
                    ),
                    child: FlatButton(
                      child: Icon(
                        Icons.close,
                        color: CustomColor.interactable,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            )));
  }

}
