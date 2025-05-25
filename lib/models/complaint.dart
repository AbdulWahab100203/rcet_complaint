import 'package:cloud_firestore/cloud_firestore.dart';

class Complaint {
  final String id;
  final String title;
  final String description;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String userId;
  final String assignedTo;
  final String department;
  final String resolutionNote;

  Complaint({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    this.createdAt,
    this.updatedAt,
    required this.userId,
    required this.assignedTo,
    required this.department,
    required this.resolutionNote,
  });

  factory Complaint.fromFirestore(Map<String, dynamic> data, String docId) {
    return Complaint(
      id: docId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      status: data['status'] ?? '',
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
      userId: data['userId'] ?? '',
      assignedTo: data['assignedTo'] ?? '',
      department: data['department'] ?? '',
      resolutionNote: data['resolutionNote'] ?? '',
    );
  }
}
