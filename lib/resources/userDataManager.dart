import 'dart:convert';

import 'package:Winery/domain/entities/catalog.dart';
import 'package:Winery/domain/entities/profile.dart';
import 'package:Winery/domain/entities/wine.dart';
import 'package:Winery/features/Catalog/catalogRepository.dart';
import 'package:Winery/features/profile/profileRepository.dart';
import 'package:Winery/features/wine/wineryCatalogRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataManager {
  final CatalogRepository _catalogRepository;
  final WineryRepository _wineryRepository;
  final ProfileRepository _profileRepository;

  UserDataManager(
      this._catalogRepository, this._profileRepository, this._wineryRepository);

  Future<void> saveUserData(Profile profile, Catalog catalog) async {
    final prefs = await SharedPreferences.getInstance();
    final profileJson = jsonEncode(profile.toJson());
    final catalogJson = jsonEncode(catalog.toJson());
    final wineryCatalogJson = jsonEncode(catalog.toJson());

    await prefs.setString('profile', profileJson);
    await prefs.setString('catalog', catalogJson);
    await prefs.setString('wineryCatalog', wineryCatalogJson);
  }

  Future<Profile> loadProfile() async {
    return _profileRepository.loadProfile(0001);
  }

  Future<Catalog> loadCatalog(int catalogId) async {
    return _catalogRepository.loadProfileCatalog(catalogId);
  }

  Future<Future<List<Wine>>> loadWineryCatalog() async {
    return _wineryRepository.listWines();
  }
}
