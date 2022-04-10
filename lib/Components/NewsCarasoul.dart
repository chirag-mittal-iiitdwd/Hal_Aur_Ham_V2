import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../Model/NewsItems.dart';

class NewsCarasoul extends StatefulWidget {
  @override
  State<NewsCarasoul> createState() => _NewsCarasoulState();
}

class _NewsCarasoulState extends State<NewsCarasoul> {
  var activeIndex = 0;
  final controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    final newsData = Provider.of<NewsItems>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        color: Color(0xffFFDFB0),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                controller.previousPage();
              },
              icon: Icon(
                Icons.navigate_before,
              ),
            ),
            Expanded(
              child: CarouselSlider.builder(
                carouselController: controller,
                itemCount: newsData.items.length,
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Center(
                      child: Text(newsData.items[index].news),
                    ),
                  );
                },
                options: CarouselOptions(
                  initialPage: 0,
                  height: 128.h,
                  enlargeCenterPage: true,
                  // enableInfiniteScroll: false,
                  onPageChanged: (index, reason) => {
                    setState(
                      () => {
                        activeIndex = index,
                      },
                    ),
                  },
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                controller.nextPage();
              },
              icon: Icon(
                Icons.navigate_next,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
