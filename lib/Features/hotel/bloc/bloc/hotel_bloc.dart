import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'hotel_event.dart';
part 'hotel_state.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  HotelBloc() : super(HotelInitial()) {
    on<SearchHotelsEvent>(_onSearchHotels);
  }

  Future<void> _onSearchHotels(
      SearchHotelsEvent event, Emitter<HotelState> emit) async {
    if (event.hotelCity == null || event.hotelCity!.isEmpty) {
      print('Error: Please enter a search query.');
      return;
    }

    emit(HotelLoading());
    try {
      final url =
          'https://serpapi.com/search.json?engine=google_hotels&q=${event.hotelCity}&gl=us&hl=en&currency=USD&check_in_date=${event.checkIn?.toIso8601String().substring(0, 10)}&check_out_date=${event.checkOut?.toIso8601String().substring(0, 10)}&api_key=b80c114322d73441770249c1c300feb87efd782882ffecb01cde7afdb378fcc9';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic>? data = jsonResponse.containsKey('hotels')
            ? jsonResponse['hotels']
            : jsonResponse['properties'];
        if (data != null && data.isNotEmpty) {
          print('Hotels Found: ${data.length}');
          print('Hotel Details: ${data}');
          emit(HotelLoaded(data));
        } else {
          print('Error: No hotels found for the given search query.');
          emit(HotelError('No hotels found for the given search query.'));
        }
      } else {
        throw Exception(
            'Failed to load hotels. Status code: ${response.statusCode}');
      }
    } on SocketException {
      print('Error: Please check your internet connection.');
      emit(HotelError('Please check your internet connection.'));
    } catch (e) {
      print('Error: $e');
      emit(HotelError('Error: $e'));
    }
  }
}
