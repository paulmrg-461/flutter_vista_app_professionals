import 'package:flutter/material.dart';
import 'package:professional_grupo_vista_app/models/professional_model.dart';
import 'package:professional_grupo_vista_app/models/service_request_model.dart';
import 'package:professional_grupo_vista_app/providers/service_request_provider.dart';
import 'package:professional_grupo_vista_app/widgets/custom_alert_dialog.dart';

class ServiceRequestListItem extends StatelessWidget {
  final ServiceRequestModel? serviceRequestModel;
  final ProfessionalModel? professionalModel;
  const ServiceRequestListItem(
      {Key? key,
      @required this.serviceRequestModel,
      @required this.professionalModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 26),
      child: InkWell(
        onTap: () => CustomAlertDialog().showCustomDialog(
            context,
            'Solicitud de ${serviceRequestModel!.name}',
            'Está seguro que dese aceptar la solicitud del servicio de ${serviceRequestModel!.type}.',
            'No',
            'Sí',
            () => ServiceRequestProvider.acceptService(
                    professionalModel!, serviceRequestModel!)
                .then((value) => print('Redirect to chat'))),
        child: Row(
          children: [
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                  color: const Color(0xffD6BA5E),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4.0),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(serviceRequestModel!.photoUrl!))),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      serviceRequestModel!.name!,
                      // overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        serviceRequestModel!.email!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.85),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Text(
                      'Solicitud de ${serviceRequestModel!.type!}',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.85),
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '${serviceRequestModel!.dateTime!.day.toString().padLeft(2, '0')}/${serviceRequestModel!.dateTime!.month.toString().padLeft(2, '0')}/${serviceRequestModel!.dateTime!.year.toString()} - ${serviceRequestModel!.dateTime!.hour.toString().padLeft(2, '0')}:${serviceRequestModel!.dateTime!.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(
                          fontSize: 14,
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
