import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pedal_project/pages/settings/settings.dart';

class DetalhesDesafioPage extends StatelessWidget {
final String documentId;

const DetalhesDesafioPage({super.key, required this.documentId});

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
    backgroundColor: Colors.white,
    actions: [
        IconButton(
        icon: const Icon(
            Icons.settings,
            color: Color.fromARGB(255, 77, 78, 146),
            size: 40,
        ),
        onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SettingsPage(documentId: documentId),
            ),
            );
        },
        ),
    ],
    ),
    body: FutureBuilder<DocumentSnapshot>(
    future: docRef.get(), // GET PELO FIREBASE!!! :D
    builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
        return const Center(child: Text('Desafio não encontrado.'));
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        return Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
            children: [
            Text(
                data['dataInicio'],
                style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color.fromARGB(255, 126, 126, 126),
                ),
            ),
            Text(
                data['titulo'] ?? 'Sem título',
                style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                ),
            ),
            Divider(color: Colors.grey, height: 40, thickness: 1),
            const SizedBox(height: 15),

            Row(
                children: [
                Text(
                    'Status: ',
                    style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 76, 71, 175),
                    ),
                ),
                Text(
                    '${data['status'] ?? 'Sem status'}',
                    style: GoogleFonts.montserrat(fontSize: 18),
                ),
                ],
            ),
            const SizedBox(height: 12),

            Row(
                children: [
                const SizedBox(height: 15),
                Text(
                    'Distância em Km: ',
                    style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 76, 71, 175),
                    ),
                ),
                if (data.containsKey('distancia'))
                    Text(
                    data['distancia'],
                    style: GoogleFonts.montserrat(fontSize: 18),
                    ),
                ],
            ),
            const SizedBox(height: 15),

            Text(
                'Descrição: ',
                style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 76, 71, 175),
                ),
            ),
            if (data.containsKey('descricao'))
                Text(
                data['descricao'],
                style: GoogleFonts.montserrat(fontSize: 18),
                ),
            const SizedBox(height: 120),
            Text(
                'Data de término: ',
                style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 76, 71, 175),
                ),
            ),
            if (data.containsKey('dataFinal'))
                Text(
                data['dataFinal'],
                style: GoogleFonts.montserrat(fontSize: 18),
                ),
            const SizedBox(height: 220),
            ElevatedButton(
                onPressed: () async {
                await docRef.update({'status': 'Concluído'});
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Marcou como concluído')),
                );
                Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 154, 115, 206),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                ),
                ),
                child: Text(
                'CONCLUIR',
                style: GoogleFonts.montserrat(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                ),
                ),
            ),
            ],
        ),
        );
    },
    ),
);
}
}
