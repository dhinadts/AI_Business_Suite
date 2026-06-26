import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'business_profile.dart';
import '../core/mock_data/mock_data.dart';
import '../core/mock_data/models.dart';

final businessProfileProvider = StateProvider<BusinessProfile>((ref) => BusinessProfileInfo.fromBuildValue(buildProfile));
final selectedNavigationIndexProvider = StateProvider<int>((ref) => 0);
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);
final sidebarCollapsedProvider = StateProvider<bool>((ref) => false);
final selectedCustomerProvider = StateProvider<Customer>((ref) => customers.first);
final selectedProductProvider = StateProvider<Product>((ref) => products.first);
final selectedInvoiceProvider = StateProvider<Invoice>((ref) => invoices.first);
final aiChatMessagesProvider = StateProvider<List<ChatMessage>>((ref) => [...aiMessages]);
