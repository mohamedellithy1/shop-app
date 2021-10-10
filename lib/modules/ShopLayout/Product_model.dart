import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:udemyshopapp/models/CategoriesModel.dart';
import 'package:udemyshopapp/models/HomeModel.dart';
import 'package:udemyshopapp/modules/ShopLayout/shopLayoutCubit/Cubit.dart';
import 'package:udemyshopapp/modules/ShopLayout/shopLayoutCubit/States.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Conditional.single(
            context: context,
            conditionBuilder: (context) =>
            ShopCubit.get(context).homeModel != null&&
                ShopCubit.get(context).categoriesModel != null,
            widgetBuilder: (context) =>
                productBuilder(
                    ShopCubit.get(context).homeModel!,
                    ShopCubit.get(context).categoriesModel!,context),
            fallbackBuilder: (context) =>
                Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget productBuilder(HomeDataModel model,
      CategoriesModel categoriesModel,context
     ) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items: model.data!.banners
                .map((e) => Image(
              image: NetworkImage('${e.image}'),
              width: double.infinity,
              fit: BoxFit.cover,
            ))
                .toList(),
            options: CarouselOptions(
              height: 225,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.easeIn,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1,
            )),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Categories",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w300),),
              SizedBox(
                height: 5,
              ),
               Container(
                 height: 100,
                 child: ListView.separated(
                   physics: BouncingScrollPhysics(),
                   scrollDirection: Axis.horizontal,
                     itemBuilder: (context,index)=>buildCategoriesItem(categoriesModel.data!.data[index] ),
                     separatorBuilder:  (context,index)=>SizedBox(width: 5,),
                     itemCount:categoriesModel.data!.data.length ),
               ),
              SizedBox(
                height: 10,
              ),
              Text("New Product",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w300),),
            ],
          ),
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1 / 1.7,
            children: List.generate(model.data!.products.length,
                    (index) => buildGridProduct(model.data!.products[index],context)),
          ),
        ),
      ],
    ),
  );
  Widget buildCategoriesItem(DataModelC model)=>  Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children:
    [
      Image(image: NetworkImage(model.image!),
        height:100,
        width: 100 ,
        fit: BoxFit.cover,),
      Container(
          width: 100,
          color: Colors.black.withOpacity(.8),
          child: Text("${model.name}",style:
          TextStyle(color: Colors.white),
            textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,)),

    ],);
  Widget buildGridProduct(ProductsData model,context) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image!),
              height: 200.0,
              width: double.infinity,
            ),
            if (model.discount != 0)
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  color: Colors.red,
                  child: Text(
                    "DISCOUNT",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Colors.white),
                  )),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  height: 1.3,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "  ${model.price!}EG ",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      height: 1.3,
                      fontSize: 12.0,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  if (model.discount != 0)
                    Text(
                      "  ${model.old_price.round()}EG",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        height: 1.3,
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  CircleAvatar(
                    backgroundColor: ShopCubit.get(context).favorites[model.id]!?Colors.blue:Colors.grey,
                    child: IconButton(
                        icon: Icon(Icons.favorite_border,color: Colors.white,),
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id!);
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
