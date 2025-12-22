import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'dart:ui' as ui; 

class JogosPage  extends StatelessWidget {
  const JogosPage ({super.key});

  final List<Map<String, dynamic>> opcoes = const [
    {"titulo": "Jogo 1", "file": "sheet1"},
    {"titulo": "Jogo 2", "file": "sheet2"},
    {"titulo": "Jogo 3", "file": "sheet3"},
    {"titulo": "Jogo 4", "file": "sheet4"},
    {"titulo": "Jogo 5", "file": "sheet5"},
    {"titulo": "Jogo 6", "file": "sheet6"},
    {"titulo": "Jogo 7", "file": "sheet7"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // SEU CONTAINER DE FUNDO
          Container(
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFC0D9), Color(0xFFFF5F8F)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Text(
                  "Escolha seu jogo",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    itemCount: opcoes.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (_, i) {
                      final item = opcoes[i];
                      return _AnimatedCard(
                        title: item["titulo"],
                        file: item["file"],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // 🔙 BOTÃO DE VOLTAR
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          )
        ],
      ),
    );
  }
}

class _AnimatedCard extends StatefulWidget {
  final String title;
  final String file;

  const _AnimatedCard({
    required this.title,
    required this.file,
  });

  @override
  State<_AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<_AnimatedCard>
    with SingleTickerProviderStateMixin {

  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => scale = 0.94),
      onTapUp: (_) => setState(() => scale = 1.0),
      onTapCancel: () => setState(() => scale = 1.0),
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (_, __, ___) =>
                DetailPage(title: widget.title, sheetFile: widget.file),
            transitionsBuilder: (_, anim, __, child) {
              return SlideTransition(
                position: Tween(begin: const Offset(0, 0.2), end: Offset.zero)
                    .animate(anim),
                child: FadeTransition(opacity: anim, child: child),
              );
            },
          ),
        );
      },
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: scale,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.25),
                    blurRadius: 12,
                    spreadRadius: 1,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 8,
                        color: Colors.black26,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
