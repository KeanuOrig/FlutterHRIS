import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_mobile_app/src/blocs/user_detail/user_detail_bloc.dart';
import 'package:hris_mobile_app/src/blocs/user_detail/user_detail_event.dart';
import 'package:hris_mobile_app/src/blocs/user_detail/user_detail_state.dart';
import 'package:hris_mobile_app/src/components/loading_screen.dart';
import 'base_page.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDetailBloc()..add(LoadUserDetail()),
      child: BasePage(
        currentRoute: '/user',
        title: 'Profile',
        child: BlocBuilder<UserDetailBloc, UserDetailState>(
          builder: (context, state) {  
            if (state is UserDetailSuccess) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildProfileHeader(state),
                    _buildUserInfo(state),
                  ],
                )
              );
            } else {
              return const LoadingScreen();
            }
          }
        )
      )
    );
  }

  Widget _buildProfileHeader(state) {
    String firstName = state.userDetail.firstName;
    String lastName = state.userDetail.lastName;
    String position = state.userDetail.position;
    String initials = _getInitials(firstName, lastName);

    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50.0,
            backgroundColor: Colors.white,
            child: Text(
              initials,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$firstName $lastName',
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                position,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getInitials(String firstName, String lastName) {
    if (firstName.isEmpty && lastName.isEmpty) {
      return '';
    } else if (firstName.isNotEmpty && lastName.isEmpty) {
      return firstName.substring(0, 1).toUpperCase();
    } else if (firstName.isEmpty && lastName.isNotEmpty) {
      return lastName.substring(0, 1).toUpperCase();
    } else {
      return '${firstName[0].toUpperCase()}${lastName[0].toUpperCase()}';
    }
  }

  Widget _buildUserInfo(state) {
    Widget buildListTile(IconData icon, String title, String subtitle) {
      return ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildListTile(Icons.email, 'Email', state.userDetail.email),
          buildListTile(Icons.phone, 'Phone', state.userDetail.mobileNumber.toString()),
          buildListTile(Icons.work, 'Branch', state.userDetail.branch),
          buildListTile(Icons.business, 'Department', state.userDetail.department),
          buildListTile(Icons.verified_user, 'Status', state.userDetail.status.toString()),
          buildListTile(Icons.flag, 'Nationality', state.userDetail.nationality.toString()),
          buildListTile(Icons.accessibility_new, 'Religion', state.userDetail.religion.toString()),
          buildListTile(Icons.family_restroom, 'Marital Status', state.userDetail.maritalStatus.toString()),
        ],
      ),
    );
  }
}