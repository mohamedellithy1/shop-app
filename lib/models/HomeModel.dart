class HomeDataModel{
  bool ?status;
  String ?message;
  DataModel ?data;
  HomeDataModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data=DataModel.fromJson(json['data']);
  }


}
class DataModel{
  List<Banners>banners=[];
  List<ProductsData>products=[];
  DataModel.fromJson(Map<String,dynamic>json){
    json["banners"].forEach((element) {
      banners.add(Banners.fromJson(element));
    });
    json["products"].forEach((element) {
      products.add(ProductsData.fromJson(element));
    });

}
}
class Banners{
 int ?id;
 String ?image;
 Banners.fromJson(Map<String,dynamic>json){
   id=json['id'];
   image=json['image'];
 }
}
class ProductsData{
  int ?id;
  dynamic ?price;
dynamic ?old_price;
  dynamic ?discount;
  String ?image;
  String ?name;
  bool ?in_favorites;
  bool ?in_cart;
  ProductsData.fromJson(Map<String,dynamic>json){
    id=json['id'];
    price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    in_favorites=json['in_favorites'];
    in_cart=json['in_cart'];

  }
}