import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_app/models/usermodel.dart';

class AuthenticationViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _userFromFireBase(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  Stream<UserModel?> get hello {
    return _auth.authStateChanges().map(_userFromFireBase);
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signUpWithEmailAndPassword(
      String uid, String email, String password) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;
  }

  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFireBase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
