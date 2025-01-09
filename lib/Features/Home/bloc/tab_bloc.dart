import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp_project/Features/Home/bloc/tab_event.dart';
import 'package:travelapp_project/Features/Home/bloc/tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabState(0)) {
    on<ChangeTab>((event, emit) {
      emit(TabState(event.index));
    });
  }
}
