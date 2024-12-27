// /**
//  * Author: Damodar Lohani
//  * profile: https://github.com/lohanidamodar
//   */

// import 'package:flutter/material.dart';


// class SettingsTwoPage extends StatelessWidget {
//    TextStyle blackText = TextStyle(
//   color: Colors.black,
// );

//  TextStyle buttonText = TextStyle(fontSize: 16.0);
// TextStyle linkText = TextStyle(
//   fontSize: 16.0,
//   fontWeight: FontWeight.bold,
//   color: Colors.indigo,
// );

// final TextStyle shadedTitle = TextStyle(
//     fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.grey.shade600);



//   static const String path = "lib/src/pages/settings/settings2.dart";
//   final TextStyle whiteText = const TextStyle(
//     color: Colors.white,
//   );
//   final TextStyle greyTExt = TextStyle(
//     color: Colors.grey.shade400,
//   );

//   SettingsTwoPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Theme(
//         data: Theme.of(context).copyWith(
//           brightness: Brightness.dark,
//           primaryColor: Colors.purple,
//         ),
//         child: DefaultTextStyle(
//           style: const TextStyle(
//             color: Colors.white,
//           ),
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(32.0),
//             child: Column(
//               children: <Widget>[
//                 const SizedBox(height: 30.0),
//                 Row(
//                   children: <Widget>[
//                     Container(
//                       width: 60,
//                       height: 60,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                         // image: DecorationImage(
//                         //   image: NetworkImage(avatars[1]),
//                         //   fit: BoxFit.cover,
//                         // ),
//                         border: Border.all(
//                           color: Colors.white,
//                           width: 2.0,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10.0),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           const Text(
//                             "Jane Doe",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20.0,
//                             ),
//                           ),
//                           Text(
//                             "Nepal",
//                             style: TextStyle(
//                               color: Colors.grey.shade400,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20.0),
//                 ListTile(
//                   title: const Text(
//                     "Languages",
                   
//                   ),
//                   subtitle: Text(
//                     "English US",
//                     style: greyTExt,
//                   ),
//                   trailing: Icon(
//                     Icons.keyboard_arrow_right,
//                     color: Colors.grey.shade400,
//                   ),
//                   onTap: () {},
//                 ),
//                 ListTile(
//                   title: const Text(
//                     "Profile Settings",
                  
//                   ),
//                   subtitle: Text(
//                     "Jane Doe",
//                     style: greyTExt,
//                   ),
//                   trailing: Icon(
//                     Icons.keyboard_arrow_right,
//                     color: Colors.grey.shade400,
//                   ),
//                   onTap: () {},
//                 ),
//                 SwitchListTile(
//                   title: const Text(
//                     "Email Notifications",
                  
//                   ),
//                   subtitle: Text(
//                     "On",
//                     style: greyTExt,
//                   ),
//                   value: true,
//                   onChanged: (val) {},
//                 ),
//                 SwitchListTile(
//                   title: const Text(
//                     "Push Notifications",
                  
//                   ),
//                   subtitle: Text(
//                     "Off",
//                     style: greyTExt,
//                   ),
//                   value: false,
//                   onChanged: (val) {},
//                 ),
//                 ListTile(
//                   title: const Text(
//                     "Logout",
                  
//                   ),
//                   onTap: () {},
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }