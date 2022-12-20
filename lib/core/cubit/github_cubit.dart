import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:github_api_app/constants/app_api.dart';
import 'package:github_api_app/model/repository_model.dart';
import 'package:http/http.dart' as http;

part 'github_state.dart';

class GithubCubit extends Cubit<GithubState> {
  GithubCubit() : super(GithubInitial());

  Future<bool> getUserData(String username) async {
    try {
      emit(LoadingState());
      var url = Uri.parse(AppApi.apiLink + username);
      var response = await http.get(url);
      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> data =
            Map<String, dynamic>.from(json.decode(response.body));
        emit(GetUserData(data));
        return true;
      }
    } catch (e) {
      if (kDebugMode) print(e);
      return false;
    }
    return false;
  }

  Future<void> getUserRepository(String username) async {
    try {
      emit(LoadingState());
      var url = Uri.parse("https://api.github.com/users/$username/repos");
      var response = await http.get(url);
      if (response.statusCode == HttpStatus.ok) {
       List<dynamic> data =  List<dynamic>.from(json.decode(response.body));
        emit(GetUserRepository(data));
      }
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }
}
