import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:udemyshopapp/modules/ShopLayout/ShopLogin/ShopLoginScreen.dart';

import 'package:udemyshopapp/network/remote/Cache_helper.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.body, required this.title});
}

bool islast = false;

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        image: "assets/image/44.jpg",
        body: "onBoard 1 Title",
        title: "On Board 1 Body"),
    BoardingModel(
        image: "assets/image/1.jpg",
        body: "onBoard 2 Title",
        title: "On Board 2 Body"),
    BoardingModel(
        image: "assets/image/2.jpg",
        body: "onBoard 3 Title",
        title: "On Board 3 Body"),
  ];

  var BoardControllor = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(onPressed: () {
              CacheHelper.setData(value:true, key: 'onBoarding').then((value) {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context)=>ShopLoginScreen()),
                        (route) => false);
              });

            },
            child: Text("Skip"),),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        islast = true;
                        print("is last");
                      });
                    } else {
                      setState(() {
                        islast = false;
                        print("not last");
                      });
                    }
                  },
                  controller: BoardControllor,
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: BoardControllor,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5,
                        activeDotColor: Colors.teal),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (islast) {
                        CacheHelper.setData(value:true, key: 'onBoarding').then((value) {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context)=>ShopLoginScreen()),
                                  (route) => false);
                        });

                      }
                      BoardControllor.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  Widget buildBoardingItem(BoardingModel Model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(image: AssetImage(Model.image)),
          ),
          Text(
            Model.title,
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            Model.body,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      );
}
