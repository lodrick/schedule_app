import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/models/staff/staff.dart';
import 'package:schedule_app/screens/loader_hub.dart';
import 'package:schedule_app/store/session_context.dart';

class SearchStaffDropdown extends StatelessWidget {
  const SearchStaffDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionContext>(builder: (_, sessionContext, __) {
      return Observer(
        builder: (_) => LoaderHud(
          inAsyncCall: false,
          loading: const CircularProgressIndicator(),
          child: Row(
            children: <Widget>[
              Expanded(
                child: DropdownSearch<Staff>(
                  onChanged: (Staff? staff) {
                    sessionContext.selectedStaff(selectedStaff: staff!);
                  },
                  //asyncItems: (String? filter) => getDataStaff(filter),
                  items: sessionContext.staffList,
                  dropdownBuilder: _customDropDownExample,
                  popupProps: PopupProps.modalBottomSheet(
                    title: const Text('Lectures', textAlign: TextAlign.center),
                    itemBuilder: _customPopupItemBuilderExample2,
                    searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1.0),
                        ),
                        disabledBorder: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        suffixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 20,
                        ),
                        filled: true,
                        labelText: 'Lecture *',
                        fillColor: Colors.white,
                      ),
                    ),
                    showSelectedItems: true,
                    showSearchBox: true,
                  ),
                  compareFn: (item, sItem) => item.uid == sItem.uid,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    textAlign: TextAlign.left,
                    dropdownSearchDecoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      icon: const Icon(
                        Icons.people,
                        color: Colors.grey,
                        size: 20,
                      ),
                      labelText: 'Lecture *',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _customPopupItemBuilderExample2(
      BuildContext context, Staff item, bool isSelected) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: !isSelected
            ? null
            : BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
        child: Text('${item.name} ${item.surname}'));
  }

  Widget _customDropDownExample(BuildContext context, Staff? item) {
    if (item == null) {
      return Container();
    }

    return Text('${item.name} ${item.surname}');
  }
}
