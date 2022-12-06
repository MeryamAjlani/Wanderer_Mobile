import 'dart:async';
import 'package:Wanderer/Icons/profile_icons.dart';
import 'package:Wanderer/Modules/Organization.dart';
import 'package:Wanderer/Modules/OrganizedEvent.dart';

import 'package:Wanderer/Services/OrganizationService.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:Wanderer/Services/Utility/ImageService.dart';
import 'package:Wanderer/widgets/Organization/DrawerOrganization.dart';
import 'package:Wanderer/widgets/Organization/Events/EventsList.dart';
import 'package:Wanderer/widgets/Organization/Events/UpdateEventInput.dart';

import 'package:Wanderer/widgets/Organization/NotFoundEvents.dart';

import 'package:Wanderer/widgets/Profile/UpdateImageWidget.dart';
import 'package:Wanderer/widgets/Profile/DrawerWidget.dart';
import 'package:Wanderer/widgets/Shared/LoadingWidget.dart';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import 'HandleRequestEventScreen.dart';
import 'UpdateEvent.dart';
import 'UpdateOrganizationProfile.dart';

class OrganizationScreen extends StatefulWidget {
  static final String routeName = "/organization";
  @override
  _OrganizationState createState() => _OrganizationState();
}

class _OrganizationState extends State<OrganizationScreen> {
  OrganizedEvent upcomingEvent;
  double fifthWidth;
  double fullWidth;

  OrganizationModel profile;
  // String url = cloudinaryImage.transform().width(150).height(150).generate();
  ScrollController _scrollController = new ScrollController();
  int page = 1;
  List<OrganizedEvent> litems = [];
  List<OrganizedEvent> litemsPast = [];

  bool loadingUpcoming = true;
  bool loadingPast = true;

  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          loadingPast = true;
        });
        _fetchMyEventsPast(page);
      }
    });
  }

  Future _fetchMyEventsUpcoming(String email) async {
    if (!loadingUpcoming) return;
    var rep = await OrganizationService.getMyEventsUpcoming(email)
        as Iterable<OrganizedEvent>;
    setState(() {
      litems = litems..addAll(rep);
      loadingUpcoming = false;
    });
  }

  Future _fetchMyProfile() async {
    if (profile != null) return;
    await OrganizationService.loadProfile('0').then((value) {
      OrganizationModel org =
          OrganizationModel.fromJson(value.data['profile'][0]);
      setState(() {
        profile = org;
      });
    });
  }

  Future _fetchOrgProfile(String email) async {
    if (profile != null) return;
    await OrganizationService.loadProfile(email).then((value) {
      OrganizationModel org =
          OrganizationModel.fromJson(value.data['profile'][0]);
      setState(() {
        profile = org;
      });
    });
  }

  Future _fetchMyEventsPast(int p) async {
    if (!loadingPast) return;
    var rep = await OrganizationService.getMyEventsPast(p, profile.email)
        as Iterable<OrganizedEvent>;
    setState(() {
      litemsPast = litemsPast..addAll(rep);
      page = p + 1;
      loadingPast = false;
    });
  }

  Future<void> showUpdateDialog(
      BuildContext context, OrganizationModel org) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: CustomColor.backgroundColor,
            // content: UpdateProfileWidget(org),
          );
        });
  }

  Future<void> showCreateEventDialog(BuildContext contexte) async {
    return await showDialog(
        context: contexte,
        builder: (context) {
          return AlertDialog(
            backgroundColor: CustomColor.backgroundColor,
            content: UpdateEventInput(null, profile.email),
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
            content: UpdateImageWidget(cropped, 1),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    fifthWidth = screenSize.width * 0.2;
    Map args = ModalRoute.of(context).settings.arguments;
    if (args['email'] == null) {
      _fetchMyProfile();
    } else {
      _fetchOrgProfile(args['email']);
    }
    if (profile != null) _fetchMyEventsUpcoming(profile.email);
    if (profile != null) _fetchMyEventsPast(1);

    //if (args['flag'] == "show") showUpdateDialog(context, profile);
    return Scaffold(
        drawer: (args['email'] == null)
            ? DrawerOrganizationWidget()
            : DrawerWidget(),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: (profile == null)
                ? LoadingWidget()
                : Container(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height,
                        minWidth: double.infinity),
                    width: screenSize.width,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(boxShadow: [
                      new BoxShadow(
                        color: Colors.black,
                        blurRadius: 12.0,
                      ),
                    ], color: Color(0xff22132f)),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 35),
                          width: screenSize.width,
                          alignment: Alignment.topCenter,
                          decoration: BoxDecoration(
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 12.0,
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(fifthWidth),
                              ),
                              color: Color(0xff29133e)),
                          child: Column(
                            children: [
                              Container(
                                width: screenSize.width,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      new BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 12.0,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(fifthWidth),
                                    ),
                                    color: CustomColor.lightBackground),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Stack(children: [
                                      Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 45, 0, 0),
                                          width: 130,
                                          height: 130,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    ImageService.imageUrl(
                                                        profile.img,
                                                        width: 150,
                                                        height: 150)),
                                                fit: BoxFit.fill),
                                          )),
                                      (args['email'] == null)
                                          ? Positioned(
                                              bottom: -7,
                                              right: -20,
                                              child: FlatButton(
                                                  shape: CircleBorder(),
                                                  color: CustomColor
                                                      .backgroundColor,
                                                  onPressed: () async {
                                                    await showUpdatePictureDialog(
                                                        context);
                                                  },
                                                  child: Icon(
                                                    Icons.add_a_photo,
                                                    size: 20,
                                                    color: CustomColor
                                                        .secondaryText,
                                                  )),
                                            )
                                          : Center()
                                    ]),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 7, 0, 3),
                                      child: Text(
                                        profile.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: CustomColor.interactable),
                                      ),
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Profile.location,
                                            color:
                                                CustomColor.interactableAccent,
                                            size: 13,
                                          ),
                                          Text(profile.city,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: CustomColor
                                                      .interactableAccent)),
                                        ]),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(35, 7, 35, 7),
                                      child: Text(
                                        profile.description,
                                        style: TextStyle(
                                            color: CustomColor.secondaryText),
                                      ),
                                    ),
                                    (args['email'] == null)
                                        ? Align(
                                            alignment: Alignment.bottomRight,
                                            child: FlatButton(
                                              onPressed: () async {
                                                /*await showUpdateDialog(
                                                    context, profile);*/
                                                Navigator.pushNamed(
                                                    context,
                                                    UpdateOrganizationProfile
                                                        .routeName,
                                                    arguments: profile.copy());
                                              },
                                              child: Text(
                                                'Update',
                                                style: TextStyle(
                                                    color: CustomColor
                                                        .secondaryText),
                                              ),
                                            ),
                                          )
                                        : Center()
                                  ],
                                ),
                              ),
                              (args['email'] == null)
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: FlatButton(
                                              onPressed: () async {
                                                Navigator.pushNamed(
                                                    context,
                                                    HandleRequestEventScreen
                                                        .routeName,
                                                    arguments: litems);
                                              },
                                              child: Text(
                                                "Handle reservations",
                                                style: TextStyle(
                                                    color: CustomColor
                                                        .interactable,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: FlatButton(
                                              onPressed: () {
                                                Navigator.pushNamed(context,
                                                    UpdateEvent.routeName,
                                                    arguments:
                                                        OrganizedEvent.init());
                                              },
                                              child: Text(
                                                "Create an event",
                                                style: TextStyle(
                                                    color: CustomColor
                                                        .interactable,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Center(),
                              Column(
                                children: [
                                  Stack(
                                    children: [
                                      loadingUpcoming
                                          ? LoadingWidget()
                                          : (litems.length == 0)
                                              ? NotFoundEvents(
                                                  org: profile.name,
                                                  message: 'upcoming events')
                                              : EventsList(
                                                  scrollController:
                                                      _scrollController,
                                                  text: 'Upcoming',
                                                  litems: litems),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Stack(
                              children: [
                                loadingPast
                                    ? LoadingWidget()
                                    : (litemsPast.length == 0)
                                        ? NotFoundEvents(
                                            org: profile.name,
                                            message: 'past events')
                                        : EventsList(
                                            scrollController: _scrollController,
                                            text: 'Past',
                                            litems: litemsPast),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
        ));
  }
}
