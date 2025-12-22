import 'package:flutter/material.dart';
import 'package:lilica/PDFMenuPage.dart';
import 'jogos_page.dart';
import 'spotify_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<Map<String, dynamic>> menu = const [
    {
      "titulo": "Palavras Cruzadas",
      "icone": Icons.grid_view_rounded,
    },
    {
      "titulo": "Playlist",
      "icone": Icons.music_note_rounded,
    },
    {
      "titulo": "Visualizar PDF",
      "icone": Icons.picture_as_pdf_rounded,
      "pdfList": [
        {
          "title": "Guia Navidad",
          "path": "assets/navidad/GUIAMANUALNAVIDAD.pdf"
        },
        {
          "title": "Outro Manual",
          "path": "assets/navidad/Manual2.pdf"
        }
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu Principal"),
        backgroundColor: Colors.pink.shade300,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: menu.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (_, index) {
          final item = menu[index];
          return GestureDetector(
            onTap: () => _navigate(context, index),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              color: Colors.pink.shade100,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(item["icone"], size: 45, color: Colors.white),
                    const SizedBox(height: 12),
                    Text(
                      item["titulo"],
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _navigate(BuildContext context, int index) {
    final item = menu[index];

    // 👉 Se tiver PDFs associados, abre o menu de PDFs
    if (item.containsKey("pdfList")) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PDFMenuPage(pdfList: List<Map<String, String>>.from(item["pdfList"])),
        ),
      );
      return;
    }

    // 👉 Caso contrário, segue com seu switch atual
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const JogosPage()),
        );
        break;

      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SpotifyPage()),
        );
        break;
    }
  }

}
