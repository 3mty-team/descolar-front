# Comment setup le projet

## Installations

### Windows VSCode

Lien : <https://docs.flutter.dev/get-started/install/windows/mobile?tab=vscode>

- Installer **Git** 2.4 ou plus (*<https://gitforwindows.org/>*)

- Installer **Android Studio 2022.3.x (Giraffe)** (*<https://developer.android.com/studio/install?hl=fr>*)

- Installer **VSCode** 1.75 ou plus (*<https://code.visualstudio.com/Download>*), et **l'extension Flutter** (*<https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter>*)

- **Lancer Android Studio**, suivre les instructions d'installation, et **installer les components** suivants avec le **SDK Manager**:
  - Android SDK Platform, **API 33.0.0**
  - Android SDK Command-line Tools
  - Android SDK Build-Tools
  - Android SDK Platform-Tools
  - Android Emulator

- Créer un appareil virtuel avec l'**API Level à 33** avec le **Virtual Device Manager**

- Installer le SDK Flutter : <https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.16.9-stable.zip>

- Ajouter Flutter SDK dans l'extension VSCode : ...

- Ajouter Flutter SDK dans le PATH : <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> &rarr; `Flutter: Add Flutter SDK to PATH`

- Accepter la licence Android :  `flutter doctor --android-licenses`

- Vérifier si tout est ok : `flutter doctor` (pas besoin de la case "Visual Studio")

### Linux ?

Lien : <https://docs.flutter.dev/get-started/install/linux>

## Cloner le projet

**SSH :** ssh://git@git.jetbrains.space/3mty/descolar/descolar-front.git

**HTTPS :**  <https://git.jetbrains.space/3mty/descolar/descolar-front.git>

## Run et commandes

Pour lancer l'application, **lancer l'appareil virtuel**, puis utiliser la commande `flutter run`

Pour ajouter une dépendance (`pubspec.yaml`), faire la commande `flutter pub add <dependency>`

Pour reload les dépendances (`pubspec.yaml`), faire la commande `flutter pub get` (automatique quand on save le fichier avec vscode)

Pour voir et fix les erreurs dart automatiquement, faire la commande `dart fix --dry-run` pour preview les erreurs,
puis faire `dart fix --apply` pour fixer les erreurs diagnostiquées

## Ressources

[Maquettes Figma](https://www.figma.com/file/zItehOB6OXvd2mfqGLU3Gm/Descolar-Front?type=design&node-id=25%3A2&mode=design&t=xN4HkjJXmRycDf8z-1)
