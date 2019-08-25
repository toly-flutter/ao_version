import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ao_version/ao_version.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }
















  Future<void> initPlatformState() async {//异步初始化平台状态
    String platformVersion;
    try {//捕捉PlatformException.
      platformVersion = await AoVersion.platformVersion;//通过插件获取平台版本
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // 如果在异步消息运行期间该widget从树中删除，
    // 我们希望丢弃响应，而不是调用setState来更新不存在的外观。
    if (!mounted) return;
    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: InkWell(
            onTap: ()=>AoVersion.toast(),
            child: Text('Running on: $_platformVersion\n')
            ,),
        ),
      ),
    );
  }
}

