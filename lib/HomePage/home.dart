import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class MusicFilesScreen extends StatefulWidget {
  @override
  _MusicFilesScreenState createState() => _MusicFilesScreenState();
}

class _MusicFilesScreenState extends State<MusicFilesScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  List<SongModel> _audioFiles = [];

  @override
  void initState() {
    super.initState();
    _fetchAudioFiles();
  }

  Future<void> _fetchAudioFiles() async {
    if (await Permission.storage.request().isGranted) {
      final audioFiles = await _audioQuery.querySongs();
      setState(() {
        _audioFiles = audioFiles;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Files'),
      ),
      body: _audioFiles.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _audioFiles.length,
              itemBuilder: (context, index) {
                final audioFile = _audioFiles[index];
                return ListTile(
                  title: Text(audioFile.title),
                  subtitle: Text(audioFile.uri ?? 'No URI'),
                );
              },
            ),
    );
  }
}
