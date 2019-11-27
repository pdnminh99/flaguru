import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaguru/models/User.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  String signInState;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    var user = (await _auth.signInWithCredential(credential));
    return user;
  }

  Future<User> getCurrentUser() async {
    var currentUser = await _auth.currentUser();
    // print(currentUser);
    return currentUser == null
        ? null
        : User(
            uuid: currentUser.uid,
            name: currentUser.displayName,
            avatar: currentUser.photoUrl,
            email: currentUser.email);
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await this._googleSignIn.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<void> switchUser() async {
    try {
      await this._googleSignIn.signOut();
      await handleSignIn();
      return 0;
    } catch (e) {
      print(e);
    }
  }
}
