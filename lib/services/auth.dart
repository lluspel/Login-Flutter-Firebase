import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello_firebase/models/user.dart';
import 'package:hello_firebase/services/database.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance; // _auth es privado para sarlo solo aqui

  // crea user obj basado en Firebaseuser
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  //  suth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
    // .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }



  // Sign in anonimamente
  Future signInAnon() async {
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  // Sign in email & password
  Future signInWithEmailAndPassword(String email, String pass) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch (e){
      print(e.toString());
      return null;
    }
  }


  // Log in email & password
  Future registerWithEmailAndPassword(String email, String pass) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = result.user;

      await DatabaseService(uid: user.uid).updateUserData('new player', 0);
      return _userFromFirebaseUser(user);
    }catch (e){
      print(e.toString());
      return null;
    }
  }


  // Sign out
  Future signOut () async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}