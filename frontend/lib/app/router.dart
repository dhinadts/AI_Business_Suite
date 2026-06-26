import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/prototype_screens.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/signup_screen.dart';
import '../features/auth/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/dashboard/screens/adaptive_dashboard_screen.dart';
import '../features/company_onboarding/screens/company_registration_screen.dart';
import '../features/company_onboarding/screens/business_classification_result_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authProvider);
  return GoRouter(
    initialLocation: auth.loading
        ? '/'
        : auth.isAuthenticated
        ? '/dashboard'
        : '/login',
    redirect: (context, state) {
      if (auth.loading) {
        return null;
      }
      final path = state.uri.path;
      final authRoute =
          path == '/login' ||
          path == '/signup' ||
          path == '/company-registration';
      if (!auth.isAuthenticated && !authRoute) {
        return '/login';
      }
      if (auth.isAuthenticated && authRoute) {
        return auth.justSignedUp ? '/classification-result' : '/dashboard';
      }
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: '/login',
        builder: (context, state) => const AuthLoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const AuthSignupScreen(),
      ),
      GoRoute(
        path: '/company-registration',
        builder: (context, state) => const CompanyRegistrationScreen(),
      ),
      GoRoute(
        path: '/classification-result',
        builder: (context, state) => const BusinessClassificationResultScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => auth.isAuthenticated
            ? const AdaptiveDashboardScreen()
            : const DashboardScreen(),
      ),
      GoRoute(
        path: '/billing',
        builder: (context, state) => const BillingScreen(),
      ),
      GoRoute(
        path: '/billing/stall-sale',
        builder: (context, state) => const GrocerySaleScreen(),
      ),
      GoRoute(
        path: '/billing/invoices',
        builder: (context, state) => const InvoiceListScreen(),
      ),
      GoRoute(
        path: '/billing/create',
        builder: (context, state) => const CreateInvoiceScreen(),
      ),
      GoRoute(
        path: '/billing/invoice-preview',
        builder: (context, state) => const InvoicePreviewScreen(),
      ),
      GoRoute(
        path: '/inventory',
        builder: (context, state) => const InventoryScreen(),
      ),
      GoRoute(
        path: '/inventory/stock-intake',
        builder: (context, state) => const StockIntakeScreen(),
      ),
      GoRoute(
        path: '/inventory/products',
        builder: (context, state) => const InventoryScreen(),
      ),
      GoRoute(
        path: '/inventory/product-detail',
        builder: (context, state) => const InventoryScreen(detail: true),
      ),
      GoRoute(path: '/crm', builder: (context, state) => const CrmScreen()),
      GoRoute(
        path: '/crm/customers',
        builder: (context, state) => const CustomerListScreen(),
      ),
      GoRoute(
        path: '/crm/customer-profile',
        builder: (context, state) => const CrmScreen(profile: true),
      ),
      GoRoute(
        path: '/accounting',
        builder: (context, state) => const AccountingScreen(),
      ),
      GoRoute(path: '/gst', builder: (context, state) => const GstScreen()),
      GoRoute(
        path: '/gst/gstr1-review',
        builder: (context, state) => const GstrReviewScreen(),
      ),
      GoRoute(
        path: '/gst/filing-success',
        builder: (context, state) => const GstSuccessScreen(),
      ),
      GoRoute(
        path: '/reports',
        builder: (context, state) => const ReportsScreen(),
      ),
      GoRoute(
        path: '/reports/profit-loss',
        builder: (context, state) => const ProfitLossScreen(),
      ),
      GoRoute(
        path: '/ai-assistant',
        builder: (context, state) => const AiAssistantScreen(),
      ),
      GoRoute(
        path: '/ocr-upload',
        builder: (context, state) => const OcrUploadScreen(),
      ),
      GoRoute(
        path: '/ocr-scanning',
        builder: (context, state) => const OcrScanningScreen(),
      ),
      GoRoute(
        path: '/translator',
        builder: (context, state) => const TranslatorToolScreen(),
      ),
      GoRoute(
        path: '/printer-setup',
        builder: (context, state) => const PrinterSetupScreen(),
      ),
      GoRoute(
        path: '/voice-billing',
        builder: (context, state) => const VoiceBillingScreen(),
      ),
      GoRoute(
        path: '/voice-billing/active',
        builder: (context, state) => const VoiceActiveScreen(),
      ),
      GoRoute(
        path: '/voice-billing/review',
        builder: (context, state) => const VoiceReviewScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/settings/team-roles',
        builder: (context, state) => const TeamRolesScreen(),
      ),
      GoRoute(
        path: '/settings/add-team-member',
        builder: (context, state) => const AddTeamMemberScreen(),
      ),
      GoRoute(
        path: '/settings/users',
        builder: (context, state) => const SimpleInfoScreen(
          title: 'User Management',
          message:
              'Manage user status, roles, and invitations with dummy UI rows.',
          icon: Icons.manage_accounts_rounded,
        ),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/associations',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const SimpleInfoScreen(
          title: 'Profile',
          message: 'DHINADTS company profile and user preferences placeholder.',
          icon: Icons.badge_rounded,
        ),
      ),
      GoRoute(
        path: '/subscription',
        builder: (context, state) => const SubscriptionScreen(),
      ),
      GoRoute(
        path: '/help',
        builder: (context, state) => const SimpleInfoScreen(
          title: 'Help & Support',
          message:
              'Support tickets, documentation, and contact cards appear here as UI placeholders.',
          icon: Icons.support_agent_rounded,
        ),
      ),
    ],
  );
});
