import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(children: [
        Column(
          children: [
            Container(
              height: 230,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
                color: Color(0xFF464f93),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 80,
                    left: 0,
                    child: Container(
                      height: 100,
                      width: 360,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 110,
                    left: 20,
                    child: Text(
                      "YourBooks",
                      style: TextStyle(fontSize: 20, color: Color(0xFF464f93)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.05),
            Container(
              height: 230,
              child: Stack(
                children: [
                  Positioned(
                    child: Material(
                      child: Container(
                          height: 188.0,
                          width: width * 0.9,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 239, 227, 227),
                            borderRadius: BorderRadius.circular(0.0),
                          )),
                    ),
                  ),
                  Positioned(
                    child: Card(
                      elevation: 10.0,
                      shadowColor:
                          Color.fromARGB(255, 29, 11, 11).withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        height: 200,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/braga.png'))),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ]),
    );
  }
}
