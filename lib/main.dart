import 'package:flutter/material.dart';
import 'package:tip_off/screens/authenticate/login_page.dart';
import 'package:tip_off/screens/authenticate/registration.dart';
import 'package:tip_off/screens/wrapper.dart';
import 'package:tip_off/services/auth.dart';
import 'package:tip_off/models/user.dart';
import 'report.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Sulphur_Point',
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => Wrapper(),
          '/tip_off_screen': (context) => TipOffPage(),
          '/help_screen': (context) => Help(),
          '/login_screen': (context) => LoginPage(),
          '/registration_screen': (context) => RegistrationPage(),
          '/firestore_test_screen': (context) => FirestoreTest(),
          '/wrapper': (context) => Wrapper(),
        }),
    );
  }
}



class TipOffPage extends StatefulWidget {
  TipOffPage({Key key}) : super(key: key);

  _TipOffPageState createState() => _TipOffPageState();
}

class _TipOffPageState extends State<TipOffPage> {
  String dropdownValue;
  String organisation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create report'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          children: <Widget>[
            Text(
              'Enter your report below: ',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                alignLabelWithHint: true,
                labelText: 'Name',
                hintText: 'Enter your name or Anonymous',
                isDense: false,
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            DropdownButton<String>(
              isDense: false,
              value: organisation,
              hint: Text('Organisation: (e.g Government)'),
              icon: Icon(null),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.blue, fontSize: 18.0),
              underline: Container(
                height: 2,
                color: Colors.blueAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  organisation = newValue;
                });
              },
              items: <String>['Government', 'Office', 'SARS', 'Other']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(
              height: 32.0,
            ),
            DropdownButton<String>(
              isDense: false,
              value: dropdownValue,
              hint: Text('Type of Crime: (e.g Theft)'),
              icon: Icon(null),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.blue, fontSize: 18.0),
              underline: Container(
                height: 2,
                color: Colors.blueAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>['Theft', 'Rape', 'Hijack', 'Hack']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(
              height: 32.0,
            ),
            TextFormField(
              textInputAction: TextInputAction.done,
              maxLines: 6,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
                labelText: 'Report',
                hintText: 'Describe your report',
                isDense: false,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: RawMaterialButton(
        onPressed: () {
          Navigator.pop(context);
          final snackBar = SnackBar(
            content: Text('Report sent'),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        },
        child: Text(
          'Submit',
          style: TextStyle(color: Colors.white),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        fillColor: Colors.blue,
        splashColor: Colors.white,
        elevation: 12.0,
        shape: StadiumBorder(),
      ),
    );
  }
}

class Help extends StatelessWidget {
  const Help({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Frequently asked questions'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('F.A.Q.'),
      ),
    );
  }
}
