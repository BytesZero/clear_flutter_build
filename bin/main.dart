// ignore_for_file: avoid_print

import 'dart:io';

import 'package:args/args.dart';
import 'package:cf_cli/cf_cli.dart';

void main(List<String> arguments) {
  var parser = ArgParser();

  // 添加 mode
  parser.addOption(
    'mode',
    abbr: 'm',
    defaultsTo: 'all',
    allowed: ['build', 'pods', 'gradle', 'all'],
    help:
        '🚀 Set the cleanup mode build is the build folder, pods is the ios/Pods folder, gradle is the android/.gradle folder, all folders',
  );

  // 添加 version
  parser.addFlag(
    'version',
    abbr: 'v',
    help: '📦️ Get the version',
    defaultsTo: false,
  );

  // 添加 help
  parser.addFlag(
    'help',
    abbr: 'h',
    help: '💡 Help description',
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
          '\n💻 OS：${Platform.operatingSystemVersion}');
    } else {
      // 输出清理模式
      print('🚀 Cleanup mode:$mode');
      switch (mode) {
        case 'build':
          flutterCleanBuild();
          break;
        case 'pods':
          flutterCleanPods();
          break;
        case 'gradle':
          flutterCleanGradle();
          break;
        default:
          flutterCleanAll();
      }
    }
  }
}
