class ProfileProvider {
  // var _localStorage = LocalStorage();
  ProfileProvider._internal();

  static ProfileProvider profileInstance;

  static Future<ProfileProvider> getInstance() async {
    if (profileInstance == null) {
      profileInstance = ProfileProvider._internal();
    }
    return profileInstance;
  }

  // Map<String, int> getData() {
  //   return {
  //     'HighestScore': this._localStorage.getHighestScore(),
  //     'Played': this.
  //   }
  // }
}
