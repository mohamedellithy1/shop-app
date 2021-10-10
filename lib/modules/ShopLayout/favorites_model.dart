import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemyshopapp/models/GetFavorites.dart';
import 'package:udemyshopapp/modules/ShopLayout/shopLayoutCubit/Cubit.dart';
import 'package:udemyshopapp/modules/ShopLayout/shopLayoutCubit/States.dart';

class FavouriteScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildFavouriteItem(ShopCubit.get(context).getFavoritesModel!.data!.data![index], context),
            separatorBuilder: (context, index) =>
                Container(
                  color: Colors.grey[300],
                  height: 1,
                ),
            itemCount: ShopCubit.get(context).getFavoritesModel!.data!.data!.length);
      },
    );
  }
}
  Widget buildFavouriteItem(FavoritesData model, context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image:
                  NetworkImage(model.product!.image!
                  ), height: 120, width: 120,),
                if(model.product!.discount != 0)
                  Container(
                      color: Colors.red,
                      child: Text("Discount ", style:
                      TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),)),

              ],),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(model.product!.name!, maxLines: 2,
                    overflow: TextOverflow.ellipsis, style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                ),
                Row(
                  children: [
                    Text(model.product!.price.toString(), style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),),
                    SizedBox(width: 10,),
                    if(model.product!.discount != 0)
                      Text(model.product!.oldPrice.toString(), style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          backgroundColor: ShopCubit.get(context).favorites[model.product!.id]! ? Colors.blue : Colors.grey,

                          child: IconButton(icon: Icon(
                            Icons.favorite_border, color: Colors.white,),
                              onPressed: () {
                                ShopCubit.get(context).changeFavorites(
                                    model.product!.id!);
                              })),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],

      );
