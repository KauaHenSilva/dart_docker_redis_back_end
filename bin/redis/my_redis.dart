import '../ConfigEnv/config_env.dart';
import 'package:redis/redis.dart';

class MyRedis {
  final RedisConnection redis = RedisConnection();

  final String user = ConfigEnv.REDIS_HOST;
  final int port = ConfigEnv.REDIS_PORT;

  Future<String> getRedisData(String key) async {
    final command = await redis.connect(user, port);
    final response = await command.send_object(['GET', key]);
    return response is String ? response : '';
  }

  Future<int> incrementRedisKey(String key) async {
    final command = await redis.connect(user, port);
    final result = await command.send_object(['INCR', key]);
    return result is int ? result : 0;
  }

  Future<void> setRedisData(String key, String value) async {
    final command = await redis.connect(user, port);
    await command.send_object(['SET', key, value]);
  }

  Future<void> close() async {
    await redis.close();
  }
}
