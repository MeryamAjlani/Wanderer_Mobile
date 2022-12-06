import 'package:Wanderer/Screens/Organization/OrganizationRole/OrganizationScreen.dart';
import 'package:Wanderer/Screens/User/ProfileScreen.dart';
import 'package:Wanderer/Services/Utility/ImageService.dart';
import 'package:Wanderer/Services/Utility/LocalStorageService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Wanderer/Services/ProfileService.dart';
import 'package:Wanderer/Services/OrganizationService.dart';

import 'dart:io';
import 'package:image_cropper/image_cropper.dart';

// ignore: must_be_immutable
class UpdateImageWidget extends StatefulWidget {
  File croppedImage;
  final int role;
  UpdateImageWidget(this.croppedImage, this.role);
  @override
  _UpdateImageWidgetState createState() => _UpdateImageWidgetState();
}

class _UpdateImageWidgetState extends State<UpdateImageWidget> {
  Widget getImageWidget() {
    if (widget.croppedImage != null) {
      return Image.file(
        widget.croppedImage,
        width: 200,
        height: 200,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        "assets/Images/imagePlaceholder.png",
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Center(
              child: ClipOval(child: getImageWidget()),
            ),
            /*(_inProcess)
                ? Container(
                    color: Color(0xff2f0328),
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Center()*/
          ],
        ),
        Container(
            margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: (widget.croppedImage != null)
                ? OutlineButton(
                    padding: EdgeInsets.fromLTRB(105, 10, 105, 10),
                    shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    borderSide: BorderSide(color: Colors.white70, width: 2),
                    child: Text('Update',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white70)),
                    onPressed: () {
                      switch (widget.role) {
                        case 0:
                          ProfileService.updateProfilePicture(
                                  widget.croppedImage)
                              .then((value) => {
                                    if (value.data["status"])
                                      {
                                        LocalStorageService.setString(
                                            'image', value.data['img']),
                                        Navigator.of(context).pushNamed(
                                            ProfileScreen.routeName,
                                            arguments: {
                                              'flag': 'whatever',
                                              'email': null
                                            })
                                      }
                                  })
                              .catchError((error) => print(error));
                          break;
                        case 1:
                          OrganizationService.updateProfilePicture(
                                  widget.croppedImage)
                              .then((value) => {
                                    if (value.data["status"])
                                      {
                                        LocalStorageService.setString(
                                            'image', value.data['img']),
                                        Navigator.of(context).pushNamed(
                                            OrganizationScreen.routeName,
                                            arguments: {
                                              'flag': 'whatever',
                                              'email': null
                                            })
                                      }
                                  })
                              .catchError((error) => print(error));
                          break;
                        default:
                          print('noo');
                          break;
                      }
                    },
                  )
                : Center(
                    child: OutlineButton(
                    padding: EdgeInsets.fromLTRB(80, 10, 80, 10),
                    shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    borderSide: BorderSide(color: Colors.white70, width: 2),
                    child: Text('Add Picture',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white70)),
                    onPressed: () async {
                      var cropped = await ImageService.pickImage(
                          cropStyle: CropStyle.circle);
                      setState(() {
                        widget.croppedImage = cropped;
                      });
                    },
                  ))),
      ],
    );
  }
}
