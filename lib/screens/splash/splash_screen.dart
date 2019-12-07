import 'package:flutter/material.dart';
import 'package:tip_off/screens/authenticate/login_page.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
            padding: EdgeInsets.all(24.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Icon(
              Icons.report,
              color: Colors.blue,
              size: 150.0,
            ),
            SizedBox(
              height: 40.0,
            ),   
            Center(child: Text(
              'Business Tipoffs',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),),
            SizedBox(
              height: 40.0,
            ),
            Center(child: Text(
              '"Safety is a priority"',
              style: TextStyle(fontSize: 18.0),
            ),),
            SizedBox(height: 40,),
            RawMaterialButton(
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(vertical: 8.0),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Get Started',
                    style: TextStyle(color: Colors.white, fontSize: 32.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                ],
              ),
              fillColor: Colors.blue,
              splashColor: Colors.blue[300],
            )
          ],
        ),
      ),
      ),
    );
  }
}
