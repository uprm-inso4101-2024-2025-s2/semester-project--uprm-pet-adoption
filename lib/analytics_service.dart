import 'package:firebase_analytics/firebase_analytics.dart';

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