import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pedal_project/pages/home/home_screen.dart';
import 'package:pedal_project/pages/settings/editar_desafio.dart';

class SettingsPage extends StatelessWidget {
  final String documentId;

  const SettingsPage({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final docRef = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(userId)
        .collection('desafios')
        .doc(documentId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => EditarDesafioPage(documentId: documentId),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 124, 172, 211),
                minimumSize: const Size(
                  double.infinity, // largura infinita
                  50, // altura 50
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4), //bordas
                ),
              ),
              child: const Text(
                'Alterar desafio',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await docRef.delete(); // Delete em FIrebase!!
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Desafio deletado com sucesso')),
                );
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil('/home', (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 223, 111, 103),
                minimumSize: const Size(
                  double.infinity, // largura infinita
                  50, // altura 50
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4), //bordas
                ),
              ),
              child: const Text(
                'Deletar desafio',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
