import 'package:appscrip/Home/model/user_api_model.dart';
import 'package:appscrip/controller/user_details_controller.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

UserDetailsController controller = UserDetailsController();

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeGetUserApiHitEvent>((event, emit) async {
      emit(HomeLoadingState());
      final response = await controller.fetchUserListData;
      if (response.isNotEmpty) {
        emit(HomeUserDataFetchSuccessState(users: response));
      } else {
        emit(
            HomeUserDateFetchFailedState(errorMsg: "Failed to load user data"));
      }
    });
    
  }

  
}
