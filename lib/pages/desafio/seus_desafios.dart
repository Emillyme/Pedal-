import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pedal_project/pages/desafio/desafio_detalhes.dart';
import 'seus_desafios.dart';

class SeusDesafios extends StatelessWidget {
  final String titulo;
  final String status;
  final String documentId;

  const SeusDesafios({
    super.key,
    required this.documentId,
    required this.titulo,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalhesDesafioPage(
              documentId: documentId
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.transparent,
          border: Border.all(
            color: const Color.fromARGB(255, 228, 228, 228),
            width: 1.8,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      color: const Color(0xFF423CA3),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Status:',
                        style: GoogleFonts.montserrat(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        status,
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Color(0xFF423CA3),
            ),
          ],
        ),
      ),
    );
  }
}
