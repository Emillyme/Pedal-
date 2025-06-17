class Book {
  final String id;
  final String name;
  final String abbreviation;

  Book({
    required this.id,
    required this.name,
    required this.abbreviation,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      name: json['name'],
      abbreviation: json['abbreviation'],
    );
  }
}
