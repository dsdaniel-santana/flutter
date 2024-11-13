import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DespesasScreen(),
    );
  }
}

class DespesasScreen extends StatefulWidget {
  @override
  _DespesasScreenState createState() => _DespesasScreenState();
}

class _DespesasScreenState extends State<DespesasScreen> {
  List despesas = []; // Lista para armazenar as despesas

  // Função para listar despesas
  Future<void> listarDespesas() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/secfin/backend/despesas/listAll.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"status": "ativo"}), // Envie o status conforme necessário
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          despesas = data['despesas']; // Atualiza a lista com as despesas da API
        });
      } else {
        // Lidar com erro ao buscar despesas
        print('Erro ao buscar despesas: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          'Despesa',
          style: TextStyle(
            fontFamily: 'Sansita',
            fontSize: 24,
            color: Color(0xFFF3F3F3),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Olá Usuário,',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 10),
              Text(
                'Bem-vindo ao sistema de Finanças Pessoais!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Você está na seção de DESPESAS.\nO que deseja fazer agora?',
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Ação para o botão "Incluir Despesa"
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: Text(
                  'Incluir Despesa',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: listarDespesas,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: Text(
                  'Listar Despesas',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              despesas.isNotEmpty
                  ? Expanded(
                      child: Column(
                        children: [
                          // Cabeçalho da tabela com a coluna Status
                          Container(
                            color: Colors.black87,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Credor',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Color(0xFFF3F3F3),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Vencimento',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Color(0xFFF3F3F3),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Valor',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Color(0xFFF3F3F3),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Status',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Color(0xFFF3F3F3),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Conteúdo da tabela com rolagem e bordas nas células de dados
                          Expanded(
                            child: ListView.builder(
                              itemCount: despesas.length,
                              itemBuilder: (context, index) {
                                final despesa = despesas[index];
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black26, width: 1.0),
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: Text(
                                          despesa['credor'].length > 10
                                              ? '${despesa['credor'].substring(0, 10)}...'
                                              : despesa['credor'],
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black26, width: 1.0),
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: Text(
                                          despesa['vencimento'],
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black26, width: 1.0),
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: Text(
                                          'R\$ ${despesa['valor']}',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black26, width: 1.0),
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: Text(
                                          despesa['status'],
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink(), // Remove a mensagem de "Nenhuma despesa encontrada"
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black87,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: Colors.white), // 🏠
                onPressed: () {
                  // Ação do ícone Home
                },
              ),
              IconButton(
                icon: Icon(Icons.attach_money, color: Colors.white), // 💵
                onPressed: () {
                  // Ação do ícone Dinheiro
                },
              ),
              IconButton(
                icon: Icon(Icons.money, color: Colors.white), // 💰
                onPressed: () {
                  // Ação do ícone Economias
                },
              ),
              IconButton(
                icon: Icon(Icons.bar_chart, color: Colors.white), // 📊
                onPressed: () {
                  // Ação do ícone Relatório
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
