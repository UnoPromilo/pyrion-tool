# Pyrion ESC Tool

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)

Desktop app for configuring and controlling Pyrion ESC.

---

## Building the App

1. **Generate Files:**
   Run the code generator to create the necessary files:

```bash
dart run build_runner build
```

> Tip: Use `dart run build_runner watch` for automatic regeneration during development.

2. **Generate gRPC client:**
   Run the `protoc`

```bash
protoc --dart_out=grpc:lib/remotes/device_api/generated \
  -I=lib/remotes/device_api/proto \
  lib/remotes/device_api/proto/**/*.proto
```

3. **Run the App:**
   Launch the app with Flutter:

```bash 
flutter run
```

---

## License

The software is released under the GNU General Public License version 3.0