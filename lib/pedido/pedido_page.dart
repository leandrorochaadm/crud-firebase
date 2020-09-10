import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:motodelivery/pedido/pedido_model.dart';
import 'package:motodelivery/pedido/pedido_repository.dart';
import 'package:motodelivery/pedido/pedido_service.dart';
import 'package:motodelivery/util/calculaEntrega.dart';

class PedidoPage extends StatefulWidget {
  final PedidoModel pedido;
  PedidoPage({Key key, @required this.pedido}) : super(key: key);

  @override
  _PedidoPageState createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
  String formaPagamentoDropDown;

  final _formKey = GlobalKey<FormState>();

  PedidoRepository repository = PedidoRepository();
  CalculaEntrega _entrega = CalculaEntrega();
  double _dinheiro;
  double _pedido;
  PedidoService service;

  @override
  void initState() {
    super.initState();
    service = PedidoService(widget.pedido);
    formaPagamentoDropDown = service.formaPagamento ?? 'Selecione';
    _dinheiro = service.valorDinheiro ?? 0;
    _pedido = service.valorPedido ?? 0;
  }

  _showDialogSemCategoria() {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Selecione uma\nforma de pagamento\nantes de salvar"),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Ok"))
            ],
          );
        });
  }

  double _troco() {
    print("Di: $_dinheiro");
    print("Pe: $_pedido");
    return (_dinheiro != null && _pedido != null) ? _dinheiro - _pedido : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Observer(builder: (_) {
                  return ListView(
                    children: [
                      // Text(service._),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: "Nome da Rua"),
                          autocorrect: false,
                          initialValue: service.endereco ?? "",
                          validator: (_) {
                            return service.enderecoError;
                          },
                          onChanged: service.setEndereco,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: TextFormField(
                          decoration:
                              InputDecoration(labelText: "Número da casa"),
                          autocorrect: false,
                          initialValue: service.numero ?? "",
                          validator: (_) {
                            return service.numeroError;
                          },
                          onChanged: service.setNumero,
                        ),
                      ),
                      /* Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Complemento/Ponto de referência"),
                          autocorrect: false,
                          initialValue: service.endereco ?? "",
                          validator: (_) {
                            return service.enderecoError;
                          },
                          onChanged: service.setEndereco,
                        ),
                      ),*/
                      DropdownButton<String>(
                        value: service.formaPagamento,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: service.setFormaPagamento,
                        items: <String>['Selecione', 'Cartão', 'Dinheiro']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      service.isDinheiro
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: "Valor do pedido"),
                                autocorrect: false,
                                initialValue: service.valorPedido ?? "",
                                validator: (_) {
                                  return service.valorPedidoError;
                                },
                                onChanged: service.setValorPedido,
                              ),
                            )
                          : Container(),
                      service.isDinheiro
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration:
                                    InputDecoration(labelText: "Troco para?"),
                                autocorrect: false,
                                initialValue: service.valorDinheiro ?? "",
                                onChanged: service.setValorDinheiro,
                                validator: (value) {
                                  return service.valorDinheiroError;
                                },
                              ),
                            )
                          : Container(),
                      service.isDinheiro
                          ? Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                "Valor do troco: ${service.valorTroco}",
                                style: TextStyle(color: Colors.red),
                              ))
                          : Container(),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton(
                            padding: EdgeInsets.all(8),
                            onPressed: () {
                              //TODO: validar se deseja sair sem salvar
                              //TODO: validar forma pagamento selecionada
                              Navigator.pop(context);

                              debugPrint("Cancelado Pedido");
                            },
                            child:
                                Text("Voltar", style: TextStyle(fontSize: 16)),
                          ),
                          RaisedButton(
                            padding: EdgeInsets.all(8),
                            onPressed: () async {
                              final form = _formKey.currentState;
                              if (service.formaPagamento != 'Cartão' &&
                                  service.formaPagamento != 'Dinheiro')
                                return _showDialogSemCategoria();
                              if (!form.validate()) return;
                              if (service.formaPagamento == "Cartão") {
                                service.setValorDinheiro("0.00");
                                service.setValorPedido("0.00");
                              }
                              form.save();
                              service.setValorEntrega(await _entrega
                                  .calcularValorEntregaPorEndereco(
                                      service.enderecoCompleto));

                              repository.enviarPedido(service.pedido);
                              Navigator.pop(context);

                              debugPrint("enviando Pedido");
                            },
                            child:
                                Text("Salvar", style: TextStyle(fontSize: 20)),
                          ),
                        ],
                      )
                    ],
                  );
                }),
              ))),
    );
  }
}
