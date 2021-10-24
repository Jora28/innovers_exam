class ExamData {
  static const String avatar1 = 'assets/avatars/avatar1.png';
  static const String avatar2 = 'assets/avatars/avatar2.png';
  static const String avatar3 = 'assets/avatars/avatar3.png';

  static List<TranstationType> listTranstationType = [
    TranstationType(0, "Car"),
    TranstationType(1, 'Train'),
    TranstationType(2, 'Bicycle'),
    TranstationType(3, 'By walk'),
    TranstationType(4, 'Any'),
  ];

  static List<TranstationType> listItemTitle = [
    TranstationType(0, "Package type"),
    TranstationType(1, "Package type"),
    TranstationType(2, "Package type"),
    TranstationType(3, "Package type"),
    TranstationType(4, "Package type"),
    TranstationType(5, "Package type"),
    TranstationType(6, "Package type"),
    TranstationType(7, "Package type"),
  ];
  static List<Contacts> listContacts = [
    Contacts(phone: '+37498888899', name: "Jor", avatar: avatar1),
    Contacts(phone: '+37498888899', name: 'Vartan', avatar: avatar2),
    Contacts(phone: '+37498888899', name: 'Gor', avatar: avatar3),
    Contacts(phone: '+37498888899', name: 'Angela', avatar: avatar2),
  ];

  static List<String> listLocations = [
    "Barekamutyaasadddasdahhhhhhhhhhhhhhhhhhhhhhhn 15, Erevan",
    "Shirakaci 24, Gyumri",
    "Shirakaci 24, Gyumri,",
    "Shirakaci 24, Gyumri",
  ];
}

class TranstationType {
  final String text;
  final int value;

  TranstationType(
    this.value,
    this.text,
  );
}

class Contacts {
  final String name;
  final String phone;
  final String avatar;

  Contacts({required this.name, required this.phone, required this.avatar});
}
