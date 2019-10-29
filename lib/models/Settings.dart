
class Settings {
  bool isAudioON;
  bool isSoundON;
  bool skipTutorials;

  Settings({
    this.isAudioON: true,
    this.isSoundON: true,
    this.skipTutorials: false,
  });

  @override
  String toString() =>
      "Setting Audio ${this.isAudioON ? 'ON' : 'OFF'}, Sound ${this.isSoundON ? 'ON' : 'OFF'} and skip Tutorials ${this.skipTutorials ? 'ON' : 'OFF'}";
}
