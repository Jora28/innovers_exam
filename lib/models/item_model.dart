import 'dart:io';

class ItemModel {
  final File file;
  final String itemName;
  final String count;
  final String weight;
  final String description;

  ItemModel(
      {required this.file,
      required this.itemName,
      required this.count,
      required this.weight,
      required this.description});
}
