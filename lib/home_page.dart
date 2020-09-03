import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motodelivery/repository/pedido_repository.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    PedidoRepository repository = PedidoRepository();

    Future<void> addPedido() {
      // Call the user's CollectionReference to add a new user
      return repository.addPedido();
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addPedido();
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: repository.pedidos.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erro'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return ListTile(
                title: Text(document.data()['endereco']),
                subtitle: Text(document.data()['idEntregador']),
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
