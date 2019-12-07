import 'package:flutter/material.dart';
import 'package:tip_off/services/auth.dart';
import 'package:tip_off/services/database.dart';
import 'package:provider/provider.dart';
import 'package:tip_off/screens/home/report_list.dart';
import 'package:tip_off/models/report.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Report>>.value(
      value: DatabaseService().reports,
      child: Scaffold(
      appBar: AppBar(
        title: IndexedStack(
            alignment: AlignmentDirectional.center,
            index: _index,
            children: [
              Text(widget.title),
              Text('Help'),
            ]),
        centerTitle: true,
      ),
      body: Center(
        child: IndexedStack(
          alignment: AlignmentDirectional.center,
          index: _index,
          children: <Widget>[
            ReportList(),
            Text('How can we help you?'),
            //Text('User profile')
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.white),
              accountName: Text(
                'Anonymous',
                style: TextStyle(color: Colors.blue, fontSize: 18.0),
              ),
              accountEmail: Text('anon@email.com',
                style: TextStyle(color: Colors.blue),
              ),
              currentAccountPicture: Icon(
                Icons.account_circle,
                size: 64.0,
                color: Colors.blue,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            ListTile(
              title: Text(
                'Make a tip-off',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              leading: Icon(Icons.report_problem),
              subtitle: Text('Report a crime or problem'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/tip_off_screen');
              },
            ),
            ListTile(
              title: Text(
                'Complaint Feedback',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              leading: Icon(Icons.share),
              subtitle: Text('Check for feedback'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/firestore_test_screen');
              },
            ),
            ListTile(
              title: Text(
                'FAQ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              leading: Icon(Icons.info),
              subtitle: Text('Frequently asked questions'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/help_screen');
              },
            ),
            ListTile(
              title: Text(
                'Contact us',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              leading: Icon(Icons.contact_phone),
              subtitle: Text('Having issues with the app?'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              leading: Icon(Icons.exit_to_app),
              subtitle: Text('Sign out'),
              onTap: () async {
                //Navigator.pop(context);
                Navigator.pop(context);
                await _auth.signOut();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FittedBox(
        child: RaisedButton(
          shape: StadiumBorder(),
          onPressed: () {
            Navigator.pushNamed(context, '/tip_off_screen');
          },
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          color: Colors.redAccent,
          splashColor: Colors.white,
          elevation: 12.0,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Create Report',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              width: 8.0,
            ),
            Icon(Icons.announcement, color: Colors.white),
          ]),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb_outline), title: Text('Help')),
          //// BottomNavigationBarItem(
          //  icon: Icon(Icons.account_circle), title: Text('Profile')),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    ),
    );
  }
}