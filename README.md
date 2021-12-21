## cf（Clean Flutter Cache）

Clean up the [build, ios/Pods] directory of Flutter projects in batches, optimize computer space, and practice Dart CLI

## Install

- Dart activate

```
dart pub global activate cf_cli
```

- Git source

```
dart pub global activate -sgit https://github.com/yy1300326388/clear_flutter_build.git
```


## Run cleanup

- Cleanup `build` 

```
➜  cf
🚀 Cleanup mode:build
🎉 All cleaned up
```

- Cleanup `ios/Pods`

```
➜  cf -m pods
🚀 Cleanup mode:pods
🎉 All cleaned up
```

- Cleanup `build` 和 `ios/Pods`

```
➜  cf -m all
🚀 Cleanup mode:all
🎉 All cleaned up
```

- Get the version

```
➜  cf -v
🚀 CF Version：1.1.0
🐦 Dart：2.15.0 (stable) (Fri Dec 3 14:23:23 2021 +0100) on "macos_x64"
🧑‍💻 OS：Version 12.0.1 (Build 21A559)
```

- Help description

```
➜  cf -h
-m, --mode            🚀 Set the cleanup mode build is the build folder, pods is the ios/Pods folder, all folders
                      [build (default), pods, all]
-v, --[no-]version    📦️ Get the version
-h, --[no-]help       💡 Help description
```

## My cleanup results

