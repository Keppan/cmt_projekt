import 'package:cmt_projekt/api/prefs.dart';
import 'package:cmt_projekt/constants.dart';
import 'package:cmt_projekt/website/View/web_profilewidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///View model för Homepage och profilewidget.
class HomePageViewModel with ChangeNotifier {
  ///Returnerar användarens email.
  String? getEmail() {
    if (Prefs().storedData.get("email").toString() == "null") {
      return "Gäst";
    } else {
      return Prefs().storedData.get("email").toString();
    }
  }

  ///Returnerar användarens uID.
  String? getUid() {
    return Prefs().storedData.get("uid").toString();
  }

  /// Skapar en showdialog med webprofilewidget.
  void profileInformation(context) {
    showDialog(
        context: context,
        builder: (context) {
          return const WebProfileWidget();
        });
  }

  void logOut(context) {
    Prefs().storedData.clear();
    if (kIsWeb) {
      Navigator.of(context).pushReplacementNamed(login);
    } else {
      Navigator.of(context).pushReplacementNamed(appWelcome);
    }
  }
}
