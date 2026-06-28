import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'app_language.dart';
import 'business_profile.dart';
import '../core/storage/app_local_storage.dart';
import '../core/mock_data/mock_data.dart';
import '../core/mock_data/models.dart';

final appLocalStorageProvider = Provider<AppLocalStorage>(
  (ref) => AppLocalStorage(),
);

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier(this.storage) : super(ThemeMode.light) {
    _restore();
  }

  final AppLocalStorage storage;

  Future<void> _restore() async {
    state = await storage.readThemeMode() ?? ThemeMode.light;
  }

  Future<void> setMode(ThemeMode mode) async {
    state = mode;
    await storage.saveThemeMode(mode);
  }

  Future<void> toggle() async {
    await setMode(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }
}

class AppLanguageNotifier extends StateNotifier<AppLanguage> {
  AppLanguageNotifier(this.storage) : super(AppLanguage.english) {
    _restore();
  }

  final AppLocalStorage storage;

  Future<void> _restore() async {
    state = await storage.readLanguage() ?? AppLanguage.english;
  }

  Future<void> setLanguage(AppLanguage language) async {
    state = language;
    await storage.saveLanguage(language);
  }
}

class AppSettingsState {
  const AppSettingsState({
    this.receiptWidth = '58mm',
    this.autoPrint = false,
    this.stockDeduction = true,
  });

  final String receiptWidth;
  final bool autoPrint;
  final bool stockDeduction;

  AppSettingsState copyWith({
    String? receiptWidth,
    bool? autoPrint,
    bool? stockDeduction,
  }) {
    return AppSettingsState(
      receiptWidth: receiptWidth ?? this.receiptWidth,
      autoPrint: autoPrint ?? this.autoPrint,
      stockDeduction: stockDeduction ?? this.stockDeduction,
    );
  }
}

class AppSettingsNotifier extends StateNotifier<AppSettingsState> {
  AppSettingsNotifier(this.storage) : super(const AppSettingsState()) {
    _restore();
  }

  final AppLocalStorage storage;

  Future<void> _restore() async {
    state = AppSettingsState(
      receiptWidth: await storage.readReceiptWidth(),
      autoPrint: await storage.readAutoPrint(),
      stockDeduction: await storage.readStockDeduction(),
    );
  }

  Future<void> setReceiptWidth(String width) async {
    state = state.copyWith(receiptWidth: width);
    await storage.saveReceiptWidth(width);
  }

  Future<void> setAutoPrint(bool value) async {
    state = state.copyWith(autoPrint: value);
    await storage.saveAutoPrint(value);
  }

  Future<void> setStockDeduction(bool value) async {
    state = state.copyWith(stockDeduction: value);
    await storage.saveStockDeduction(value);
  }
}

final businessProfileProvider = StateProvider<BusinessProfile>(
  (ref) => BusinessProfileInfo.fromBuildValue(buildProfile),
);
final selectedNavigationIndexProvider = StateProvider<int>((ref) => 0);
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) => ThemeModeNotifier(ref.watch(appLocalStorageProvider)),
);
final appLanguageProvider =
    StateNotifierProvider<AppLanguageNotifier, AppLanguage>(
      (ref) => AppLanguageNotifier(ref.watch(appLocalStorageProvider)),
    );
final appSettingsProvider =
    StateNotifierProvider<AppSettingsNotifier, AppSettingsState>(
      (ref) => AppSettingsNotifier(ref.watch(appLocalStorageProvider)),
    );
final sidebarCollapsedProvider = StateProvider<bool>((ref) => false);
final selectedCustomerProvider = StateProvider<Customer>(
  (ref) => customers.first,
);
final inventoryProductsProvider = StateProvider<List<Product>>(
  (ref) => [...products],
);
final stockIntakeItemsProvider = StateProvider<List<StockIntakeItem>>(
  (ref) => [...scannedStockIntakeItems],
);
final activeBillLinesProvider = StateProvider<List<VoiceBillLine>>(
  (ref) => [...voiceBillLines],
);
final activeBillTranscriptProvider = StateProvider<String>((ref) => '');
final selectedProductProvider = StateProvider<Product>((ref) => products.first);
final selectedInvoiceProvider = StateProvider<Invoice>((ref) => invoices.first);
final aiChatMessagesProvider = StateProvider<List<ChatMessage>>(
  (ref) => [...aiMessages],
);
