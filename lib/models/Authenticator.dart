import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserDetail {
  String uid;
  String name;
  String photoURL;
  String email;

  UserDetail({String uuid, String name, String photoURL, String email}) {
    this.uid = uuid;
    this.name = name;
    this.photoURL = photoURL;
    this.email = email;
  }
}

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

  Future<UserDetail> getCurrentUser() async {
    var currentUser = await _auth.currentUser();
    if (currentUser == null) {
      return null;
    } else {
      return UserDetail(
          uuid: currentUser.uid,
          name: currentUser.displayName,
          photoURL: currentUser.photoUrl,
          email: currentUser.email);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await this._googleSignIn.signOut();
    } catch (e) {
      print(e);
    }
  }
}
