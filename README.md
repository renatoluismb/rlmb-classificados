# cvag

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

environment:
  sdk: ">=2.3.0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^0.1.2
  flutter_localizations:
    sdk: flutter
  intl: ^0.16.0
  intl_translation: ^0.17.7
  rxdart: ^0.23.1
  brasil_fields: ^0.0.7+2
  image_picker: ^0.6.2+3
  cached_network_image: ^2.0.0-rc
  parse_server_sdk: ^1.0.24
  geolocator: ^5.1.5
  url_launcher: ^5.4.0
  carousel_pro: ^1.0.0
  path_provider: ^1.5.1
  flutter_image_compress: ^0.6.3
  transparent_image: ^1.0.0
  flutter_masked_text: ^0.8.0
  provider: ^3.2.0
  shared_preferences: ^0.5.6
  connectivity: ^0.4.6+1
  onesignal_flutter: ^2.0.2
  image_cropper: ^1.1.1
  location_permissions: ^2.0.3
  dio: ^3.0.7

  # Habilitar somente quando for solicitado!
  # flutter_facebook_login: ^3.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter


# For information on the generic Dart part of this file, see the
# following page: https://dart.dev/tools/pub/pubspec

# The following section is specific to Flutter.
flutter:

  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true

  # To add assets to your application, add an assets section, like this:
  # assets:
  #  - images/a_dot_burr.jpeg
  #  - images/a_dot_ham.jpeg
  assets:
    - images/

  # An image asset can refer to one or more resolution-specific "variants", see
  # https://flutter.dev/assets-and-images/#resolution-aware.

  # For details regarding adding assets from package dependencies, see
  # https://flutter.dev/assets-and-images/#from-packages

  # To add custom fonts to your application, add a fonts section here,
  # in this "flutter" section. Each entry in this list should have a
  # "family" key with the font family name, and a "fonts" key with a
  # list giving the asset and other descriptors for the font. For
  # example:
  # fonts:
  #   - family: Schyler
  #     fonts:
  #       - asset: fonts/Schyler-Regular.ttf
  #       - asset: fonts/Schyler-Italic.ttf
  #         style: italic
  #   - family: Trajan Pro
  #     fonts:
  #       - asset: fonts/TrajanPro.ttf
  #       - asset: fonts/TrajanPro_Bold.ttf
  #         weight: 700
  #
  # For details regarding fonts from package dependencies,
  # see https://flutter.dev/custom-fonts/#from-packages

