【构建flutter项目】
官方文档：https://flutter-ko.dev/get-started/install/macos
（中文版）：https://doc.flutterchina.club/setup-macos/

【mac中配置环境变量】
假设已经将 Flutter SDK 解压到某个目录（例如 ~/development/flutter），这个路径就是 Flutter SDK 的路径。

open -e ~/.bash_profile

.bash_profile 文件里加一句：export PATH="$PATH:/path/to/flutter/bin"
将 /path/to/flutter/bin 替换为 Flutter SDK 路径。例如：
例如 export PATH="$PATH:~/development/flutter/bin"

保存并关闭编辑器。然后，重新加载配置文件，使更改生效：
source ~/.bash_profile

确认 Flutter 是否已正确配置：
flutter doctor

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
