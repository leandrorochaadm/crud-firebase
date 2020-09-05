import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CalculaEntrega {
  Future<LatLng> searchandNavigate(String endereco) async {
    final List<Location> locations =
        await locationFromAddress("$endereco Ji-paraná Rondônia");

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
    if (distanciaMetros < 3500) {
      return 3.50;
    }
    if (distanciaMetros < 5000) {
      return 5.00;
    }
    if (distanciaMetros < 7000) {
      return 7.00;
    } else {
      return (distanciaMetros / 1000).ceilToDouble();
    }
  }

  Future<double> calcularValorEntregaPorEndereco(String endereco) async {
    return calcularValorEntrega(
        await calculeteDistanceInMeters(await searchandNavigate(endereco)));
  }
}
