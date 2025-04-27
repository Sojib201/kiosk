import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kiosk/widgets/home_banner_slider.dart';
import 'package:kiosk/widgets/product_image_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<String> imageUrls = [
    'https://picsum.photos/id/1018/400/250',
    'https://picsum.photos/id/1015/400/250',
    'https://picsum.photos/id/1019/400/250',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(
      //   child: CarouselSlider(
      //     options: CarouselOptions(
      //       height: 200.0,
      //       autoPlay: true,
      //       enlargeCenterPage: true,
      //       viewportFraction: 0.9,
      //       aspectRatio: 16 / 9,
      //       autoPlayInterval: Duration(seconds: 3),
      //       autoPlayAnimationDuration: Duration(milliseconds: 800),
      //     ),
      //     items: imageUrls.map((i) {
      //       return Builder(
      //         builder: (BuildContext context) {
      //           return Container(
      //             width: MediaQuery.of(context).size.width,
      //             margin: EdgeInsets.symmetric(horizontal: 4.0),
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(5),
      //               color: Colors.green.withOpacity(0),
      //               image: DecorationImage(image: NetworkImage(i),),),
      //             alignment: Alignment.center,
      //           );
      //         },
      //       );
      //     }).toList(),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
              children: [
                HomeBannerSlider(
                  imageAssets: imageUrls,
                  onTap: (){},
                ),
                // ProductIamgeSlider()
              ],

          ),
        ),
      ),
    );
  }
}
