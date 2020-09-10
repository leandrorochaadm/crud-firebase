import 'package:mobx/mobx.dart';
import 'package:motodelivery/pedido/pedido_model.dart';
part 'pedido_service.g.dart';

class PedidoService = _PedidoServiceBase with _$PedidoService;

abstract class _PedidoServiceBase with Store {
  final PedidoModel _pedido;
  _PedidoServiceBase(this._pedido) {
    endereco = _pedido.endereco;
    numero = _pedido.numero.toString();
    formaPagamento = _pedido.formaPagamento;
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
  String numero;

  @action
  void setNumero(String val) => numero = val;

  @computed
  String get numeroError {
    if (endereco != null && endereco.trim().length >= 2)
      return null;
    else if (endereco.isEmpty || endereco == null)
      return "Campo obrigatório";
    else
      return "Número muito curto";
  }

  @computed
  String get enderecoCompleto {
    return "$endereco, $numero";
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

  @action
  void setValorEntrega(double val) => valorEntrega = val;

  @computed
  String get valorEntregaError {
    if (valorEntrega != null && valorEntrega >= 0)
      return null;
    else if (valorEntrega <= 0 || valorEntrega == null)
      return "Campo obrigatório";
  }

  @computed
  double get valorTroco => valorDinheiro - valorPedido;

  @computed
  PedidoModel get pedido {
    print("uuid >>>>" + _pedido.uuid);
    return PedidoModel(
      uuid: _pedido.uuid,
      endereco: endereco,
      numero: int.parse(numero),
      formaPagamento: formaPagamento,
      valorDinheiro: valorDinheiro,
      valorEntrega: valorEntrega,
      valorPedido: valorPedido,
    );
  }
}
