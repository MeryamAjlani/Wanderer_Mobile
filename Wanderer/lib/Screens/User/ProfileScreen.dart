import 'dart:async';
import 'package:Wanderer/Icons/profile_icons.dart';

import 'package:Wanderer/Services/ProfileService.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:Wanderer/Services/Utility/ImageService.dart';

import 'package:Wanderer/widgets/Profile/UpdateProfileWidget.dart';
import 'package:Wanderer/widgets/Profile/UpdateImageWidget.dart';
import 'package:Wanderer/widgets/Profile/DrawerWidget.dart';
import 'package:Wanderer/widgets/Shared/LoadingWidget.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:flutter/material.dart';

import 'package:Wanderer/Modules/Profile.dart';

class ProfileScreen extends StatefulWidget {
  static final String routeName = "/profile";
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  ProfileModel profile;

  Future _fetchMyProfile() async {
    if (profile != null) return;
    await ProfileService.loadProfile('0').then((value) {
      ProfileModel user = ProfileModel.fromJson(value.data['profile'][0]);
      setState(() {
        profile = user;
      });
    });
  }

  Future _fetchUserProfile(String email) async {
    if (profile != null) return;
    await ProfileService.loadProfile(email).then((value) {
      ProfileModel user = ProfileModel.fromJson(value.data['profile'][0]);
      setState(() {
        profile = user;
      });
    });
  }

  Future<void> showUpdateDialog(BuildContext contexte) async {
    return await showDialog(
        context: contexte,
        builder: (context) {
          return AlertDialog(
            backgroundColor: CustomColor.backgroundColor,
            content: UpdateProfileWidget(profile),
            /*actions: <Widget>[
              OutlineButton(
                padding: EdgeInsets.fromLTRB(125, 10, 125, 10),
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                borderSide: BorderSide(color: Colors.white70, width: 2),
                child: Text('Cancel',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white70)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],*/
          );
        });
  }

  Future<void> showUpdatePictureDialog(BuildContext contexte) async {
    var cropped = await ImageService.pickImage(cropStyle: CropStyle.circle);
    return await showDialog(
        context: contexte,
        builder: (context) {
          return AlertDialog(
            backgroundColor: CustomColor.backgroundColor,
            content: UpdateImageWidget(cropped, 0),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    if (args['email'] == null) {
      _fetchMyProfile();
    } else {
      _fetchUserProfile(args['email']);
    }
    if (args['flag'] == "show") showUpdateDialog(context);
    return Scaffold(
        drawer: DrawerWidget(),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/Images/backgroundProfile.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: (profile == null)
              ? LoadingWidget()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                      Stack(children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(ImageService.imageUrl(
                                      profile.img,
                                      width: 150,
                                      height: 150)),
                                  fit: BoxFit.fill),
                            )),
                        Positioned(
                          bottom: -7,
                          right: -20,
                          child: FlatButton(
                              shape: CircleBorder(),
                              color: CustomColor.backgroundColor,
                              onPressed: () async {
                                await showUpdatePictureDialog(context);
                              },
                              child: Icon(
                                Icons.add_a_photo,
                                size: 20,
                                color: CustomColor.secondaryText,
                              )),
                        )
                      ]),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 7, 0, 3),
                        child: Text(
                          profile.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CustomColor.secondaryText),
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Profile.location,
                              color: CustomColor.secondaryText,
                              size: 13,
                            ),
                            Text(profile.city,
                                style: TextStyle(color: CustomColor.fadedText)),
                          ]),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: FlatButton(
                            onPressed: () async {
                              await showUpdateDialog(context);
                            },
                            child: Text(
                              'Update',
                              style:
                                  TextStyle(color: CustomColor.secondaryText),
                            ),
                          )),
                      Divider(
                          height: 0,
                          thickness: 3,
                          color: CustomColor.secondaryText),
                      /*Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/Images/ProfileMap/complete.png"),
                  )),*/
                      /*TextButton(
                onPressed: () {
                  for (var i = 0; i < 5; i++) {
                    CampingLocationService.addRandom();
                  }
                  print("added 5 randoms");
                },
                child: Text("Add 5 locations")),
            TextButton(
                onPressed: () {
                  CampingLocationService.getList();
                },
                child: Text("test list")),
            TextButton(
                onPressed: () {
                  for (var i = 0; i < 5; i++) {
                    CampingCenterService.addRandom();
                  }
                  print("added 5 randoms");
                },
                child: Text("add 5 centers ")),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddProduct.routeName);
                  print("Add Product");
                },
                child: Text("add 5 centersadd prod  ")),*/
                    ]),
        ));
  }
}
