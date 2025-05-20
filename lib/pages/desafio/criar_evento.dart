import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CriarEventoPage extends StatefulWidget {
  const CriarEventoPage({super.key});

  @override
  State<CriarEventoPage> createState() => _CriarEventoPageState();
}

class _CriarEventoPageState extends State<CriarEventoPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _dataInicioController = TextEditingController();
  final TextEditingController _dataFinalController = TextEditingController();
  final TextEditingController _distanciaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voltar', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 142, 89, 211),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(labelText: 'Título do desafio'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira um título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _distanciaController,
                decoration: const InputDecoration(labelText: 'Distância (km)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a distância';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  alignLabelWithHint: true,
                ),
                minLines: 5,
                maxLines: 8,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira uma descrição';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dataInicioController,
                decoration: const InputDecoration(labelText: 'Data de início (ex: 20/05/2025)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a data de início';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dataFinalController,
                decoration: const InputDecoration(labelText: 'Data final (ex: 30/05/2025)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a data final';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _salvarDesafio,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 142, 89, 211),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                ),
                child: const Text(
                  'Salvar Desafio',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _salvarDesafio() async {
    if (!_formKey.currentState!.validate()) return;

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário não autenticado')),
      );
      return;
    }

    final desafioData = {
      'titulo': _tituloController.text,
      'descricao': _descricaoController.text,
      'dataInicio': _dataInicioController.text,
      'dataFinal': _dataFinalController.text,
      'distancia': _distanciaController.text,
      'status': 'Em andamento',
    };

    try {
      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .collection('desafios')
          .add(desafioData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Desafio criado com sucesso!')),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar: $e')),
      );
    }
  }
}
