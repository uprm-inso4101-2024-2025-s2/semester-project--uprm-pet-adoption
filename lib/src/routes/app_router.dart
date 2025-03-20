import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:semester_project__uprm_pet_adoption/src/screens/FAQs_screen.dart';
import 'package:semester_project__uprm_pet_adoption/src/screens/Settings_Screen.dart';
import 'package:semester_project__uprm_pet_adoption/src/screens/chat_screen.dart';
import 'package:semester_project__uprm_pet_adoption/src/screens/dms_screen.dart';
import '../screens/home_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/menu_screen.dart';
import '../screens/login_screen.dart';
import '../screens/auth_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/auth_provider.dart';
import '../screens/gettoknow_screen.dart';
import '../screens/AboutUs_screen.dart';
import '../screens/Settings_Screen.dart';
import '../screens/FAQs_screen.dart';

//This file contains the routes for all screens. It also manages transitions between screens.

final GoRouter appRouter = GoRouter(
  redirect: (context, state) {
    final container = ProviderScope.containerOf(context);
    final isLoggedIn = container.read(authProvider);

    if (!isLoggedIn && state.matchedLocation == '/' || !isLoggedIn && state.matchedLocation == 'menu') {
      return '/auth'; // get unauthenticated users back to start screen (authentication screen)
    }
    return null;
  },
  routes: [
    //Route for home screen
    GoRoute(
      path: '/',
      //Page with custom transition functionality. This is part of the Go Router library.
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const HomeScreen(),
        //In Flutter's GoRouter, the transitionsBuilder function controls how a new screen
        // appears and how the current screen disappears during navigation.
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          //This transition is supposed to make it so that the screen slides from right to left when exiting it.
          return SlideTransition(
            //Tween is useful if you want to interpolate across a range. In this case,
            // creates a smooth horizontal slide animation when navigating through screens.
            position: Tween<Offset>(
              begin: const Offset(1,
                  0), // Starts from the right. Offset takes in x,y coordinates as arguments.
              end: Offset.zero, // Ends at normal position
            ).animate(animation),
            child:
                child, //The child represents the screen (widget) that is being transitioned into.
          );
        },
      ),
    ),

    //Route for auth screen
    GoRoute(
      path: '/auth',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const AuthScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),

    //Route for signup screen
    GoRoute(
      path: '/signup',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: SignUpScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),

    //Route for login screen
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const LogInScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),

    //Route for menu screen
    GoRoute(
      path: '/menu',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const MenuScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),

    GoRoute(
      path: '/gettoknow',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const GettoknowScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),

    GoRoute(
      path: '/chat',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const ChatScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    
    GoRoute(
      path: '/dms',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const DMScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),

    GoRoute(
      path: '/about_us',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const DMScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/settings',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const SettingsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/FAQs',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const FAQScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
  ],
);
