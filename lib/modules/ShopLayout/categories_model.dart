import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemyshopapp/models/CategoriesModel.dart';
import 'package:udemyshopapp/modules/ShopLayout/shopLayoutCubit/Cubit.dart';
import 'package:udemyshopapp/modules/ShopLayout/shopLayoutCubit/States.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
            separatorBuilder: (context, index) => Container(
                  color: Colors.grey[300],
                  height: 1,
                ),
            itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length);
      },
    );
  }

  Widget buildCatItem(DataModelC model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image!),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Text(
                model.name!,

                style: TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold,),
              ),
            ),

            Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
}
