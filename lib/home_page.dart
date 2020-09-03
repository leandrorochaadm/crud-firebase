import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    CollectionReference pedidos =
        FirebaseFirestore.instance.collection('pedidos');

    Future<void> addPedido() {
      // Call the user's CollectionReference to add a new user
      return pedidos
          .add({
            'endereco': 'end 21',
            'formaPagamento': 'formaPagamento',
            'idCliente': 'idCliente 21',
            'idEntregador': 'idEntregador 21',
            'status': 'status',
            'troco': 50.0,
          })
          .then((value) => print("pedidos Added"))
          .catchError((error) => print("Failed to add pedido: $error"));
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addPedido();
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: pedidos.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erro'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return new ListTile(
                title: new Text(document.data()['endereco']),
                subtitle: new Text(document.data()['idEntregador']),
                onTap: () {
                  //abrir detalhes
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
