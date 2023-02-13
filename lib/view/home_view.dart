import 'package:flutter/material.dart';
import 'package:mvvm_flutter/utils/routes/routes_name.dart';
import 'package:mvvm_flutter/view_model/home_view_model.dart';
import 'package:mvvm_flutter/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel _homeViewModel = HomeViewModel();

  @override
  void initState() {
    _homeViewModel.fetchProductsListFromDummyJsonApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final manageUserSessionBySharePref = Provider.of<UserViewModel>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("home screen"),
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
              onTap: () {
                manageUserSessionBySharePref
                    .removeUserDetailsOnLogout()
                    .then((value) {
                  Navigator.pushNamed(context, RoutesName.login)
                      .onError((error, stackTrace) {
                    debugPrint("error in home view");
                  });
                });
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Center(child: Text("Logout")),
              ),
            ),
          ],
        ),
        body: ChangeNotifierProvider<HomeViewModel>(
          create: (context) => _homeViewModel,
          child: Consumer<HomeViewModel>(
            builder: (context, value, child) {
              switch (value.productsList.status) {
                case Status.loading:
                  return CircularProgressIndicator();

                case Status.completed:
                  return ListView.builder(
                    itemCount: value.productsList.data?.products?.length,
                      itemBuilder: (context,index){
                        return Card(
                          child: ListTile(
                            title: Text(value.productsList.data?.products![index].title ?? ''),
                            subtitle: Text(value.productsList.data?.products![index].id.toString() ?? ''),
                          ),
                        );
                      });

                case Status.error:
                  return Text(value.productsList.message.toString());

                default:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
