import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/models/subject/subject.dart';
import 'package:schedule_app/screens/loader_hub.dart';
import 'package:schedule_app/store/session_context.dart';

class SearchSubjectDropdown extends StatelessWidget {
  const SearchSubjectDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionContext>(
      builder: (_, sessionContext, __) {
        return Observer(
          builder: (_) => LoaderHud(
            inAsyncCall: false,
            loading: const CircularProgressIndicator(),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: DropdownSearch<Subject>(
                    onChanged: (Subject? subject) {
                      sessionContext.selectedSubject(selectedSubject: subject!);
                    },
                    //asyncItems: (String? filter) => getDataStaff(filter),
                    items: sessionContext.subjects,
                    dropdownBuilder: _customDropDownExample,
                    popupProps: PopupProps.modalBottomSheet(
                      title: const Text('Subject', textAlign: TextAlign.center),
                      itemBuilder: _customPopupItemBuilderExample2,
                      searchFieldProps: TextFieldProps(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 1.0),
                          ),
                          disabledBorder: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          suffixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 20,
                          ),
                          filled: true,
                          labelText: 'Subject *',
                          hintText: 'Select',
                          hintStyle: const TextStyle(color: Colors.grey),
                          fillColor: Colors.white,
                        ),
                      ),
                      showSelectedItems: true,
                      showSearchBox: true,
                    ),
                    compareFn: (item, sItem) => item.sid == sItem.sid,
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
                          Icons.subject,
                          color: Colors.grey,
                          size: 20,
                        ),
                        labelText: 'Subject *',
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
      },
    );
  }

  Widget _customPopupItemBuilderExample2(
      BuildContext context, Subject item, bool isSelected) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: !isSelected
            ? null
            : BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
        child: Text(item.subjectName!));
  }

  Widget _customDropDownExample(BuildContext context, Subject? item) {
    if (item == null) {
      return Container();
    }

    return Text(item.subjectName!);
  }
}
