import 'package:flutter/material.dart';
import 'package:frontend/AIresponse/AIhome.dart';
import 'package:frontend/AIresponse/screens/app.dart';
import 'package:frontend/aichat/aichatscreen.dart';
import 'package:frontend/components/splash.dart';
import 'package:frontend/profile/demoprofile.dart';
import 'package:frontend/resource/resourcehome.dart';
import 'package:frontend/AIresponse/providers/q_a_provider.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

// Global navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  String? geminiAPIKey = dotenv.env['GEMINI_API_KEY'];

  // Initialize Gemini if key is found
  if (geminiAPIKey != null && geminiAPIKey.isNotEmpty) {
    Gemini.init(apiKey: geminiAPIKey);
  } else {
    print('⚠️ GEMINI_API_KEY not found in .env');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QAProvider()),
      ],
      child: MaterialApp(
        title: 'Nyayapath',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        home: SplashScreen(), // Start with splash screen
        routes: {
          '/ai': (_) => const App(), // Your Gemini AI assistant entry point
        },
      ),
    );
  }
}
