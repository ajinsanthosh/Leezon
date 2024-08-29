import 'package:hive_flutter/hive_flutter.dart';
import 'package:leezon/utility/constants.dart';
import 'package:leezon/hive/chat_history.dart';

import 'package:leezon/hive/settings.dart';

class Boxes {
  // get the caht history box
  static Box<ChatHistory> getChatHistory() =>
      Hive.box<ChatHistory>(Constants.chatHistoryBox);

       // // get user box
  // static Box<Profile> getUser() => Hive.box<Profile>(Constants.userBox);
   
  // get settings box
  static Box<Settings> getSettings() =>
      Hive.box<Settings>(Constants.settingsBox);
}
