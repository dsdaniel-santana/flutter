import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Remove o banner de debug
      home: DespesasScreen(),
    );
  }
}

class DespesasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          'Despesas',
          style: TextStyle(
            fontFamily: 'Sansita', // Certifique-se de que a fonte está incluída
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(  // Aqui está a mudança
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,  // Centraliza verticalmente
            crossAxisAlignment: CrossAxisAlignment.center,  // Centraliza horizontalmente
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
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Função para incluir despesa
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Função para listar despesas
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: Text(
                  'Listar Despesas',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
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
                icon: Icon(Icons.receipt_long, color: Colors.white),
                onPressed: () {
                  // Ação do primeiro ícone
                },
              ),
              IconButton(
                icon: Icon(Icons.attach_money, color: Colors.white),
                onPressed: () {
                  // Ação do segundo ícone
                },
              ),
              IconButton(
                icon: Icon(Icons.calculate, color: Colors.white),
                onPressed: () {
                  // Ação do terceiro ícone
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
