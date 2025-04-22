import 'package:bhagavadgita_telugu/screens/verscreen_new.dart';
import 'package:flutter/material.dart';

class VerseNavigationBar extends StatelessWidget {
  final BuildContext context;
  final double screenWidth;
  final double screenHeight;
  final bool isSmallScreen;
  final String chapterNumber;
  final String chapterTitle;
  final String verseNumber;
  final VoidCallback onSelectVerse;

  const VerseNavigationBar({
    super.key,
    required this.context,
    required this.screenWidth,
    required this.screenHeight,
    required this.isSmallScreen,
    required this.chapterNumber,
    required this.chapterTitle,
    required this.verseNumber,
    required this.onSelectVerse,
  });

  @override
  Widget build(BuildContext context) {
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
          // Previous button
          TextButton.icon(
            onPressed: () {
              if (int.parse(verseNumber) > 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerseDetailScreenNew(
                      chapterNumber: chapterNumber,
                      chapterTitle: chapterTitle,
                      verseNumber:
                          (int.parse(verseNumber) - 1).toString(),
                      verseText: 'Previous verse text',
                      meaning: 'Previous verse meaning',
                    ),
                  ),
                );
              }
            },
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
            onTap: onSelectVerse,
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

          // Next button
          TextButton.icon(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => VerseDetailScreenNew(
                    chapterNumber: chapterNumber,
                    chapterTitle: chapterTitle,
                    verseNumber: (int.parse(verseNumber) + 1).toString(),
                    verseText: 'Next verse text',
                    meaning: 'Next verse meaning',
                  ),
                ),
              );
            },
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
}
