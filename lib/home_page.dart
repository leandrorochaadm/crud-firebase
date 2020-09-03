import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motodelivery/pedido/PedidoModel.dart';
import 'package:motodelivery/pedido/pedido_repository.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int i = 1;

  @override
  Widget build(BuildContext context) {
    PedidoRepository repository = PedidoRepository();

    var ped = PedidoModel(
        endereco: "end $i",
        formaPagamento: "Dinheiro",
        idCliente: "cliente $i",
        idEntregador: "entregador $i",
        status: "entregue",
        troco: i.toDouble());

    Future<void> addPedido() {
      // Call the user's CollectionReference to add a new user
      this.i += 1;
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
                onLongPress: () {
                  _showDialogDeletePedido();
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }

  _showDialogDeletePedido() {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Deseja excluir essa entrega"),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Não')),
              FlatButton(
                  onPressed: () {
                    //Excluir Pedido
                    Navigator.pop(context);
                  },
                  child: Text('Sim')),
            ],
          );
        });
  }
}
