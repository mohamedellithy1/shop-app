import 'package:udemyshopapp/models/loginmodel.dart';

abstract class ShopLoginStates{}
 class ShopLoginInitialStates extends ShopLoginStates{}
 class ShopLoginSuccessStates extends ShopLoginStates{
ShopLoginModel loginmodel;

  ShopLoginSuccessStates(this.loginmodel);
 }
 class ShopLoginLoadingStates extends ShopLoginStates{}
 class OnSuffixPressedStates extends ShopLoginStates{}
 class ShopLoginErrorStates extends ShopLoginStates{
  final String error;

  ShopLoginErrorStates(this.error);
 }