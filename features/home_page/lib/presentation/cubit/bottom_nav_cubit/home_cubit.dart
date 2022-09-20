import 'package:bloc/bloc.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(homeState: ViewData.loaded(data: 0)));

  void changeTab({required int tabIndex}) => emit(
        HomeState(
          homeState: ViewData.loaded(data: tabIndex),
        ),
      );
}
