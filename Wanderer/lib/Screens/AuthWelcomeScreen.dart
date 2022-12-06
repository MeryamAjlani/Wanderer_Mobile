import 'package:Wanderer/widgets/Authentification/ChangePasswordStateless.dart';
import 'package:Wanderer/widgets/Authentification/CodeFormStateless.dart';
import 'package:Wanderer/widgets/Authentification/ResetFormStateless.dart';
import 'package:flutter/material.dart';
import '../Modules/Vector2.dart';
import 'package:Wanderer/widgets/Authentification/LoginFormStateless.dart';
import 'package:Wanderer/widgets/BackGroundAnimation/BackgroundAnimatedControllerStateless.dart';
import 'package:Wanderer/widgets/Authentification/SigninFormStateless.dart';

class AuthWelcomeScreen extends StatefulWidget {
  static final String routeName = "/login";
  @override
  _AuthWelcomeScreenState createState() => _AuthWelcomeScreenState();
}

class _AuthWelcomeScreenState extends State<AuthWelcomeScreen> {
  static bool isFirstBuild = true;
  bool test = true;
  String email = "";
  String currentForm = "login";
  final Vector2 loginOffset = Vector2(50, -15);
  final Vector2 signinOffset = Vector2(-150, -15);
  final Vector2 resetOffset = Vector2(50, 90);
  final Vector2 codeOffset = Vector2(-150, 90);
  final Vector2 changeOffset = Vector2(50, -15);
  static Vector2 offset = Vector2(0, -200);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/Images/animated-background/sky.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          BackgroundAnimatedControllerStateless(offset),
          LoginFormStateless(
            visible: currentForm == "login",
            routeSignIn: goToSigninForm,
            routeReset: goToResetForm,
          ),
          SigninFormStateless(
            visible: currentForm == "signin",
            routeLogIn: goToLoginForm,
          ),
          RestFormStateless(
            visible: currentForm == "reset",
            routeLogIn: goToLoginForm,
            routeCode: goToCodeForm,
          ),
          CodeFormStateless(
            visible: currentForm == "code",
            routeReset: goToResetForm,
            email: email,
            routeChange: goToChangeForm,
          ),
          ChangePasswordStateless(
            visible: currentForm == "change",
            routeLogin: goToLoginForm,
            email: email,
          )
        ],
      ),
    ));
  }

  void goToLoginForm() {
    setState(() {
      offset = loginOffset;
      currentForm = "login";
    });
  }

  void goToSigninForm() {
    setState(() {
      offset = signinOffset;
      currentForm = "signin";
    });
  }

  void goToResetForm() {
    setState(() {
      offset = resetOffset;
      currentForm = "reset";
    });
  }

  void goToCodeForm(String newEmail) {
    setState(() {
      offset = codeOffset;
      currentForm = "code";
    });
    this.email = newEmail;
    print(this.email);
  }

  void goToChangeForm(String newEmail) {
    print("khra");
    setState(() {
      offset = changeOffset;
      currentForm = "change";
      this.email = newEmail;
    });

    print(this.email);
  }

  void initY(_) {
    if (isFirstBuild) {
      print("after build");
      isFirstBuild = false;
      setState(() {
        offset.y = -15;
      });
    }
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(initY);
  }
}
