# React Native Module Template

[![Code Style: Google](https://img.shields.io/badge/code%20style-google-blueviolet.svg)](https://github.com/google/gts)

A starter for the React Native library written in TypeScript, with linked example project and optional native code. This project aims to support latest React Native versions and keep best practices in mind.

## Alternatives

[create-react-native-module](https://github.com/brodybits/create-react-native-module)

### Why this template?

First of all it has TypeScript set up and ready. Template and example uses [gts](https://github.com/google/gts) as a formatter and linter, modified to work with React Native. If you don't happy with a code style you can always modify [prettier.config.js](prettier.config.js) and [tslint.json](tslint.json).

Example project is linked in a way so that you can work on your library and see results of your work immediately. If you use native code you can see linked libraries in the example project opened in Xcode or Android Studio and can modify the code directly from there, just remember to rebuild an example to see the changes. When you change TypeScript code you need to compile it first (using `yarn` command, it has `prepare` hook set up) since with npm you are supplying `lib` folder with JavaScript and type definitions, but there is an [option](#how-to-see-my-changes-immediately-in-the-example) to point example to the `src` folder instead, so that when you modify your library you see changes immediately in the example thanks to [Fast Refresh](https://facebook.github.io/react-native/docs/fast-refresh).

## Usage

Clone this repo, rename the `react-native-module-template` folder to your library name, navigate to that folder and run

```
node rename.js
```

or if you want to **remove native code**

```
node rename.js js-only
```

This will invoke rename script, which removes all references to the template and makes some cleanup. It also removes `.git` folder.

⚠️⚠️⚠️ This script is not made to be bulletproof, some assumptions are made:

- Script will ask for different information (such as library name, author name, author email etc.) and there might be instructions in the parenthesis, please follow them or something will likely **fail**.
- Use `kebab-case` for the library name, _preferably_ with `react-native` prefix (e.g. `react-native-blue-button`, blue-button, button).
- Use `PascalCase` for the library short name (in case you will have native code, with `js-only` argument script will not ask for this), it is used in native projects (RNModuleTemplate.xcodeproj, RNModuleTemplatePackage.java etc.). If you prefixed your library name with `react-native` use prefix `RN` for the short name (e.g. `RNBlueButton`, BlueButton, Button).
- Library homepage is used only in `package.json`, if you are not sure, you can press enter to skip this step and modify this field later. Library git url is used only in `.podspec` file, same as above (note that this file will be removed if you pass `js-only` argument).
- Please don't use any special characters in author name since it is a part of Android package name, (e.g. `com.alexdemchenko.reactnativemoduletemplate`) and used in Java and other files. Android package name is generated from author name (with removed spaces and lowercased) and from library name (with removed dashes).

Don't forget to remove the rename script, do `yarn` to install dependencies in root and example folders, and, if you kept native code, do `pod install` in `example/ios`.

If you didn't use `js-only` you are good to go. If you did, you need to unlink native code from the example

### iOS

Open Xcode, in the project navigator find `Libraries` folder, reveal contents using small arrow and hit `DELETE` on `RNModuleTemplate.xcodeproj`. Alternatively, open `example/ios/example.xcodeproj/project.pbxproj`, search for the `Template` (there should be number of `libRNModuleTemplate.a` and `RNModuleTemplate.xcodeproj` files) and remove all references to them. Please remove whole lines if it among files with other names or whole sections if it is the only item. Groups, like `Library` or `Products`, must stay, just remove template from appropriate children field.

### Android

In `example/android/settings.gradle` remove

```gradle
include ':react-native-module-template'
project(':react-native-module-template').projectDir = new File(rootProject.projectDir, '../../android')
```

In `example/android/app/build.gradle` remove

```gradle
implementation project(':react-native-module-template')
```

In `example/android/app/src/main/java/com/example/MainApplication.java` remove

```java
import com.alexdemchenko.reactnativemoduletemplate.RNModuleTemplatePackage;

packages.add(new RNModuleTemplatePackage());
```

## How example project is linked

Native part is manually linked (you can see changes for Android right above), for iOS check [official docs](https://facebook.github.io/react-native/docs/linking-libraries-ios#manual-linking), but **Header Search Paths** are pointing to the `ios` folder, `$(SRCROOT)/../../ios`, not node_modules.

JavaScript part is using Metro Bundler configuration, see [this article](https://callstack.com/blog/adding-an-example-app-to-your-react-native-library/) for more details and final configuration [here](example/metro.config.js).

In example's [tsconfig.json](example/tsconfig.json) custom path is specified, so you can import your code the same way end user will do.

```json
"paths": {
  "react-native-module-template": ["../lib"]
},
```

### How to see my changes immediately in the example

In library's `package.json` change

```json
"main": "lib/index.js",
```

to

```json
"main": "src/index.tsx",
```

and in the example's `tsconfig.json` change

```json
"paths": {
  "react-native-module-template": ["../lib"]
},
```

to

```json
"paths": {
  "react-native-module-template": ["../src"]
},
```

restart the bundler if you have it running

```
yarn start
```

⚠️⚠️⚠️ Don't forget to change this back before making a release, since with npm you supply `lib` folder, not `src`. Let me know if there is a way to do this automatically.

## License

[MIT](LICENSE)
