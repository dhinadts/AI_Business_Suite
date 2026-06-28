import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/app_language.dart';

class AppLocalStorage {
  static const _tokenKey = 'auth.accessToken';
  static const _sessionKey = 'auth.session';
  static const _themeKey = 'settings.themeMode';
  static const _languageKey = 'settings.language';
  static const _receiptWidthKey = 'settings.receiptWidth';
  static const _autoPrintKey = 'settings.autoPrint';
  static const _stockDeductionKey = 'settings.stockDeduction';

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  Future<void> saveToken(String token) async {
    final prefs = await _prefs;
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> readToken() async {
    final prefs = await _prefs;
    return prefs.getString(_tokenKey);
  }

  Future<void> clearToken() async {
    final prefs = await _prefs;
    await prefs.remove(_tokenKey);
  }

  Future<void> saveSession(Map<String, dynamic> session) async {
    final prefs = await _prefs;
    await prefs.setString(_sessionKey, jsonEncode(session));
  }

  Future<Map<String, dynamic>?> readSession() async {
    final prefs = await _prefs;
    final raw = prefs.getString(_sessionKey);
    if (raw == null || raw.isEmpty) return null;
    return Map<String, dynamic>.from(jsonDecode(raw) as Map);
  }

  Future<void> clearSession() async {
    final prefs = await _prefs;
    await prefs.remove(_sessionKey);
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = await _prefs;
    await prefs.setString(_themeKey, mode.name);
  }

  Future<ThemeMode?> readThemeMode() async {
    final prefs = await _prefs;
    final raw = prefs.getString(_themeKey);
    return ThemeMode.values.where((mode) => mode.name == raw).firstOrNull;
  }

  Future<void> saveLanguage(AppLanguage language) async {
    final prefs = await _prefs;
    await prefs.setString(_languageKey, language.name);
  }

  Future<AppLanguage?> readLanguage() async {
    final prefs = await _prefs;
    final raw = prefs.getString(_languageKey);
    return AppLanguage.values
        .where((language) => language.name == raw)
        .firstOrNull;
  }

  Future<void> saveReceiptWidth(String width) async {
    final prefs = await _prefs;
    await prefs.setString(_receiptWidthKey, width);
  }

  Future<String> readReceiptWidth() async {
    final prefs = await _prefs;
    return prefs.getString(_receiptWidthKey) ?? '58mm';
  }

  Future<void> saveAutoPrint(bool enabled) async {
    final prefs = await _prefs;
    await prefs.setBool(_autoPrintKey, enabled);
  }

  Future<bool> readAutoPrint() async {
    final prefs = await _prefs;
    return prefs.getBool(_autoPrintKey) ?? false;
  }

  Future<void> saveStockDeduction(bool enabled) async {
    final prefs = await _prefs;
    await prefs.setBool(_stockDeductionKey, enabled);
  }

  Future<bool> readStockDeduction() async {
    final prefs = await _prefs;
    return prefs.getBool(_stockDeductionKey) ?? true;
  }

  Future<void> clearAuth() async {
    await clearToken();
    await clearSession();
  }
}
