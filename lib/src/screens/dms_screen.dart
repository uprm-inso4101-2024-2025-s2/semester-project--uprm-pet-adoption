import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart'; 
import 'package:bubble/bubble.dart'; //import flutter bubble widget
// Import for navigation

class DMScreen extends StatelessWidget {

  const DMScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DMS")),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: [
            // Implemented Message Bubble with temporary text
            Bubble(
              margin: const BubbleEdges.only(top: 10),
              alignment: Alignment.topRight,
              nipWidth: 8,
              nipHeight: 24,
              nip: BubbleNip.rightTop,
              color: const Color(0xFF82B0FF),
              child: const Text(
                'Hello, I would like to adopt',
                textAlign: TextAlign.right, 
                maxLines: 10,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w100,
                  fontFamily: 'Archivo',
                ),
              ),
            ),
            // Box containing time of message
            const SizedBox(
              height: 90,
              child: Text(
                "11:59 pm",
                textWidthBasis: TextWidthBasis.longestLine,
                textAlign: TextAlign.right,
                textDirection: TextDirection.ltr,
              ),
            ),
            Bubble(
              margin: const BubbleEdges.only(top: 10),
              alignment: Alignment.topLeft,
              nipWidth: 8,
              nipHeight: 24,
              nip: BubbleNip.leftTop,
              color: Colors.white,
              child: const Text(
                'Sure!!!',
                maxLines: 10,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w100,
                  fontFamily: 'Archivo',
                ),
              ),
            ),
            const SizedBox(
              height: 85,
              child: Text(
                "12:01 am",
                textWidthBasis: TextWidthBasis.longestLine,
                textAlign: TextAlign.left,
                textDirection: TextDirection.ltr,
              ),
            ),
            Bubble(
              margin: const BubbleEdges.only(top: 10),
              alignment: Alignment.topRight,
              nipWidth: 8,
              nipHeight: 24,
              nip: BubbleNip.rightTop,
              color: Colors.white,
              child: const Text(
                  'I want a pug',
                  textAlign: TextAlign.right, 
                  maxLines: 10, //Character limit set to 10 lines of message
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w100,
                    fontFamily: 'Archivo',
                  ),
                ),
            ),
            const SizedBox(
              height: 45,
              child: Text(
                "12:05 am",
                textWidthBasis: TextWidthBasis.longestLine,
                textAlign: TextAlign.right,
                textDirection: TextDirection.ltr,
              ),
            ),
             Bubble(
              margin: const BubbleEdges.only(top: 10),
              alignment: Alignment.topLeft,
              nipWidth: 8,
              nipHeight: 24,
              nip: BubbleNip.leftTop,
              color: const Color(0xFF82B0FF),
              child: const Text(
                  'This message is reallly long!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
                  maxLines: 7,
                  overflow: TextOverflow.clip,

                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w100,
                    fontFamily: 'Archivo',
                  ),
                ),
            ),
            const SizedBox(
              //height:0,
              child: Text(
                "12:10 am",
                textWidthBasis: TextWidthBasis.longestLine,
                textAlign: TextAlign.left,
                textDirection: TextDirection.ltr,
              ),
            ),
          ]
        )
      )
    );
  }
}
