import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:professional_grupo_vista_app/models/professional_model.dart';
import 'package:professional_grupo_vista_app/providers/professionals_provider.dart';
import 'package:professional_grupo_vista_app/widgets/professionals_list_item.dart';

class ProfessionalsTab extends StatelessWidget {
  final ProfessionalModel? professionalModel;
  const ProfessionalsTab({Key? key, @required this.professionalModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff1B1B1B),
        body: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 32),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Profesionales',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      tooltip: 'Agregar nuevo profesional',
                      onPressed: () => Navigator.pushNamed(context, 'register'),
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: Color(0xffD6BA5E),
                        size: 38,
                      )),
                ],
              ),
              const SizedBox(
                height: 32.0,
              ),
              StreamBuilder<QuerySnapshot<ProfessionalModel>>(
                stream: ProfessionalsProvider.getAllProfessionals(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<ProfessionalModel>> snapshot) {
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
                    final List<ProfessionalModel> allProfessionals = snapshot
                        .data!.docs
                        .map((DocumentSnapshot<ProfessionalModel> document) =>
                            document.data()!)
                        .toList();
                    final List<ProfessionalModel> activeProfessionals =
                        allProfessionals
                            .where((professional) => professional.isEnable!)
                            .toList();
                    final List<ProfessionalModel> inactiveProfessionals =
                        allProfessionals
                            .where((professional) => !professional.isEnable!)
                            .toList();
                    return Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              children: activeProfessionals
                                  .map((ProfessionalModel professional) =>
                                      ProfessionalsListItem(
                                          professionalModel: professional))
                                  .toList(),
                            ),
                          ),
                          Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              children: inactiveProfessionals
                                  .map((ProfessionalModel professional) =>
                                      ProfessionalsListItem(
                                          professionalModel: professional))
                                  .toList(),
                            ),
                          ),
                        ],
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
