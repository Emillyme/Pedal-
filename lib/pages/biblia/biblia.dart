import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pedal_project/models/book.dart';

Future<List<Book>> fetchBooks() async {
  final response = await http.get(
    Uri.parse(
      'https://api.scripture.api.bible/v1/bibles/685d1470fe4d5c3b-01/books',
    ),
    headers: {
      'accept': 'application/json',
      'api-key': '5132c4eff95e3e309ac4674cb0160f60',
    },
  );

  if (response.statusCode == 200) {
    final jsonBody = jsonDecode(response.body);
    final List<dynamic> data = jsonBody['data'];
    return data.map((json) => Book.fromJson(json)).toList();
  } else {
    throw Exception('Erro ao carregar api');
  }
}

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  late Future<List<Book>> _futureBooks;

  @override
  void initState() {
    super.initState();
    _futureBooks = fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Livros da Bíblia")),
      body: FutureBuilder<List<Book>>(
        future: _futureBooks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Nenhum livro encontrado"));
          }

          final books = snapshot.data!;


          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {

              final book = books[index];
              return ListTile(
                title: Text(book.name),
                subtitle: Text("Abreviação: ${book.abbreviation}"),
              );
              
            },
          );
        },
      ),
    );
  }
}
