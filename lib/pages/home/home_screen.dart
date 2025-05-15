import 'package:flutter/material.dart';
import 'package:pedal_project/pages/componentes/navbar.dart';
import 'package:pedal_project/pages/desafio/desafio_semanal.dart';
import 'package:pedal_project/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/bar.png',
                    height: 25,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 134, 123, 160),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      elevation: 0,
                    ),
                    onPressed: () async {
                      await AuthService().signout(context: context);
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // CONTEÚDO PRINCIPAL do PEDALL!!
              const Expanded(
                child: Column(
                  children: [
                    DesafioSemanal(km: '30,00'),
                    // BottomBarExample(),
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
