// ignore_for_file: avoid_print

import 'dart:io';

/// cli 版本号
const String kCliVersion = '1.2.0';

// pubspec.yaml
const String kPubspecYaml = 'pubspec.yaml';
// example
const String kExampleDir = 'example';

// build
const String kBuildDir = 'build';

// ios/Pods
const String kIosPodsDir = 'ios/Pods';

// android/.gradle
const String kAndroidDir = 'android/.gradle';

/// 清理全部
Future<void> flutterCleanAll() async {
  await forEachFlutterDir(
    Directory.current.path,
    clearBuild: true,
    clearPods: true,
    clearGradle: true,
  );
  print('🎉 All cleaned up');
}

/// 清理 build
Future<void> flutterCleanBuild() async {
  await forEachFlutterDir(Directory.current.path);
  print('🎉 All cleaned up');
}

/// 清理 Pods
Future<void> flutterCleanPods() async {
  await forEachFlutterDir(
    Directory.current.path,
    clearBuild: false,
    clearPods: true,
  );
  print('🎉 All cleaned up');
}

/// 清理 gradle
Future<void> flutterCleanGradle() async {
  await forEachFlutterDir(
    Directory.current.path,
    clearBuild: false,
    clearPods: false,
    clearGradle: true,
  );
  print('🎉 All cleaned up');
}

/// 遍历 Flutter dir
Future<void> forEachFlutterDir(String path,
    {bool clearBuild = true,
    bool clearPods = false,
    bool clearGradle = false}) async {
  // 不是文件夹退出
  if (!await FileSystemEntity.isDirectory(path)) {
    return;
  }
  // 隐藏文件退出
  if (path.split(Platform.pathSeparator).last.startsWith('.')) {
    print('🙈 Hidden folder skip');
    return;
  }
  // 开始遍历
  var fileList = Directory(path).listSync(followLinks: false);
  var fileNameList =
      fileList.map((e) => e.path.split(Platform.pathSeparator).last).toList();
  // 检查 Flutter 目录
  if (fileNameList.contains(kPubspecYaml)) {
    // 处理 package 有 example 的情况
    if (fileNameList.contains(kExampleDir)) {
      String exampleDirPath = '$path${Platform.pathSeparator}$kExampleDir';
      if (Directory(exampleDirPath).existsSync()) {
        await forEachFlutterDir(
          exampleDirPath,
          clearBuild: clearBuild,
          clearPods: clearPods,
          clearGradle: clearGradle,
        );
        return;
      }
    }
    // 清理 build
    if (clearBuild && fileNameList.contains(kBuildDir)) {
      await runClean(path);
    }
    // 清理 Pods
    if (clearPods &&
        Directory('$path${Platform.pathSeparator}$kIosPodsDir').existsSync()) {
      await runPodsClean(path);
    }

    // 清理 gradle
    if (clearGradle &&
        Directory('$path${Platform.pathSeparator}$kAndroidDir').existsSync()) {
      await runGradleClean(path);
    }
  } else {
    // 没有 Flutter 目录，继续遍历:$path
    for (var file in fileList) {
      forEachFlutterDir(
        file.path,
        clearBuild: clearBuild,
        clearPods: clearPods,
        clearGradle: clearGradle,
      );
    }
  }
}

// 执行 Flutter build 清理
Future<void> runClean(String dirPath) async {
  print('🗑️ Cleaning up：$dirPath');
  var result =
      await Process.run('flutter', ['clean'], workingDirectory: dirPath);
  print(result.stdout);
  // 延迟 50 毫秒
  await Future.delayed(const Duration(milliseconds: 50));
}

// 执行 ios/Pods 清理
Future<void> runPodsClean(String dirPath) async {
  print('🧹 Cleaning up Pods：$dirPath${Platform.pathSeparator}$kIosPodsDir');
  var result =
      await Process.run('rm', ['-rf', kIosPodsDir], workingDirectory: dirPath);
  print(result.stdout);
  // 延迟 50 毫秒
  await Future.delayed(const Duration(milliseconds: 50));
}

// 执行 android/.gradle 清理
Future<void> runGradleClean(String dirPath) async {
  print('🧹 Cleaning up gradle：$dirPath${Platform.pathSeparator}$kAndroidDir');
  var result =
      await Process.run('rm', ['-rf', kAndroidDir], workingDirectory: dirPath);
  print(result.stdout);
  // 延迟 50 毫秒
  await Future.delayed(const Duration(milliseconds: 50));
}
