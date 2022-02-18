import 'package:flutter/material.dart';
import 'package:professional_grupo_vista_app/models/professional_model.dart';
import 'package:professional_grupo_vista_app/pages/tabs/professionals_tab.dart';
import 'package:professional_grupo_vista_app/pages/tabs/profile_tab.dart';
import 'package:professional_grupo_vista_app/pages/tabs/service_request_tab.dart';
import 'package:professional_grupo_vista_app/pages/tabs/users_tab.dart';
import 'package:professional_grupo_vista_app/providers/user_provider.dart';
import 'package:professional_grupo_vista_app/widgets/custom_animated_bottom_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final Color _inactiveColor = Colors.grey;
  final Color _activeColor = const Color(0xffD6BA5E);

  @override
  Widget build(BuildContext context) {
    final UserProvider _userProvider = Provider.of<UserProvider>(context);
    return FutureBuilder<ProfessionalModel>(
        future: _getUserInformation(_userProvider),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text(
                  'Ha ocurrido un error al cargar datos, por favor intente nuevamente.',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            );
          }
          if (snapshot.hasData) {
            final ProfessionalModel _professionalModel =
                snapshot.data as ProfessionalModel;
            return Scaffold(
              body: getBody(_professionalModel),
              bottomNavigationBar: _buildBottomBar(_professionalModel),
            );
          }
          return const Scaffold(
            backgroundColor: Color(0xff211915),
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget _buildBottomBar(ProfessionalModel _professionalModel) {
    final List<BottomNavyBarItem> itemsNavBar = _professionalModel.isAdmin!
        ? [
            BottomNavyBarItem(
              icon: const Icon(Icons.person_add_alt_1_rounded),
              title: const Text('Solicitudes'),
              activeColor: _activeColor,
              inactiveColor: _inactiveColor,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.message),
              title: const Text('Mensajes'),
              activeColor: _activeColor,
              inactiveColor: _inactiveColor,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.group_rounded),
              title: const Text('Usuarios'),
              activeColor: _activeColor,
              inactiveColor: _inactiveColor,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.business_center_rounded),
              title: const Text('Profesionales'),
              activeColor: _activeColor,
              inactiveColor: _inactiveColor,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.person),
              title: const Text('Perfil'),
              activeColor: _activeColor,
              inactiveColor: _inactiveColor,
              textAlign: TextAlign.center,
            ),
          ]
        : [
            BottomNavyBarItem(
              icon: const Icon(Icons.person_add_alt_1_rounded),
              title: const Text('Solicitudes'),
              activeColor: _activeColor,
              inactiveColor: _inactiveColor,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.message),
              title: const Text('Mensajes'),
              activeColor: _activeColor,
              inactiveColor: _inactiveColor,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.person),
              title: const Text('Perfil'),
              activeColor: _activeColor,
              inactiveColor: _inactiveColor,
              textAlign: TextAlign.center,
            ),
          ];

    return CustomAnimatedBottomBar(
        containerHeight: 70,
        backgroundColor: Colors.black,
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() => _currentIndex = index),
        items: itemsNavBar);
  }

  Widget getBody(ProfessionalModel _professionalModel) {
    List<Widget> pages = [
      ServiceRequestTab(
        professionalModel: _professionalModel,
      ),
      ProfileTab(
        professionalModel: _professionalModel,
      ),
      const UsersTab(),
      ProfessionalsTab(
        professionalModel: _professionalModel,
      ),
      ProfileTab(
        professionalModel: _professionalModel,
      ),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }

  Future<ProfessionalModel> _getUserInformation(
          UserProvider _userProvider) async =>
      await _userProvider.getUserInformation();
}
