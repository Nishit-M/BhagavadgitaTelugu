import 'package:bhagavadgita_telugu/chapters_screen.dart';
import 'package:bhagavadgita_telugu/provider/gita_provider.dart';
import 'package:bhagavadgita_telugu/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GitaProvider()),
        // Add other providers if needed
      ],
      child: const Bhagavadgita(),
    ),
  );
}

class Bhagavadgita extends StatelessWidget {
  const Bhagavadgita({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(
        nextScreen: ChaptersScreen(),
      ),
    );
  }
}
