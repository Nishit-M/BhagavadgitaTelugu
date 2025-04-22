import 'dart:async';
import 'package:bhagavadgita_telugu/widgets/verse_screen/navigationbar.dart';
import 'package:bhagavadgita_telugu/widgets/verse_screen/verseview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bhagavadgita_telugu/provider/gita_provider.dart';
import 'package:just_audio/just_audio.dart';

class VerseDetailScreenNew extends StatefulWidget {
  final String chapterNumber;
  final String chapterTitle;
  final String verseNumber;
  final String verseText;
  final String meaning;

  const VerseDetailScreenNew({
    super.key,
    required this.chapterNumber,
    required this.chapterTitle,
    required this.verseNumber,
    required this.verseText,
    required this.meaning,
  });

  @override
  State<VerseDetailScreenNew> createState() => _VerseDetailScreenNewState();
}

class _VerseDetailScreenNewState extends State<VerseDetailScreenNew>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isPlaying = false;
  double playbackProgress = 0.0;
  bool isFavorite = false;
  Timer? progressTimer;
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Provider.of<GitaProvider>(context, listen: false)
        .ensureChapterLoaded(widget.chapterNumber);
    // Initialize audio player
    audioPlayer = AudioPlayer();
    // Here you would set up the audio source from your assets or network
    _loadAudio();
  }

  @override
  void dispose() {
    _tabController.dispose();
    progressTimer?.cancel();
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _loadAudio() async {
    try {
      await audioPlayer.setAsset(
          './audio/chapter_${widget.chapterNumber}/verse_${widget.verseNumber}.mp3');
    } catch (e) {
      print('Error loading audio: $e');
    }
  }

  void togglePlayback() {
    setState(() {
      isPlaying = !isPlaying;

      if (isPlaying) {
        // Start actual audio playback
        audioPlayer.play();

        // Set up a timer to update the progress UI
        if (progressTimer == null || !progressTimer!.isActive) {
          progressTimer =
              Timer.periodic(const Duration(milliseconds: 100), (timer) {
            setState(() {
              // Get actual playback position from the audio player
              double currentPosition =
                  audioPlayer.position.inMilliseconds.toDouble();
              double totalDuration =
                  audioPlayer.duration?.inMilliseconds.toDouble() ?? 0.0;

              // Calculate progress as a value between 0.0 and 1.0
              playbackProgress =
                  totalDuration > 0 ? currentPosition / totalDuration : 0.0;

              // Check if playback has ended
              if (playbackProgress >= 0.99) {
                playbackProgress = 0.0;
                isPlaying = false;
                timer.cancel();
              }
            });
          });
        }
      } else {
        // Pause the audio playback
        audioPlayer.pause();

        // Stop the progress timer
        if (progressTimer != null && progressTimer!.isActive) {
          progressTimer!.cancel();
        }
      }
    });
  }

// Add this to your initState or constructor
  void setupAudioPlayerListeners() {
    // Listen for playback completion
    audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        setState(() {
          playbackProgress = 0.0;
          isPlaying = false;
          if (progressTimer != null && progressTimer!.isActive) {
            progressTimer!.cancel();
          }
        });
      }
    });
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text(isFavorite ? 'Added to favorites' : 'Removed from favorites'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _shareVerse() {
    // Using share_plus package
    // Share.share(
    //   'Bhagavad Gita - Chapter ${widget.chapterNumber}, Verse ${widget.verseNumber}\n\n'
    //   '${widget.verseText}\n\n'
    //   'Meaning: ${widget.meaning}'
    // );

    // Placeholder
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Sharing functionality will be implemented')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final isSmallScreen = screenWidth < 360;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.brown[800]),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.chapterTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
              ),
            ),
            const SizedBox(width: 8),
            const Text("•"),
            const SizedBox(width: 8),
            Text(
              widget.chapterNumber,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
              ),
            ),
            const SizedBox(width: 8),
            const Text("•"),
            const SizedBox(width: 8),
            Text(
              widget.verseNumber,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.brown[800],
            ),
            onPressed: _toggleFavorite,
            tooltip: 'Add to Favorites',
          ),
          IconButton(
            icon: Icon(Icons.share, color: Colors.brown[800]),
            onPressed: _shareVerse,
            tooltip: 'Share Verse',
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFFFF7AE).withOpacity(0.8),
              const Color(0xFFFFF1D0).withOpacity(0.9),
            ],
          ),
          image: const DecorationImage(
            opacity: 0.2,
            image: AssetImage('./assets/images/Verses.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Tab content
              Expanded(
                child: buildVerseView(
                    screenWidth,
                    screenHeight,
                    isSmallScreen,
                    widget.verseText,
                    widget.meaning,
                    isPlaying,
                    togglePlayback,
                    playbackProgress,
                    audioPlayer),
              ),

              // Navigation bar
              buildNavigationBar(
                  context,
                  screenWidth,
                  screenHeight,
                  isSmallScreen,
                  widget.chapterNumber,
                  widget.chapterTitle,
                  widget.verseNumber,
                  widget.verseText,
                  widget.meaning),
            ],
          ),
        ),
      ),
    );
  }

}
