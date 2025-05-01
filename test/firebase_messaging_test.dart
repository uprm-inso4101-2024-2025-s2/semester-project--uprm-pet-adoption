import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:semester_project__uprm_pet_adoption/services/firebase_cloud_messaging.dart';

import 'firebase_messaging_test.mocks.dart';

@GenerateMocks([
  FirebaseMessaging,
  FlutterLocalNotificationsPlugin,
])
void main() {
  late MockFirebaseMessaging mockFirebaseMessaging;
  late MockFlutterLocalNotificationsPlugin mockFlutterLocalNotificationsPlugin;
  late MessagingNotifications messagingNotifications;

  setUp(() {
    mockFirebaseMessaging = MockFirebaseMessaging();
    mockFlutterLocalNotificationsPlugin = MockFlutterLocalNotificationsPlugin();

    messagingNotifications = MessagingNotifications(
      firebaseMessaging: mockFirebaseMessaging,
      notificationsPlugin: mockFlutterLocalNotificationsPlugin,
    );
  });

  test('should request permission and subscribe to topic on initialize', () async {
    // Mock permission response
    when(mockFirebaseMessaging.requestPermission(
      alert: anyNamed('alert'),
      announcement: anyNamed('announcement'),
      badge: anyNamed('badge'),
      carPlay: anyNamed('carPlay'),
      criticalAlert: anyNamed('criticalAlert'),
      sound: anyNamed('sound'),
    )).thenAnswer((_) async => NotificationSettings(
      authorizationStatus: AuthorizationStatus.authorized,
      alert: AppleNotificationSetting.enabled,
      announcement: AppleNotificationSetting.enabled,
      badge: AppleNotificationSetting.enabled,
      carPlay: AppleNotificationSetting.enabled,
      lockScreen: AppleNotificationSetting.enabled,
      notificationCenter: AppleNotificationSetting.enabled,
      showPreviews: AppleShowPreviewSetting.always,
      timeSensitive: AppleNotificationSetting.enabled,
      criticalAlert: AppleNotificationSetting.enabled,
      providesAppNotificationSettings: AppleNotificationSetting.enabled,
      sound: AppleNotificationSetting.enabled,
    ));

    // Mock subscription to topic
    when(mockFirebaseMessaging.subscribeToTopic('general'))
        .thenAnswer((_) async => {});

    // Mock plugin initialization
    when(mockFlutterLocalNotificationsPlugin.initialize(any))
        .thenAnswer((_) async => true);

    await messagingNotifications.initialize();

    verify(mockFirebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      sound: true,
    )).called(1);

    verify(mockFirebaseMessaging.subscribeToTopic('general')).called(1);
    verify(mockFlutterLocalNotificationsPlugin.initialize(any)).called(1);
  });
}








