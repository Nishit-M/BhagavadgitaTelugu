import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

String _formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "$twoDigitMinutes:$twoDigitSeconds";
}

Widget buildAudioPlayer(
    double screenWidth,
    double screenHeight,
    bool isSmallScreen,
    void Function() togglePlayback,
    bool isPlaying,
    double playbackProgress,
    AudioPlayer audioPlayer) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(
      horizontal: screenWidth * 0.05,
      vertical: screenHeight * 0.015,
    ),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      color: Color.fromARGB(255, 245, 234, 187),
    ),
    child: Row(
      children: [
        // Play/pause button
        InkWell(
          onTap: togglePlayback,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            width: screenWidth * 0.1,
            height: screenWidth * 0.1,
            decoration: BoxDecoration(
              color: const Color(0xFFFFC107),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.withOpacity(0.4),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.brown[800],
              size: screenWidth * 0.06,
            ),
          ),
        ),

        // Progress bar
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinearProgressIndicator(
                  value: playbackProgress,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                ),
                SizedBox(height: screenHeight * 0.005),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(Duration(
                          milliseconds: (playbackProgress *
                                  (audioPlayer.duration?.inMilliseconds ?? 0))
                              .round())),
                      style: TextStyle(
                        fontSize: isSmallScreen ? 10 : 12,
                        color: Colors.brown[700],
                      ),
                    ),
                    StreamBuilder<Duration?>(
                        stream: audioPlayer.durationStream,
                        builder: (context, snapshot) {
                          final duration = snapshot.data ?? Duration.zero;
                          return Text(
                            _formatDuration(duration),
                            style: TextStyle(
                              fontSize: isSmallScreen ? 10 : 12,
                              color: Colors.brown[700],
                            ),
                          );
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}


