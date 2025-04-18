class Employee {
  final String id;
  final String name;
  final String department;
  final String contact;
  final String email;

  Employee({
    required this.id,
    required this.name,
    required this.department,
    required this.contact,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'department': department,
      'contact': contact,
      'email': email,
    };
  }
}
