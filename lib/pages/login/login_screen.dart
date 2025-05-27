import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pedal_project/pages/login/login_screen.dart';
import 'package:pedal_project/pages/signup/signup_screen.dart';
import 'package:pedal_project/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView( // para fazer a rolagme de pagina
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 120),
          Center(
            child: Image.asset('assets/images/pedalmais.png', height: 150),
          ),
          const SizedBox(height: 80),

          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: 'E-mail',
              hintStyle: GoogleFonts.montserrat(
                color: const Color.fromARGB(255, 146, 146, 146),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 221, 221, 221),
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 221, 221, 221),
                  width: 2,
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),

          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Senha',
              hintStyle: GoogleFonts.montserrat(
                color: const Color.fromARGB(255, 146, 146, 146),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 221, 221, 221),
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 221, 221, 221),
                  width: 2,
                ),
              ),
            ),
          ),

          const SizedBox(height: 60),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              backgroundColor: const Color.fromARGB(255, 148, 77, 206),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () async {
              await AuthService().signIn(
                email: _emailController.text,
                password: _passwordController.text,
                context: context,
              );
            },
            child: const Text(
              'Entrar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 40),

          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupPage()),
                );
              },
              child: Text(
                'Não tenho uma conta',
                style: GoogleFonts.montserrat(
                  color: Colors.purple[800],
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
