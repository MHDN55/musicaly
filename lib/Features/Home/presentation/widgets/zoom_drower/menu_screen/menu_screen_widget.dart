// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:go_router/go_router.dart';

import 'package:music_app/core/routes/app_route_const.dart';

class MenuScreenWidget extends StatelessWidget {
  final ZoomDrawerController? controller;
  const MenuScreenWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 100.h),
          child: Center(
            child: Icon(
              Icons.music_note_rounded,
              size: 60.w,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 25.h, left: 10.w),
          child: MaterialButton(
            height: 50.h,
            onPressed: () {
              controller?.close!();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.home_rounded),
                Text(
                  "H O M E",
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(width: 28.w),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 10.h,
            left: 10.w,
          ),
          child: MaterialButton(
            height: 50.h,
            onPressed: () {
              controller?.close!();
              (context).pushNamed(MyAppRouteConst.settingsPage);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.settings_rounded),
                Text(
                  "S E T T I N G S",
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
