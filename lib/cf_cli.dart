// ignore_for_file: avoid_print

import 'dart:io';

/// cli 版本号
const String kCliVersion = '1.1.0';

/// 清理全部
Future<void> flutterCleanAll() async {
  await forEachFlutterDir(
    Directory.current.path,
    clearBuild: true,
    clearPods: true,
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

/// 遍历 Flutter dir
Future<void> forEachFlutterDir(String path,
    {bool clearBuild = true, bool clearPods = false}) async {
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
  if (fileNameList.contains('pubspec.yaml')) {
    // 清理 build
    if (clearBuild && fileNameList.contains('build')) {
      await runClean(path);
    }
    // 清理 Pods
    if (clearPods && Directory('$path/ios/Pods').existsSync()) {
      await runPodsClean(path);
    }
  } else {
    // print('没有 Flutter 目录，继续遍历:$path');
    for (var file in fileList) {
      forEachFlutterDir(file.path);
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

// 执行 Pods 清理
Future<void> runPodsClean(String dirPath) async {
  print('🧹 Cleaning up Pods：$dirPath');
  var result =
      await Process.run('rm', ['-rf', 'ios/Pods'], workingDirectory: dirPath);
  print(result.stdout);
  // 延迟 50 毫秒
  await Future.delayed(const Duration(milliseconds: 50));
}
