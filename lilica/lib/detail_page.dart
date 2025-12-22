import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailPage extends StatefulWidget {
  final String title;
  final String sheetFile;

  const DetailPage({
    super.key,
    required this.title,
    required this.sheetFile,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

  class QuestionTile extends StatelessWidget {
    final int numero;
    final String sentido;
    final String pergunta;
    final String resposta;

    const QuestionTile({
      super.key,
      required this.numero,
      required this.sentido,
      required this.pergunta,
      required this.resposta,
    });

    factory QuestionTile.fromJson(dynamic json) {
      return QuestionTile(
        numero: json["numero"],
        sentido: json["sentido"],
        pergunta: json["pergunta"],
        resposta: json["resposta"],
      );
    }

    @override
    Widget build(BuildContext context) {
      final corTag = sentido.toLowerCase() == "horizontal"
          ? Colors.blueAccent
          : Colors.deepPurpleAccent;

      return Card(
        color: Colors.pink.shade50,
        margin: const EdgeInsets.only(bottom: 12),
        child: ExpansionTile(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔥 ENVOLVEMOS APENAS A PERGUNTA EM SCROLL HORIZONTAL
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      Text(
                        "$numero — $pergunta",
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: corTag,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          sentido.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                resposta,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            )
          ],
        ),
      );
    }
  }


class _DetailPageState extends State<DetailPage> {
  List<dynamic> perguntas = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final raw = await rootBundle.loadString('assets/perguntas/${widget.sheetFile}.json');
      final decoded = json.decode(raw) as List<dynamic>;

      setState(() => perguntas = decoded);
    } catch (e) {
      if (!mounted) return;
      setState(() => perguntas = []);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar JSON: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.pink.shade300,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: perguntas.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: perguntas.length,
              itemBuilder: (_, i) => QuestionTile.fromJson(perguntas[i]),
            ),
    );
  }
}
