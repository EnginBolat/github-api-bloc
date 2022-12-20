part of 'github_cubit.dart';

@immutable
abstract class GithubState {}

class GithubInitial extends GithubState {
  GithubInitial();
}

class LoadingState extends GithubState {
  LoadingState();
}

class GetUserData extends GithubState {
  final Map<String, dynamic> user;
  GetUserData(this.user);
}

class GetUserRepository extends GithubState {
  final List<dynamic> repositoryList;

  GetUserRepository(this.repositoryList);
}
