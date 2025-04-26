import 'package:bhagavadgita_telugu/chapters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  bool _fontsLoaded = false;

  @override
  void initState() {
    super.initState();
    
    // Setup animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    // Create slide animation
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    
    // Start animation immediately
    _controller.forward();
    
    // Preload fonts while welcome screen is showing
    _preloadFonts();
  }

  // Method to preload fonts
  Future<void> _preloadFonts() async {
    try {
      // Load Telugu fonts
      await Future.wait([
        rootBundle.load('assets/fonts/NotoSansTelugu-Regular.ttf'),
        rootBundle.load('assets/fonts/NotoSansTelugu-Bold.ttf'),
        // Add any other fonts used in ChaptersScreen
      ]);
      
      if (mounted) {
        setState(() {
          _fontsLoaded = true;
        });
      }
    } catch (e) {
      print('Error preloading fonts: $e');
    } finally {
      // Navigate after animation completes
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(Duration(milliseconds: 500), () {
            if (mounted) {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => ChaptersScreen(),
                  transitionDuration: Duration(milliseconds: 500),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    var begin = Offset(1.0, 0.0);
                    var end = Offset.zero;
                    var curve = Curves.easeInOut;
                    
                    var tween = Tween(begin: begin, end: end).chain(
                      CurveTween(curve: curve)
                    );
                    
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
              );
            }
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('./assets/images/Krishna-1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.indigo.withOpacity(0.3),
                  Colors.deepPurple.withOpacity(0.5),
                ],
                stops: const [0.5, 0.8, 1.0],
              ),
            ),
          ),
          
          // Bottom Sliding Element
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: _slideAnimation,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.amber.withOpacity(0.3),
                      Colors.deepOrange.withOpacity(0.4),
                    ],
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _fontsLoaded ? Icons.check : Icons.hourglass_top,
                      color: Colors.amber,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Top Sliding Element (optional)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, -1.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _controller,
                curve: Curves.easeOut,
              )),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.transparent,
                      Colors.indigo.withOpacity(0.3),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}