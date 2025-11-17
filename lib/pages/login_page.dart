import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:otakutn/components/my_button.dart';
import 'package:otakutn/components/my_textfield.dart';
import 'package:otakutn/screens/anime/anime_list_screen.dart';
import 'package:otakutn/services/auth_service.dart';
import 'package:otakutn/pofiles/profile_screen.dart';
import 'package:otakutn/providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // sign user in method
  Future<void> signInUser() async {
    try {
      // Get the email and password from the controllers
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      
      // Validate input
      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter both email and password')),
        );
        return;
      }
      
      // loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );
      
      // Sign in with email and password
      final authService = AuthService();
      final userCredential = await authService.signInWithEmailAndPassword(email, password);
     
      
      // Hide loading indicator
      if (mounted) {
        Navigator.of(context).pop();
      }
      
      if (userCredential?.user != null) {
        // Update auth provider with user data
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        authProvider.setUser(userCredential!.user);
        
        // Navigate to profile screen after successful login
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to sign in. Please check your credentials.')),
          );
        }
      }
    } catch (e) {
      // Hide loading indicator in case of error
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Icon(Icons.lock, size: 100, color: Colors.white),
                const SizedBox(height: 50),
                const Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Color.fromARGB(255, 5, 109, 8),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                
                // Email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                
                // Password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),

                // Forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.yellow[700]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),
                
                // Sign in button
                MyButton(
                  value: "Sign In",
                  onTap: signInUser,
                ),

                const SizedBox(height: 50),

                // Not a member 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not a member? ',
                      style: TextStyle(
                        color: Color.fromARGB(255, 170, 167, 167),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
       ),
     );
  }
}