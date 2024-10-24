// import 'package:flutter/material.dart';
// import 'package:music_app/Features/Home/presentation/pages/home_page.dart';

// class NoAccessToLibraryWidget extends StatelessWidget {
//   const NoAccessToLibraryWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: Theme.of(context).colorScheme.secondary,
//         ),
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text("Application doesn't have access to the library"),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               style: ButtonStyle(
//                 backgroundColor: WidgetStatePropertyAll(
//                   Theme.of(context).colorScheme.tertiary,
//                 ),
//               ),
//               onPressed: () {
//                 musicBloc.add(CheckAndRequestPermissionsEvent());
//               },
//               child: const Text("Allow"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
