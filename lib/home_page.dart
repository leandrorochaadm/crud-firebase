import 'package:flutter/material.dart';
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
  double totalEntrega = 0;
  double totalDinheiro = 0;

  @override
  Widget build(BuildContext context) {
    double _heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
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
          totalDinheiro = 0;
          totalEntrega = 0;
          if (snapshot.hasError) {
            return Center(child: Text('Erro'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              Container(
                height: _heightScreen * .87,
                child: ListView(
                  children: snapshot.data.map((PedidoModel document) {
                    totalEntrega += document.valorEntrega;
                    totalDinheiro += document.valorDinheiro;
                    return ListTile(
                      title: Text(document.endereco),
                      subtitle: Text(document.valorEntrega.toString()),
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
                ),
              ),
              Container(
                // alignment: Alignment.bottomLeft,
                height: _heightScreen * .12,
                // color: Colors.amberAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Total entregas: $totalEntrega",
                        style: TextStyle(color: Colors.green)),
                    Text("Total Dinheiro: $totalDinheiro",
                        style: TextStyle(color: Colors.green)),
                    Text("Acerto: ${totalEntrega - totalDinheiro}",
                        style: TextStyle(color: Colors.blue)),
                  ],
                ),
              )
            ],
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
}
