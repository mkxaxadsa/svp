import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/db/prefs.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetHomeEvent>((event, emit) async {
      await getData().then((_) {
        emit(HomeLoadedState(
          coins: Prefs.coins,
          gems: Prefs.gems,
        ));
      });
    });
  }
}
