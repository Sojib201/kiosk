import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SidebarItem extends StatelessWidget {
  const SidebarItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        //padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
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
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),
              child: Image.asset(
                "assets/burger1.png",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              "Sushi Roll",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),),
            SizedBox(height: 4.h),
          ],
        ) ,
      ),
    );
  }
}