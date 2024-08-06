import 'dart:typed_data';
import 'package:hive_flutter/hive_flutter.dart';

part 'image_data.g.dart';

@HiveType(typeId: 4)
class ImageData extends HiveObject {
  @HiveField(0)
  final Uint8List imageData;

  @HiveField(1)
  final DateTime creationDate;

  ImageData(this.imageData, this.creationDate);
}



