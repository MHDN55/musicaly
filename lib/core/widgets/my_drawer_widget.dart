import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:music_app/core/routes/app_route_const.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Icon(
                Icons.music_note_rounded,
                size: 60.w,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25.h, left: 15.w,right: 10.w ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text("H O M E"),
              leading: const Icon(Icons.home_rounded),
              onTap: () {
                (context).pop();
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.w,right: 10.w),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text("S E T T I N G S"),
              leading: const Icon(Icons.settings_rounded),
              onTap: () {
                (context).pop();
                (context).pushNamed(MyAppRouteConst.settingsPage);
              },
            ),
          ),
        ],
      ),
    );
  }
}
