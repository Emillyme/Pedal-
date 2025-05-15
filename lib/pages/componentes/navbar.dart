import 'package:flutter/material.dart';

class BottomBarExample extends StatelessWidget {
  const BottomBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Corpo da tela
      body: const Center(child: Text('Conteúdo aqui')),

      // Botão flutuante
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ação do botão +
        },
        backgroundColor: const Color(0xFF0D6EFD), // Azul personalizado
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 32), // Ícone +
      ),

      // Posição do botão (centro da barra inferior)
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Barra inferior
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(), // recorte para o botão
        notchMargin: 8.0,
        elevation: 8.0,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Pode deixar vazio ou colocar ícones laterais futuramente
            ],
          ),
        ),
      ),
    );
  }
}
