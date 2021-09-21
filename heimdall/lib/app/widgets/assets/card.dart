import 'package:chainmetric/infrastructure/repositories/assets_fabric.dart';
import 'package:chainmetric/platform/repositories/identities_shared.dart';
import 'package:chainmetric/platform/repositories/localdata_json.dart';
import 'package:chainmetric/infrastructure/repositories/requirements_fabric.dart';
import 'package:chainmetric/app/theme/theme.dart';
import 'package:chainmetric/models/assets/asset.dart';
import 'package:chainmetric/app/utils/utils.dart';
import 'package:chainmetric/app/widgets/common/modal_menu.dart';
import 'package:chainmetric/app/pages/assets/asset_form.dart';
import 'package:chainmetric/app/pages/readings/readings_page.dart';
import 'package:chainmetric/app/pages/requirements/requirements_form.dart';
import 'package:chainmetric/usecase/notifications/notifications_manager.dart';
import 'package:flutter/material.dart';

class AssetCard extends StatelessWidget {
  final AssetPresenter asset;
  final Function()? refreshParent;

  const AssetCard(this.asset, {this.refreshParent, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () => _showAssetMenu(context, asset),
      child: Card(
        elevation: 5,
        color: LocalDataRepo.assetTypesMap[asset.type]!.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Icon(Icons.photo, size: 90),
            const SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 8),
              Text(asset.name, style: AppTheme.title3),
              Text(asset.sku,
                  style: AppTheme.subtitle2.override(
                      fontFamily: "Roboto Mono",
                      color: Theme.of(context).hintColor,
                      fontWeight: FontWeight.w400))
            ]),
            const Spacer(),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.corporate_fare,
                      color: Theme.of(context).hintColor),
                  const SizedBox(width: 5),
                  Text(LocalDataRepo.organizationsMap[asset.holder]!.name,
                      style: AppTheme.bodyText2.override(
                          color: Theme.of(context).hintColor,
                          fontWeight: FontWeight.w400))
                ],
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Icon(Icons.location_on, color: Theme.of(context).hintColor),
                  const SizedBox(width: 5),
                  Text(asset.location.name!,
                      style: AppTheme.bodyText2.override(
                          color: Theme.of(context).hintColor,
                          fontWeight: FontWeight.w400))
                ],
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Icon(Icons.fact_check, color: Theme.of(context).hintColor),
                  const SizedBox(width: 5),
                  Text(
                      asset.requirements != null
                          ? "Assigned (${asset.requirements!.metrics.length})"
                          : "Not assigned",
                      style: AppTheme.bodyText2.override(
                          color: Theme.of(context).hintColor,
                          fontWeight: FontWeight.w400))
                ],
              )
            ]),
          ]),
        ),
      ),
    );
  }

  void _showAssetMenu(BuildContext context, AssetPresenter asset) {
    showModalMenu(context: context, options: [
      ModalMenuOption(
        title: asset.requirements == null
            ? "Assign requirements"
            : "Edit requirements",
        icon: Icons.fact_check,
        action: () => openPage(
            context, RequirementsForm(model: asset.getRequirements()),
            then: refreshParent),
      ),
      ModalMenuOption(
        title: "Revoke requirements",
        icon: Icons.delete_sweep,
        action: decorateWithLoading(
            context,
            () => RequirementsController.revokeRequirements(
                    asset.requirements!.id)
                .whenComplete(refreshParent!)),
        enabled: asset.requirements != null,
      ),
      ModalMenuOption(
          title: "Transfer asset",
          icon: Icons.local_shipping,
          action: () => throw UnimplementedError()),
      ModalMenuOption(
          title: "History",
          icon: Icons.history,
          action: () => throw UnimplementedError()),
      ModalMenuOption(
          title: "Watch asset",
          icon: Icons.visibility,
          action: () => openPage(context,
              ReadingsPage(asset: asset, requirements: asset.requirements))),
      ModalMenuOption(
          title: "Edit asset",
          icon: Icons.edit,
          action: () =>
              openPage(context, AssetForm(model: asset), then: refreshParent)),
      ModalMenuOption(
          title: "Delete asset",
          icon: Icons.delete_forever,
          action: () => showYesNoDialog(context,
              title: "Delete ${asset.sku}",
              message: "Are you sure?",
              onYes: decorateWithLoading(
                  context,
                  () => AssetsController.deleteAsset(asset.id)
                      .whenComplete(refreshParent!)))),
      ModalMenuOption(
          title: "Subscribe to notifications",
          icon: Icons.notifications,
          action: decorateWithLoading(
              context,
              () => NotificationsManager(IdentitiesRepo.organization!)
                  .subscribeToRequirementsViolationOf(asset.id)))
    ]);
  }
}
