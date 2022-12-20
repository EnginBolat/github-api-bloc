import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:github_api_app/constants/app_padding.dart';
import 'package:github_api_app/constants/app_radius.dart';
import 'package:github_api_app/core/cubit/github_cubit.dart';
import 'package:github_api_app/view/repository_list_page.dart';

class UserDetailsPage extends StatelessWidget {
  const UserDetailsPage({super.key, required this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    bool? isAvalible;
    getControl() async {
      isAvalible = await GithubCubit().getUserData(username);
    }

    return BlocProvider(
      create: (context) {
        getControl();
        return GithubCubit()..getUserData(username);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<GithubCubit, GithubState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is LoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is GetUserData) {
                    return Padding(
                      padding: EdgeInsets.all(AppPadding.normalValue),
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(AppPadding.minValue),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: deviceWidth * 0.4,
                                    height: deviceHeight * 0.2,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        state.user["avatar_url"],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.all(AppPadding.normalValue),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.user["name"],
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        Text(
                                          state.user["login"],
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Text(
                              state.user["bio"],
                              style: const TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: deviceHeight * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  FontAwesomeIcons.twitter,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(width: deviceWidth * 0.05),
                                Text("@${state.user["twitter_username"]}")
                              ],
                            ),
                            SizedBox(height: deviceHeight * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(width: deviceWidth * 0.05),
                                Text("${state.user["followers"]} Takipçi"),
                                SizedBox(width: deviceWidth * 0.05),
                                Text("${state.user["following"]} Takip Edilen"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.book,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(width: deviceWidth * 0.05),
                                    const Text("Repository"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("${state.user["public_repos"]} "),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RepositoryListPage(
                                              username: state.user["login"],
                                            ),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.chevron_right,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
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
