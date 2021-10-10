import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemyshopapp/modules/ShopLayout/search_model.dart';
import 'package:udemyshopapp/modules/ShopLayout/shopLayoutCubit/Cubit.dart';
import 'package:udemyshopapp/modules/ShopLayout/shopLayoutCubit/States.dart';



class ShopLayoutScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){

      },
      builder: (context,state){
        var Cubit=ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title:Text("Salla",style: TextStyle(color: Colors.black),) ,
            actions: [
              IconButton(icon: Icon(Icons.search), 
                  onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
                  })
            ],
          ),
          body:Cubit.screen[Cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: Cubit.currentIndex,
            onTap: (index){
              Cubit.onChangeBottomNav(index);
            },
            items: Cubit.BottomNavBarItem,


          ),
        );
      },
    );




  }
}
