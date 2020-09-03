import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motodelivery/pedido/PedidoModel.dart';

class PedidoRepository {
  CollectionReference _pedidos =
      FirebaseFirestore.instance.collection('pedidos');

  Future<void> addPedido() {
    // Call the user's CollectionReference to add a new user
    return _pedidos
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

  Stream<List<PedidoModel>> getPedidos() {
    return _pedidos.snapshots().map(
        (event) => event.docs.map((e) => PedidoModel.fromFirebase(e)).toList());
  }
}
