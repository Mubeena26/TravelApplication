import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'flight_event.dart';
part 'flight_state.dart';

class FlightBloc extends Bloc<FlightEvent, FlightState> {
  FlightBloc() : super(FlightInitial()) {
    on<SearchFlights>(_onSearchFlights);
  }

  Future<void> _onSearchFlights(
      SearchFlights event, Emitter<FlightState> emit) async {
    emit(FlightLoading());
    try {
      final response = await http.get(
        Uri.parse(
          'https://serpapi.com/search.json?engine=google_flights&type=2&departure_id=${event.departure}&arrival_id=${event.arrival}&gl=us&hl=en&currency=USD&outbound_date=${event.date.toIso8601String().substring(0, 10)}&api_key=b80c114322d73441770249c1c300feb87efd782882ffecb01cde7afdb378fcc9',
        ),
      );
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         final List<dynamic>? data = jsonResponse.containsKey('flights')
//             ? jsonResponse['flights']
//             : jsonResponse['properties'];
//         if (data != null && data.isNotEmpty) {
//           print('flights Found: ${data.length}');
//           print('flights Details: ${data}');
//           emit(FlightLoaded(data));
//         } else {
//           print('Error: No flight found for the given search query.');
//           emit(FlightError('No flight found for the given search query.'));
//         }
//       } else {
//         throw Exception(
//             'Failed to load flights. Status code: ${response.statusCode}');
//       }
//     } on SocketException {
//       print('Error: Please check your internet connection.');
//       emit(FlightError('Please check your internet connection.'));
//     } catch (e) {
//       print('Error: $e');
//       emit(FlightError('Error: $e'));
//     }
//   }
// }
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('best_flights')) {
          emit(FlightLoaded(jsonResponse['best_flights']));
        } else {
          emit(FlightError('No flights found for the given criteria'));
        }
      } else {
        emit(FlightError('Error fetching flight details'));
      }
    } catch (e) {
      emit(FlightError('An error occurred: $e'));
    }
  }
}
