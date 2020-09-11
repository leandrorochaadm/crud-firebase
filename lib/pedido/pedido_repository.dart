import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motodelivery/pedido/pedido_model.dart';

class PedidoRepository {
  CollectionReference _pedidos =
      FirebaseFirestore.instance.collection('pedidos');

  void enviarPedido(PedidoModel p) {
    print("rep: $p");
    if (p.uuid == null) {
      print("rep: add");
      addPedido(p);
    } else {
      print("rep: up");
      updatePedido(p);
    }
  }

  Future<void> addPedido(PedidoModel p) {
    return _pedidos
        .add(
          /*{
          'endereco': 'end 21',
          'formaPagamento': 'formaPagamento',
          'idCliente': 'idCliente 21',
          'idEntregador': 'idEntregador 21',
          'status': 'status',
          'troco': 50.0,
        }*/
          p.toJson(),
        )
        .then((value) => print("pedidos Added"))
        .catchError((error) => print("Failed to add pedido: $error"));
  }

  Stream<List<PedidoModel>> getPedidos() {
    return _pedidos.snapshots().map(
        (event) => event.docs.map((e) => PedidoModel.fromFirebase(e)).toList());
  }

  Future<void> deletePedido(PedidoModel p) {
    return _pedidos.doc(p.uuid).delete();
  }

  Future<void> updatePedido(PedidoModel p) {
    return _pedidos.doc(p.uuid).update(p.toJson());
  }
}
