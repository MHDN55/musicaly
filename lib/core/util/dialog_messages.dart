import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:music_app/core/widgets/loading_widget.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomDialog {
  void showMessageDialog({
    required BuildContext context,
    required String message,
    required bool isDetails,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            height: 150.h,
            width: 250.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 10,
                  offset: const Offset(4, 4),
                ),
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10,
                  offset: const Offset(-4, -4),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 45.h),
                      child: Text(
                        message,
                        style: TextStyle(
                          fontSize: 17.sp,
                        ),
                      ),
                    ),
                    isDetails
                        ? MaterialButton(
                            onPressed: () {},
                            child: const Text(
                              "View Cart",
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.h, right: 10.w),
                    child: GestureDetector(
                      onTap: () {
                        (context).pop();
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showLoadingDialog({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) {
        return const LoadingWidget();
      },
    );
  }

  void showPermissionDialog({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Permisson Denied"),
          content: const Text("Allow access to media"),
          actions: [
            MaterialButton(
              onPressed: () {
                context.pop();
              },
              child: const Text("Cancel"),
            ),
            MaterialButton(
              onPressed: () {
              openAppSettings();
              },
              child: const Text("Settings"),
            ),
          ],
        );
      },
    );
  }
}
