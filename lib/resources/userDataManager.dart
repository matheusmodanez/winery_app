import 'dart:convert';

import 'package:Winery/domain/entities/catalog.dart';
import 'package:Winery/domain/entities/profile.dart';
import 'package:Winery/features/catalog/catalogRepository.dart';
import 'package:Winery/features/profile/profileRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataManager {
  final CatalogRepository _catalogRepository;
  final ProfileRepository _profileRepository;

  UserDataManager(this._catalogRepository, this._profileRepository);

  Future<void> saveUserData(Profile profile, Catalog catalog) async {
    final prefs = await SharedPreferences.getInstance();
    final profileJson = jsonEncode(profile.toJson());
    final catalogJson = jsonEncode(catalog.toJson());

    await prefs.setString('profile', profileJson);
    await prefs.setString('catalog', catalogJson);
  }

  Future<void> saveWineryData(Catalog catalog) async {
    final prefs = await SharedPreferences.getInstance();

    final wineryCatalogJson = jsonEncode(catalog.toJson());
    await prefs.setString('wineryCatalog', wineryCatalogJson);
  }

  Future<Profile> loadProfile() async {
    return _profileRepository.loadProfile(0001);
  }

  Future<Catalog> loadCatalog(int catalogId) async {
    return _catalogRepository.loadProfileCatalog(catalogId);
  }

  Future<Catalog> loadWineryCatalog() async {
    return _catalogRepository.loadProfileCatalog(00001);
  }
}
