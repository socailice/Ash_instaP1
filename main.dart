import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_flutter/responsive/responsive_layout_screen.dart';
import 'package:instagram_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_flutter/screen/login_screen.dart';
import 'package:instagram_flutter/screen/signup_screen.dart';
import 'package:instagram_flutter/utils/color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyCP5LwAP-3u37TA3N0Rt0Jj1OUfkkNDXJs',
            appId: '1:604977400011:android:526c4b7f6b1d70a354334e',
            messagingSenderId: '604977400011',
            projectId: 'instagram-e5ef8',
            storageBucket: 'instagram-e5ef8.appspot.com'));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.active){
            if(snapshot.hasData){
              return const ResponsiveLayout(
                  webScreenLayout: WebScreen(), mobileScreenLayout: MobileScreen());
            }
            else if(snapshot.hasError){
              return Center(child: Text('${snapshot.error}'),);
            }
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(
              color: primaryColor,
            ),);
          }
          return const SignupScreen();
        }));
  }
}
