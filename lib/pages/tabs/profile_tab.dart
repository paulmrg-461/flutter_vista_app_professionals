import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:professional_grupo_vista_app/models/professional_model.dart';
import 'package:professional_grupo_vista_app/providers/user_provider.dart';
import 'package:professional_grupo_vista_app/widgets/custom_alert_dialog.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  final ProfessionalModel? professionalModel;
  const ProfileTab({Key? key, @required this.professionalModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider _userProvider = Provider.of<UserProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff1B1B1B),
        body: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 32),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Mi perfil',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold),
                  ),
                  FaIcon(
                    FontAwesomeIcons.user,
                    size: 34,
                    color: Color(0xffD6BA5E),
                  )
                ],
              ),
              const SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                        color: const Color(0xffD6BA5E),
                        border: Border.all(color: Colors.white, width: 5.0),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(professionalModel!.photoUrl!))),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            professionalModel!.name!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              professionalModel!.email!,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.85),
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 13,
                                height: 13,
                                decoration: BoxDecoration(
                                    color: professionalModel!.isEnable!
                                        ? Colors.green.withOpacity(0.8)
                                        : Colors.red.withOpacity(0.8),
                                    shape: BoxShape.circle),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                professionalModel!.isAdmin!
                                    ? 'Administrador Grupo Vista'
                                    : 'Profesional Grupo Vista',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white.withOpacity(0.85),
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  PopupMenuButton(
                      tooltip: 'Acciones',
                      icon: const Icon(
                        Icons.more_horiz,
                        size: 38,
                        color: Color(0xffD6BA5E),
                      ),
                      onSelected: (value) {
                        switch (value) {
                          case 0:
                            _userProvider.logout().then((value) => value
                                ? Navigator.pushReplacementNamed(
                                    context, 'login')
                                : CustomAlertDialog().showCustomDialog(
                                    context,
                                    'Ha ocurrido un error',
                                    'Ha ocurrido un error al cerrar sesión, por favor intente nuevamente.',
                                    '',
                                    'Aceptar',
                                    () => Navigator.pop(context)));
                            break;
                          case 1:
                            Navigator.pushNamed(context, 'about');
                            break;
                          default:
                            print(value);
                        }
                      },
                      itemBuilder: (_) => [
                            PopupMenuItem(
                                value: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Icon(
                                      Icons.logout_rounded,
                                      size: 20,
                                      color: Colors.black87,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text('Cerrar sesión'),
                                  ],
                                )),
                            PopupMenuItem(
                                value: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Icon(
                                      Icons.developer_mode_rounded,
                                      size: 20,
                                      color: Colors.black87,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text('Acerca de'),
                                  ],
                                )),
                          ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
