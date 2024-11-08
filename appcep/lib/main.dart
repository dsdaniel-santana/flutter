
// Criar um projeto chamado appcep: flutter create appcep
// cd appcep
// no arquivo pubspec.yaml inserir :
// http: 0.13.6
// abaixo da linha: cupertino_icons: ^1.0.2
// Gravar e dar o comando flutter pub get
// Copie esse código para o main.dart
// Executar com flutter run
// É importante pois teremos requisições via http com API externa
 
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
 
void main() {
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Busca de Endereço por CEP'),
        ),
        body: CepForm(),
      ),
    );
  }
}
 
// classe inicial
class CepForm extends StatefulWidget {
  @override
  _CepFormState createState() => _CepFormState();
}
 
// classe declaração das variaveis
class _CepFormState extends State<CepForm> {
  final _cepController = TextEditingController();
  // Zeramos as variáveis
  String _logradouro = '';
  String _bairro = '';
  String _cidade = '';
  String _estado = '';
 
  Future<void> _buscarEndereco() async {
    final cep = _cepController.text;
    // pegamos o cep digitado
    // a URL abaixo executa a API da via cep que devolve o endereço
    // em Json
    final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
    final response = await http.get(url);
 
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // json.decode converte para os dados que vamos trazer abaixo
      setState(() {
        _logradouro = data['logradouro'] ?? '';
        _bairro = data['bairro'] ?? '';
        _cidade = data['localidade'] ?? '';
        _estado = data['uf'] ?? '';
      });
    } else {
      // Handle error
      // Aqui caso não encontre o cep na base de dados da VIACEP
      setState(() {
        _logradouro = 'Erro ao buscar endereço';
        _bairro = '';
        _cidade = '';
        _estado = '';
      });
    }
  }
 
  @override
  // Montagem da tela
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _cepController,
            // Cep digitado no input com o nome acima
            decoration: InputDecoration(labelText: 'Digite o CEP'),
            // Abaixo só aceitará numeros. (Fica bom no celular)
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            // botão para executar a API
            onPressed: _buscarEndereco,
            child: Text('Buscar Endereço'),
          ),
          SizedBox(height: 16),
          // Exibindo os campos de endereço nos inputs
          TextField(
            decoration: InputDecoration(labelText: 'Logradouro'),
            controller: TextEditingController(text: _logradouro),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Bairro'),
            controller: TextEditingController(text: _bairro),
            readOnly: true,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Cidade'),
            controller: TextEditingController(text: _cidade),
            readOnly: true,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Estado'),
            controller: TextEditingController(text: _estado),
            readOnly: true,
          ),
        ],
      ),
    );
  }
}
 
 