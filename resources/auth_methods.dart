// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:instagram_flutter/screen/Signup_screen.dart';


// class AuthMethods {
//   Future<String> _signUp({
//     required String username,
//     required String email,
//     required String password,
//     required String bio,
//     //required Uint8List file,
//   })
//   async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       print('User signed up: ${userCredential.user!.email}');
//     } catch (e) {
//       throw Exception(e);
//     }
//   }
// }










// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// // import 'package:instagram_flutter/resources/auth_methods.dart';
// // import 'package:instagram_flutter/utils/color.dart';
// // import 'package:instagram_flutter/widget/text_field_input.dart';

// // class AuthMethods {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //   Future<String> signUpUser({
// //     required String username,
// //     required String email,
// //     required String password,
// //     required String bio,
// //     //required Uint8List file,
// //   }) async {
// //     String res = "Some error occured";
// //     print("Email: $email");
// //     print("Password: $password");
// //     print("Username: $username");
// //     print("Bio: $bio");
// //     try {
// //       if (email.isNotEmpty ||
// //           password.isNotEmpty ||
// //           username.isNotEmpty ||
// //           bio.isNotEmpty ) {
// //             UserCredential cred = await _auth.createUserWithEmailAndPassword(
// //               email: email.trim(),
// //               password: password.trim(),
// //         );
// //         print(cred.user!.uid);
// //         await _firestore.collection('users').doc(cred.user!.uid).set({
// //           'username': username,
// //           'uid': cred.user!.uid,
// //           'email': email,
// //           'bio': bio,
// //           'followers': [],
// //           'following': [],
// //         });
// //         res = "success";
// //       }
// //       else{
// //         res="Please enter all the fields";
// //       }
// //     } catch (err) {
// //       print("error is $err");
// //       res = err.toString();
// //     }
// //     return res;
// //   }
// // }
