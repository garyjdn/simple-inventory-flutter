import 'dart:convert';
import 'package:inventoryapp/shared/helpers/cache_storage.dart';
import 'package:inventoryapp/data/data.dart';

class AuthSharedPref {
  static const key = 'auth';

  static createData(Map<String, dynamic> data, {expiry: const Duration(hours: 23)}) {
    assert(data != null);
    Map cache = {};
    cache['data'] = data;
    if(expiry != null) {
      cache['expiryDate'] = DateTime.now().add(expiry).toIso8601String();
    }
    final String encodedCache = json.encode(cache);
    Cache.setCache(key: key, data: encodedCache);
  }

  static readData() async {
    final String encodedCache = await Cache.getCache(key: key);
    final decodedCache = json.decode(encodedCache);
    if(decodedCache.containsKey('expiryDate')) {
      final expiryDate = DateTime.parse(decodedCache['expiryDate']);
      if(expiryDate.isBefore(DateTime.now())) {
        return null;
      }
    }
    Map<String, dynamic> cache = {
      'user': User.fromMap(decodedCache['data']['user']),
      'token': decodedCache['data']['token'],
    };
    return cache;
  }

  static hasCache() async {
    final bool cacheContainsKey = await Cache.containsKey(key: key);
    if(cacheContainsKey) {
      final String encodedCache = await Cache.getCache(key: key);
      final cache = json.decode(encodedCache);
      if(cache.containsKey('expiryDate')) {
        final expiryDate = DateTime.parse(cache['expiryDate']);
        if(expiryDate.isAfter(DateTime.now())) {
          return true;
        }
      }
    }
    return false;
  }

  static deleteData() async {
    await Cache.removeCache(key: key);
  }
}