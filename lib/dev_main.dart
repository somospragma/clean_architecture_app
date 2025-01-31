import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app.dart';
import 'core/env/config_env.dart';
import 'core/network/dio_network.dart';

void main() async{
  await ConfigENV.intance.loadEnvironment(fileName: '.local.env');
  await ScreenUtil.ensureScreenSize();
  DioNetwork.initDio();
  runApp(const ProviderScope(child: MainApp()));
}
