**COMEÇO MAIN.DART (TELA DE SALVAR DESPESAS)**
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DespesaFormScreen(),
    );
  }
}

class DespesaFormScreen extends StatefulWidget {
  @override
  _DespesaFormScreenState createState() => _DespesaFormScreenState();
}

class _DespesaFormScreenState extends State<DespesaFormScreen> {
  final TextEditingController credorController = TextEditingController();
  final TextEditingController vencimentoController = TextEditingController();
  final TextEditingController valorController = TextEditingController();
  final TextEditingController observacaoController = TextEditingController();
  String? statusSelecionado;

  void salvarDespesa() {
    print("Credor: ${credorController.text}");
    print("Vencimento: ${vencimentoController.text}");
    print("Valor: ${valorController.text}");
    print("Observação: ${observacaoController.text}");
    print("Status: $statusSelecionado");
  }

  Future<void> _selecionarData(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      setState(() {
        vencimentoController.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          'Cadastro de Despesas',
          style: TextStyle(
            color: Color(0xFFF3F3F3),
            fontFamily: 'Sansita',
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20), // Espaço inicial

            Text(
              'Credor',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: credorController,
              decoration: InputDecoration(
                hintText: 'Digite o nome do credor',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),

            Text(
              'Vencimento',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: vencimentoController,
              readOnly: true,
              onTap: () => _selecionarData(context),
              decoration: InputDecoration(
                hintText: 'Selecione a data de vencimento',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
            ),
            SizedBox(height: 24),

            Text(
              'Valor',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: valorController,
              decoration: InputDecoration(
                hintText: 'Digite o valor',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 24),

            // Novo campo de Observação
            Text(
              'Observação',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: observacaoController,
              maxLength: 280,
              decoration: InputDecoration(
                hintText: 'Digite uma observação (até 280 caracteres)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 24),

            Text(
              'Status',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: statusSelecionado,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(value: null, child: Text('Selecione um Status')),
                DropdownMenuItem(value: 'Previsão', child: Text('Previsão')),
                DropdownMenuItem(value: 'Concluído', child: Text('Concluído')),
              ],
              onChanged: (String? value) {
                setState(() {
                  statusSelecionado = value;
                });
              },
            ),
            SizedBox(height: 40), // Espaço antes do botão "Salvar"

            Center(
              child: ElevatedButton(
                onPressed: salvarDespesa,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: Text(
                  'Salvar',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
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
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  // Ação do ícone Home
                },
              ),
              IconButton(
                icon: Icon(Icons.attach_money, color: Colors.white),
                onPressed: () {
                  // Ação do ícone Dinheiro
                },
              ),
              IconButton(
                icon: Icon(Icons.money, color: Colors.white),
                onPressed: () {
                  // Ação do ícone Economias
                },
              ),
              IconButton(
                icon: Icon(Icons.bar_chart, color: Colors.white),
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



**FINAL MAIN.DART (TELA DE SALVAR DESPESAS)**



**COMEÇO PUBSPEC.YAML (TELA DE SALVAR DESPESAS)**
name: secfin
description: "A new Flutter project."
# The following line prevents the package from being accidentally published to
# pub.dev using `flutter pub publish`. This is preferred for private packages.
publish_to: 'none' # Remove this line if you wish to publish to pub.dev

# The following defines the version and build number for your application.
# A version number is three numbers separated by dots, like 1.2.43
# followed by an optional build number separated by a +.
# Both the version and the builder number may be overridden in flutter
# build by specifying --build-name and --build-number, respectively.
# In Android, build-name is used as versionName while build-number used as versionCode.
# Read more about Android versioning at https://developer.android.com/studio/publish/versioning
# In iOS, build-name is used as CFBundleShortVersionString while build-number is used as CFBundleVersion.
# Read more about iOS versioning at
# https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html
# In Windows, build-name is used as the major, minor, and patch parts
# of the product and file versions while build-number is used as the build suffix.
# ATENÇÃO: DESABILITAR PARA FUNCIONAR
# flutter run -d chrome --web-browser-flag "--disable-web-security" --web-browser-flag "--user-data-dir=/tmp"

version: 1.0.0+1

environment:
  sdk: ^3.5.4

# Dependencies specify other packages that your package needs in order to work.
# To automatically upgrade your package dependencies to the latest versions
# consider running `flutter pub upgrade --major-versions`. Alternatively,
# dependencies can be manually updated by changing the version numbers below to
# the latest version available on pub.dev. To see which dependencies have newer
# versions available, run `flutter pub outdated`.
dependencies:
  flutter:
    sdk: flutter
  intl: ^0.18.0  # Certifique-se de usar a versão mais recente


  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_test:
    sdk: flutter

  # The "flutter_lints" package below contains a set of recommended lints to
  # encourage good coding practices. The lint set provided by the package is
  # activated in the `analysis_options.yaml` file located at the root of your
  # package. See that file for information about deactivating specific lint
  # rules and activating additional ones.
  flutter_lints: ^4.0.0

# For information on the generic Dart part of this file, see the
# following page: https://dart.dev/tools/pub/pubspec

# The following section is specific to Flutter packages.
flutter:
  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true

  # OBSERVAÇÃO: FONTE SANSITA ADICIONADA AQUI
  fonts:
    - family: Sansita
      fonts:
        - asset: fonts/Sansita-Regular.ttf


**FINAL PUBSPEC.YAML (TELA DE SALVAR DESPESAS)**