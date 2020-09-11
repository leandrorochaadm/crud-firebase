// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pedido_service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PedidoService on _PedidoServiceBase, Store {
  Computed<String> _$enderecoErrorComputed;

  @override
  String get enderecoError =>
      (_$enderecoErrorComputed ??= Computed<String>(() => super.enderecoError,
              name: '_PedidoServiceBase.enderecoError'))
          .value;
  Computed<String> _$numeroErrorComputed;

  @override
  String get numeroError =>
      (_$numeroErrorComputed ??= Computed<String>(() => super.numeroError,
              name: '_PedidoServiceBase.numeroError'))
          .value;
  Computed<String> _$bairroErrorComputed;

  @override
  String get bairroError =>
      (_$bairroErrorComputed ??= Computed<String>(() => super.bairroError,
              name: '_PedidoServiceBase.bairroError'))
          .value;
  Computed<String> _$enderecoCompletoComputed;

  @override
  String get enderecoCompleto => (_$enderecoCompletoComputed ??=
          Computed<String>(() => super.enderecoCompleto,
              name: '_PedidoServiceBase.enderecoCompleto'))
      .value;
  Computed<String> _$valorPedidoErrorComputed;

  @override
  String get valorPedidoError => (_$valorPedidoErrorComputed ??=
          Computed<String>(() => super.valorPedidoError,
              name: '_PedidoServiceBase.valorPedidoError'))
      .value;
  Computed<String> _$valorDinheiroErrorComputed;

  @override
  String get valorDinheiroError => (_$valorDinheiroErrorComputed ??=
          Computed<String>(() => super.valorDinheiroError,
              name: '_PedidoServiceBase.valorDinheiroError'))
      .value;
  Computed<bool> _$isDinheiroComputed;

  @override
  bool get isDinheiro =>
      (_$isDinheiroComputed ??= Computed<bool>(() => super.isDinheiro,
              name: '_PedidoServiceBase.isDinheiro'))
          .value;
  Computed<double> _$valorTrocoComputed;

  @override
  double get valorTroco =>
      (_$valorTrocoComputed ??= Computed<double>(() => super.valorTroco,
              name: '_PedidoServiceBase.valorTroco'))
          .value;

  final _$enderecoAtom = Atom(name: '_PedidoServiceBase.endereco');

  @override
  String get endereco {
    _$enderecoAtom.reportRead();
    return super.endereco;
  }

  @override
  set endereco(String value) {
    _$enderecoAtom.reportWrite(value, super.endereco, () {
      super.endereco = value;
    });
  }

  final _$numeroAtom = Atom(name: '_PedidoServiceBase.numero');

  @override
  int get numero {
    _$numeroAtom.reportRead();
    return super.numero;
  }

  @override
  set numero(int value) {
    _$numeroAtom.reportWrite(value, super.numero, () {
      super.numero = value;
    });
  }

  final _$bairroAtom = Atom(name: '_PedidoServiceBase.bairro');

  @override
  String get bairro {
    _$bairroAtom.reportRead();
    return super.bairro;
  }

  @override
  set bairro(String value) {
    _$bairroAtom.reportWrite(value, super.bairro, () {
      super.bairro = value;
    });
  }

  final _$complementoAtom = Atom(name: '_PedidoServiceBase.complemento');

  @override
  String get complemento {
    _$complementoAtom.reportRead();
    return super.complemento;
  }

  @override
  set complemento(String value) {
    _$complementoAtom.reportWrite(value, super.complemento, () {
      super.complemento = value;
    });
  }

  final _$formaPagamentoAtom = Atom(name: '_PedidoServiceBase.formaPagamento');

  @override
  String get formaPagamento {
    _$formaPagamentoAtom.reportRead();
    return super.formaPagamento;
  }

  @override
  set formaPagamento(String value) {
    _$formaPagamentoAtom.reportWrite(value, super.formaPagamento, () {
      super.formaPagamento = value;
    });
  }

  final _$valorPedidoAtom = Atom(name: '_PedidoServiceBase.valorPedido');

  @override
  double get valorPedido {
    _$valorPedidoAtom.reportRead();
    return super.valorPedido;
  }

  @override
  set valorPedido(double value) {
    _$valorPedidoAtom.reportWrite(value, super.valorPedido, () {
      super.valorPedido = value;
    });
  }

  final _$valorDinheiroAtom = Atom(name: '_PedidoServiceBase.valorDinheiro');

  @override
  double get valorDinheiro {
    _$valorDinheiroAtom.reportRead();
    return super.valorDinheiro;
  }

  @override
  set valorDinheiro(double value) {
    _$valorDinheiroAtom.reportWrite(value, super.valorDinheiro, () {
      super.valorDinheiro = value;
    });
  }

  final _$valorEntregaAtom = Atom(name: '_PedidoServiceBase.valorEntrega');

  @override
  double get valorEntrega {
    _$valorEntregaAtom.reportRead();
    return super.valorEntrega;
  }

  @override
  set valorEntrega(double value) {
    _$valorEntregaAtom.reportWrite(value, super.valorEntrega, () {
      super.valorEntrega = value;
    });
  }

  final _$_PedidoServiceBaseActionController =
      ActionController(name: '_PedidoServiceBase');

  @override
  void setEndereco(String val) {
    final _$actionInfo = _$_PedidoServiceBaseActionController.startAction(
        name: '_PedidoServiceBase.setEndereco');
    try {
      return super.setEndereco(val);
    } finally {
      _$_PedidoServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNumero(String val) {
    final _$actionInfo = _$_PedidoServiceBaseActionController.startAction(
        name: '_PedidoServiceBase.setNumero');
    try {
      return super.setNumero(val);
    } finally {
      _$_PedidoServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBairro(String val) {
    final _$actionInfo = _$_PedidoServiceBaseActionController.startAction(
        name: '_PedidoServiceBase.setBairro');
    try {
      return super.setBairro(val);
    } finally {
      _$_PedidoServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setComplemento(String val) {
    final _$actionInfo = _$_PedidoServiceBaseActionController.startAction(
        name: '_PedidoServiceBase.setComplemento');
    try {
      return super.setComplemento(val);
    } finally {
      _$_PedidoServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFormaPagamento(String val) {
    final _$actionInfo = _$_PedidoServiceBaseActionController.startAction(
        name: '_PedidoServiceBase.setFormaPagamento');
    try {
      return super.setFormaPagamento(val);
    } finally {
      _$_PedidoServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setValorPedido(String val) {
    final _$actionInfo = _$_PedidoServiceBaseActionController.startAction(
        name: '_PedidoServiceBase.setValorPedido');
    try {
      return super.setValorPedido(val);
    } finally {
      _$_PedidoServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setValorDinheiro(String val) {
    final _$actionInfo = _$_PedidoServiceBaseActionController.startAction(
        name: '_PedidoServiceBase.setValorDinheiro');
    try {
      return super.setValorDinheiro(val);
    } finally {
      _$_PedidoServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
endereco: ${endereco},
numero: ${numero},
bairro: ${bairro},
complemento: ${complemento},
formaPagamento: ${formaPagamento},
valorPedido: ${valorPedido},
valorDinheiro: ${valorDinheiro},
valorEntrega: ${valorEntrega},
enderecoError: ${enderecoError},
numeroError: ${numeroError},
bairroError: ${bairroError},
enderecoCompleto: ${enderecoCompleto},
valorPedidoError: ${valorPedidoError},
valorDinheiroError: ${valorDinheiroError},
isDinheiro: ${isDinheiro},
valorTroco: ${valorTroco}
    ''';
  }
}
