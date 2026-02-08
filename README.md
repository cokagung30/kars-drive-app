<div align="center">

# 🚗 KARS Driver App

**Aplikasi mobile untuk driver KARS — kelola pesanan, pantau penghasilan, dan atur penarikan dana dengan mudah.**

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.8-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![BLoC](https://img.shields.io/badge/State_Management-BLoC-blueviolet)](https://bloclibrary.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Enabled-FFCA28?logo=firebase&logoColor=black)](https://firebase.google.com)

</div>

---

## 📖 Tentang Project

**KARS Driver App** adalah aplikasi mobile berbasis Flutter yang dirancang khusus untuk para driver KARS. Aplikasi ini memungkinkan driver untuk menerima dan mengelola pesanan, memantau riwayat perjalanan, serta melakukan penarikan dana — semua dalam satu aplikasi yang intuitif dan responsif.

---

## ✨ Fitur Utama

| Fitur                    | Deskripsi                                                          |
| ------------------------ | ------------------------------------------------------------------ |
| 🔐 **Autentikasi**       | Login dengan keamanan tinggi, termasuk fitur lupa & reset password |
| 📋 **Manajemen Pesanan** | Lihat, terima, dan update status pesanan secara real-time          |
| 📊 **Dashboard**         | Ringkasan performa dan statistik driver                            |
| 📜 **Riwayat**           | Riwayat lengkap pesanan yang telah diselesaikan                    |
| 💰 **Penarikan Dana**    | Ajukan penarikan penghasilan dengan mudah                          |
| 🔔 **Notifikasi**        | Push notification real-time via Firebase Cloud Messaging           |
| 👤 **Profil Akun**       | Kelola informasi profil dan pengaturan akun                        |
| 🎬 **Onboarding**        | Landing page intro untuk pengguna baru                             |

---

## 🏗️ Arsitektur & Tech Stack

### Arsitektur

Project ini mengikuti **Clean Architecture** dengan pemisahan layer yang jelas:

```
lib/
├── app/                 # App-level config, BLoC observer
├── core/                # Shared modules
│   ├── api/             # API client & interceptors
│   ├── client/          # HTTP client setup (Dio)
│   ├── models/          # Data models
│   ├── notification/    # Push notification handler
│   ├── repositories/    # Repository layer
│   ├── storage/         # Local storage (SharedPreferences)
│   ├── theme/           # App theming
│   ├── utils/           # Utility functions
│   └── widgets/         # Reusable widgets
├── features/            # Feature modules
│   ├── account/         # Profil & pengaturan akun
│   ├── dashboard/       # Dashboard driver
│   ├── history/         # Riwayat pesanan
│   ├── landing/         # Onboarding screen
│   ├── login/           # Autentikasi
│   ├── main/            # Main shell / bottom navigation
│   ├── notification/    # Notifikasi
│   ├── orders/          # Manajemen pesanan
│   ├── password/        # Forgot, reset & update password
│   ├── status/          # Status driver
│   └── withdrawals/     # Penarikan dana
├── injection/           # Dependency Injection (GetIt)
├── router/              # Routing (GoRouter)
└── gen/                 # Generated assets (flutter_gen)
```

### Tech Stack

| Kategori                 | Library                                                            |
| ------------------------ | ------------------------------------------------------------------ |
| **State Management**     | `flutter_bloc` / `bloc` + `rxdart`                                 |
| **Networking**           | `dio` + `curl_logger_dio_interceptor`                              |
| **Routing**              | `go_router`                                                        |
| **Dependency Injection** | `get_it`                                                           |
| **Firebase**             | `firebase_core`, `firebase_messaging`                              |
| **Local Storage**        | `shared_preferences`                                               |
| **Notifications**        | `flutter_local_notifications`                                      |
| **Form Validation**      | `formz`                                                            |
| **Image Handling**       | `cached_network_image`, `extended_image`, `flutter_image_compress` |
| **UI**                   | `flutter_svg`, `shimmer`, Font Poppins                             |
| **Code Quality**         | `very_good_analysis`, `mocktail`, `bloc_test`                      |

---

## 🚀 Getting Started

### Prasyarat

- Flutter SDK `>=3.8.0`
- Dart SDK `>=3.8.0`
- Android Studio / VS Code
- Firebase project yang sudah dikonfigurasi

### Instalasi

1. **Clone repository**

   ```sh
   git clone <repository-url>
   cd kars_driver_app
   ```

2. **Install dependencies**

   ```sh
   flutter pub get
   ```

3. **Konfigurasi Environment**

   Salin file contoh environment dan isi value yang sesuai:

   ```sh
   cp environment.example.json environment.json
   cp environment.example.json environment.dev.json
   ```

   Isi `API_URL` pada masing-masing file environment:

   ```json
   {
     "API_URL": "https://api.example.com"
   }
   ```

4. **Setup Firebase**

   Pastikan file `google-services.json` (Android) dan `GoogleService-Info.plist` (iOS) sudah dikonfigurasi dengan benar.

### Menjalankan Aplikasi

Project ini memiliki **3 flavor** untuk environment yang berbeda:

```sh
# 🟢 Development
flutter run --flavor development --target lib/main_development.dart

# 🟡 Staging
flutter run --flavor staging --target lib/main_staging.dart

# 🔴 Production
flutter run --flavor production --target lib/main_production.dart
```

> 💡 **Tip:** Gunakan launch configuration di VS Code / Android Studio untuk kemudahan.

---

## 🧪 Testing

```sh
# Jalankan semua unit & widget tests
very_good test --coverage --test-randomize-ordering-seed random
```

### Coverage Report

Gunakan [lcov](https://github.com/linux-test-project/lcov) untuk generate laporan coverage:

```sh
# Generate coverage report
genhtml coverage/lcov.info -o coverage/

# Open coverage report
open coverage/index.html
```

---

## 🌐 Lokalisasi

Project ini menggunakan [flutter_localizations][flutter_localizations_link] dan mengikuti [panduan internasionalisasi resmi Flutter][internationalization_link].

### Menambahkan String Baru

1. Buka file `app_en.arb` di `lib/l10n/arb/app_en.arb`
2. Tambahkan key/value baru:

```arb
{
    "@@locale": "en",
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Gunakan string di widget:

```dart
import 'package:kars_driver_app/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Generate Translations

```sh
flutter gen-l10n --arb-dir="lib/l10n/arb"
```

> Atau cukup jalankan `flutter run` — code generation akan berjalan otomatis.

---

## 📱 Platform Support

| Android | iOS |
| :-----: | :-: |
|   ✅    | ✅  |

---

## 📦 Build & Release

```sh
# Build APK (Android)
flutter build apk --flavor production --target lib/main_production.dart

# Build App Bundle (Android)
flutter build appbundle --flavor production --target lib/main_production.dart

# Build IPA (iOS)
flutter build ipa --flavor production --target lib/main_production.dart
```

---

## 🤝 Contributing

1. Fork repository ini
2. Buat feature branch (`git checkout -b feature/fitur-baru`)
3. Commit perubahan (`git commit -m 'feat: tambah fitur baru'`)
4. Push ke branch (`git push origin feature/fitur-baru`)
5. Buat Pull Request

---

## 📄 License

Project ini dilisensikan di bawah [MIT License][license_link].

---

<div align="center">

**Built with ❤️ using [Flutter](https://flutter.dev) & [Very Good CLI](https://github.com/VeryGoodOpenSource/very_good_cli)**

</div>

[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
