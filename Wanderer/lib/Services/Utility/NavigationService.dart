import 'package:Wanderer/Screens/AuthWelcomeScreen.dart';
import 'package:flutter/material.dart';

class NavigationService {
  GlobalKey<NavigatorState> navigationKey;

  static NavigationService instance = NavigationService();

  NavigationService() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  Future<dynamic> navigateToReplacement(String _rn) {
    return navigationKey.currentState.pushReplacementNamed(_rn);
  }

  Future<dynamic> navigateTo(String _rn) {
    return navigationKey.currentState.pushNamed(_rn);
  }

  Future<dynamic> navigateToRoute(MaterialPageRoute _rn) {
    return navigationKey.currentState.push(_rn);
  }

  Future<dynamic> goToAuthScreen() {
    return navigationKey.currentState.pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => AuthWelcomeScreen()),
        (route) => false);
  }

  goback() {
    return navigationKey.currentState.pop();
  }
}
