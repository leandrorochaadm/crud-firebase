/*

{
    "uuid": "",
    "idCliente": "",
    "idEntregador": "",
    "endereco": "",
    "formaPagamento": "",
    "valorPedido": 0.1,
    "valorDinheiro": 0.1,
    "status": ""
}

 */

/*
  PedidoModel.fromFirebase(DocumentSnapshot json) {
    uuid = json.reference.id;
    idCliente = json.data()['idCliente'];
    idEntregador = json.data()['idEntregador'];
    endereco = json.data()['endereco'];
    formaPagamento = json.data()['formaPagamento'];
    valorPedido = json.data()['valorPedido'];
    valorDinheiro = json.data()['valorDinheiro'];
    status = json.data()['status'];
  }
*/

/*
  @override
  String toString() {
    return "[uuid: $uuid, cliente: $idCliente, entregador: $idEntregador, endereço: $endereco]";
  }
*/

import 'package:cloud_firestore/cloud_firestore.dart';

class PedidoModel {
  String uuid;
  String idCliente;
  String idEntregador;
  String endereco;
  String formaPagamento;
  double valorPedido;
  double valorDinheiro;
  double valorEntrega;
  String status;

  PedidoModel(
      {this.uuid,
      this.idCliente,
      this.idEntregador,
      this.endereco,
      this.formaPagamento,
      this.valorPedido,
      this.valorDinheiro,
      this.valorEntrega,
      this.status});

  PedidoModel.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    idCliente = json['idCliente'];
    idEntregador = json['idEntregador'];
    endereco = json['endereco'];
    formaPagamento = json['formaPagamento'];
    valorPedido = json['valorPedido'];
    valorDinheiro = json['valorDinheiro'];
    valorEntrega = json['valorEntrega'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['idCliente'] = this.idCliente;
    data['idEntregador'] = this.idEntregador;
    data['endereco'] = this.endereco;
    data['formaPagamento'] = this.formaPagamento;
    data['valorPedido'] = this.valorPedido;
    data['valorDinheiro'] = this.valorDinheiro;
    data['valorEntrega'] = this.valorEntrega;
    data['status'] = this.status;
    return data;
  }

  PedidoModel.fromFirebase(DocumentSnapshot json) {
    uuid = json.reference.id;
    idCliente = json.data()['idCliente'];
    idEntregador = json.data()['idEntregador'];
    endereco = json.data()['endereco'];
    formaPagamento = json.data()['formaPagamento'];
    valorPedido = json.data()['valorPedido'];
    valorDinheiro = json.data()['valorDinheiro'];
    valorEntrega = json.data()['valorEntrega'];
    status = json.data()['status'];
  }

  @override
  String toString() {
    return "[uuid: $uuid, cliente: $idCliente, entregador: $idEntregador, endereço: $endereco]";
  }
}
