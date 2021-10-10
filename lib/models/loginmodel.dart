class ShopLoginModel{
  bool ?status;
  String ?message;
 UserData ?data;
  ShopLoginModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data=json['data']!=null?UserData.fromJson(json['data']):null;

  }

}
class UserData{
  int ?id;
  String ?name;
  String ?email;
  String ?phone;
  String ?image;
 late String token;
  int ?points;
  int ?credit;
  UserData(this.id,this.name,this.email,this.phone,this.image,this.points,this.credit,this.token);
  UserData.fromJson(Map<String,dynamic>json){
     id=json['id'];
     name=json['name'];
     email=json['email'];
     points=json['points'];
     credit=json['credit'];
     token=json['token'];
  }
}