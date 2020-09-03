/*

{
    "uuid": "",
    "idCliente": "",
    "idEntregador": "",
    "endereco": "",
    "formaPagamento": "",
    "troco": 0.1,
    "status": ""
}

 */

import 'package:cloud_firestore/cloud_firestore.dart';

class PedidoModel {
  String uuid;
  String idCliente;
  String idEntregador;
  String endereco;
  String formaPagamento;
  double troco;
  String status;

  PedidoModel(
      {this.uuid,
      this.idCliente,
      this.idEntregador,
      this.endereco,
      this.formaPagamento,
      this.troco,
      this.status});

  PedidoModel.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    idCliente = json['idCliente'];
    idEntregador = json['idEntregador'];
    endereco = json['endereco'];
    formaPagamento = json['formaPagamento'];
    troco = json['troco'];
    status = json['status'];
  }

  PedidoModel.fromFirebase(DocumentSnapshot json) {
    uuid = json.reference.id;
    idCliente = json.data()['idCliente'];
    idEntregador = json.data()['idEntregador'];
    endereco = json.data()['endereco'];
    formaPagamento = json.data()['formaPagamento'];
    troco = json.data()['troco'];
    status = json.data()['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['idCliente'] = this.idCliente;
    data['idEntregador'] = this.idEntregador;
    data['endereco'] = this.endereco;
    data['formaPagamento'] = this.formaPagamento;
    data['troco'] = this.troco;
    data['status'] = this.status;
    return data;
  }

  @override
  String toString() {
    return "[uuid: $uuid, cliente: $idCliente, entregador: $idEntregador, endereço: $endereco]";
  }
}
