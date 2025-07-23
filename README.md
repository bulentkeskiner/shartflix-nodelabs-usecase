# 🎬 Shartflix (Movie App) – Flutter Developer Case Study

Bu proje, **Nodelabs Flutter Developer** rolü teknik değerlendirme kapsamında geliştirilmiştir. Amaç, modern Flutter uygulama geliştirme prensiplerine uygun, sürdürülebilir, performanslı ve ölçeklenebilir bir mobil uygulama ortaya koymaktır.

## 🚀 Özellikler

### 🔐 Kimlik Doğrulama

- Kullanıcı Girişi / Kayıt ekranı
- Oturum yönetimi (token güvenli biçimde saklama - `flutter_secure_storage`)
- Başarılı giriş sonrası otomatik yönlendirme

### 🏠 Ana Sayfa (Home)

- Sonsuz kaydırma (infinite scroll – `custom_refresh_indicator`)
- Sayfa başına 5 film
- Pull-to-refresh desteği
- Favori işlemlerinde anlık UI güncellemeleri

### 👤 Profil Sayfası

- Kullanıcı bilgilerini görüntüleme
- Favori filmleri listeleme
- Profil fotoğrafı seçme ve yükleme (`image_picker`)

### 🧭 Navigasyon

- `BottomNavigationBar` kullanımı ile çoklu sayfa geçişi
- Sayfalar arası state korunumu
- `go_router` ile route yönetimi

### 🧱 Uygulama Mimarisi

- Clean Architecture
- MVVM yapısı
- `flutter_bloc` ile state management
- `get_it` ile dependency injection

---

## 🔥 Ekstra Özellikler

### 🎬 Film Detay Sayfası

- Seçilen filme ait detayları gösteren özel bir ekran:
- Film adı, açıklama, IMDb puanı, görsel gibi bilgiler detaylı şekilde sunulur.
- Filmi favorilere ekleme/çıkarma özelliği entegre edilmiştir.
- Kullanıcı arayüzü, Figma tasarımına birebir uyumludur.
- Bloc yapısı ile state yönetimi sağlanmaktadır.

### 🎨 Tema Desteği

- Uygulama içerisinde **Açık/Karanlık Mod** geçişi desteklenmektedir.
- Kullanıcı temayı anlık olarak değiştirebilir.
- Tema değişimi, tüm ekranlara **dinamik** olarak uygulanır.

### 🌍 Dil Desteği (Localization)

- Uygulama **Türkçe** ve **İngilizce** dillerini desteklemektedir.
- Dil seçimi kullanıcı tarafından uygulama içinden yapılabilir.
- `easy_localization` paketi ile **dinamik dil değişimi** sağlanmaktadır.
- Tüm metinler lokal dosyalardan çekilmektedir (`.json` formatında).

### 🔓 Çıkış Yapma (Logout)

- Kullanıcı oturumu **güvenli** bir şekilde temizlenmektedir.
- Oturum kapatıldığında kullanıcı, otomatik olarak **giriş ekranına** yönlendirilir.
- Gerekli tüm token ve kullanıcı bilgileri temizlenerek güvenli çıkış sağlanır.

---

## 🧩 Kullanılan Paketler

### 🔧 Core & State Management

- flutter_bloc
- get_it
- dio
- dartz
- equatable

### 🎨 UI & UX

- cached_network_image
- custom_refresh_indicator
- loader_overlay
- permission_handler
- image_picker
- path

### 💾 Veri Saklama

- shared_preferences
- flutter_secure_storage

### 🌐 Localization & Config

- easy_localization
- flutter_dotenv

### 🛠️ Tools & Logger

- validators
- logger

### ☁️ Firebase

- firebase_core
- firebase_crashlytics

---

## 🧪 Bonus Özellikler

- ✅ Custom Theme
- ✅ Navigation Service
- ✅ Localization (Türkçe, İngilizce)
- ✅ Logger Service
- ✅ Firebase Crashlytics entegrasyonu
- ✅ Splash Screen ve App Icon
- ✅ Güvenli token yönetimi
- ✅ Performans optimizasyonları

---

## 📁 Proje Dosya Yapısı

```
lib/
├── core/
│   ├── app/
│   ├── components/
│   ├── enum/
│   ├── exceptions/
│   ├── network/
│   ├── resources/
│   ├── routing/
│   ├── theme/
│   ├── usecase/
│   └── util/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── use_cases/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       └── widgets/
│   ├── discover/
│   ├── language/
│   ├── limited_offer/
│   ├── main_navigation/
│   ├── profile/
│   ├── splash/
│   └── theme/
├── models/
│   ├── movie_model.dart
│   ├── no_params.dart
│   └── user_model.dart
├── shared_local_shared_prefs/
│   ├── secure_shared_pref_impl.dart
│   ├── shared_pref_impl.dart
│   └── shared_pref.dart
├── support/
│   ├── app_lang.dart
│   ├── bloc_observer.dart
│   ├── locale_keys.g.dart
│   └── di_helper.dart
└── main.dart
```

---

## 🔗 Kaynaklar

- [API Dokümantasyonu](https://caseapi.servicelabs.tech/api-docs/)
- [Figma UI Design](https://www.figma.com/design/Lopx2xQcYkWZ6eAHlYAesH/Flutter-Test-Case?node-id=0-1&p=f)
- [Asset Dosyaları](https://drive.google.com/file/d/1ddbxLVRgjXECdiRrLaDkK09pQm_HHzlW/view)

---

## Uygulama Ekran Görüntüleri

<table>
  <tr>
    <td><img src="screenshots/login.png" width="100" /></td>
    <td><img src="screenshots/register.png" width="100" /></td>
    <td><img src="screenshots/home.png" width="100" /></td>
    <td><img src="screenshots/profile.png" width="100" /></td>
  </tr>
  <tr>
    <td><img src="screenshots/profile_detail.png" width="100" /></td>
    <td><img src="screenshots/select_language.png" width="100" /></td>
    <td><img src="screenshots/upload_photo.png" width="100" /></td>
    <td><img src="screenshots/limited_offer.png" width="100" /></td>
  </tr>
</table>

---

## 📦 Kurulum

1. `.env` dosyasını assets/.env dizinine ekleyin:

```env
API_BASE_URL=LINK
```

2. Bağımlılıkları yükleyin:

```bash
flutter pub get
```

3. Uygulamayı başlatın:

```bash
flutter run
```

---

## 🧑‍💻 Geliştirici Notu

Bu proje, modern Flutter prensiplerine göre modüler ve sürdürülebilir olarak geliştirilmiştir. Clean Architecture, Bloc state management ve best practice’ler ışığında yapılandırılmıştır.

Teşekkür ederim! 🙏

## 👤 Geliştirici Bilgileri

**Bülent Keskiner**  
**E-posta:** [bulentkeskiner@proton.me](mailto:bulentkeskiner@proton.me)  
**GitHub:** [github.com/bulentkeskiner](https://github.com/bulentkeskiner)  
**LinkedIn:** [linkedin.com/in/bulentkeskiner](https://www.linkedin.com/in/bulentkeskiner/)
