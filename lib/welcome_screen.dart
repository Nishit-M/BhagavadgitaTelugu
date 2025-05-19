// lib/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WelcomeScreen extends StatefulWidget {
  final Widget nextScreen;
  
  const WelcomeScreen({super.key, required this.nextScreen});

  @override
  State<WelcomeScreen> createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  
  @override
  void initState() {
    super.initState();
    
    // Set device to full screen mode during splash
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    
    // Initialize animation
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    
    // Start animation
    _controller.forward();
    
    // Navigate to next screen after a delay
    Future.delayed(const Duration(seconds: 3), () {
      // Restore UI visibility
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      
      // Navigate to the main app screen
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => widget.nextScreen),
        );
      }
    });
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _opacityAnimation,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Krishna-1.png"),
              fit: BoxFit.cover, // This ensures the image covers the entire screen
            ),
          ),
        ),
      ),
    );
  }
}