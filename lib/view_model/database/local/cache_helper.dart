

import 'package:shared_preferences/shared_preferences.dart';
//CacheHelper That's Connect and Talk to local database.

class CacheHelper
{
  static late SharedPreferences sharedPreferences;
  //Here The Initialize of cache .

  static  init()
  async {
    sharedPreferences =await SharedPreferences.getInstance();
  }

  static String? getDataString({
    required String key,
  }) {
    return sharedPreferences.getString(key);
  }

// this fun to put data in local data base using key

  static Future<bool>  saveData({required String key,required dynamic value})
  async {
    if(value is bool){return await  sharedPreferences.setBool(key, value);}
    if(value is String){return await  sharedPreferences.setString(key, value);}
    if(value is int){return await  sharedPreferences.setInt(key, value);}
    else{return await  sharedPreferences.setDouble(key, value);}

  }
  // this fun to get data already saved in local data base

  static dynamic  getData({required String key})
  {
    return sharedPreferences.get(key);

  }
// remove data using specific key

  static Future<bool> removeData({required String key}) async
  {
    return await sharedPreferences.remove(key);
  }


  //clear all data in the local data base
  static Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }

}