import 'package:flutter/material.dart';
import 'package:github_api_app/constants/app_images.dart';
import 'package:github_api_app/constants/app_padding.dart';
import 'package:github_api_app/constants/app_radius.dart';
import 'package:github_api_app/core/cubit/github_cubit.dart';
import 'package:github_api_app/view/user_details_page.dart';

import '../constants/app_text.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final TextEditingController _userNameController = TextEditingController();
  bool? isExist;
  getValue() async {
    isExist = await GithubCubit().getUserData(_userNameController.text);
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.normalValue),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Image.asset(
                  AppImages.octocat,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: deviceHeight * 0.1),
              TextField(
                decoration: InputDecoration(
                  hintText: AppText.userName,
                  labelText: AppText.userName,
                ),
                controller: _userNameController,
              ),
              SizedBox(height: deviceHeight * 0.02),
              SizedBox(
                width: deviceWidth * 0.6,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.minValue),
                    ),
                  ),
                  onPressed: () async {
                    await getValue();
                    Future.delayed(Duration(seconds: 3));
                    if (isExist != true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Böyle bir kullanıcı mevcut değil!'),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetailsPage(
                              username: _userNameController.text),
                        ),
                      );
                    }
                  },
                  child: Text(
                    AppText.search,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
