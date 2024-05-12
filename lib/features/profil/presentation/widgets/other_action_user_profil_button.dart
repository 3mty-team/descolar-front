import 'package:descolar_front/core/arguments/arguments.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/profil/presentation/providers/profil_provider.dart';
import 'package:flutter/material.dart';

class OtherActionUserProfilButton extends StatelessWidget {
  final ProfilProvider profilProvider;

  const OtherActionUserProfilButton({super.key, required this.profilProvider});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) {
       return [
         const PopupMenuItem<String>(
           value: 'report',
           child: Row(
             children: [
               Padding(
                 padding: EdgeInsets.only(right: 5),
                 child: Icon(Icons.report),
               ),
               Text('Signaler', style: TextStyle(fontSize: 15)),
             ],
           ),
         ),
         const PopupMenuItem<String>(
           value: 'block',
           child: Row(
             children: [
               Padding(
                 padding: EdgeInsets.only(right: 5),
                 child: Icon(Icons.block),
               ),
               Text('Bloquer', style: TextStyle(fontSize: 15)),
             ],
           ),
         ),
       ];
      },
      onSelected: (value) {
        switch (value) {
          case 'report':
            Navigator.pushNamed(context, '/report-user', arguments: UserProfilArguments(profilProvider.userProfil!.uuid));
            break;
          case 'block':
            profilProvider.blockUser();
            break;
        }
      },
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(42),
        ),
        child: const Icon(Icons.more_horiz, color: AppColors.white,),
      ),
    );
  }
}
