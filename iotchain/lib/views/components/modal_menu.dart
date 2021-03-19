import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ModalMenuOption extends StatelessWidget {
  final Function() action;
  final String title;
  IconData icon;

  ModalMenuOption({
    this.title,
    this.icon,
    this.action
  });

  @override
  Widget build(BuildContext context) => SizedBox(
      width: double.infinity,
      height: 55,
      child: InkWell(
          onTap: () => action(),
          child: ListTile(
              leading: Icon(icon, color: Colors.teal, size: 30,),
              title: Text(title,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                    FontWeight.bold,
                    color: Colors.teal
                ),
              )
          )
      )
  );
}

void showModalMenu({BuildContext context, List<ModalMenuOption> options}) {
  showMaterialModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).primaryColor.withAlpha(225),
    builder: (context) => Container(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: options,
          ),
        )),
  );
}