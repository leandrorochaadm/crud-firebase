import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motodelivery/pedido/PedidoModel.dart';
import 'package:motodelivery/pedido/pedido_repository.dart';
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
  double _troco = 0;
  double _dinheiro;
  double _pedido;

  @override
  void initState() {
    super.initState();
    formaPagamentoDropDown = widget.pedido.formaPagamento ?? 'Selecione';
    _dinheiro = widget.pedido.valorDinheiro;
    _pedido = widget.pedido.valorPedido;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Endereco"),
                      autocorrect: false,
                      initialValue: widget.pedido.endereco ?? "",
                      validator: (value) {
                        if (value.trim().length < 5) {
                          return 'Nome da rua inválido';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        widget.pedido.endereco = val;
                      },
                    ),
                  ),
                  DropdownButton<String>(
                    value: widget.pedido.formaPagamento,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        widget.pedido.formaPagamento = newValue;
                      });
                    },
                    items: <String>['Selecione', 'Cartão', 'Dinheiro']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  (widget.pedido.formaPagamento == 'Dinheiro')
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(labelText: "Valor do pedido"),
                            autocorrect: false,
                            initialValue:
                                widget.pedido.valorPedido.toString() ?? "0.00",
                            validator: (value) {
                              if (double.tryParse(value) < 0) {
                                return 'Valor inválido';
                              }
                              return null;
                            },
                            onSaved: (val) {
                              widget.pedido.valorPedido = double.tryParse(val);
                            },
                            onChanged: (val) {
                              setState(() {
                                _pedido = double.parse(val);
                              });
                            },
                          ),
                        )
                      : Container(),
                  (widget.pedido.formaPagamento == 'Dinheiro')
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(labelText: "Troco para?"),
                            autocorrect: false,
                            initialValue:
                                widget.pedido.valorDinheiro.toString() ??
                                    "0.00",
                            onChanged: (val) {
                              setState(() {
                                _dinheiro = double.parse(val);
                              });
                            },
                            validator: (value) {
                              if (double.parse(value) <
                                  widget.pedido.valorPedido.toDouble()) {
                                return 'Valor não pode ser menor do que o pedido';
                              }
                              return null;
                            },
                            onSaved: (val) {
                              widget.pedido.valorDinheiro =
                                  double.tryParse(val);
                            },
                          ),
                        )
                      : Container(),
                  (widget.pedido.formaPagamento == 'Dinheiro')
                      ? Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            "Valor do troco: ${_dinheiro - _pedido}",
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
                        child: Text(
                          "Voltar",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      RaisedButton(
                        padding: EdgeInsets.all(8),
                        onPressed: () async {
                          final form = _formKey.currentState;
                          if (widget.pedido.formaPagamento != 'Cartão' &&
                              widget.pedido.formaPagamento != 'Dinheiro')
                            return _showDialogSemCategoria();
                          if (!form.validate()) return;
                          if (widget.pedido.formaPagamento == "Cartão") {
                            widget.pedido.valorDinheiro = 0.00;
                            widget.pedido.valorPedido = 0.00;
                          }
                          widget.pedido.valorEntrega =
                              await _entrega.calcularValorEntregaPorEndereco(
                                  widget.pedido.endereco);
                          form.save();

                          /* Scaffold.of(context).showSnackBar(SnackBar(
                                                                         content: Text('Enviando'),
                                                                         duration: Duration(seconds: 2),
                                                                       ));*/

                          repository.enviarPedido(widget.pedido);
                          Navigator.pop(context);

                          debugPrint("enviando Pedido");
                        },
                        child: Text(
                          "Salvar",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
      )),
    );
  }
}
