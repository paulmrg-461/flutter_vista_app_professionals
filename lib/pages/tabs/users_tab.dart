import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:professional_grupo_vista_app/models/user_model.dart';
import 'package:professional_grupo_vista_app/providers/users_provider.dart';
import 'package:professional_grupo_vista_app/widgets/users_list_item.dart';

class UsersTab extends StatelessWidget {
  const UsersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff1B1B1B),
        body: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 26),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    'Usuarios',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.group_outlined,
                    color: Color(0xffD6BA5E),
                    size: 38,
                  ),
                ],
              ),
              const SizedBox(
                height: 22.0,
              ),
              StreamBuilder<QuerySnapshot<UserModel>>(
                stream: UsersProvider.getAllUsers(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<UserModel>> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 22),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(22)),
                        child: const Text(
                            'Ha ocurrido un error al cargar las solicitudes de servicio. Por favor intenta nuevamente.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                // letterSpacing: 0.4,
                                fontWeight: FontWeight.w400)),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xffD6BA5E),
                      ),
                    );
                  }

                  if (snapshot.hasData) {
                    final List<UserModel> allUsers = snapshot.data!.docs
                        .map((DocumentSnapshot<UserModel> document) =>
                            document.data()!)
                        .toList();
                    final List<UserModel> activeUsers =
                        allUsers.where((user) => user.isEnable!).toList();
                    final List<UserModel> inactiveUsers =
                        allUsers.where((user) => !user.isEnable!).toList();
                    return Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                children: activeUsers
                                    .map((UserModel user) =>
                                        UsersListItem(userModel: user))
                                    .toList(),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                children: inactiveUsers
                                    .map((UserModel user) =>
                                        UsersListItem(userModel: user))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xffD6BA5E),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
