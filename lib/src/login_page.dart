import 'package:cloud_firestore/cloud_firestore.dart';
                 import 'package:flutter/material.dart';
                 import 'package:firebase_auth/firebase_auth.dart';
                 import 'package:font_awesome_flutter/font_awesome_flutter.dart';

                 class LoginPage extends StatefulWidget {
                   const LoginPage({super.key});

                   @override
                   _LoginPageState createState() => _LoginPageState();
                 }

                 class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
                   final _formKey = GlobalKey<FormState>();
                   final TextEditingController _emailController = TextEditingController();
                   final TextEditingController _passwordController = TextEditingController();
                   final FirebaseAuth _auth = FirebaseAuth.instance;
                   bool _isLoading = false;
                   late AnimationController _animationController;
                   late Animation<double> _animation;

                   @override
                   void initState() {
                     super.initState();
                     _animationController = AnimationController(
                       duration: const Duration(seconds: 1),
                       vsync: this,
                     );
                     _animation = CurvedAnimation(
                       parent: _animationController,
                       curve: Curves.easeIn,
                     );
                     _animationController.forward();
                   }

                   @override
                   void dispose() {
                     _animationController.dispose();
                     super.dispose();
                   }

                   void _login() async {
                     if (_formKey.currentState!.validate()) {
                       setState(() {
                         _isLoading = true;
                       });
                       try {
                         UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                           email: _emailController.text,
                           password: _passwordController.text,
                         );

                         // Fetch the user's name from Firestore
                         DocumentSnapshot userDoc = await FirebaseFirestore.instance
                             .collection('users')
                             .doc(userCredential.user!.uid)
                             .get();
                         String userName = userDoc['first_name'];

                         // Navigate to the welcome page with the user's name
                         Navigator.pushReplacementNamed(
                           context,
                           '/welcome',
                           arguments: {'userName': userName},
                         );
                       } on FirebaseAuthException catch (e) {
                         // Show error message
                         ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(content: Text('Login failed: ${e.message}')),
                         );
                       } finally {
                         setState(() {
                           _isLoading = false;
                         });
                       }
                     }
                   }

                   @override
                   Widget build(BuildContext context) {
                     return Scaffold(
                       body: Stack(
                         children: [
                           Container(
                             decoration: BoxDecoration(
                               color: Colors.white,
                             ),
                           ),
                           Center(
                             child: SingleChildScrollView(
                               padding: const EdgeInsets.all(16.0),
                               child: Form(
                                 key: _formKey,
                                 child: FadeTransition(
                                   opacity: _animation,
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: <Widget>[
                                       Image.asset(
                                         'assets/images/app_logo.png',
                                         height: 120,
                                       ),
                                       SizedBox(height: 20),
                                       Container(
                                         padding: EdgeInsets.all(16.0),
                                         decoration: BoxDecoration(
                                           color: Colors.white70,
                                           borderRadius: BorderRadius.circular(8.0),
                                           boxShadow: [
                                             BoxShadow(
                                               color: Colors.black26,
                                               spreadRadius: 5,
                                               blurRadius: 7,
                                               offset: Offset(0, 3),
                                             ),
                                           ],
                                         ),
                                         child: Column(
                                           children: <Widget>[
                                             TextFormField(
                                               controller: _emailController,
                                               decoration: InputDecoration(
                                                 labelText: 'Email',
                                                 border: OutlineInputBorder(
                                                   borderRadius: BorderRadius.circular(8.0),
                                                 ),
                                               ),
                                               validator: (value) {
                                                 if (value == null || value.isEmpty) {
                                                   return 'Please enter your email';
                                                 }
                                                 return null;
                                               },
                                             ),
                                             SizedBox(height: 20),
                                             TextFormField(
                                               controller: _passwordController,
                                               decoration: InputDecoration(
                                                 labelText: 'Password',
                                                 border: OutlineInputBorder(
                                                   borderRadius: BorderRadius.circular(8.0),
                                                 ),
                                               ),
                                               obscureText: true,
                                               validator: (value) {
                                                 if (value == null || value.isEmpty) {
                                                   return 'Please enter your password';
                                                 }
                                                 return null;
                                               },
                                             ),
                                             SizedBox(height: 20),
                                             _isLoading
                                                 ? CircularProgressIndicator()
                                                 : ElevatedButton(
                                                     onPressed: _login,
                                                     style: ElevatedButton.styleFrom(
                                                       backgroundColor: Colors.blue[100],
                                                       shape: RoundedRectangleBorder(
                                                         borderRadius: BorderRadius.circular(8.0),
                                                       ),
                                                       padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                                       textStyle: TextStyle(fontSize: 18),
                                                     ),
                                                     child: Text('Login'),
                                                   ),
                                             TextButton(
                                               onPressed: () {
                                                 Navigator.pushNamed(context, '/register');
                                               },
                                               child: Text('Don\'t have an account? Register'),
                                             ),
                                             TextButton(
                                               onPressed: () {
                                                 Navigator.pushNamed(context, '/reset-password');
                                               },
                                               child: Text('Forgot Password?'),
                                             ),
                                             SizedBox(height: 20),
                                             Text('or login with'),
                                             SizedBox(height: 10),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: [
                                                 IconButton(
                                                   icon: Icon(FontAwesomeIcons.facebook),
                                                   onPressed: () {
                                                     // Handle Facebook login
                                                   },
                                                 ),
                                                 IconButton(
                                                   icon: Icon(FontAwesomeIcons.google),
                                                   onPressed: () {
                                                     // Handle Google login
                                                   },
                                                 ),
                                               ],
                                             ),
                                           ],
                                         ),
                                       ),
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