import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class SpotifyPage extends StatefulWidget {
  const SpotifyPage({super.key});

  @override
  State<SpotifyPage> createState() => _SpotifyPageState();
}

class _SpotifyPageState extends State<SpotifyPage> {
  List<dynamic>? musicas;

  @override
  void initState() {
    super.initState();
    loadMusic();
  }

  Future<void> loadMusic() async {
    final raw = await rootBundle.loadString("assets/playlist.json");
    final decoded = json.decode(raw);
    setState(() => musicas = decoded);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Playlist"),
        backgroundColor: Colors.pink.shade300,
      ),
      body: musicas == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: musicas!.length,
              itemBuilder: (_, i) {
                final m = musicas![i];
                return ListTile(
                  leading: const Icon(Icons.music_note),
                  title: Text(m["titulo"]),
                  subtitle: Text(m["artista"]),
                );
              },
            ),
    );
  }
}
