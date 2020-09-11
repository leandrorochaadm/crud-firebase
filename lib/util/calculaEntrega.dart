import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CalculaEntrega {
  Future<LatLng> searchandNavigate(String endereco) async {
    final List<Location> locations = await locationFromAddress(endereco);

    return LatLng(locations[0].latitude, locations[0].longitude);
  }

/*
https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=-10.8865882,-61.950475&destinations=-10.8853693,-61.9351293&key=AIzaSyC9SHrMSjri7WHEpG9wjw_bVTti0E6jm98
*/
  Future<int> calculeteDistanceInMeters(LatLng localEntrega) async {
    Response response = await Dio().get(
        "https://maps.googleapis.com/maps/api/distancematrix/json" +
            "?units=metric" +
            "&origins=-10.886692, -61.950091" +
            "&destinations=${localEntrega.latitude},${localEntrega.longitude}" +
            "&key=AIzaSyC9SHrMSjri7WHEpG9wjw_bVTti0E6jm98");

    /* distancia["text"] =
          response.data["rows"][0]["elements"][0]["distance"]["text"];*/

    return response.data["rows"][0]["elements"][0]["distance"]["value"];
  }

  double calcularValorEntrega(int distanciaMetros) {
    if (distanciaMetros <= 2333) {
      return 3.50;
    } else if (distanciaMetros <= 4666) {
      return (distanciaMetros * 1.5) / 1000;
    } else {
      return ((distanciaMetros - 4666) / 1000) + 7;
    }
  }

  double arrendondar25centavos(double val) {
    return ((val / 0.25).ceil()) * .25;
  }

  Future<double> calcularValorEntregaPorEndereco(String endereco) async {
    return arrendondar25centavos(calcularValorEntrega(
        await calculeteDistanceInMeters(await searchandNavigate(endereco))));
  }
}
