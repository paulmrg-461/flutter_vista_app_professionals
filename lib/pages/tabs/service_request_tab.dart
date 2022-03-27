import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:professional_grupo_vista_app/models/professional_model.dart';
import 'package:professional_grupo_vista_app/models/service_request_model.dart';
import 'package:professional_grupo_vista_app/providers/service_request_provider.dart';
import 'package:professional_grupo_vista_app/widgets/service_request_list_item.dart';
import 'package:url_launcher/url_launcher.dart';

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
          padding: const EdgeInsets.only(left: 12, right: 12, top: 26),
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
                height: 22.0,
              ),
              professionalModel!.isEnable!
                  ? StreamBuilder<QuerySnapshot<ServiceRequestModel>>(
                      stream: professionalModel!.isAdmin!
                          ? ServiceRequestProvider.getAllAdminServiceRequests()
                          : ServiceRequestProvider.getAllServiceRequests(
                              professionalModel!.profession!),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot<ServiceRequestModel>>
                              snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Container(
                              width: double.infinity,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 22),
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xffD6BA5E),
                            ),
                          );
                        }

                        if (snapshot.hasData) {
                          final List<ServiceRequestListItem> requestsList =
                              snapshot.data!.docs.map(
                                  (DocumentSnapshot<ServiceRequestModel>
                                      document) {
                            ServiceRequestModel serviceRequestModel =
                                document.data()!;
                            return ServiceRequestListItem(
                              serviceRequestModel: serviceRequestModel,
                              professionalModel: professionalModel,
                            );
                          }).toList();

                          if (requestsList.isEmpty) {
                            return Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 22, vertical: 36),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.white10,
                                  borderRadius: BorderRadius.circular(22)),
                              child: Text(
                                  'No hay solicitudes disponibles para ${professionalModel!.profession}.',
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      // letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400)),
                            );
                          } else {
                            return Expanded(
                              child: ListView(
                                  physics: const BouncingScrollPhysics(),
                                  children: requestsList),
                            );
                          }
                        }
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xffD6BA5E),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: InkWell(
                        onTap: () => launch("tel://3218910268"),
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 22),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(22)),
                          child: const Text(
                              'Aún no cuentas con una suscripción activa como profesional en Vista APP. Si deseas más información, por favor comunícate al número 3218910268.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  // letterSpacing: 0.4,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
