import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/core/theme/app_theme.dart';
import 'package:music_app/core/theme/theme_bloc/theme_bloc.dart';
import 'package:music_app/injection_injectable_package.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  ThemeBloc themeBloc = getIt<ThemeBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("S E T T I N G S"),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.tertiary,
                  blurRadius: 10,
                  offset: const Offset(4, 4),
                ),
                BoxShadow(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  blurRadius: 10,
                  offset: const Offset(-4, -4),
                ),
              ],
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.secondary,
            ),
            padding: EdgeInsets.all(16.h),
            margin: EdgeInsets.all(20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Theme : ",
                  style: TextStyle(fontSize: 16.sp),
                ),
                MaterialButton(
                  minWidth: 60.w,
                  color: Colors.white,
                  onPressed: () {
                    themeBloc.add(
                      ThemeChangedEvent(
                        theme: AppTheme.values[1],
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "Light Mode",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                MaterialButton(
                  minWidth: 60.w,
                  color: Colors.black,
                  onPressed: () {
                    themeBloc.add(
                      ThemeChangedEvent(
                        theme: AppTheme.values[0],
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "Dark Mode",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
