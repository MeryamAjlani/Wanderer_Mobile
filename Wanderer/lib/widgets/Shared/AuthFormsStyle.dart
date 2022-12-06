import 'package:Wanderer/Icons/my_flutter_app_icons.dart';
import 'package:Wanderer/Screens/MarketPlace/AddProduct.dart';
import 'package:Wanderer/Services/AuthService.dart';
import 'package:flutter/material.dart';

class AuthStyle {
 static InputDecoration inputStyle(String message,String label,IconData icon) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AuthService.getColorByEvent(message)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey),
        ),
        prefixIcon: Icon(icon,
            color: AuthService.getColorByEvent(message)),
        labelText:label,
        labelStyle: TextStyle(color: Colors.white70),
        errorStyle: TextStyle(color: Colors.yellow),
    focusedErrorBorder: errorstyle(),
    
    errorBorder: errorstyle());
        
  }

  static UnderlineInputBorder errorstyle() {
  return UnderlineInputBorder(
    borderSide: const BorderSide(color: Colors.yellow),
    borderRadius: BorderRadius.circular(10.0),
  );
}
}
