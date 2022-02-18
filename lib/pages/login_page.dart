import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:professional_grupo_vista_app/providers/user_provider.dart';
import 'package:professional_grupo_vista_app/widgets/custom_alert_dialog.dart';
import 'package:professional_grupo_vista_app/widgets/custom_buttom.dart';
import 'package:professional_grupo_vista_app/widgets/custom_input.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserProvider? userProvider;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.black54,
        backgroundColor: const Color(0xff1B1B1B),
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text('Bienvenido a Vista App',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            letterSpacing: 0.4,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(
                      height: 18,
                    ),
                    SvgPicture.asset(
                      'assets/icons/logo_grupo_vista.svg',
                      semanticsLabel: 'Logo Grupo Vista',
                      width: MediaQuery.of(context).size.height * 0.33,
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(vertical: 22, horizontal: 12),
                  padding:
                      const EdgeInsets.symmetric(vertical: 42, horizontal: 36),
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(22)),
                  child: Column(
                    children: [
                      CustomInput(
                        hintText: 'Correo electrónico',
                        textController: emailController,
                        icon: Icons.email_outlined,
                        textInputType: TextInputType.emailAddress,
                        borderRadius: 8,
                        backgroundColor: Colors.black54,
                        borderColor: const Color(0xffD6BA5E),
                        fontColor: Colors.white,
                      ),
                      CustomInput(
                        hintText: 'Contraseña',
                        textController: passwordController,
                        icon: Icons.lock_outline_rounded,
                        obscureText: true,
                        passwordVisibility: true,
                        borderRadius: 8,
                        backgroundColor: Colors.black54,
                        borderColor: const Color(0xffD6BA5E),
                        fontColor: Colors.white,
                      ),
                      CustomButton(
                          text: 'Iniciar sesión',
                          width: double.infinity,
                          fontColor: const Color(0xff211915),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          backgroundColor: const Color(0xffD6BA5E),
                          onPressed: () => _login(emailController.text.trim(),
                              passwordController.text.trim())),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(22)),
                  child: const Text(
                      'Somos una oficina virtual donde encontrarás asesoría y acompañamiento de diferentes profesionales como abogados, contadores, ingenieros, administradores de empresas y asesores en el área que requieras, sin necesidad de moverte de tu casa o empresa, afíliate al GRUPO VISTA.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          // letterSpacing: 0.4,
                          fontWeight: FontWeight.w400)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login(String email, String password) {
    if (email == '' || password == '') {
      CustomAlertDialog().showCustomDialog(
          context,
          'Campos vacíos',
          'Los campos no pueden estar vacíos. Por favor revise los campos e intente nuevamente',
          'Aceptar');
    } else {
      userProvider!.login(email, password).then((value) =>
          value == 'Login success'
              ? Navigator.pushReplacementNamed(context, 'home')
              : CustomAlertDialog().showCustomDialog(
                  context, 'Ha ocurrido un error', value, 'Aceptar'));
    }
  }
}
