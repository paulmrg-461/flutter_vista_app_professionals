import 'package:flutter/material.dart';
import 'package:professional_grupo_vista_app/providers/professionals_provider.dart';
import 'package:professional_grupo_vista_app/providers/user_provider.dart';
import 'package:professional_grupo_vista_app/widgets/custom_alert_dialog.dart';
import 'package:professional_grupo_vista_app/widgets/custom_buttom.dart';
import 'package:professional_grupo_vista_app/widgets/custom_input.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  final bool? isEditing;
  final String? name;
  final String? id;
  final String? address;
  final String? email;
  final String? profession;
  final String? specialty;
  const RegisterPage({
    Key? key,
    this.isEditing = false,
    this.name = '',
    this.id = '',
    this.address = '',
    this.email = '',
    this.profession = '',
    this.specialty = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    TextEditingController nameController = TextEditingController(text: name);
    TextEditingController idController = TextEditingController(text: id);
    TextEditingController addressController =
        TextEditingController(text: address);
    TextEditingController emailController = TextEditingController(text: email);
    TextEditingController passwordController = TextEditingController();
    TextEditingController professionController =
        TextEditingController(text: profession);
    TextEditingController specialtyController =
        TextEditingController(text: specialty);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff1B1B1B),
        appBar: AppBar(
          title: Text(
            isEditing! ? 'Editar profesional' : 'Registrar professional',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
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
                CustomInput(
                  hintText: 'Profesión *',
                  textController: professionController,
                  icon: Icons.business_center_outlined,
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  borderRadius: 8,
                  backgroundColor: Colors.black54,
                  borderColor: const Color(0xffD6BA5E),
                  fontColor: Colors.white,
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
                isEditing!
                    ? Container()
                    : CustomInput(
                        hintText: 'Correo electrónico *',
                        textController: emailController,
                        icon: Icons.email_outlined,
                        textInputType: TextInputType.emailAddress,
                        borderRadius: 8,
                        backgroundColor: Colors.black54,
                        borderColor: const Color(0xffD6BA5E),
                        fontColor: Colors.white,
                      ),
                isEditing!
                    ? Container()
                    : CustomInput(
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
                    text: isEditing! ? 'Aceptar' : 'Registrar',
                    width: double.infinity,
                    fontColor: const Color(0xff211915),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    backgroundColor: const Color(0xffD6BA5E),
                    onPressed: () => isEditing!
                        ? _edit(
                            nameController.text.trim(),
                            idController.text.trim(),
                            addressController.text.trim(),
                            professionController.text.trim(),
                            specialtyController.text.trim(),
                            emailController.text.trim().toLowerCase(),
                            context)
                        : _register(
                            nameController.text.trim(),
                            idController.text.trim(),
                            addressController.text.trim(),
                            emailController.text.trim().toLowerCase(),
                            passwordController.text.trim(),
                            professionController.text.trim(),
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
          'Aceptar');
    } else {
      userProvider
          .register(name, id, address, email, password, profession, specialty)
          .then((value) => value == 'Registration success'
              ? Navigator.pop(context)
              : CustomAlertDialog().showCustomDialog(
                  context, 'Registro incorrecto', value, 'Aceptar'));
    }
  }

  void _edit(String name, String id, String address, String profession,
      String specialty, String email, BuildContext context) {
    if (name == '' || id == '' || address == '' || profession == '') {
      CustomAlertDialog().showCustomDialog(
          context,
          'Campos vacíos',
          'Los campos obligatorios no pueden estar vacíos. Por favor revise los campos e intente nuevamente',
          'Aceptar');
    } else {
      ProfessionalsProvider.editProfessional(
              name, id, address, profession, specialty, email)
          .then((value) => value
              ? Navigator.pop(context)
              : CustomAlertDialog().showCustomDialog(
                  context,
                  'Error al actualizar datos',
                  'Error al actualizar datos del profesional. Por favor revise los campos e intente nuevamente',
                  'Aceptar'));
    }
  }
}
