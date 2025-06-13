import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pedal_project/pages/desafio/desafio_semanal.dart';
import 'package:pedal_project/pages/desafio/seus_desafios.dart';
import 'package:pedal_project/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userId;

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser?.uid;
  }

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return const Center(child: Text('usueario não logado'));
    }

    final desafiosRef = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(userId)
        .collection('desafios');

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/bar.png', height: 25),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 134, 123, 160),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                      elevation: 0,
                    ),
                    onPressed: () async {
                      await AuthService().signout(context: context);
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // CONTEÚDO PRINCIPAL do PEDALL!!
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const DesafioSemanal(km: '30,00'),
                      const SizedBox(height: 24),
                      Text(
                        'Seus Desafios',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 49, 46, 49),
                          // Para testar: cor preta => Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: Container(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: desafiosRef.snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return const Center(
                                  child: Text('Nenhum desafio encontrado.'),
                                );
                              }

                              final desafios = snapshot.data!.docs;

                              return ListView.builder(
                                itemCount: desafios.length,
                                itemBuilder: (context, index) {
                                  final desafio = desafios[index];
                                  final id = desafio.id;
                                  final titulo =
                                      desafio['titulo'] ?? 'Sem título';
                                  final status =
                                      desafio['status'] ?? 'Sem status';

                                  return SeusDesafios(
                                    documentId: id,
                                    titulo: titulo,
                                    status: status,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 64,
                height: 64,
                child: FloatingActionButton(
                  heroTag: 'mapa',
                  backgroundColor: const Color.fromARGB(255, 89, 148, 211),
                  shape: const CircleBorder(),
                  elevation: 4,
                  onPressed: () {
                    Navigator.pushNamed(context, '/mapa');
                  },
                  child: const Icon(Icons.map, size: 28, color: Colors.white),
                ),
              ),
              const SizedBox(width: 20), 
              SizedBox(
                width: 64,
                height: 64,
                child: FloatingActionButton(
                  heroTag: 'criarEvento',
                  backgroundColor: const Color.fromARGB(255, 142, 89, 211),
                  shape: const CircleBorder(),
                  elevation: 4,
                  onPressed: () {
                    Navigator.pushNamed(context, '/criarEvento');
                  },
                  child: const Icon(Icons.add, size: 32, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
