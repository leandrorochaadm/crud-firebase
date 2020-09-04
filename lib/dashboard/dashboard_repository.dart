import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motodelivery/pedido/PedidoModel.dart';

class DashboardRepository {
  CollectionReference _pedidos =
      FirebaseFirestore.instance.collection("pedidos");

  Future<double> totalValorEntrega() async {
    double total = 0;
    _pedidos.snapshots().map((event) => event.docs
        .map((e) => total += double.tryParse(e.data()["valorEntrega"])));
    return total;
  }

  Future<double> totalValorDinheiro() async {
    double total = 0;
    _pedidos.snapshots().map((event) => event.docs
        .map((e) => total += double.tryParse(e.data()["valorDinheiro"])));
    return total;
  }

  double totalEntrega() {
    double total = 0.0;
    _pedidos.snapshots().map((event) => event.docs
        .map((e) => total += PedidoModel.fromFirebase(e).valorEntrega));
    return total;
  }
}
