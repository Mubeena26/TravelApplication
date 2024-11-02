import 'package:flutter/material.dart';

// class Tour extends StatelessWidget {
//   const Tour({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Sample data for the items
//     final items = [
//       {'title': 'Mountain', 'location': 'Thailand', 'rating': '⭐ 48'},
//       {'title': 'Beach', 'location': 'Maldives', 'rating': '⭐ 52'},
//       {'title': 'Desert', 'location': 'Dubai', 'rating': '⭐ 45'},
//       {'title': 'Forest', 'location': 'Amazon', 'rating': '⭐ 50'},
//     ];

//     // Additional data for the vertical list
//     final popularDestinations = [
//       {'title': 'Malaysia', 'dates': '12-02-2024 : 23-02-2024'},
//       {'title': 'Japan', 'dates': '10-05-2024 : 20-05-2024'},
//       {'title': 'Australia', 'dates': '15-07-2024 : 25-07-2024'},
//       {'title': 'Switzerland', 'dates': '01-09-2024 : 10-09-2024'},
//       {'title': 'Switzerland', 'dates': '01-09-2024 : 10-09-2024'},
//     ];

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 244, 254, 255),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 70),
//               child: SizedBox(
//                 height: 232,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: items.length,
//                   itemBuilder: (context, index) {
//                     final item = items[index];
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       child: Container(
//                         height: 232,
//                         width: 233,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: Colors.white,
//                         ),
//                         child: Column(
//                           children: [
//                             // Image Container
//                             Container(
//                               width: 208,
//                               height: 157,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 color: Colors.white,
//                               ),
//                               child: Image.asset(
//                                 'assets/Mask group.png',
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             // Row for Package Name and Review
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 25, vertical: 5),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         item['title']!,
//                                         style: const TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w400,
//                                             color: Color.fromARGB(
//                                                 255, 66, 88, 132)),
//                                       ),
//                                       Text(
//                                         item['location']!,
//                                         style: const TextStyle(
//                                             fontSize: 10,
//                                             color: Color.fromARGB(
//                                                 255, 66, 88, 132)),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 30, vertical: 10),
//                                   child: Container(
//                                     width: 42,
//                                     height: 18,
//                                     decoration: BoxDecoration(
//                                         color: Colors.grey,
//                                         borderRadius:
//                                             BorderRadius.circular(20)),
//                                     child: Center(
//                                       child: Text(
//                                         item['rating']!,
//                                         style: const TextStyle(fontSize: 10),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 1),
//               child: Row(
//                 children: const [
//                   Text(
//                     'Popular',
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                         color: Color.fromARGB(255, 66, 88, 132)),
//                   ),
//                   SizedBox(
//                     width: 50,
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 10, top: 10),
//               child: SizedBox(
//                 height: 300, // Adjust based on the total height you want
//                 child: ListView.builder(
//                   itemCount: popularDestinations.length,
//                   itemBuilder: (context, index) {
//                     final destination = popularDestinations[index];
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                       child: Container(
//                         width: 331,
//                         height: 70,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colors.white,
//                         ),
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 10),
//                               child: Container(
//                                 width: 51,
//                                 height: 56,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.blue,
//                                 ),
//                                 child: Image.asset(
//                                   'assets/Mask group (1).png',
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 5),
//                             Expanded(
//                               child: ListTile(
//                                 title: Text(
//                                   destination['title']!,
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 18,
//                                       color: Color.fromARGB(255, 66, 88, 132)),
//                                 ),
//                                 subtitle: Text(
//                                   destination['dates']!,
//                                   style: const TextStyle(
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.normal,
//                                       color: Color.fromARGB(255, 66, 88, 132)),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class TourScreen extends StatelessWidget {
  const TourScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      {'title': 'Mountain', 'location': 'Thailand', 'rating': '⭐ 48'},
      {'title': 'Beach', 'location': 'Maldives', 'rating': '⭐ 52'},
      {'title': 'Desert', 'location': 'Dubai', 'rating': '⭐ 45'},
      {'title': 'Forest', 'location': 'Amazon', 'rating': '⭐ 50'},
    ];
    final popularDestinations = [
      {'title': 'Malaysia', 'dates': '12-02-2024 : 23-02-2024'},
      {'title': 'Japan', 'dates': '10-05-2024 : 20-05-2024'},
      {'title': 'Australia', 'dates': '15-07-2024 : 25-07-2024'},
      {'title': 'Switzerland', 'dates': '01-09-2024 : 10-09-2024'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: 232,
                    width: 233,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 208,
                          height: 157,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            'assets/Mask group.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title']!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 66, 88, 132),
                                    ),
                                  ),
                                  Text(
                                    item['location']!,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Color.fromARGB(255, 66, 88, 132),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              child: Container(
                                width: 42,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    item['rating']!,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            child: Row(
              children: [
                Text(
                  'Popular',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 66, 88, 132),
                  ),
                ),
                SizedBox(width: 50),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: popularDestinations.length,
              itemBuilder: (context, index) {
                final destination = popularDestinations[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    width: 331,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            width: 51,
                            height: 56,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue,
                            ),
                            child: Image.asset(
                              'assets/Mask group (1).png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              destination['title']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Color.fromARGB(255, 66, 88, 132),
                              ),
                            ),
                            subtitle: Text(
                              destination['dates']!,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                                color: Color.fromARGB(255, 66, 88, 132),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
