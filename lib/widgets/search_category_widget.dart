import 'dart:developer';
import 'package:at_data_browser/utils/sizes.dart';
import 'package:at_data_browser/widgets/search_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/at_data_controller.dart';
import '../controllers/filter_form_controller.dart';

class SearchCategoryWidget extends ConsumerStatefulWidget {
  const SearchCategoryWidget({required this.index, super.key});
  final int index;
  @override
  ConsumerState<SearchCategoryWidget> createState() =>
      _SearchCategroyWidgetState();
}

class _SearchCategroyWidgetState extends ConsumerState<SearchCategoryWidget> {
  late TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchRequest = ref.watch(searchFormProvider).searchRequest;
    // set the text in the search field to the value in the search request if the search request is not empty
    if (searchRequest.isNotEmpty && searchRequest[widget.index] != null) {
      log('searchRequest is not empty: ${searchRequest[widget.index]}');
      textEditingController.text = searchRequest[widget.index]!;
    } else {
      log('searchRequest is empty');
      textEditingController.text = '';
    }

    return CategoryContainer(
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(Sizes.p8),
          isCollapsed: true,
          border: InputBorder.none,
          hintText: AppLocalizations.of(context)!.search,
          alignLabelWithHint: true,
          hintStyle: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: Colors.black.withOpacity(.5), fontSize: 14),
          suffixIcon: const Icon(
            Icons.search,
            size:
                14, //todo(kzawadi): icon size of 13.34 seems so small but that how its specified in figma document.
          ),
        ),
        controller: textEditingController,
        onChanged: (value) {
          ref.watch(searchFormProvider).isConditionMet = [];
          if (searchRequest.isNotEmpty) {
            searchRequest[widget.index] = value;
          } else {
            searchRequest.add(value);
          }
          ref.watch(searchFormProvider).searchRequest[widget.index] = value;
          ref.watch(filterControllerProvider.notifier).getFilteredAtData();
        },
      ),
    );
  }
}
