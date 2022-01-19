# Getting started

### Step 1
Clone this repository
[Flutter mobile template 2.0!](https://gitlab.com/boiler-plates2/flutter-mobile-template-2.0.git)


### Step 2: Update git configurations
Run below command
```
git remote rename origin old-origin
git remote add origin <YOUR GIT ORIGIN>
git push -u origin --all
git push -u origin --tags
```
### Step 3: Update project name
Rename project name in following files/folders
 - Folder name
 - Name in pubspec.yaml
 - Change android package name [Stack overflow Reference](https://stackoverflow.com/a/29092698/12142044)
 - Change the bundle identifier from your `Info.plist` file inside your ios/Runner directory.
    ```plist
    <key>CFBundleIdentifier</key>
    <string>com.your.packagename</string>
    ```
### Step 4: Configure pubspec.yaml
- Update environment sdk if new version is available
- Update and review dependancies
- Update font files in ./assets/fonts/ and add them to `pubspec.yaml`
- Add assets or logo to ./assets/icons/
- Add your assets to app_assets.dart
- Update font family in environmant.dart
- Review flutter_launcher_icons configurations
- Run below command
```
flutter packages get
flutter pub run flutter_launcher_icons:main
flutter pub run intl_utils:generate
```
### Step 5: Configure App themes
- Update app_colors.dart
- Update app_themes.dart
- Update main.dart theme mode (if required)

### Step 6: Configure App Widgets
- Update app_decorations.dart for textfield decorations
-