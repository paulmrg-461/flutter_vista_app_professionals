import 'package:flutter/material.dart';
import 'package:professional_grupo_vista_app/models/professional_model.dart';
import 'package:professional_grupo_vista_app/pages/register_page.dart';
import 'package:professional_grupo_vista_app/providers/professionals_provider.dart';

class ProfessionalsListItem extends StatelessWidget {
  final ProfessionalModel? professionalModel;
  const ProfessionalsListItem({Key? key, @required this.professionalModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 26, right: 22),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.78,
        // margin: const EdgeInsets.symmetric(vertical: 22, horizontal: 12),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
        decoration: BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.white.withOpacity(0.1),
              offset: const Offset(3, 3),
              blurRadius: 10)
        ], color: Colors.white10, borderRadius: BorderRadius.circular(22)),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.height * 0.085,
                  height: MediaQuery.of(context).size.height * 0.085,
                  // margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      color: const Color(0xffD6BA5E),
                      border: Border.all(color: Colors.white, width: 5.0),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(professionalModel!.photoUrl!))),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.00275,
                  right: MediaQuery.of(context).size.height * 0.00275,
                  child: Container(
                    width: MediaQuery.of(context).size.height * 0.02,
                    height: MediaQuery.of(context).size.height * 0.02,
                    decoration: BoxDecoration(
                        color: professionalModel!.isEnable!
                            ? Colors.green
                            : Colors.red,
                        shape: BoxShape.circle),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                Flexible(
                  child: Text(
                    professionalModel!.name!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                PopupMenuButton(
                    tooltip: 'Acciones',
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 32,
                      color: Color(0xffD6BA5E),
                    ),
                    onSelected: (value) {
                      switch (value) {
                        case 0:
                          ProfessionalsProvider.changeProfessionalStatus(
                              professionalModel!.isEnable!
                                  ? 'isEnabled'
                                  : 'isDisabled',
                              professionalModel!.email!);
                          break;
                        case 1:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(
                                  isEditing: true,
                                  name: professionalModel!.name,
                                  id: professionalModel!.id,
                                  email: professionalModel!.email,
                                  address: professionalModel!.address,
                                  profession: professionalModel!.profession,
                                  specialty: professionalModel!.specialty,
                                ),
                              ));
                          break;
                        default:
                          print(value);
                      }
                    },
                    itemBuilder: (_) => [
                          PopupMenuItem(
                              value: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  professionalModel!.isEnable!
                                      ? const Icon(
                                          Icons.radio_button_unchecked_rounded,
                                          size: 20,
                                          color: Colors.black87,
                                        )
                                      : const Icon(
                                          Icons.check_circle_outline_rounded,
                                          size: 20,
                                          color: Colors.black87,
                                        ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  professionalModel!.isEnable!
                                      ? const Text('Deshabilitar')
                                      : const Text('Habilitar'),
                                ],
                              )),
                          PopupMenuItem(
                              value: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Icon(
                                    Icons.edit,
                                    size: 20,
                                    color: Colors.black87,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text('Editar'),
                                ],
                              )),
                        ]),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Divider(color: Color(0xffD6BA5E)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.email_outlined,
                  color: Color(0xffD6BA5E),
                  size: 22,
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    professionalModel!.email!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.85),
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.account_box_outlined,
                    color: Color(0xffD6BA5E),
                    size: 22,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      professionalModel!.id!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white.withOpacity(0.85),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on_outlined,
                      color: Color(0xffD6BA5E), size: 22),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    professionalModel!.address!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.85),
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.business_center_outlined,
                    color: Color(0xffD6BA5E),
                    size: 22,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    professionalModel!.profession!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.85),
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            professionalModel!.specialty == ''
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.star_border,
                          color: Color(0xffD6BA5E),
                          size: 22,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          professionalModel!.specialty!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white.withOpacity(0.85),
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.date_range_rounded,
                      color: Color(0xffD6BA5E),
                      size: 22,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${professionalModel!.registerDate!.day.toString().toString().padLeft(2, '0')}/${professionalModel!.registerDate!.month.toString().padLeft(2, '0')}/${professionalModel!.registerDate!.year.toString()}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white.withOpacity(0.85),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
