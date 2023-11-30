class Video {
  final String? id;
  final String? userId;
  final String? userEmail; // Optional field, as it is not present in all objects
  final String? name;
  final String? filePath;
  final DateTime? createdAt;
  final String? image ; 

  Video({
    required this.id,
    required this.userId,
    this.userEmail,
    required this.name,
    required this.filePath,
    required this.createdAt,
     this.image
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['_id'],
      userId: json['userId'],
      userEmail: json['userEmail'],
      name: json['name'],
      filePath: json['filePath'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}