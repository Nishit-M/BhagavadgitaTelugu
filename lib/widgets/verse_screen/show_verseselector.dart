  
  
  
import 'package:bhagavadgita_telugu/screens/verscreen_new.dart';
import 'package:flutter/material.dart';

void showVerseSelector(BuildContext context,String chapterNumber,String chapterTitle,String verseNumber,String verseText,String meaning){
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 5,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Chapter $chapterNumber Verses',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[800],
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                // Assuming there are 47 verses in the chapter (adjust as needed)
                itemCount: 47,
                itemBuilder: (context, index) {
                  final verseNum = (index + 1).toString();
                  final isSelected = verseNum == verseNumber;

                  return InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      if (verseNum != verseNumber) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerseDetailScreenNew(
                              chapterNumber: chapterNumber,
                              chapterTitle: chapterTitle,
                              verseNumber: verseNum,
                              // You would need to get the verse text and meaning
                              verseText: verseText,
                              meaning: meaning,
                            ),
                          ),
                        );
                      }
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFFFC107)
                            : const Color(0xFFFFF7AE).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                        border: isSelected
                            ? Border.all(color: Colors.brown.shade800, width: 2)
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        verseNum,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected
                              ? Colors.brown[900]
                              : Colors.brown[700],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }