import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 32),
              child: const Text(
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
              margin: const EdgeInsets.only(top: 32),
              child: const Text(
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
              margin: const EdgeInsets.only(top: 32),
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
              margin: EdgeInsets.only(top: 12, bottom: 32),
              height: 150,
              decoration: const BoxDecoration(
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
                       children: const [
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
                     children: const [
                       Text(
                           "Check Out",
                         style: TextStyle(
                           fontFamily: "NexaRegular",
                           fontSize: 10,
                           color: Colors.black,
                         ),
                       ),
                       Text(
                         "--/--",
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
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "12:00:01 PM",
                style: TextStyle(
                  fontFamily: "NexaRegular",
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                  text: const TextSpan(
                    text: "11",
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: "NexaBold",
                    ),
                    children: [
                      TextSpan(
                        text: "Jan 2020",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "NexaBold",
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "21 May 2023",
                style: TextStyle(
                  fontFamily: "NexaBold",
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top:24),
              child: Builder(
                  builder: (context){
                    final GlobalKey<SlideActionState> key = GlobalKey();
                    return SlideAction(
                      text: "Slide to Check Out",
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "NexaRegular",
                      ),
                      outerColor: Colors.white,
                      innerColor: Colors.black,
                      key: key,
                      onSubmit: () {
                        key.currentState!.reset();
                      },
                    );
                  }),
            )
          ],
        ),

      ),
    );
  }
}
