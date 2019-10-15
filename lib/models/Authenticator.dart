class Authenticator {

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
  //
  //
}
