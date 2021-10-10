import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemyshopapp/Shared/constant.dart';
import 'package:udemyshopapp/models/CategoriesModel.dart';
import 'package:udemyshopapp/models/FavoriteModel.dart';
import 'package:udemyshopapp/models/GetFavorites.dart';
import 'package:udemyshopapp/models/HomeModel.dart';
import 'package:udemyshopapp/modules/ShopLayout/categories_model.dart';
import 'package:udemyshopapp/modules/ShopLayout/favorites_model.dart';

import 'package:udemyshopapp/modules/ShopLayout/shopLayoutCubit/States.dart';
import 'package:udemyshopapp/network/endpoint.dart';
import 'package:udemyshopapp/network/local/dioHelper.dart';

import '../change_favorites_model.dart';
import '../Product_model.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  void onChangeBottomNav(int index) {
    currentIndex = index;
    emit(onChangeBottomNavState());
  }

  List<Widget> screen = [
    HomeScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingScreen(),
  ];
  List<BottomNavigationBarItem> BottomNavBarItem = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: "Categories"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
  ];
  Map<int, bool> favorites = {};

  HomeDataModel? homeModel;
  void getHomeData() {
    emit(ShopLoadingHomeDataStates());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeDataModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({element.id!: element.in_favorites!});
      });
      print(favorites);

      emit(ShopSuccessHomeDataStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataStates());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(url: GET_GATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesStates());
    });
  }


   ChangeFavouriteModel ?changeFavouriteModel;
  void changeFavorites(int productId) {
    favorites[productId]=!favorites[productId]!;
    emit(ShopSuccessChangeFavoritesStates());
    DioHelper.postData(
            url: FAVORITE, data: {'product_id': productId}, token: token)
        .then((value) {
      changeFavouriteModel= ChangeFavouriteModel.fromJson(value.data);
      if(changeFavouriteModel!.status!=true){
        favorites[productId]=!favorites[productId]!;
      }
      // else{
      //   getFavoritesData();
      // }
      print(changeFavouriteModel!.message);

      emit(ShopSuccessChangeFavoritesStates());


    }).catchError((onError) {
      favorites[productId]=!favorites[productId]!;
      emit(ShopErrorChangeFavoritesStates());
    });
  }

  GetFavoritesModel ?getFavoritesModel;
  void  getFavoritesData() {
    emit(ShopLoadingGetFavoritesStates());
    DioHelper.getData(url: FAVORITE,token: token).then((value) {
      getFavoritesModel = GetFavoritesModel.fromJson(value.data);
      print(getFavoritesModel!.data!.currentPage);
      emit(ShopSuccessGetFavoritesStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesStates());
    });
  }

}
