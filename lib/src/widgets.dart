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
      //AppBar is a prebuilt widget in Flutter
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

            //Like button
            Swipeable(
              key: ValueKey("swipe"),
              onSwipe:(direction) {
                if (direction == SwipeDirection.startToEnd) {
                  SwipeDirection.horizontal;
                  SwipeEdge.left;
                } else {
                  SwipeDirection.horizontal;
                  SwipeEdge.right;
                }
              },

              background: Container(color: Colors.yellow),
              // Widget to display below if swiping from end to start.
              // Only works if [background] is defined
              // Optional.
              secondaryBackground: Container(color: Colors.teal),
              // Function to call before calling onSwipe. If it returns false,
              // swipe is aborted and onSwipe is not called.
              // Optional.
              confirmSwipe: (direction) async {
                return true;
              },

              allowedPointerKinds: allowedPointerKinds = {
                PointerDeviceKind.touch,
                PointerDeviceKind.stylus,
                PointerDeviceKind.invertedStylus,
                PointerDeviceKind.mouse,
                PointerDeviceKind.unknown,
              },

              child: const SizedBox(
                  height: 360,
                  child: Image(image: AssetImage('images/image.png')),
              ),
    ),

        //Auth screen button
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/'); // Go back to Auth screen
              },
              child: const Text('Return to home'),
            ),
          ],
        ),
      ),
    );
  }
  }