import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motodelivery/dashboard/dashboard_page.dart';
import 'package:motodelivery/pedido/PedidoModel.dart';
import 'package:motodelivery/pedido/pedido_page.dart';
import 'package:motodelivery/pedido/pedido_repository.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  PedidoRepository repository = PedidoRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selecaoNavigatorBar,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "Lista"),
            BottomNavigationBarItem(icon: Icon(Icons.money), label: "Gerenciar")
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => PedidoPage(pedido: PedidoModel())));
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<List<PedidoModel>>(
        stream: repository.getPedidos(),
        builder:
            (BuildContext context, AsyncSnapshot<List<PedidoModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erro'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data.map((PedidoModel document) {
              return ListTile(
                title: Text(document.endereco),
                subtitle: Text(document.uuid),
                onTap: () {
                  //abrir detalhes
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => PedidoPage(pedido: document)));
                },
                onLongPress: () {
                  _showDialogDeletePedido(document);
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }

  _showDialogDeletePedido(PedidoModel pedido) {
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
                    repository.deletePedido(pedido);
                    Navigator.pop(context);
                  },
                  child: Text('Sim')),
            ],
          );
        });
  }

  void _selecaoNavigatorBar(int value) {
    _selectedIndex = value;
    switch (value) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => DashboardPage()));
        break;
      default:
    }
  }
}
