import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BookSearchApp extends StatelessWidget {
  const BookSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BookSearchScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BookSearchScreen extends StatefulWidget {
  const BookSearchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookSearchScreenState createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _books = [];
  List<String> _genres = ["todos"];
  bool _isLoading = false;
  String _selectedGenre = "todos";

  @override
  void initState() {
    super.initState();
    _fetchGenres();
  }

  Future<void> _fetchGenres() async {
    final commonGenres = [
      "todos",
      "fantasy",
      "science fiction",
      "romance",
      "horror",
      "history",
      "biography",
      "children",
      "mystery",
      "adventure"
    ];
    setState(() {
      _genres = commonGenres;
    });
  }

  Future<void> _searchBooks() async {
    setState(() {
      _isLoading = true;
    });

    String query = "";

    if (_searchController.text.isNotEmpty) {
      query = _searchController.text;
      if (_selectedGenre != "todos") {
        query += "+subject:$_selectedGenre";
      }
    } else if (_selectedGenre != "todos") {
      query = "subject:$_selectedGenre";
    }

    final url =
        'https://www.googleapis.com/books/v1/volumes?q=$query&maxResults=20';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _books = data['items'] ?? [];
        _isLoading = false;
      });
    } else {
      setState(() {
        _books = [];
        _isLoading = false;
      });
    }
  }

  void _showBookDetails(BuildContext context, Map<String, dynamic> book) {
    final title = book['title'] ?? 'Sem título';
    final author = book['authors']?.join(', ') ?? 'Sem autor';
    final year = book['publishedDate'] ?? 'Data desconhecida';
    final image = book['imageLinks']?['thumbnail'] ?? '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              image.isNotEmpty
                  ? Image.network(image)
                  : Icon(Icons.book, size: 50),
              SizedBox(height: 10),
              Text('Autor(es): $author'),
              Text('Ano: $year'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Procure seu Livro'),
        centerTitle: true,
        backgroundColor: Color(0xFFFFE4C4),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            SizedBox(
              width: width * 0.5,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome do livro',
                  hintText: 'Ex: Harry Potter',
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "OU",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: width * 0.5,
              child: DropdownButtonFormField<String>(
                value: _selectedGenre,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Gênero',
                ),
                items: _genres
                    .map((genre) => DropdownMenuItem(
                          value: genre,
                          child: Text(genre),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedGenre = value;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: width * 0.5,
              child: ElevatedButton(
                onPressed: _searchBooks,
                child: Text('Procure'),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _books.length,
                      itemBuilder: (context, index) {
                        final book = _books[index]['volumeInfo'];
                        final title = book['title'] ?? 'Sem título';

                        return ListTile(
                          title: Text(
                            title,
                            textAlign: TextAlign.center,
                          ),
                          onTap: () => _showBookDetails(context, book),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(BookSearchApp());
}
