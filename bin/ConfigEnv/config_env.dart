// ignore_for_file: non_constant_identifier_names

import 'package:dotenv/dotenv.dart';

final _env = DotEnv(includePlatformEnvironment: true)..load();

abstract class ConfigEnv {
  static String get REDIS_HOST => _env['REDIS_HOST'] ?? 'localhost';
  static int get REDIS_PORT => int.parse(_env['REDIS_PORT'] ?? '6379');
  static String get PORT => _env['PORT'] ?? '8080';
}
