import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_api_app/core/cubit/github_cubit.dart';

class RepositoryListPage extends StatelessWidget {
  const RepositoryListPage({super.key, required this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => GithubCubit()..getUserRepository(username),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<GithubCubit, GithubState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetUserRepository) {
              return ListView.builder(
                itemCount: state.repositoryList.length,
                itemBuilder: (context, index) {
                  var repoItem = state.repositoryList;
                  return Card(
                    child: SizedBox(
                      height: deviceHeight * 0.1,
                      child: ListTile(
                        title: Text(repoItem[index]["name"]),
                        subtitle: Text(repoItem[index]["description"] ?? ""),
                        trailing: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 18,
                            ),
                            Text(repoItem[index]["stargazers_count"]
                                .toString())
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("Error"),
              );
            }
          },
        ),
      ),
    );
  }
}
