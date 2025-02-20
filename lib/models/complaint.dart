class Complaint {
  final String title;
  final String description;
  final String department;
  final DateTime dateSubmitted;
  final String status;

  Complaint({
    required this.title,
    required this.description,
    required this.department,
    required this.dateSubmitted,
    required this.status,
  });
}
