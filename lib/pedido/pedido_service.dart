import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:motodelivery/pedido/pedido_model.dart';
import 'package:motodelivery/pedido/pedido_repository.dart';
import 'package:motodelivery/util/calculaEntrega.dart';
// import 'package:motodelivery/util/calculaEntrega.dart';
part 'pedido_service.g.dart';

class PedidoService = _PedidoServiceBase with _$PedidoService;

abstract class _PedidoServiceBase with Store {
  PedidoRepository repository = PedidoRepository();
  final PedidoModel pedido;
  _PedidoServiceBase({this.pedido}) {
    endereco = pedido.endereco;
    numero = pedido.numero ?? "";
    bairro = pedido.bairro;
    complemento = pedido.complemento;
    formaPagamento = pedido.formaPagamento;
    /*endereco = "Rua dom augusto";
    numero = 123;
    formaPagamento = "Cartão";*/
    valorDinheiro = pedido.valorDinheiro ?? 0;
    valorPedido = pedido.valorPedido ?? 0;
  }

  @observable
  String endereco;

  @action
  void setEndereco(String val) => endereco = val;

  @computed
  String get enderecoError {
    if (endereco != null && endereco.trim().length > 4)
      return null;
    else if (endereco.isEmpty || endereco == null)
      return "Campo obrigatório";
    else
      return "Endereço muito curto";
  }

  @observable
  int numero;

  @action
  void setNumero(String val) => numero = int.parse(val);

  @computed
  String get numeroError {
    if (numero != null && numero > 0)
      return null;
    else if (endereco.isEmpty || endereco == null) return "Campo obrigatório";
  }

  @observable
  String bairro;

  @action
  void setBairro(String val) => bairro = val;

  @computed
  String get bairroError {
    if (bairro != null && bairro.trim().length > 4)
      return null;
    else if (bairro.isEmpty || bairro == null)
      return "Campo obrigatório";
    else
      return "Bairro muito curto";
  }

  @observable
  String complemento;

  @action
  void setComplemento(String val) => complemento = val;

  @computed
  String get enderecoCompleto {
    return "$endereco, $numero - $bairro";
  }

  @observable
  String formaPagamento;

  @action
  void setFormaPagamento(String val) => formaPagamento = val;

  @observable
  double valorPedido;

  @action
  void setValorPedido(String val) => valorPedido = double.parse(val);

  @computed
  String get valorPedidoError {
    if (valorPedido != null && valorPedido >= 0)
      return null;
    else if (valorPedido <= 0 || valorPedido == null)
      return "Campo obrigatório";
  }

  @observable
  double valorDinheiro;

  @action
  void setValorDinheiro(String val) => valorDinheiro = double.parse(val);

  @computed
  String get valorDinheiroError {
    if (valorDinheiro != null && valorDinheiro >= 0)
      return null;
    else if (valorDinheiro <= 0 || valorDinheiro == null)
      return "Campo obrigatório";
  }

  @computed
  bool get isDinheiro => formaPagamento == 'Dinheiro';

  @observable
  double valorEntrega;

  Future<void> calculaValorEntrega() async {
    final calc = CalculaEntrega();
    valorEntrega = await calc.calcularValorEntregaPorEndereco(enderecoCompleto);
  }

  @computed
  double get valorTroco => valorDinheiro - valorPedido;
  bool get valorTrocoValido => valorDinheiro >= valorPedido;

  Future<void> salvePedido() async {
    // print("uuid: " + pedido.uuid);
    await calculaValorEntrega();
    final cad = PedidoModel(
      uuid: pedido.uuid,
      endereco: endereco,
      numero: numero,
      bairro: bairro,
      complemento: complemento,
      formaPagamento: formaPagamento,
      valorDinheiro: valorDinheiro,
      valorEntrega: valorEntrega,
      valorPedido: valorPedido,
      idCliente: "",
      idEntregador: "",
      status: "",
    );

    /*final cad = await PedidoModel(
      endereco: "Rua dom augusto",
      formaPagamento: "Cartão",
      numero: 453,
    );*/

    await repository.enviarPedido(cad);
  }
}