import 'package:bhagavadgita_telugu/widgets/verse_screen/audio_player.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

Widget buildVerseView(double screenWidth, double screenHeight, bool isSmallScreen,String verseText,String meaning,bool isPlaying,void Function() togglePlayback,
    double playbackProgress,
    AudioPlayer audioPlayer){
  // Calculate responsive font sizes
  final titleSize = isSmallScreen ? 14.0 : 16.0;
  final verseSize = isSmallScreen ? 16.0 : 18.0;
  final translationSize = isSmallScreen ? 16.0 : 18.0;
  
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    padding: EdgeInsets.symmetric(
      horizontal: screenWidth * 0.06,
      vertical: screenHeight * 0.02,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with decorative elements
        Row(
          children: [
            Container(
              height: 24,
              width: 3,
              decoration: BoxDecoration(
                color: Colors.amber[700],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(width: 8),
            Text(
              'श्लोक / śloka',
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.w600,
                color: Colors.brown[800],
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.02),
        
        // Verse container with improved styling
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.08,
            vertical: screenHeight * 0.03,
          ),
          decoration: BoxDecoration(
            color: Colors.brown[50],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(
              color: Colors.brown[200]!,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              // Decorative top element
              Container(
                height: 2,
                width: screenWidth * 0.2,
                decoration: BoxDecoration(
                  color: Colors.amber[700],
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              
              Text(
                verseText,
                style: TextStyle(
                  fontSize: verseSize,
                  height: 1.7,
                  color: Colors.brown[900],
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              
              // Decorative bottom element
              SizedBox(height: screenHeight * 0.02),
              Container(
                height: 2,
                width: screenWidth * 0.2,
                decoration: BoxDecoration(
                  color: Colors.amber[700],
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: screenHeight * 0.03),
        
        // Enhanced audio player
        buildAudioPlayer(
          screenWidth, 
          screenHeight, 
          isSmallScreen,
          togglePlayback, 
          isPlaying, 
          playbackProgress, 
          audioPlayer
        ),
        
        SizedBox(height: screenHeight * 0.03),
        
        // Translation header with matching style
        Row(
          children: [
            Container(
              height: 24,
              width: 3,
              decoration: BoxDecoration(
                color: Colors.amber[700],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(width: 8),
            Text(
              'Translation',
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.w600,
                color: Colors.brown[800],
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        
        SizedBox(height: screenHeight * 0.02),
        
        // Translation container with matching style
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(screenWidth * 0.06),
          decoration: BoxDecoration(
            color: Colors.brown[50],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(
              color: Colors.brown[200]!,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                meaning,
                style: TextStyle(
                  fontSize: translationSize,
                  height: 1.6,
                  color: Colors.brown[800],
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        
        // Bottom padding
        SizedBox(height: screenHeight * 0.03),
      ],
    ),
  );
}