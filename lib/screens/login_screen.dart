import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 170),
              child: Image.asset('assets/images/pedalmais.png'),
            ),
            SizedBox(height: 93),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelStyle: GoogleFonts.montserrat(
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
                      hintText: 'Username',
                      hintStyle: GoogleFonts.montserrat(
                        color: const Color.fromARGB(255, 146, 146, 146),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelStyle: GoogleFonts.montserrat(
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
                      hintText: 'Password',
                      hintStyle: GoogleFonts.montserrat(
                        color: const Color.fromARGB(255, 146, 146, 146),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  GestureDetector(
                    onTap: () => {print('Botão clicado!!')},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 155,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 148, 77, 206),
                            Color.fromRGBO(65, 53, 175, 1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        'Entrar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Eu tenho uma conta',
                    style: GoogleFonts.montserrat(
                      color: Colors.purple[800],
                      fontSize: 16,
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
