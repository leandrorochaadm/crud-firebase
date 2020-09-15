import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:motodelivery/pedido/pedido_model.dart';
import 'package:motodelivery/pedido/pedido_page.dart';
import 'package:motodelivery/pedido/pedido_repository.dart';
import 'package:motodelivery/pedido/pedido_service.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PedidoRepository repository = PedidoRepository();
  PedidoService service;
  double totalEntrega;
  double totalDinheiro;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    service = GetIt.I<PedidoService>();
    // service.setPedido(widget.pedido);
  }

  @override
  Widget build(BuildContext context) {
    double _heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          service.novoForm();
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
          totalDinheiro = 0.0;
          totalEntrega = 0.0;

          if (snapshot.hasError) {
            return Center(child: Text('Erro'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            // padding: EdgeInsets.zero,
            children: [
              Container(
                height: _heightScreen * .85,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: snapshot.data.map((PedidoModel document) {
                    totalEntrega += document.valorEntrega ?? 0;
                    totalDinheiro += document.valorDinheiro ?? 0;
                    return ListTile(
                      title: Text(
                          "${document.endereco}, ${document.numero} - ${document.bairro} - ${document.complemento ?? ""}"),
                      // subtitle: Text(document.uuid),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Entrega: ${document.valorEntrega}"),
                          Text(
                              "${document.valorDinheiro == 0 ? 'Cartão' : document.valorDinheiro}")
                        ],
                      ),
                      onTap: () {
                        service.setPedido(document);
                        //abrir detalhes
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => PedidoPage()));
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
