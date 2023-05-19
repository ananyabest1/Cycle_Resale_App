import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({Key? key}) : super(key: key);

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 32),
              child: Text(
                "Welcome",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "NexaRegular",
                    fontSize: 30,
                 ),
               ),
              ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 32),
              child: Text(
                "Employee",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "NexaBold",
                  fontSize: 25,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 32),
              child: Text(
                "Today's Status",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "NexaBold",
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 10,
                    offset: Offset(2, 2)
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Expanded(
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Text(
                             "Check In",
                           style: TextStyle(
                             fontFamily: "NexaRegular",
                             fontSize: 10,
                             color: Colors.black,
                           ),
                         ),
                         Text(
                           "9:30",
                           style: TextStyle(
                             fontFamily: "NexaBold",
                             fontSize: 10,
                             color: Colors.black,
                           ),
                         ),
                       ],
                     ),
                 ),
                 Expanded(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Text(
                           "Check Out",
                         style: TextStyle(
                           fontFamily: "NexaRegular",
                           fontSize: 10,
                           color: Colors.black,
                         ),
                       ),
                       Text(
                         "15:30",
                         style: TextStyle(
                           fontFamily: "NexaBold",
                           fontSize: 10,
                           color: Colors.black,
                         ),
                       ),
                     ],
                   ),
                 ),
               ],
             ),
            ),

          ],
        ),

      ),
    );
  }
}
