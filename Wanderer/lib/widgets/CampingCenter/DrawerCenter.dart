import 'dart:async';

import 'package:Wanderer/Screens/Organization/OrganizationRole/OrganizationScreen.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:Wanderer/Services/Utility/LocalStorageService.dart';
import 'package:flutter/material.dart';

import 'package:Wanderer/Screens/AuthWelcomeScreen.dart';

import 'package:Wanderer/Services/AuthService.dart';

class DrawerCenterWidget extends StatefulWidget {
  @override
  _DrawerCenterWidgetState createState() => _DrawerCenterWidgetState();
}

String savedEmail = '';
//String savedImage = 'profileImagePlaceholder';
String savedName = '';
int savedRole = -1;

class _DrawerCenterWidgetState extends State<DrawerCenterWidget> {
  Future init() async {
    savedEmail = LocalStorageService.getString('email');
    //savedImage = LocalStorageService.getString('image');
    savedName = LocalStorageService.getString('name');
    savedRole = LocalStorageService.getInt('role');
  }

  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(80), bottomRight: Radius.circular(80)),
      child: Drawer(
        child: Container(
          decoration: new BoxDecoration(
            color: CustomColor.backgroundColor,
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    height: 230,
                    decoration: BoxDecoration(
                        color: CustomColor.backgroundColor,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/Images/sample.jpg'))),
                  ),
                  Container(
                      height: 230,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: <Color>[
                            Colors.black26,
                            CustomColor.backgroundColor.withAlpha(120),
                            Colors.transparent,
                          ],
                        ),
                      )),
                  Container(
                    height: 234,
                    child: DrawerHeader(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /*Container(
                                width: 60,
                                height: 60,
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 17),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(ImageService.imageUrl(
                                          savedImage,
                                          width: 150,
                                          height: 150)),
                                      fit: BoxFit.fill),
                                )),*/
                            Expanded(
                                child: Column(children: [
                              Text(
                                savedName,
                                style: TextStyle(
                                    color: CustomColor.highlightText,
                                    fontSize: 22),
                              ),
                              Text(
                                savedEmail,
                                style: TextStyle(
                                    color: CustomColor.fadedText, fontSize: 15),
                              ),
                            ]))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.fireplace_rounded,
                        color: CustomColor.secondaryText,
                      ),
                      title: Text(
                        'My reservations',
                        style: TextStyle(
                            color: CustomColor.secondaryText, fontSize: 17),
                      ),
                      onTap: () => {Navigator.of(context).pop()},
                    ),
                    /*ListTile(
                      leading: Icon(
                        Icons.calendar_today,
                        color: CustomColor.secondaryText,
                      ),
                      title: Text('My events',
                          style: TextStyle(
                              color: CustomColor.secondaryText, fontSize: 17)),
                      onTap: () => {
                        //Navigator.of(context).pushNamed(EventList.routeName)
                      },
                    ),*/
                    ListTile(
                      leading: Icon(
                        Icons.verified_user_sharp,
                        color: CustomColor.secondaryText,
                      ),
                      title: Text('Profile',
                          style: TextStyle(
                              color: CustomColor.secondaryText, fontSize: 17)),
                      onTap: () => {
                        Navigator.of(context).pushNamed(
                            OrganizationScreen.routeName,
                            arguments: {'flag': 'whatever', 'email': null})
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.group,
                        color: CustomColor.secondaryText,
                      ),
                      title: Text('Members',
                          style: TextStyle(
                              color: CustomColor.secondaryText, fontSize: 17)),
                      onTap: () => {Navigator.of(context).pop()},
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.monetization_on,
                        color: CustomColor.secondaryText,
                      ),
                      title: Text('My income',
                          style: TextStyle(
                              color: CustomColor.secondaryText, fontSize: 17)),
                      onTap: () => {Navigator.of(context).pop()},
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.info_outline,
                        color: CustomColor.secondaryText,
                      ),
                      title: Text('About Us',
                          style: TextStyle(
                              color: CustomColor.secondaryText, fontSize: 17)),
                      onTap: () => {Navigator.of(context).pop()},
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.exit_to_app,
                        color: CustomColor.secondaryText,
                      ),
                      title: Text('Logout',
                          style: TextStyle(
                              color: CustomColor.secondaryText, fontSize: 18)),
                      onTap: () {
                        AuthService.logout().then((_) {
                          Navigator.of(context)
                              .pushNamed(AuthWelcomeScreen.routeName);
                          LocalStorageService.clear();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
