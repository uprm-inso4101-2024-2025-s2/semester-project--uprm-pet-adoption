import 'package:firebase_analytics/firebase_analytics.dart';

// The asynchronous Future functions serve as a link
// between functions defined throughout the application
// and the Firebase analytics. Essentially it allows the changes made
// within the project defined functions to also be tracked
// in the Firebase analytics. This is what actually passes the information
// inputted in the application to the Firebase.

class AnalyticsService {
  final _instance = FirebaseAnalytics.instance;

  Future <void> addSignUp() async {
    await _instance.logEvent(name: "new_signup");
  }

  Future <void> addPetsSignUp() async {
    await _instance.logEvent(name: "new_pet_signup");
  }

  Future<void> addLogIn() async {
    await _instance.logEvent(name: "new_login");
  }

  Future<void> logScreenView(String screenName) async {
    await _instance.logEvent(name: "screen_view",
    parameters: {
      "screen_name": screenName,
    },
    );
  }
}