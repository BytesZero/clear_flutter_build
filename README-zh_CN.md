## cf

批量清理 Flutter 项目 [build、ios/Pods] 目录，优化电脑空间，顺手练习一下 Dart CLI

## 安装

- 方法一

```
dart pub global activate cf_cli
```

- 方法二

```
dart pub global activate -sgit https://github.com/yy1300326388/clear_flutter_build.git
```


## 运行效果

- 清理 `build` 

```
➜  cf
🚀 清理模式:build
🎉 全部清理完毕
```

- 清理 `ios/Pods`

```
➜  cf -m pods
🚀 清理模式:pods
🎉 全部清理完毕
```

- 清理 `build` 和 `ios/Pods`

```
➜  cf -m all
🚀 清理模式:all
🎉 全部清理完毕
```

- 版本信息

```
➜  cf -v
🚀 CF Version：1.0.0
🐦 Dart：2.14.4 (stable) (Wed Oct 13 11:11:32 2021 +0200) on "macos_x64"
🧑‍💻 OS：10.16
```

- 帮助说明

```
➜  cf -h
-m, --mode            🚀 设置清理模式 build 是 build 文件夹，pods 是 ios/Pods 文件夹, all 全部文件夹
                      [build (default), pods, all]
-v, --[no-]version    📦️ 获取版本
-h, --[no-]help       💡 帮助说明
```
