import 'package:flutter/material.dart';
import 'package:tip_off/services/auth.dart';
import 'package:tip_off/shared/loading.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key key}) : super(key: key);

  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String error, firstname, lastname, phonenumber, email, password = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: loading ? Loading() : Form(
        key: _formKey,
        child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        children: <Widget>[
          TextFormField(
            validator: (val) => val.isEmpty ? 'Enter your first name' : null,
            onChanged: (val) {
                  setState(() {
                    firstname = val;
                  });
                },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
              labelText: 'First name',
              hintText: 'Jane',
              isDense: false,
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            validator: (val) => val.isEmpty ? 'Enter your last name' : null,
            onChanged: (val) {
                  setState(() {
                    lastname = val;
                  });
                },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
              labelText: 'Last name',
              hintText: 'Doe',
              isDense: false,
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            validator: (val) => val.isEmpty ? 'Enter your email address' : null,
            onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
              labelText: 'Email Address',
              hintText: 'janedoe@email.com',
              isDense: false,
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            validator: (val) => val.isEmpty ? 'Enter your phone number' : null,
            onChanged: (val) {
                  setState(() {
                    phonenumber = val;
                  });
                },
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
              labelText: 'Phone Number',
              hintText: '+27 12 345 6789',
              isDense: false,
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            validator: (val) => val.isEmpty ? 'Enter your password' : null,
            obscureText: true,
            onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                isDense: false,
                alignLabelWithHint: true,
                labelText: 'Password',
                hintText: 'Password'),
          ),
          SizedBox(
            height: 16.0,
          ),
          TextFormField(
            validator: (val) => val.isEmpty ? 'Enter your password again' : null,
            obscureText: true,
            onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                isDense: false,
                alignLabelWithHint: true,
                labelText: 'Re-type password',
                hintText: 'Re-type password'),
          ),
          SizedBox(
            height: 32.0,
          ),
          RawMaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0))),
            fillColor: Colors.white,
            elevation: 3.0,
            padding: EdgeInsets.symmetric(vertical: 20.0),
            onPressed: () async {
              if(_formKey.currentState.validate()) {
                loading = true;
                dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                if(result == null) {
                  setState(() {
                    error = 'Please supply a valid email';
                    loading = false;
                  });
                }
                Navigator.pop(context);
              }

              //Navigator.pop(context);
            },
            child: Text(
              'Create Account',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}
