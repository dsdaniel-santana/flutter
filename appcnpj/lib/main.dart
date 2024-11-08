
// Criar um projeto chamado appcnpj: flutter create appcnpj
// cd appcnpj
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
          title: Text('Busca dados por CNPJ'),
        ),
        body: CnpjForm(),
      ),
    );
  }
}
 
class CnpjForm extends StatefulWidget {
  @override
  _CnpjFormState createState() => _CnpjFormState();
}
 
class _CnpjFormState extends State<CnpjForm> {
  final _cnpjController = TextEditingController();
  // Zeramos as variáveis
  String _razao_social = '';
  String _logradouro = '';
  String _bairro = '';
  String _cidade = '';
  String _estado = '';
 
  Future<void> _buscarEndereco() async {
    final cnpj = _cnpjController.text;
    // pegamos o CNPJ digitado
    // a URL abaixo executa a API da minhareceita.org que devolve os dados
    // em Json
    final url = Uri.parse('https://minhareceita.org/$cnpj');
    final response = await http.get(url);
 
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // json.decode converte para os dados que vamos trazer abaixo
      setState(() {
        _razao_social = data['razao_social'] ?? '';
        _logradouro = data['descricao_tipo_de_logradouro'] +
                ' ' +
                data['logradouro'] +
                ', ' +
                data['numero'] ??
            '';
        _bairro = data['bairro'] ?? '';
        _cidade = data['municipio'] ?? '';
        _estado = data['uf'] ?? '';
      });
    } else {
      // Handle error
      // Aqui caso não encontre o CNPJ na base de dados da minhareceita.org
      setState(() {
        _razao_social = 'Erro ao buscar endereço';
        _logradouro = '';
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
            controller: _cnpjController,
            // CNPJ digitado no input com o nome acima
            decoration: InputDecoration(labelText: 'Digite o CNPJ'),
            // Abaixo só aceitará numeros. (Fica bom no celular)
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            // botão para executar a API
            onPressed: _buscarEndereco,
            child: Text('Buscar Dados da Empresa'),
          ),
          SizedBox(height: 16),
          // Exibindo os campos de endereço nos inputs
          TextField(
            decoration: InputDecoration(labelText: 'Razão Social'),
            controller: TextEditingController(text: _razao_social),
            readOnly: true,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Logradouro'),
            controller: TextEditingController(text: _logradouro),
            readOnly: true,
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
 
 