import 'package:firebase_auth/firebase_auth.dart';
import 'package:tip_off/services/database.dart';
import '../models/user.dart';
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Sign in anon
  Future signInAnon() async {
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(error) {
      print(error.toString());
      return null;
    }
  }

  //SignIn with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(error) {
      print(error.toString());
      return null;
    }
  }

  //Register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateUserData('Anon', 'Unknown', 'Unknown', 'None');
      return _userFromFirebaseUser(user);
    } catch(error) {
      print(error.toString());
      return null;
    }
  }

  //Sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(error) {
      print(error.toString());
      return null;
    }
  }

  //Create user object based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //Auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }
}