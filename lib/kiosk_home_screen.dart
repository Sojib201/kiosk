import 'dart:ui';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodKioskScreen extends StatelessWidget {
  const FoodKioskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final List<String> imageUrls = [
      'https://picsum.photos/id/1018/400/250',
      'https://picsum.photos/id/1015/400/250',
      'https://picsum.photos/id/1019/400/250',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Expanded(
                //   flex:6,
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(16),
                //     child: Image.asset(
                //       "assets/3DineBase.png",
                //       //width: double.infinity,
                //       fit: BoxFit.fill,
                //       height: 50,
                //     ),
                //   ),
                // ),

                Expanded(
                  flex: 6,
                  child: _Logo(),
                ),

                Expanded(
                  flex: 3,
                  child: _SearchField(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(12)),
                  width: size.width * 0.25,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        child: _sidebarItem("Burgers", "assets/burger.png"),
                      );
                    },
                  ),
                ),

                // Main Area
                Expanded(

                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                          height: 200.0,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.9,
                          aspectRatio: 16 / 9,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                        ),
                        items: imageUrls.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 4.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.green.withOpacity(0),
                                  image: DecorationImage(
                                    image: NetworkImage(i),
                                  ),
                                ),
                                alignment: Alignment.center,
                              );
                            },
                          );
                        }).toList(),
                      ),

                      //HomeBannerSlider(),
                      //ProductIamgeSlider(),

                      // Category Chips
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          height: 30,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 8,
                            itemBuilder: (context, index) {
                              return Container(
                                //height: 20,
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.5
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text('Halal'),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "All Items",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 8),


                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GridView.builder(
                            itemCount: 12,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 18,
                              crossAxisSpacing: 18,
                              childAspectRatio: 0.75,
                            ),
                            itemBuilder: (context, index) {
                              return _FoodCard();
                            },
                          ),
                        ),
                      ),

                      // Bottom Bar
                      Container(
                        height: 90,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color: Colors.black.withOpacity(0.05),
                            ),
                          ],
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20)),
                        ),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.deepOrange),
                              ),
                            ),
                            const Spacer(),
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    "Your Order",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    "2   \$50.50",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrange,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: const Text("Order",
                                  style: TextStyle(fontSize: 18)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }

  Widget _sidebarItem(
    String title,
    String imagePath,
  ) {
    return GestureDetector(
      onTap: (){},
        // child: Column(
        //   children: [
        //     ClipRRect(
        //       borderRadius: BorderRadius.circular(16),
        //       child: Image.asset(
        //         imagePath,
        //         width: double.infinity,
        //         // width: 10,
        //         height: 70,
        //         fit: BoxFit.fill,
        //       ),
        //     ),
        //     const SizedBox(height: 8),
        //     Text(
        //       title,
        //       textAlign: TextAlign.center,
        //       style: const TextStyle(color: Colors.white, fontSize: 13),
        //     ),
        //   ],
        // ),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6,
                spreadRadius: 0,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child:Column(
            children: [
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(16),
              //   child: Image.asset(
              //     "assets/pizza.png",
              //     width: double.infinity,
              //     fit: BoxFit.fill,
              //   ),
              // ),
              Stack(
                  children: [
                    Opacity(
                      opacity: 0.3,
                      child: SizedBox(
                        child:  Image.asset(
                          "assets/pizza.png",
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: -60.w, sigmaY: 0.h),
                        child: Image.asset(
                          "assets/pizza.png",
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ]
              ),
              SizedBox(height: 2.h),
              Text(
                "Sushi Roll",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                             ),
            ],
          ) ,
        ),
    );
  }


}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.deepOrange,
        ),
        children: [
          TextSpan(text: "3"),
          TextSpan(
            text: "DineBase",
            style: TextStyle(color: Colors.brown),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          suffixIcon: const Icon(
            Icons.search,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.black, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.black, width: 0.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.black, width: 0.5),
          ),
        ),
      ),
    );
  }
}

class _FoodCard extends StatelessWidget {
  const _FoodCard();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('xx');
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              spreadRadius: 0,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.3,
                    child: SizedBox(
                      child:  Image.asset(
                        "assets/pizza.png",
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: -60.w, sigmaY: 0.h),
                      child: Image.asset(
                        "assets/pizza.png",
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ]
              ),
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '20 min',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  '⭐ 4.5',
                  style: TextStyle(fontSize: 12, color: Colors.black87),
                )
              ],
            ),
            const SizedBox(height: 2),
            const Text(
              "Sushi Roll",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "\$5.50",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.add_circle_outline,
                    size: 15.h,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
