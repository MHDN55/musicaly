import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:music_app/Features/Home/presentation/blocs/permission/permission_bloc.dart';
import 'package:music_app/Features/Home/presentation/widgets/zoom_drower/main_screen/main_screen_widget.dart';
import 'package:music_app/Features/Home/presentation/widgets/zoom_drower/menu_screen/menu_screen_widget.dart';
import 'package:music_app/core/widgets/loading_widget.dart';
import 'package:music_app/injection_injectable_package.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final OnAudioQuery audioQuery = getIt<OnAudioQuery>();

final PermissionBloc permissionBloc = getIt<PermissionBloc>();

final ZoomDrawerController zoomDrawerController = ZoomDrawerController();

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    permissionBloc.add(CheckAndRequestPermissionsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PermissionBloc, PermissionState>(
      bloc: permissionBloc,
      builder: (context, state) {
        if (state.status == PermissionStatusb.loaded) {
          return ZoomDrawer(
            mainScreen: MainScreenWidget(controller: zoomDrawerController),
            menuScreen: MenuScreenWidget(controller: zoomDrawerController),
            menuBackgroundColor: Theme.of(context).colorScheme.surface,
            controller: zoomDrawerController,
            androidCloseOnBackTap: true,
            borderRadius: 25,
            angle: 0,
            showShadow: true,
            slideWidth: 360.w * 0.65,
            duration: const Duration(milliseconds: 500),
            openCurve: Curves.fastOutSlowIn,
            closeCurve: Curves.bounceIn,
          );
        } else if (state.status == PermissionStatusb.error) {
          return Scaffold(
            body: Center(
              child: SizedBox(
                height: 100.h,
                width: 200.w,
                child: Column(
                  children: [
                    Text(
                      "No Permission Access",
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(height: 20.h),
                    MaterialButton(
                      color: Colors.red,
                      onPressed: () async {
                        await openAppSettings();
                        permissionBloc.add(CheckAndRequestPermissionsEvent());
                      },
                      child: const Text("Settings"),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state.status == PermissionStatusb.loading) {
          return const LoadingWidget();
        } else {
          return const LoadingWidget();
        }
      },
    );
  }
}
