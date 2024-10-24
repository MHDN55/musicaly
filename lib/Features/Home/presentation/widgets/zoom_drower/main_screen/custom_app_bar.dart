import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class CustomMainAppBarWidget extends StatelessWidget {
  const CustomMainAppBarWidget({
    super.key,
    required this.controller,
  });

  final ZoomDrawerController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        height: 60.h,
        width: 360.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                controller?.toggle!();
              },
              icon: const Icon(Icons.menu_rounded),
            ),
            Padding(
              padding: EdgeInsets.only(right: 144.w),
              child: Text(
                "H O M E",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
