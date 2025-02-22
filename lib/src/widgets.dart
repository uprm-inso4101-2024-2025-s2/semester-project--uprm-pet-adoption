import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/swipeable_stack_provider.dart';
import 'package:swipe_to_action/swipe_to_action.dart';


// this file contains the swipeable stack widget

class SwipeableStackWidget extends ConsumerWidget{
  const SwipeableStackWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Set<PointerDeviceKind> allowedPointerKinds;
    return Scaffold(
      //Color the background
      backgroundColor: Color(0xFF82B0FF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Swipeable Stack'),
            const SizedBox(height:5),
            //An elevated button is a label child displayed on a Material widget
            // whose Material.elevation increases when the button is pressed

            Image(image: AssetImage('images/sign_log.png')),

            //Implemented the Swipe Feature, swipes from left to right
            Swipeable(
              key: ValueKey("swipe"),
              onSwipe:(direction) {
                if (direction == SwipeDirection.startToEnd) {
                  SwipeDirection.horizontal;
                  SwipeEdge.left;
                  //Swiping animation
                } else {
                  SwipeDirection.horizontal;
                  SwipeEdge.right;
                }
              },

              background: Container(color: Colors.yellow),
              // widget animation background
              secondaryBackground: Container(color: Colors.teal),
              // Confirm if Swipe gesture was accomplished
              confirmSwipe: (direction) async {
                return true;
              },

              //Allows mouse to drag screen in swipe direction
              allowedPointerKinds: allowedPointerKinds = {
                PointerDeviceKind.touch,
                PointerDeviceKind.stylus,
                PointerDeviceKind.invertedStylus,
                PointerDeviceKind.mouse,
                PointerDeviceKind.unknown,
              },

              //TODO: Implement the petCard object to be swiped
              child: const SizedBox(
                  height: 360,
                  child: Image(image: AssetImage('images/image.png')),
              ),
    ),

        //Return to home button
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/'); // Go back to home screen
              },
              child: const Text('Return to home'),
            ),
          ],
        ),
      ),
    );
  }
  }