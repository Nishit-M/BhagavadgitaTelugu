// import 'dart:convert';

class Verse {
  final String chapterNumber;
  final String verse;
  final String text;
  final String meaning;
  final String audioPath; // Path to the audio file
  
  Verse({
    required this.chapterNumber,
    required this.verse,
    required this.text,
    required this.meaning,
    required this.audioPath,
  });
  
  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      chapterNumber: json['chapter'].toString(),
      verse: json['verse'].toString(),
      text: json['text'],
      meaning: json['meaning'],
      audioPath: json['audio_path'] ?? '',
    );
  }
}

class Chapter {
  final String number;
  final String name;
  final String summary;
  List<Verse>? verses; // Made nullable
  bool versesLoaded = false;
  
  Chapter({
    required this.number,
    required this.name,
    required this.summary,
    this.verses,
  });
  
  factory Chapter.fromJson(Map<String, dynamic> json, {bool loadVerses = false}) {
    List<Verse>? versesList;
    
    if (loadVerses && json['verses'] != null) {
      versesList = List<Verse>.from(
        json['verses'].map((verse) => Verse.fromJson(verse))
      );
    }
    
    return Chapter(
      number: json['chapter'].toString(),
      name: json['name'],
      summary: json['summary'],
      verses: versesList,
    );
  }
}