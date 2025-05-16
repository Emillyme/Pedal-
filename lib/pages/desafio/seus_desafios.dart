import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SeusDesafios extends StatelessWidget {
  final String titulo;
  final String status;

  const SeusDesafios({
    super.key,
    required this.titulo,  
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Text(
          'Seus Desafios',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 49, 46, 49),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity, 
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
              // Coluna com título e status
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
              // Ícone de flecha para a direita
              const Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Color(0xFF423CA3),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
