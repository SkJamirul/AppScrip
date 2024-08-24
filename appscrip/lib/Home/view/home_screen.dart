import 'package:appscrip/Home/bloc/home_bloc.dart';
import 'package:appscrip/Home/view/widget/appbar.dart';
import 'package:appscrip/Home/view/widget/user_list.dart';
import 'package:appscrip/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appscrip/Home/model/user_api_model.dart';
// Import the details screen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';
  List<UserApiResModel> userList = [];
  List<UserApiResModel> filteredUserList = [];
  bool isSearchBarVisible = false;

  @override
  void initState() {
    super.initState();
    // Dispatch the event to load data initially
    context.read<HomeBloc>().add(HomeGetUserApiHitEvent());
  }

// function for search , every time call on typing
  void _onSearchChanged(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      filteredUserList = userList.where((user) {
        return user.name?.toLowerCase().contains(searchQuery) ?? false;
      }).toList();
    });
  }

//function to clear the search text
  void _toggleSearchBar() {
    setState(() {
      isSearchBarVisible = !isSearchBarVisible;
      if (!isSearchBarVisible) {
        searchQuery = '';
        filteredUserList = userList;
      }
    });
  }

//function for pull to refresh
  Future<void> _onRefresh() async {
    // Dispatch the event to reload data when pulled to refresh
    context.read<HomeBloc>().add(HomeGetUserApiHitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(
          context: context,
          isSearchBarVisible: isSearchBarVisible,
          onSearchChanged: _onSearchChanged,
          toggleSearchBar: _toggleSearchBar),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeUserDataFetchSuccessState) {
            // Initialize the userList and filteredUserList when data is fetched
            userList = state.users;
            filteredUserList = userList.where((user) {
              return user.name?.toLowerCase().contains(searchQuery) ?? false;
            }).toList();

            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: UserListWidget(filteredUserList: filteredUserList),
            );
          } else if (state is HomeUserDateFetchFailedState) {
            // show the error message using toast 
            ToastUtils.showToast('Error: ${state.errorMsg}');
            return Center(child: Text('Error: ${state.errorMsg}'));
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
