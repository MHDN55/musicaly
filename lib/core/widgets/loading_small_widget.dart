import 'package:flutter/material.dart';

class LoadingSmallWidget extends StatelessWidget {
  const LoadingSmallWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Center(
          child: SizedBox(
        height: 15,
        width: 15,
        child: CircularProgressIndicator( color: Color(0xff849DFE)),
      )),
    );
  }
}
