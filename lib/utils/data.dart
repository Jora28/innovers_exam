class ExamData {
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
    Contacts(phone: '+37498888899', name: "Jor"),
    Contacts(phone: '+37498888899', name: 'Vartan'),
    Contacts(phone: '+37498888899', name: 'Gor'),
    Contacts(phone: '+37498888899', name: 'Angela'),
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

  Contacts({required this.name, required this.phone});
}
