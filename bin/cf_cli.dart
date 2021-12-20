// ignore_for_file: avoid_print

import 'dart:io';

import 'package:args/args.dart';
import 'package:cf/cf.dart';

void main(List<String> arguments) {
  var parser = ArgParser();

  // 添加 mode
  parser.addOption(
    'mode',
    abbr: 'm',
    defaultsTo: 'build',
    allowed: ['build', 'pods', 'all'],
    help: '🚀 设置清理模式 build 是 build 文件夹，pods 是 ios/Pods 文件夹, all 全部文件夹',
  );

  // 添加 version
  parser.addFlag(
    'version',
    abbr: 'v',
    help: '📦️ 获取版本',
    defaultsTo: false,
  );

  // 添加 help
  parser.addFlag(
    'help',
    abbr: 'h',
    help: '💡 帮助说明',
    defaultsTo: false,
  );
  late String mode;
  late bool help;
  late bool version;
  try {
    var result = parser.parse(arguments);
    mode = result['mode'];
    help = result['help'];
    version = result['version'];
  } catch (e) {
    help = true;
  }

  // 输出帮助说明
  if (help) {
    print(parser.usage);
  } else {
    if (version) {
      print('🚀 CF Version：$kCliVersion'
          '\n🐦 Dart：${Platform.version}'
          '\n🧑‍💻 OS：${Platform.operatingSystemVersion}');
    } else {
      // 输出清理模式
      print('🚀 清理模式:$mode');
      switch (mode) {
        case 'all':
          flutterCleanAll();
          break;
        case 'pods':
          flutterCleanPods();
          break;
        default:
          flutterCleanBuild();
      }
    }
  }
}
