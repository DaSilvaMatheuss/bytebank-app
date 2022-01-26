// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencias(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  get child => null;
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lançar Transferência'),
      ),
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Editor(_controladorCampoNumeroConta, 'Número da conta', '0000',
              Icons.account_balance_wallet),
          Editor(
              _controladorCampoValor, 'Valor', '0.00', Icons.monetization_on),
          ElevatedButton(
              child: Text('Confirmar'),
              onPressed: () {
                _criaTransferencia(context);
              }),
        ],
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);
    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      debugPrint('$transferenciaCriada');
      Navigator.pop(context, transferenciaCriada);
    }
  }
}

class ListaTransferencias extends StatelessWidget {
  final List<Transferencia> _transferencias = [];
  @override
  Widget build(BuildContext context) {
    _transferencias.add(Transferencia(220, 85));
    _transferencias.add(Transferencia(220, 85));
    _transferencias.add(Transferencia(220, 85));
    _transferencias.add(Transferencia(220, 85));
    _transferencias.add(Transferencia(220, 85));

    // ignore: todo
    // TODO: implement build
    return Scaffold(
      body: ListView.builder(
        itemCount: _transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = _transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
          future.then((transferenciaRecebida) {
            debugPrint('passou no then do future');
            debugPrint('$transferenciaRecebida');
            _transferencias.add(transferenciaRecebida);
          });
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Transferências'),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on_sharp),
      title: Text(_transferencia.valor.toString()),
      subtitle: Text(_transferencia.numeroConta.toString()),
    ));
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);
  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroconta: $numeroConta}';
  }
}

class Editor extends StatelessWidget {
  final TextEditingController _controlador;
  final String _nomeCampo;
  final String _placeholder;
  final IconData _icone;

  Editor(this._controlador, this._nomeCampo, this._placeholder, this._icone);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _controlador,
        style: TextStyle(
          fontSize: 16.0,
        ),
        decoration: InputDecoration(
            icon: Icon(_icone), labelText: _nomeCampo, hintText: _placeholder),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
