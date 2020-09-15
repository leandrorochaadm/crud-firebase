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
  int numero;
  String bairro;
  String complemento;
  String formaPagamento;
  double valorPedido;
  double valorDinheiro;
  double valorEntrega;
  String status;
  GeoPoint coodernadas;

  PedidoModel({
    this.uuid,
    this.idCliente,
    this.idEntregador,
    this.endereco,
    this.numero,
    this.bairro,
    this.complemento,
    this.formaPagamento,
    this.valorPedido,
    this.valorDinheiro,
    this.valorEntrega,
    this.status,
    this.coodernadas,
  });

  PedidoModel.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    idCliente = json['idCliente'];
    idEntregador = json['idEntregador'];
    endereco = json['endereco'];
    numero = json['numero'];
    bairro = json['bairro'];
    complemento = json['complemento'];
    formaPagamento = json['formaPagamento'];
    valorPedido = json['valorPedido'];
    valorDinheiro = json['valorDinheiro'];
    valorEntrega = json['valorEntrega'];
    status = json['status'];
    coodernadas = json['coodernadas'];
    print(json['coodernadas']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['idCliente'] = this.idCliente;
    data['idEntregador'] = this.idEntregador;
    data['endereco'] = this.endereco;
    data['numero'] = this.numero;
    data['bairro'] = this.bairro;
    data['complemento'] = this.complemento;
    data['formaPagamento'] = this.formaPagamento;
    data['valorPedido'] = this.valorPedido;
    data['valorDinheiro'] = this.valorDinheiro;
    data['valorEntrega'] = this.valorEntrega;
    data['status'] = this.status;
    data['coodernadas'] = this.coodernadas;
    return data;
  }

  PedidoModel.fromFirebase(DocumentSnapshot json) {
    uuid = json.reference.id;
    idCliente = json.data()['idCliente'];
    idEntregador = json.data()['idEntregador'];
    endereco = json.data()['endereco'];
    numero = json.data()['numero'];
    bairro = json.data()['bairro'];
    complemento = json.data()['complemento'];
    formaPagamento = json.data()['formaPagamento'];
    valorPedido = json.data()['valorPedido'];
    valorDinheiro = json.data()['valorDinheiro'];
    valorEntrega = json.data()['valorEntrega'];
    status = json.data()['status'];
    coodernadas = json.data()['coodernadas'];
  }

  @override
  String toString() {
    return "[uuid: $uuid, cliente: $idCliente, entregador: $idEntregador, endereço: $endereco, $numero - $bairro]";
  }
}
