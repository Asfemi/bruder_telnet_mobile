import 'package:bruder_telnet_mobile/src/app.dart';
import 'package:bruder_telnet_mobile/src/config/supabase_config.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zod_validation/zod_validation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await SupabaseConfig.initialize();
  Zod.zodLocaleInstance = LocaleEN();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
