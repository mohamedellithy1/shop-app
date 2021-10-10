import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemyshopapp/modules/ShopLayout/shopLayoutCubit/Cubit.dart';
import 'package:udemyshopapp/modules/ShopLayout/shopLayoutCubit/States.dart';

import 'package:udemyshopapp/modules/on_boarding_screen/onBoardingScreen.dart';
import 'package:udemyshopapp/network/remote/Cache_helper.dart';
import 'package:udemyshopapp/styles/themes.dart';

import 'Shared/BlocObserver.dart';
import 'Shared/constant.dart';
import 'modules/ShopLayout/ShopLayout.dart';
import 'modules/ShopLayout/ShopLogin/ShopLoginScreen.dart';
import 'network/local/dioHelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool ?onBoardingValue = CacheHelper.getData(key: "onBoarding");
  token = CacheHelper.getData(key: "token");
  print(token);
  if (onBoardingValue != null) {
    if (token != null)
      widget = ShopLayoutScreen();
    else
      widget = ShopLoginScreen();
  } else
    widget = OnBoardingScreen();

  runApp(MyApp(
    onBoarding: onBoardingValue,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? onBoarding;
  Widget? startWidget;

  MyApp({this.onBoarding, this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData(),
      child:   BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){

        },
              builder: (context,state){
          return      MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: startWidget,
            ),
            theme: LightTheme,
            darkTheme: darkTheme,
          );
        },

      ),


    );
  }
}
