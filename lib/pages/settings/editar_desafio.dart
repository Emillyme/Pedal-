import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class EditarDesafioPage extends StatefulWidget {
  final String documentId;

  const EditarDesafioPage({super.key, required this.documentId});

  @override
  State<EditarDesafioPage> createState() => _EditarDesafioPageState();
}

class _EditarDesafioPageState extends State<EditarDesafioPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _tituloController;
  late TextEditingController _descricaoController;
  late TextEditingController _dataInicioController;
  late TextEditingController _dataFinalController;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController();
    _descricaoController = TextEditingController();
    _dataInicioController = TextEditingController();
    _dataFinalController = TextEditingController();
    _loadDesafio();
  }

  void _loadDesafio() async { 
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final docRef = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(userId)
        .collection('desafios')
        .doc(widget.documentId);

    final snapshot = await docRef.get();
    final data = snapshot.data() as Map<String, dynamic>;

    setState(() {
      _tituloController.text = data['titulo'] ?? '';
      _descricaoController.text = data['descricao'] ?? '';
      _dataInicioController.text = data['dataInicio'] ?? '';
      _dataFinalController.text = data['dataFinal'] ?? '';
      _isLoading = false;
    });
  }

  void _salvarAlteracoes() async {
    if (_formKey.currentState!.validate()) {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final docRef = FirebaseFirestore.instance
          .collection('usuarios')
          .doc(userId)
          .collection('desafios')
          .doc(widget.documentId);

      await docRef.update({ // PUT usando O FIREBASE!!!
        'titulo': _tituloController.text,
        'descricao': _descricaoController.text,
        'dataInicio': _dataInicioController.text,
        'dataFinal': _dataFinalController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Alterações salvas com sucesso!')),
      );

      Navigator.of(context).pop(); 
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _dataInicioController.dispose();
    _dataFinalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Desafio'),
        backgroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _tituloController,
                      decoration: const InputDecoration(labelText: 'Título'),
                      validator: (value) =>
                          value!.isEmpty ? 'Campo obrigatório' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _descricaoController,
                      decoration: const InputDecoration(labelText: 'Descrição'),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _dataInicioController,
                      decoration:
                          const InputDecoration(labelText: 'Data de início'),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _dataFinalController,
                      decoration:
                          const InputDecoration(labelText: 'Data de término'),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _salvarAlteracoes,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 154, 115, 206),
                      ),
                      child: const Text(
                        'Salvar alterações',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
