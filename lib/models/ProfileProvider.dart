class ProfileProvider {
  ProfileProvider._internal();

  static ProfileProvider profileInstance;

  static Future<ProfileProvider> getInstance() async {
    if (profileInstance == null) {
      profileInstance = ProfileProvider._internal();
    }
    return profileInstance;
  }
}