import 'package:bhagavadgita_telugu/provider/gita_provider.dart';
import 'package:bhagavadgita_telugu/screens/verscreen_new.dart';
import 'package:bhagavadgita_telugu/widgets/verse_screen/show_verseselector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget buildNavigationBar(
    BuildContext context,
    double screenWidth,
    double screenHeight,
    bool isSmallScreen,
    String chapterNumber,
    String chapterTitle,
    String verseNumber,
    verseText,
    meaning) {
  final gitaProvider = Provider.of<GitaProvider>(context, listen: false);
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  final navigator = Navigator.of(context);
  
  void showLastVerseMessage() {
    scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text("This is the last verse in the chapter")));
  }

  // Navigation functions that don't use context directly
  void navigateToPreviousVerse(previousVerse) {
    navigator.pushReplacement(
      MaterialPageRoute(
        builder: (context) => VerseDetailScreenNew(
          chapterNumber: chapterNumber,
          chapterTitle: chapterTitle,
          verseNumber: (int.parse(verseNumber) - 1).toString(),
          verseText: previousVerse.text,
          meaning: previousVerse.meaning,
        ),
      ),
    );
  }

  void navigateToNextVerse(nextVerse) {
    navigator.pushReplacement(
      MaterialPageRoute(
        builder: (context) => VerseDetailScreenNew(
          chapterNumber: chapterNumber,
          chapterTitle: chapterTitle,
          verseNumber: (int.parse(verseNumber) + 1).toString(),
          verseText: nextVerse.text,
          meaning: nextVerse.meaning,
        ),
      ),
    );
  }

  // Handler functions with proper async handling
  void handlePreviousVerse() async {
    if (int.parse(verseNumber) > 1) {
      final previousVerse = await gitaProvider.getPreviousVerse(chapterNumber, verseNumber);
      if (previousVerse != null) {
        navigateToPreviousVerse(previousVerse);
      }
    }
  }

  void handleNextVerse() async {
    final nextVerse = await gitaProvider.getNextVerse(chapterNumber, verseNumber);
    if (nextVerse != null) {
      navigateToNextVerse(nextVerse);
    } else {
      showLastVerseMessage();
    }
  }

  void openVerseSelector() {
    showVerseSelector(context, chapterNumber, chapterTitle, verseNumber, verseText, meaning);
  }

  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: screenWidth * 0.05,
      vertical: screenHeight * 0.015,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 4,
          offset: const Offset(0, -2),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Previous verse button
        TextButton.icon(
          onPressed: int.parse(verseNumber) > 1 ? handlePreviousVerse : null,
          icon: Icon(
            Icons.arrow_back_ios,
            size: screenWidth * 0.04,
            color: int.parse(verseNumber) > 1
                ? Colors.brown[700]
                : Colors.grey[400],
          ),
          label: Text(
            'Previous',
            style: TextStyle(
              fontSize: isSmallScreen ? 12 : 14,
              color: int.parse(verseNumber) > 1
                  ? Colors.brown[700]
                  : Colors.grey[400],
            ),
          ),
        ),

        // Verse selector
        InkWell(
          onTap: openVerseSelector,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.03,
              vertical: screenHeight * 0.01,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF7AE),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Text(
                  'Verse $verseNumber',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 12 : 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.brown[800],
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  size: screenWidth * 0.05,
                  color: Colors.brown[800],
                ),
              ],
            ),
          ),
        ),

        // Next verse button
        TextButton.icon(
          onPressed: handleNextVerse,
          label: Text(
            'Next',
            style: TextStyle(
              fontSize: isSmallScreen ? 12 : 14,
              color: Colors.brown[700],
            ),
          ),
          icon: Icon(
            Icons.arrow_forward_ios,
            size: screenWidth * 0.04,
            color: Colors.brown[700],
          ),
        ),
      ],
    ),
  );
}