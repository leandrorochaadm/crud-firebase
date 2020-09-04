import 'package:flutter/material.dart';
import 'package:motodelivery/dashboard/dashboard_repository.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({Key key}) : super(key: key);
  DashboardRepository _repository = DashboardRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text(_repository.totalEntrega().toString()),
              subtitle: Text("Valor entregas"),
            ),
          ],
        ),
      ),
    );
  }
}
