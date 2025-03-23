import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:semester_project__uprm_pet_adoption/src/screens/FAQs_screen.dart' hide FAQScreen;
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
import '../screens/FAQ_screen.dart';

import '../screens/match_making_screen.dart';
import '../screens/pet_tips_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/user_profile_screen.dart';
import '../screens/map_screen.dart';
import '../screens/search_screen.dart';
import 'package:semester_project__uprm_pet_adoption/src/screens/forgot_password_screen.dart';
import 'package:semester_project__uprm_pet_adoption/src/screens/forgot_password_verification_screen.dart';
import 'package:semester_project__uprm_pet_adoption/src/screens/forgot_password_change_screen.dart';
//import '../screens/settings_screen.dart';
//import 'package:semester_project__uprm_pet_adoption/src/screens/faq_screen.dart';


//This file contains the routes for all screens. It also manages transitions between screens.

final GoRouter appRouter = GoRouter(
  redirect: (context, state) {
    final container = ProviderScope.containerOf(context);
    final isLoggedIn = container.read(authProvider);

    if (!isLoggedIn && state.matchedLocation == '/' ||
        !isLoggedIn && state.matchedLocation == 'menu') {
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
        child:  HomeScreen(),
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

// Route for forgot password screen 
GoRoute(
  path: '/forgot_password',
  pageBuilder: (context, state) => CustomTransitionPage(
    child: const ForgotPasswordScreen(),
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

// Route for forgot password verification screen
GoRoute(
  path: '/forgot_password_verification',
  pageBuilder: (context, state) => CustomTransitionPage(
    child: const ForgotPasswordVerificationScreen(),
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

// Route for forgot password change screen
GoRoute(
  path: '/forgot_password_change',
  pageBuilder: (context, state) => CustomTransitionPage(
    child: const ForgotPasswordChangeScreen(),
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

  // FAQ Screen
  GoRoute(
    path: '/faq',
    pageBuilder: (context, state) => CustomTransitionPage(
      child: const FAQ_Screen(),
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
        child: const AboutUsScreen(),
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

    //Route for match making screen
    GoRoute(
      path: '/matchmaking',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const MatchMakingScreen(),
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
      path: '/profile',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const Profile(),
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
      path: '/map',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const Maps(),
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
      path: '/tips',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const PetTips(),
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
      path: '/favorites',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const Favorites(),
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
      path: '/search',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const Search(),
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
    // Route for chat settings
    GoRoute(
    path: '/settings',
    pageBuilder: (context, state) => CustomTransitionPage(
      child: const SettingsScreen(), // Replace with your actual settings screen widget
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
