import 'package:at_data_browser/screens/apps_screen.dart';
import 'package:at_data_browser/screens/browse_screen.dart';
import 'package:at_data_browser/screens/connected_atsigns_screen.dart';
import 'package:at_data_browser/utils/constants.dart';
import 'package:at_data_browser/widgets/nav_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/nav_widget_controller.dart';

class NavWidget extends ConsumerStatefulWidget {
  const NavWidget({super.key});

  @override
  ConsumerState<NavWidget> createState() => _NavWidgetState();
}

class _NavWidgetState extends ConsumerState<NavWidget> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) async {
      await ref.watch(navWidgetController.notifier).getData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final navWidgetModel = ref.watch(navWidgetController).value;
    return SizedBox(
      height: 270,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Positioned(
            height: 270,
            child: NavContainer(
              name: strings.dataStorage,
              titleCount: strings.itemsStored,
              navWidgetModel: navWidgetModel,
              color: kDataStorageColor,
              onTap: () {
                Navigator.pushNamed(context, BrowseScreen.route);
              },
            ),
          ),
          Positioned(
            height: 190,
            // top: 90,
            child: NavContainer(
              name: strings.atSigns,
              titleCount: strings.connectedAtsigns,
              navWidgetModel: navWidgetModel,
              color: kAtSignColor,
              onTap: () {
                Navigator.pushNamed(context, ConnectedAtsignsScreen.route);
              },
            ),
          ),
          Positioned(
            height: 100,
            child: NavContainer(
              name: strings.apps,
              titleCount: strings.connectedApps,
              navWidgetModel: navWidgetModel,
              color: kAppsColor,
              onTap: () {
                Navigator.pushNamed(context, AppsScreen.route);
              },
            ),
          ),
        ],
      ),
    );
  }
}
