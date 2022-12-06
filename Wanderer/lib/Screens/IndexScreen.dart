import 'package:Wanderer/Screens/AuthWelcomeScreen.dart';

import 'package:Wanderer/Services/AuthService.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:Wanderer/Services/Utility/DioService.dart';
import 'package:Wanderer/Services/Utility/LocalStorageService.dart';

import 'package:flutter/material.dart';

import 'CampingCenter/CampingCenterRole/CampingCenterProfileScreen.dart';
import 'Organization/OrganizationRole/OrganizationScreen.dart';
import 'User/ProfileScreen.dart';

class IndexScreen extends StatefulWidget {
  static final String routeName = "/index";
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  @override
  void initState() {
    super.initState();
    authRedirect();
  }

  authRedirect() async {
    await Future.delayed(Duration.zero);
    if (AuthService.hasCookie()) {
      AuthService.autoLogin().then((val) {
        if (val.data['status']) {
          LocalStorageService.setString('email', val.data['user']['email']);
          LocalStorageService.setInt('role', val.data['user']['role']);
          LocalStorageService.setString('name', val.data['user']['name']);
          LocalStorageService.setString('image', val.data['user']['img']);
          switch (val.data['user']['role']) {
            case 0:
              Navigator.of(context).pushNamed(ProfileScreen.routeName,
                  arguments: {'flag': 'whatever', 'email': null});
              break;
            case 1:
              Navigator.of(context).pushNamed(OrganizationScreen.routeName,
                  arguments: {'flag': 'whatever', 'email': null});
              break;
            case 2:
              Navigator.of(context)
                  .popAndPushNamed(CampingCenterProfileScreen.routeName);
              break;
          }
        } else {
          DioService.cookieJar.deleteAll();
          Navigator.of(context).popAndPushNamed(AuthWelcomeScreen.routeName);
        }
      }).catchError((err) {
        DioService.cookieJar.deleteAll();
        Navigator.of(context).popAndPushNamed(AuthWelcomeScreen.routeName);
      });
    } else {
      Navigator.of(context).popAndPushNamed(AuthWelcomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: CustomColor.backgroundColor,
      ),
    );
  }
}
