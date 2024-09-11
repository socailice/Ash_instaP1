import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter/screen/signup_screen.dart';
import 'package:instagram_flutter/utils/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:instagram_flutter/widget/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final  _emailcontroller = TextEditingController();
  final  _passwordcontroller = TextEditingController();

  void _login() async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignupScreen()),  // Navigate to HomePage after login
    );
  } catch (e) {
    print(e);
  }
}

  @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _emailcontroller.dispose();
  //   _passwordcontroller.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              SvgPicture.asset(
                'assest/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 64),
              TextField(
                controller: _emailcontroller,
                decoration: const InputDecoration(
                  hintText: "Enter your email",
                  border: InputBorder.none,
                  filled: true,
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _passwordcontroller,
                decoration: const InputDecoration(
                  hintText: "Enter your password",
                  border: InputBorder.none,
                  filled: true,
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _login,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(9))),color: blueColor),
                  child: const Text("Log in"),
                ),
              ),
              const SizedBox(height: 36),
              const SizedBox(
                height: 12,
              ),
              Flexible(child: Container(),flex: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Don't have an account? "),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text("Sign up",style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  )
                ],  
              )
            ],
          ),
        ),
      ),
    );
  }
}
