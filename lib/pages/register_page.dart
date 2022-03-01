import 'package:flutter/material.dart';
import 'package:professional_grupo_vista_app/providers/professionals_provider.dart';
import 'package:professional_grupo_vista_app/providers/user_provider.dart';
import 'package:professional_grupo_vista_app/widgets/custom_alert_dialog.dart';
import 'package:professional_grupo_vista_app/widgets/custom_button.dart';
import 'package:professional_grupo_vista_app/widgets/custom_input.dart';
import 'package:provider/provider.dart';

TextEditingController nameController = TextEditingController();
TextEditingController idController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController specialtyController = TextEditingController();

class RegisterPage extends StatelessWidget {
  const RegisterPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff1B1B1B),
        appBar: AppBar(
          title: Text(
            'Registrar professional',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 22, horizontal: 12),
            padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 36),
            decoration: BoxDecoration(
                color: Colors.white10, borderRadius: BorderRadius.circular(22)),
            child: Column(
              children: [
                CustomInput(
                  hintText: 'Nombre completo *',
                  textController: nameController,
                  icon: Icons.person_outline,
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  borderRadius: 8,
                  backgroundColor: Colors.black54,
                  borderColor: const Color(0xffD6BA5E),
                  fontColor: Colors.white,
                ),
                CustomInput(
                  hintText: 'Cédula *',
                  textController: idController,
                  icon: Icons.account_box_outlined,
                  textInputType: TextInputType.number,
                  borderRadius: 8,
                  backgroundColor: Colors.black54,
                  borderColor: const Color(0xffD6BA5E),
                  fontColor: Colors.white,
                ),
                CustomInput(
                  hintText: 'Dirección *',
                  textController: addressController,
                  icon: Icons.location_on_outlined,
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  borderRadius: 8,
                  backgroundColor: Colors.black54,
                  borderColor: const Color(0xffD6BA5E),
                  fontColor: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color:
                          Colors.black54, //background color of dropdown button
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Icon(
                              Icons.business_center_outlined,
                              color: const Color(0xffD6BA5E),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: DropdownButton<String>(
                                  hint: Text(
                                    'Profesión *',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  isExpanded: true,
                                  dropdownColor: Colors.black87,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                  underline: Container(),
                                  value: userProvider.professionSelected,
                                  items: [
                                    'Abogados',
                                    'Ingenieros',
                                    'Contadores',
                                    'Administradores'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style: TextStyle(
                                              inherit: false,
                                              color: Colors.white,
                                              fontSize: 15)),
                                    );
                                  }).toList(),
                                  onChanged: (value) =>
                                      userProvider.professionSelected = value),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                CustomInput(
                  hintText: 'Especialidad',
                  textController: specialtyController,
                  icon: Icons.star_border,
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  borderRadius: 8,
                  backgroundColor: Colors.black54,
                  borderColor: const Color(0xffD6BA5E),
                  fontColor: Colors.white,
                ),
                CustomInput(
                  hintText: 'Correo electrónico *',
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
                    text: 'Registrar',
                    width: double.infinity,
                    fontColor: const Color(0xff211915),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    backgroundColor: const Color(0xffD6BA5E),
                    onPressed: () => _register(
                        nameController.text.trim(),
                        idController.text.trim(),
                        addressController.text.trim(),
                        emailController.text.trim().toLowerCase(),
                        passwordController.text.trim(),
                        userProvider.professionSelected,
                        specialtyController.text.trim(),
                        userProvider,
                        context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _register(
      String name,
      String id,
      String address,
      String email,
      String password,
      String profession,
      String specialty,
      UserProvider userProvider,
      BuildContext context) {
    if (name == '' ||
        email == '' ||
        password == '' ||
        id == '' ||
        address == '' ||
        profession == '') {
      CustomAlertDialog().showCustomDialog(
          context,
          'Campos vacíos',
          'Los campos obligatorios no pueden estar vacíos. Por favor revise los campos e intente nuevamente',
          '',
          'Aceptar',
          () => Navigator.pop(context));
    } else {
      userProvider
          .register(name, id, address, email, password, profession, specialty)
          .then((value) => value == 'Registration success'
              ? Navigator.pop(context)
              : CustomAlertDialog().showCustomDialog(
                  context,
                  'Registro incorrecto',
                  value,
                  '',
                  'Aceptar',
                  () => Navigator.pop(context)));
    }
  }

  void _edit(String name, String id, String address, String profession,
      String specialty, String email, BuildContext context) {
    if (name == '' || id == '' || address == '' || profession == '') {
      CustomAlertDialog().showCustomDialog(
          context,
          'Campos vacíos',
          'Los campos obligatorios no pueden estar vacíos. Por favor revise los campos e intente nuevamente',
          '',
          'Aceptar',
          () => Navigator.pop(context));
    } else {
      ProfessionalsProvider.editProfessional(
              name, id, address, profession, specialty, email)
          .then((value) => value
              ? Navigator.pop(context)
              : CustomAlertDialog().showCustomDialog(
                  context,
                  'Error al actualizar datos',
                  'Error al actualizar datos del profesional. Por favor revise los campos e intente nuevamente',
                  '',
                  'Aceptar',
                  () => Navigator.pop(context)));
    }
  }
}
