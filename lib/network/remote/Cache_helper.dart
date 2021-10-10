import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static late SharedPreferences sharedPreferences;
 static Future<SharedPreferences>init()async{
  return sharedPreferences=await SharedPreferences.getInstance();
  }
  static Future<bool>putBoolean({required String key,required bool value})async{
  return sharedPreferences.setBool(key, value);
}
static Future<bool>setData({required dynamic value,required String key}){
  if(value is bool){return sharedPreferences.setBool(key, value);}
  if(value is String){return sharedPreferences.setString(key, value);}
  if(value is int){return sharedPreferences.setInt(key, value);}
  else
   return sharedPreferences.setDouble(key, value);
}
static dynamic getData({required String key}){
  return sharedPreferences.get(key);
}
  static Future<bool> removeData({required String key})async{
   return await sharedPreferences.remove(key);
  }


}