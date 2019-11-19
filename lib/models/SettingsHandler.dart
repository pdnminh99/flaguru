import 'package:flaguru/models/Connectivity.dart';
import 'package:flutter/material.dart';

import '../models/Country.dart';
import '../models/DatabaseConnector.dart';
import '../models/Enum.dart';
import '../models/Settings.dart';
import '../utils/global_audio_player.dart';
import 'LocalStorage.dart';

class SettingsHandler with ChangeNotifier {
  Settings _currentSettings;
  var countries = List<Country>();

  bool get isSoundEnabled {
    return this._currentSettings.isSoundON;
  }

  set isSoundEnabled(bool newState) {
    this._currentSettings.isSoundON = newState;
    LocalStorage.updateNewSettings(this._currentSettings).catchError((error) => print(error));
    notifyListeners();
  }

  bool get isMusicEnabled {
    return this._currentSettings.isAudioON;
  }

  set isMusicEnabled(bool newState) {
    this._currentSettings.isAudioON = newState;
    LocalStorage.updateNewSettings(this._currentSettings).catchError((error) => print(error));
    newState ? audioPlayer?.playMusic() : audioPlayer?.pauseMusic();
    notifyListeners();
  }

  bool get skipTutorials {
    return this._currentSettings.skipTutorials;
  }

  set skipTutorials(bool newState) {
    this._currentSettings.skipTutorials = newState;
    LocalStorage.updateNewSettings(this._currentSettings).catchError((error) => print(error));
    notifyListeners();
  }

  SettingsHandler._internal();

  static SettingsHandler settingInstance;

  static Future<SettingsHandler> getInstance() async {
    if (settingInstance == null) {
      settingInstance = SettingsHandler._internal();
      settingInstance._currentSettings = await LocalStorage.getExistingSettings();
      await settingInstance._getCountries();
      Connection.createNetworkListener();
    }
    return settingInstance;
  }

  Future<void> _getCountries() => DatabaseConnector.getInstance()
      .then((sqlDatabase) => sqlDatabase.collectCountries(isAllowedOnly: false))
      .then((countries) => this.countries = countries);

  Map<String, List<Country>> getCountriesByContinent() {
    var dictionary = Map<String, List<Country>>();
    // var dictionary = Map.from({
    dictionary['Europe'] = List<Country>();
    dictionary['Africa'] = List<Country>();
    dictionary['Asia'] = List<Country>();
    dictionary['AsiaEurope'] = List<Country>();
    dictionary['AustraliaOceania'] = List<Country>();
    dictionary['NorthAmerica'] = List<Country>();
    dictionary['SouthAmerica'] = List<Country>();
    dictionary['Unknown'] = List<Country>();
    // });
    for (var country in countries) {
      switch (country.continent) {
        case Continent.EUROPE:
          dictionary['Europe'].add(country);
          break;
        case Continent.AFRICA:
          dictionary['Africa'].add(country);
          break;
        case Continent.ASIA:
          dictionary['Asia'].add(country);
          break;
        case Continent.ASIAandEUROPE:
          dictionary['AsiaEurope'].add(country);
          break;
        case Continent.AUSTRALIAandOCEANIA:
          dictionary['AustraliaOceania'].add(country);
          break;
        case Continent.NORTH_AMERICA:
          dictionary['NorthAmerica'].add(country);
          break;
        case Continent.SOUTH_AMERICA:
          dictionary['SouthAmerica'].add(country);
          break;
        default:
          dictionary['Unknown'].add(country);
          break;
      }
    }
    // print(dictionary.toString());
    return dictionary;
  }

  void switchAllowStatus(int countryID) {
    bool isFound = false;
    bool newStatus = false;
    for (var country in countries)
      if (country.id == countryID) {
        country.isAllow = !country.isAllow;
        newStatus = country.isAllow;
        isFound = true;
        break;
      }
    if (isFound)
      DatabaseConnector.getInstance()
          .then((sqlDatabase) => sqlDatabase.switchAllowStatus(newStatus, countryID))
          .then((_) => print('Switch $countryID allow status to $newStatus'))
          .catchError((error) => print(error));
  }

  void resetSettings() {
    this._currentSettings.isAudioON = true;
    this._currentSettings.isSoundON = true;
    this._currentSettings.skipTutorials = false;
    LocalStorage.updateNewSettings(this._currentSettings);
  }
}
