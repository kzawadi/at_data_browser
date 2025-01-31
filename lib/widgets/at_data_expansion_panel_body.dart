import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/at_data_expansion_panel_controller.dart';

class AtDataExpansionPanelBody extends ConsumerWidget {
  const AtDataExpansionPanelBody({required this.properties, super.key});

  final List<AtDataProperty> properties;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: ref.watch(atDataExpansionPanelModelProvider).fadedColor,
        border: Border(
          left: BorderSide(
            color: ref.watch(atDataExpansionPanelModelProvider).primaryColor,
            width: 5,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: properties,
        ),
      ),
    );
  }
}

class AtDataProperty extends StatelessWidget {
  const AtDataProperty({required this.title, required this.value, super.key});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: Text(value),
    );
  }
}
