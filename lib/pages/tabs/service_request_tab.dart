import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:professional_grupo_vista_app/models/professional_model.dart';
import 'package:professional_grupo_vista_app/models/service_request_model.dart';
import 'package:professional_grupo_vista_app/providers/service_request_provider.dart';
import 'package:professional_grupo_vista_app/widgets/service_request_list_item.dart';

class ServiceRequestTab extends StatelessWidget {
  final ProfessionalModel? professionalModel;
  const ServiceRequestTab({Key? key, @required this.professionalModel})
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
                children: const [
                  Text(
                    'Solicitudes',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
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
                height: 32.0,
              ),
              StreamBuilder<QuerySnapshot<ServiceRequestModel>>(
                stream: ServiceRequestProvider.getAllServiceRequests(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<ServiceRequestModel>>
                        snapshot) {
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
                    return Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: snapshot.data!.docs.map(
                            (DocumentSnapshot<ServiceRequestModel> document) {
                          ServiceRequestModel serviceRequestModel =
                              document.data()!;
                          return ServiceRequestListItem(
                              serviceRequestModel: serviceRequestModel);
                        }).toList(),
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
