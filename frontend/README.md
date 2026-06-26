# AI Business Suite

Responsive Flutter UI/UX prototype for **DHINADTS IT SOLUTIONS AND SUPPORT (OPC) PRIVATE LIMITED**.

This is a UI-only app. It does not include backend, database, authentication, real billing, payment, GST filing, Firebase, Supabase, or API integration.

## Tech Stack

- Flutter
- Material 3
- Riverpod for UI state
- GoRouter for navigation
- Responsive mobile, tablet, desktop, and web layouts

## Business Profiles

The app supports separate build profiles using `--dart-define=BUSINESS_PROFILE=...`.

Available profiles:

- `small` - Small Registered Company
- `medium` - Medium Registered Company
- `large` - Large Registered Company
- `grocery` - Grocery and Department Store

If no profile is passed, the app defaults to `medium`.

## Run Locally

```powershell
flutter pub get
flutter run -d chrome --dart-define=BUSINESS_PROFILE=medium
```

Run a specific profile:

```powershell
flutter run -d chrome --dart-define=BUSINESS_PROFILE=small
flutter run -d chrome --dart-define=BUSINESS_PROFILE=medium
flutter run -d chrome --dart-define=BUSINESS_PROFILE=large
flutter run -d chrome --dart-define=BUSINESS_PROFILE=grocery
```

## Web Builds

Small registered company:

```powershell
flutter build web --dart-define=BUSINESS_PROFILE=small --output build\web-small
```

Medium registered company:

```powershell
flutter build web --dart-define=BUSINESS_PROFILE=medium --output build\web-medium
```

Large registered company:

```powershell
flutter build web --dart-define=BUSINESS_PROFILE=large --output build\web-large
```

Grocery and departmental store:

```powershell
flutter build web --dart-define=BUSINESS_PROFILE=grocery --output build\web-grocery
```

## Android APK Builds

Small registered company:

```powershell
flutter build apk --debug --dart-define=BUSINESS_PROFILE=small
```

Medium registered company:

```powershell
flutter build apk --debug --dart-define=BUSINESS_PROFILE=medium
```

Large registered company:

```powershell
flutter build apk --debug --dart-define=BUSINESS_PROFILE=large
```

Grocery and departmental store:

```powershell
flutter build apk --debug --dart-define=BUSINESS_PROFILE=grocery
```

The APK is generated at:

```text
build\app\outputs\flutter-apk\app-debug.apk
```

Rename or copy the APK after each build if you want to keep all four APK files.

## Build All Profiles

A helper script is available:

```powershell
tools\build_profiles.ps1 -Target web
tools\build_profiles.ps1 -Target apk
tools\build_profiles.ps1 -Target all
```

Web outputs:

```text
build\web-small
build\web-medium
build\web-large
build\web-grocery
```

APK outputs from the helper script:

```text
build\profiles\small\ai-business-manager-small-debug.apk
build\profiles\medium\ai-business-manager-medium-debug.apk
build\profiles\large\ai-business-manager-large-debug.apk
build\profiles\grocery\ai-business-manager-grocery-debug.apk
```

If PowerShell blocks script execution, run:

```powershell
powershell -ExecutionPolicy Bypass -File tools\build_profiles.ps1 -Target all
```

## Profile UI Differences

Small registered company:

- Simple dashboard
- Billing
- Inventory
- GST
- Reports
- Settings

Medium registered company:

- Dashboard
- Billing
- Inventory
- CRM
- Accounting
- GST
- Reports
- AI Assistant
- Voice Billing
- Settings

Large registered company:

- Full ERP dashboard
- Billing
- Inventory
- CRM
- Accounting
- GST
- Reports
- AI Assistant
- OCR Upload
- Voice Billing
- Settings

Grocery and departmental store:

- Store dashboard
- Manual billing
- Voice billing
- Store inventory
- Daily reports
- Settings

## Subscription UI

The subscription screen is available at `/subscription`.

Plans shown in UI:

- `Rs. 399/month` for less than 3 employees
- `Rs. 999/month` for more than 5 employees
- `Rs. 1499/month` for more than 10 employees

UPI and bank transfer auto-renewal are UI placeholders only. No real payment integration is implemented.

## Verification

Run:

```powershell
flutter analyze
flutter test
```

Build checks:

```powershell
flutter build web --dart-define=BUSINESS_PROFILE=medium
flutter build apk --debug --dart-define=BUSINESS_PROFILE=medium
```
