import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeBannerSlider extends StatelessWidget {
  HomeBannerSlider({super.key});

  final CarouselController _carouselController = CarouselController();
  final ValueNotifier<int> CurrentSelectedIndex = ValueNotifier(0);
  final List<String> imageUrls = [
    'https://picsum.photos/id/1018/400/250',
    'https://picsum.photos/id/1019/400/250',
    'https://picsum.photos/id/1015/400/250',
    'https://picsum.photos/id/1018/400/250',
    'https://picsum.photos/id/1019/400/250',
  ];



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          //carouselController: _carouselController,
          options: CarouselOptions(
            pauseAutoPlayOnTouch: true,
              //autoPlayInterval: Duration(seconds: 3),
              autoPlayCurve: Curves.fastLinearToSlowEaseIn,

              height: 180.0,
              autoPlay: true,
              viewportFraction: 0.84,
              onPageChanged: (index, _) {
                CurrentSelectedIndex.value = index;
              }),
          items: imageUrls.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.green.withOpacity(0),
                    image: DecorationImage(image: NetworkImage(i),),),
                  alignment: Alignment.center,
                );
              },
            );
          }).toList(),
        ),
        SizedBox(
          height: 5,
        ),
        ValueListenableBuilder(
          valueListenable: CurrentSelectedIndex,
          builder: (context, updateValue, _) {
            if (imageUrls.isEmpty) {
              return Center(child: Text("No data available"));
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < (imageUrls.length); i++)
                  Container(
                    margin: EdgeInsets.all(3),
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      color: i == CurrentSelectedIndex.value
                          ? Colors.green
                          : null,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: i == CurrentSelectedIndex.value
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
