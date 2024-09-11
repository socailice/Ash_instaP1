import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/utils/color.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/widget/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _bioController = TextEditingController();
  final _usernameController = TextEditingController();
  Uint8List? _image;
  void _signUp() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String res = "Some error occured";
    try {
      if (_usernameController.text.isNotEmpty ||
          _emailController.text.isNotEmpty ||
          _passwordController.text.isNotEmpty ||
          _bioController.text.isNotEmpty || _image != null) {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        print('User signed up: ${userCredential.user!.uid}');
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'username': _usernameController.text,
          'uid': userCredential.user!.uid,
          'email': _emailController.text,
          'bio': _bioController.text,
          'followers': [],
          'following': [],
        });
        res = "success";
      }
    } catch (e) {
      print(e);
    }
  }

  void selectImage() async {
    Uint8List? im = await pickImage(ImageSource.gallery,ImageSource.camera);
    setState(() {
      _image = im;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              SvgPicture.asset(
                'assest/ic_instagram.svg',
                color: primaryColor,
                height: 56,
              ),
              const SizedBox(height: 32),
              Stack(
                children: [
                  _image!=null?CircleAvatar(
                    radius: 74,
                    backgroundImage: MemoryImage(_image!),):
                  const CircleAvatar(
                    radius: 74,
                    backgroundImage: NetworkImage(
                        'https://imgs.search.brave.com/xzD43YwbAAI5c0x5F1MpGhtUGPsws8ocM2aq3JP10EI/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9ibG9n/Z2VyLmdvb2dsZXVz/ZXJjb250ZW50LmNv/bS9pbWcvYi9SMjl2/WjJ4bC9BVnZYc0Vq/Wno2eFNsN0NpUFNl/TVNtNEE3aUllZE0w/NGVueU1YcUx0eGoy/VlBBYnpxMkt5Q2lB/X0hnakttN0xISnBq/eVVXUzdjUkNNbXY4/MkpCeXpmckV1RGN6/S29ZOThTczhBZ2Q1/QkJSSkpKV3BUXzJx/MnNteFA0bC1EN2gt/QzMzLXFmX3B2UHZ0/aGIwOG4wVmhLQ3kx/RU14WEh1SUwxamp4/UnVac1BLeElQajYz/ckxVMkMwTVdybE5t/QjdvXzIvczYwMC9J/bnN0YWdyYW1fRGVm/YXVsdF9Qcm9maWxl/X1BpY3R1cmVfTm9f/UGZwXzY2LmpwZw'),
                  ),
                  
                  Positioned(
                      bottom: -10,
                      left: 110,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                        color: Colors.blue,
                      )),
                ],
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your Username',
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter your Email',
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Enter your Password',

                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _bioController,
                decoration: const InputDecoration(
                  hintText: 'Enter your bio',
                ),
              ),
              // const SizedBox(height: 24),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _signUp,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(9))),
                      color: blueColor),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const SizedBox(
                height: 12,
              ),
              Flexible(child: Container(), flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Don't have an account?"),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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




// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {

//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _bioController = TextEditingController();
//   final TextEditingController _usernameController = TextEditingController();

//   @override
//   void dispose() {
//     super.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _bioController.dispose();
//     _usernameController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal:16),
//           width: double.infinity,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Flexible(
//                 flex: 1,
//                 child: Container(),
//               ),
//               SvgPicture.asset(
//                 'assest/ic_instagram.svg',
//                 color: primaryColor,
//                 height:56,
//               ),
//               const SizedBox(height: 32),
//               Stack(
//                 children: [
//                   const CircleAvatar(
//                     radius: 74,
//                     backgroundImage: NetworkImage('https://images.unsplash.com/photo-1698711864764-c9150adc9f36?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
//                   ),
//                   Positioned(
//                     bottom:-10,
//                     left: 110,
//                     child: IconButton(onPressed:(){},icon: const Icon(Icons.add_a_photo),color: Colors.blue,)),
//                 ],
//               ),
//               const SizedBox(height: 24),
//               TextFieldInput(
//                 hintText: 'Enter your Username',
//                 textInputType: TextInputType.text,
//                 textEditingController: _usernameController,
//               ),
//               const SizedBox(height: 24),
//               TextFieldInput(
//                 hintText: 'Enter your Email',
//                 textInputType: TextInputType.text,
//                 textEditingController: _emailController,
//               ),
//               const SizedBox(height: 24),
//               TextFieldInput(
//                 hintText: 'Enter your Password',
//                 textInputType: TextInputType.text,
//                 textEditingController: _passwordController,
//                 isPass: true,
//               ),
//               const SizedBox(height: 24),
//               TextFieldInput(
//                 hintText: 'Enter your Bio',
//                 textInputType: TextInputType.text,
//                 textEditingController: _bioController,
//               ),
//               // const SizedBox(height: 24),
//               const SizedBox(height: 24),
//               InkWell(
//                 onTap: ()
//                 async {
//                   String res=await AuthMethods().signUpUser(
//                   username: _usernameController.text,
//                   email: _emailController.text,
//                   password: _passwordController.text,
//                   bio: _bioController.text,
//               );
//               print(res);},
//                 child: Container(
//                   width: double.infinity,
//                   alignment: Alignment.center,
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   decoration: const ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(9))),color: blueColor),
//                   child: const Text("Sign Up",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900),),
//                 ),
//               ),
//               const SizedBox(height: 24),
//               const SizedBox(
//                 height: 12,
//               ),
//               Flexible(child: Container(),flex: 1),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(vertical: 8),
//                     child: const Text("Don't have an account?"),
//                   ),
//                   GestureDetector(
//                     onTap: () {},
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(vertical: 8),
//                       child: const Text("Sign up",style: TextStyle(fontWeight: FontWeight.bold),),
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({Key? key}) : super(key: key);

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _bioController = TextEditingController();
//   bool _isLoading = false;

//   @override
//   void dispose() {
//     super.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _bioController.dispose();
//     _usernameController.dispose();
//   }

//   void signUpUser() async {
//     // set loading to true
//     setState(() {
//       _isLoading = true;
//     });

//     // signup user using our authmethodds
//     String res = await AuthMethods().signUpUser(
//       email: _emailController.text,
//       password: _passwordController.text,
//       username: _usernameController.text,
//       bio: _bioController.text,
//     );
//     // if string returned is sucess, user has been created
//     if (res == "success") {
//       setState(() {
//         _isLoading = false;
//       });
      // navigate to the home screen
      //     if (context.mounted) {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (context) => const ResponsiveLayout(
      //             mobileScreenLayout: MobileScreenLayout(),
      //             webScreenLayout: WebScreenLayout(),
      //           ),
      //         ),
      //       );
      //     }
      //   } else {
      //     setState(() {
      //       _isLoading = false;
      //     });
      //     // show the error
      //     if (context.mounted) {
      //       showSnackBar(context, res);
      //     }
      //   }
      // }

      // selectImage() async {
      //   Uint8List im = await pickImage(ImageSource.gallery);
      //   // set state because we need to display the image we selected on the circle avatar
      //   setState(() {
      //     _image = im;
      //   });
      // }

//       @override
//       Widget build(BuildContext context) {
//         return Scaffold(
//           resizeToAvoidBottomInset: false,
//           body: SafeArea(
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 32),
//               width: double.infinity,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Flexible(
//                     flex: 2,
//                     child: Container(),
//                   ),
//                   SvgPicture.asset(
//                     'assets/ic_instagram.svg',
//                     color: primaryColor,
//                     height: 64,
//                   ),
//                   const SizedBox(
//                     height: 64,
//                   ),
//                   Stack(
//                     children: [
//                       // _image != null
//                       //     ? CircleAvatar(
//                       //         radius: 64,
//                       //         backgroundImage: MemoryImage(_image!),
//                       //         backgroundColor: Colors.red,
                            
//                            const CircleAvatar(
//                               radius: 64,
//                               backgroundImage: NetworkImage(
//                                   'https://i.stack.imgur.com/l60Hf.png'),
//                               backgroundColor: Colors.red,
//                             ),
//                       Positioned(
//                         bottom: -10,
//                         left: 80,
//                         child: IconButton(
//                           onPressed: () {},
//                           icon: const Icon(Icons.add_a_photo),
//                         ),
//                       )
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 24,
//                   ),
//                   TextFieldInput(
//                     hintText: 'Enter your username',
//                     textInputType: TextInputType.text,
//                     textEditingController: _usernameController,
//                   ),
//                   const SizedBox(
//                     height: 24,
//                   ),
//                   TextFieldInput(
//                     hintText: 'Enter your email',
//                     textInputType: TextInputType.emailAddress,
//                     textEditingController: _emailController,
//                   ),
//                   const SizedBox(
//                     height: 24,
//                   ),
//                   TextFieldInput(
//                     hintText: 'Enter your password',
//                     textInputType: TextInputType.text,
//                     textEditingController: _passwordController,
//                     isPass: true,
//                   ),
//                   const SizedBox(
//                     height: 24,
//                   ),
//                   TextFieldInput(
//                     hintText: 'Enter your bio',
//                     textInputType: TextInputType.text,
//                     textEditingController: _bioController,
//                   ),
//                   const SizedBox(
//                     height: 24,
//                   ),
//                   InkWell(
//                     onTap: signUpUser,
//                     child: Container(
//                       width: double.infinity,
//                       alignment: Alignment.center,
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       decoration: const ShapeDecoration(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(4)),
//                         ),
//                         color: blueColor,
//                       ),
//                       child: !_isLoading
//                           ? const Text(
//                               'Sign up',
//                             )
//                           : const CircularProgressIndicator(
//                               color: primaryColor,
//                             ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 12,
//                   ),
//                   Flexible(
//                     flex: 2,
//                     child: Container(),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(vertical: 8),
//                         child: const Text(
//                           'Already have an account?',
//                         ),
//                       ),
//                       GestureDetector(onTap: () {}
//                           // => Navigator.of(context).push(
//                           //   MaterialPageRoute(
//                           //     builder: (context) => const LoginScreen(),
//                           //
//                           ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }
//     }
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
