import 'package:flutter/material.dart';
import 'package:tip_off/models/user.dart';
import 'package:provider/provider.dart';
import 'package:tip_off/screens/authenticate/authenticate.dart';
import 'package:tip_off/screens/home/home.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    
    if(user != null) {
      return MyHomePage(title: 'Campus SafeApp',);
    } else {
      return Authenticate();
    }

  }
}