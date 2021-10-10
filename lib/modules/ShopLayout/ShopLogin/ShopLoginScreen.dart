import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:udemyshopapp/Shared/component.dart';
import 'package:udemyshopapp/modules/ShopLayout/ShopLayout.dart';

import 'package:udemyshopapp/network/remote/Cache_helper.dart';

import 'Cubit/Cubit.dart';
import 'Cubit/states.dart';



class ShopLoginScreen extends StatelessWidget {
  const ShopLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey=GlobalKey<FormState>();
    var EmailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccessStates){
            if(state.loginmodel.status==true){
              print(state.loginmodel.message);
              CacheHelper.setData(value: "${state.loginmodel.data!.token}", key: "token").then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShopLayoutScreen()),
                        (route) => false);
              });
              showToast(text:" ${state.loginmodel.message}", state: ToastStates.SUCCESS);
            }
            else
              {
                print(state.loginmodel.message);
                showToast(text:" ${state.loginmodel.message}", state: ToastStates.ERROR);

              }

          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                        image: AssetImage("assets/image/login.jpg"),
                      ),
                      Text(
                        "LOGIN",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text("Login now to browse our hot offers",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey)),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: EmailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) return "Email must not be empty";
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(

                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: LoginCubit.get(context).isPassword,

                        onFieldSubmitted: (value){
                          if(formKey.currentState!.validate()){

                          }
                          LoginCubit.get(context).UserLogin(email: EmailController.text, password: passwordController.text);
                        },

                        // onFieldSubmitted: (){},
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(icon:Icon (LoginCubit.get(context).suffix),
                              onPressed: (){
                            LoginCubit.get(context).onSuffixPressed();
                             }),
                        ),

                        validator: (String? value) {
                          if (value!.isEmpty) return "Password must not be empty";
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      state is ShopLoginLoadingStates
                              ? Center(child: CircularProgressIndicator())
                              :Container(
                          width: double.infinity,
                          color: Colors.teal,
                          child:  MaterialButton(
                                  onPressed: () {
                                    if(formKey.currentState!.validate()){
                                      LoginCubit.get(context).UserLogin(email: EmailController.text, password: passwordController.text);

                                    }
                                  },
                                  child: Text("LOGIN"),
                                )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Dont\'t have an account ?"),
                          TextButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShopLayoutScreen()),
                                    (route) => false);
                              },
                              child: Text("Register now"))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
