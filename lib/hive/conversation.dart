// lib/hive/conversation.dart
import 'package:hive_flutter/hive_flutter.dart';

part 'conversation.g.dart';

@HiveType(typeId: 3)
class Conversation extends HiveObject {
  @HiveField(0)
  late String prompt;

  @HiveField(1)
  late String response;

  @HiveField(2)
  late DateTime date;

  Conversation({
    required this.prompt, 
    required this.response, 
    required this.date
  });
}
