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
    return "[cliente: $idCliente, entregador: $idEntregador, endereço: $endereco]";
  }
}
