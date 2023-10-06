import 'package:chat_app_with_laravel/utils/logger.dart';
import 'package:chat_app_with_laravel/utils/utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

const oneSignalAppId = "a8b44f58-adfc-4595-b491-0fc3f21c48f4";

Future<void> initOneSignal() async {
  final oneSignalShared = OneSignal.shared;

  oneSignalShared.setLogLevel(OSLogLevel.none, OSLogLevel.none);

  oneSignalShared.setRequiresUserPrivacyConsent(true);

  await oneSignalShared.setAppId(oneSignalAppId);
}

void registerOneSignalEventListener({
  required Function(OSNotificationOpenedResult) onOpened,
  required Function(OSNotificationReceivedEvent) onReceivedInForeground,
}) {
  final oneSignalShared = OneSignal.shared;

  oneSignalShared.setNotificationOpenedHandler(onOpened);

  oneSignalShared
      .setNotificationWillShowInForegroundHandler(onReceivedInForeground);
}

const tagName = "userId";

void sendUserTag(int userId) {
  OneSignal.shared.sendTag(tagName, userId.toString()).then((response) {
    vLog("Successfully sent tags with response: $response");
  }).catchError((error) {
    vLog("Encountered an error sending tags: $error");
  });
}

void deleteUserTag() {
  OneSignal.shared.deleteTag(tagName).then((response) {
    vLog("Successfully deleted tags with response $response");
  }).catchError((error) {
    vLog("Encountered error deleting tag: $error");
  });
}
