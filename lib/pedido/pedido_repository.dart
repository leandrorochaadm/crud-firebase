import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motodelivery/pedido/PedidoModel.dart';

class PedidoRepository {
  CollectionReference _pedidos =
      FirebaseFirestore.instance.collection('pedidos');

  enviarPedido(PedidoModel p) {
    if (p.uuid == null) {
      addPedido(p);
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
}
