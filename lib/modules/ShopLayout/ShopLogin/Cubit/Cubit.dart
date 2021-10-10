import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemyshopapp/models/loginmodel.dart';
import 'package:udemyshopapp/modules/ShopLayout/ShopLogin/Cubit/states.dart';

import 'package:udemyshopapp/network/endpoint.dart';
import 'package:udemyshopapp/network/local/dioHelper.dart';

class LoginCubit extends Cubit<ShopLoginStates>{

  LoginCubit() : super(ShopLoginInitialStates());
  static LoginCubit get(context)=>BlocProvider.of(context);
  ShopLoginModel ?model;

  void UserLogin({required String email,required String password}){
    emit(ShopLoginLoadingStates());
    DioHelper.postData(url: LOGIN, data:{
      'email':'${email}',
      'password':"${password}"

    }).then((value) {
      model=ShopLoginModel.fromJson(value.data);

      emit(
          ShopLoginSuccessStates(model!));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorStates(error.toString()));
    });
  }
  IconData suffix=Icons.visibility_outlined;
  bool isPassword=false;
  void onSuffixPressed(){
    isPassword=!isPassword;
    suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(OnSuffixPressedStates());


  }
}