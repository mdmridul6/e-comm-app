import 'package:crafty_bay/app/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/state_holders/connection_state.dart';
import 'core/themes/theme_switcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NetworkState());
  Get.find<NetworkState>().initialize();
  Get.put(ThemeSwitcher());
  runApp(const CraftyBay());
}
