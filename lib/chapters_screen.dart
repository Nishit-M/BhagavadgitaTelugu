import 'package:bhagavadgita_telugu/provider/gita_provider.dart';
import 'package:bhagavadgita_telugu/screens/chapterdetailsscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChaptersScreen extends StatefulWidget {
  const ChaptersScreen({super.key});

  @override
  State<ChaptersScreen> createState() => chaptersScreenState();
}

class chaptersScreenState extends State<ChaptersScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<GitaProvider>(context,listen: false).loadChaptersList();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    // final padding = mediaQuery.padding;
    final isSmallScreen = screenWidth < 360;
    final chapters = Provider.of<GitaProvider>(context).chapters;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'శ్రీమద్భగవద్గీత',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isSmallScreen ? 20 : 24,
            color: Colors.brown[800],
            shadows: [
              Shadow(
                offset: const Offset(1, 1),
                blurRadius: 3.0,
                color: Colors.amber.withOpacity(0.6),
              ),
            ],
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            // Implement drawer or navigation logic
          }, 
          icon: Icon(Icons.menu_rounded, color: Colors.brown[800]),
          tooltip: 'Menu',
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Implement search functionality
            }, 
            icon: Icon(Icons.search, color: Colors.brown[800]),
            tooltip: 'Search',
          )
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
              const Color(0xFFFFF7AE),
              const Color(0xFFFFF7AE).withOpacity(0.8),
              const Color(0xFFFFF1D0).withOpacity(0.9),
            ],
          ),
          image: DecorationImage(
            opacity: 0.2,
            image: const AssetImage('./assets/images/Verses.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.amber.withOpacity(0.2),
              BlendMode.softLight,
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header Banner
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.015,
                ),
                child: Hero(
                  tag: 'gita-banner',
                  child: Container(
                    height: screenHeight * 0.22,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('./assets/images/Krishna-3.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    // Optional overlay for text readability
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.5),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.6],
                        ),
                      ),
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
              ),
                    
              // Chapter List
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: chapters.length,
                    itemBuilder: (context, index) {
                      // print('Chapters_verses: ${chapters[index].name}');
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.005,
                          horizontal: screenWidth * 0.02,
                        ),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: Colors.white.withOpacity(0.85),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            splashColor: Colors.amber.withOpacity(0.3),
                            onTap: () {
                              // Navigate to chapter details
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChapterDetailScreen(
                                    chapterNumber: chapters[index].number,
                                    chapterTitle: chapters[index].name,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: ListTile(
                                leading: Container(
                                  width: screenWidth * 0.12,
                                  height: screenWidth * 0.12,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF7AE),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.amber.withOpacity(0.5),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      chapters[index].number,
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.045,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.brown[800],
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  chapters[index].name,
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 14 : 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.brown[800],
                                  ),
                                ),
                                subtitle: Text(
                                  chapters[index].name,
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 12 : 14,
                                    color: Colors.brown[600],
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: screenWidth * 0.04,
                                  color: Colors.amber[700],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}