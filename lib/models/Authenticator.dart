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
    print(currentUser);
    return currentUser == null
        ? null
        : UserDetail(
            uuid: currentUser.uid,
            name: currentUser.displayName,
            photoURL: currentUser.photoUrl,
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

//class Authenticator {
// Future<void> initializeAuthenticator() async {
//   // check for current user.
//   this._isInit = true;
// }

// void frontEndDo() {
//   var auth = Authenticator();
//   await auth.initializeAuthenticator();
//   var user = auth.getCurrentUser();
//   if (user == null) {
//     if (await auth.login() == true) {
//       user = auth.getCurrentUser();
//     }
//   } else {
//     // already login
//   }
// }

// bool _isInit = false;
// Map<String, Object> _currentUser;

// Object getCurrentUser() {
//   // check
//   if (this._isInit == false) throw "You must call initialize ... first";
//   if (this._currentUser == null) return null;
// }

// Future<bool> login() async {
//   try {

//     this._currentUser = await Firebase().login();
//     return true;
//   } catch(e) {
//     return false;
//   }
// }

// Future<bool> signOut() async {
//   try {

//     return true;
//   } catch(e) {
//     return false;
//   }
// }
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//
//class UserDetail {
//  String uid;
//  String name;
//  String photoURL;
//  String email;
//
//  UserDetail({String uuid, String name, String photoURL, String email}) {
//    this.uid = uuid;
//    this.name = name;
//    this.photoURL = photoURL;
//    this.email = email;
//  }
//}
//
//class Authentication {
//  String signInState;
//  final GoogleSignIn _googleSignIn = GoogleSignIn();
//  final FirebaseAuth _auth = FirebaseAuth.instance;
//
//  Future<FirebaseUser> handleSignIn() async {
//    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//    final GoogleSignInAuthentication googleAuth =
//        await googleUser.authentication;
//    final AuthCredential credential = GoogleAuthProvider.getCredential(
//      accessToken: googleAuth.accessToken,
//      idToken: googleAuth.idToken,
//    );
//
//    var user = (await _auth.signInWithCredential(credential));
//    return user;
//  }
//
//  Future<UserDetail> getCurrentUser() async {
//    var currentUser = await _auth.currentUser();
//    return currentUser == null
//        ? null
//        : UserDetail(
//            uuid: currentUser.uid,
//            name: currentUser.displayName,
//            photoURL: currentUser.photoUrl,
//            email: currentUser.email);
//  }
//
//  Future<void> signOut() async {
//    try {
//      await _auth.signOut();
//      await this._googleSignIn.signOut();
//    } catch (e) {
//      print(e);
//    }
//  }
//
//  Future<void> switchUser() async {
//    try {
//      await this._googleSignIn.signOut();
//      await handleSignIn();
//      return 0;
//    } catch (e) {
//      print(e);
//    }
//  }
//}
//
////class Authenticator {
//// Future<void> initializeAuthenticator() async {
////   // check for current user.
////   this._isInit = true;
//// }
//
//// void frontEndDo() {
////   var auth = Authenticator();
////   await auth.initializeAuthenticator();
////   var user = auth.getCurrentUser();
////   if (user == null) {
////     if (await auth.login() == true) {
////       user = auth.getCurrentUser();
////     }
////   } else {
////     // already login
////   }
//// }
//
//// bool _isInit = false;
//// Map<String, Object> _currentUser;
//
//// Object getCurrentUser() {
////   // check
////   if (this._isInit == false) throw "You must call initialize ... first";
////   if (this._currentUser == null) return null;
//// }
//
//// Future<bool> login() async {
////   try {
//
////     this._currentUser = await Firebase().login();
////     return true;
////   } catch(e) {
////     return false;
////   }
//// }
//
//// Future<bool> signOut() async {
////   try {
//
////     return true;
////   } catch(e) {
////     return false;
////   }
//// }
////
////
////}
