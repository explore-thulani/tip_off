import 'package:flutter/material.dart';
import 'package:tip_off/services/auth.dart';
import 'package:tip_off/shared/loading.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';
  String error = '';
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
              decoration: BoxDecoration(color: Colors.blue[10]),
              child: Form(
                key: _formKey,
                child: ListView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.report,
                        color: Colors.blue,
                        size: 100.0,
                      ),
                    ),
                    Center(
                      child: Text(
                        'Business Tipoffs',
                        style: TextStyle(fontSize: 32.0),
                      ),
                    ),
                    SizedBox(
                      height: 32.0,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'Enter your email address' : null,
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
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'Enter your password' : null,
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
                      height: 8.0,
                    ),
                    RawMaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0))),
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      fillColor: Colors.blue,
                      elevation: 3.0,
                      textStyle: TextStyle(color: Colors.white),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result != null) {
                            setState(() {
                              loading = false;
                            });
                          } else {
                            setState(() {
                              error = 'Invalid email or password.';
                              loading = false;
                            });
                          }
                        }
                        /* dynamic result = await _auth.signInAnon();
                  if (result == null) {
                    print("Could not sign in!");
                  } else {
                    print("Sign in successful!");
                  }*/
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Center(child: Text('Have no account?')),
                    SizedBox(
                      height: 8.0,
                    ),
                    RawMaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0))),
                      fillColor: Colors.white,
                      elevation: 3.0,
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      onPressed: () {
                        Navigator.pushNamed(context, '/registration_screen');
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    FlatButton(
                      child: Text('Report Anonymously'),
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth.signInAnon();
                        if (result == null) {
                          print("Could not sign in!");
                          setState(() {
                            loading = false;
                          });
                        } else {
                          print("Sign in successful!");
                         // Navigator.pushNamed(context, '/');
                          setState(() {
                            loading = false;
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Center(
                        child: Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ))
                  ],
                ),
              ),
            ),
          );
  }
}
