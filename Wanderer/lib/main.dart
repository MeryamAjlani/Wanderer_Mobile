import 'package:Wanderer/Screens/AuthWelcomeScreen.dart';

import 'package:Wanderer/Screens/IndexScreen.dart';

import 'package:Wanderer/Screens/MarketPlace/AddProduct.dart';
import 'package:Wanderer/Screens/MarketPlace/Catalogue.dart';
import 'package:Wanderer/Screens/MarketPlace/CategoryList.dart';
import 'package:Wanderer/Screens/MarketPlace/ItemDetailScreen.dart';
import 'package:Wanderer/Screens/Organization/EventList.dart';
import 'package:Wanderer/Screens/Organization/MyReservations.dart';

import 'package:Wanderer/SplashScreenApp.dart';
import 'package:Wanderer/widgets/Organization/HandleReservationEvent.dart';
import 'Screens/CampingCenter/CampingCenterDetailScreen.dart';

import 'Screens/CampingCenter/CampingCenterRole/CampingCenterProfileScreen.dart';
import 'Screens/CampingCenter/CampingCenterRole/CenterPriceEditScreen.dart';
import 'Screens/CampingCenter/CenterMakeReservationScreen.dart';

import 'Screens/CampingCenter/ListCenters.dart';

import 'package:flutter/material.dart';

import 'Screens/CampingLocations/ListSites.dart';
import 'Screens/CampingLocations/MapScreen.dart';
import 'Screens/Organization/EventDetailScreen.dart';
import 'Screens/Organization/OrganizationRole/HandleRequestEventScreen.dart';
import 'Screens/Organization/OrganizationRole/OrganizationScreen.dart';
import 'Screens/Organization/OrganizationRole/UpdateEvent.dart';
import 'Screens/Organization/OrganizationRole/UpdateEventDetails.dart';
import 'Screens/Organization/OrganizationRole/UpdateOrganizationProfile.dart';
import 'Screens/User/ProfileScreen.dart';
import 'Services/Utility/NavigationService.dart';

void main() {
  runApp(SplashScreenApp(
    initializationDoneCallback: runMainApp,
  ));
}

void runMainApp() {
  print("main app running");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("main app build");
    return MaterialApp(
      initialRoute: '/',
      title: 'Wanderer',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: NavigationService.instance.navigationKey,
      home: IndexScreen(),
      routes: {
        CampingCenterProfileScreen.routeName: (ctx) =>
            CampingCenterProfileScreen(),
        EventDetailScreen.routeName: (ctx) => EventDetailScreen(),
        AuthWelcomeScreen.routeName: (ctx) => AuthWelcomeScreen(),
        ProfileScreen.routeName: (ctx) => ProfileScreen(),
        ListCenters.routeName: (ctx) => ListCenters(),
        ListSites.routeName: (ctx) => ListSites(),
        CampingCenterDetailScreen.routeName: (ctx) =>
            CampingCenterDetailScreen(),
        IndexScreen.routeName: (ctx) => IndexScreen(),
        MapScreen.routeName: (ctx) => MapScreen(),
        EventList.routeName: (ctx) => EventList(),
        ItemDetailScreen.routeName: (ctx) => ItemDetailScreen(),
        CategoryList.routeName: (ctx) => CategoryList(),
        Catalogue.routeName: (ctx) => Catalogue(),
        OrganizationScreen.routeName: (ctx) => OrganizationScreen(),
        UpdateEventDetails.routeName: (ctx) => UpdateEventDetails(),
        AddProduct.routeName: (ctx) => AddProduct(),
        HandleRequestEventScreen.routeName: (ctx) => HandleRequestEventScreen(),
        HandleReservationEvent.routeName: (ctx) => HandleReservationEvent(),
        MyReservations.routeName: (ctx) => MyReservations(),
        UpdateOrganizationProfile.routeName: (ctx) =>
            UpdateOrganizationProfile(),
        CenterPriceEditScreen.routeName: (ctx) => CenterPriceEditScreen(),
        CenterMakeReservationScreen.routeName: (ctx) =>
            CenterMakeReservationScreen(),
        UpdateEvent.routeName: (ctx) => UpdateEvent(),
      },
    );
  }
}
