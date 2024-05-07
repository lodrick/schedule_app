import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:schedule_app/models/course/course.dart';
import 'package:schedule_app/store/session_context.dart';

class CourseDropdown extends StatelessWidget {
  const CourseDropdown({
    super.key,
    required this.sessionContext,
  });
  final SessionContext sessionContext;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: DropdownSearch<Course>(
            onChanged: (Course? course) {
              sessionContext.selectedCourse(selectedCourse: course!);
            },
            items: sessionContext.courses,
            dropdownBuilder: _customDropDownExample,
            popupProps: PopupProps.modalBottomSheet(
              title: const Text('Course', textAlign: TextAlign.center),
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
                  labelText: 'Course *',
                  hintText: 'Select',
                  hintStyle: const TextStyle(color: Colors.grey),
                  fillColor: Colors.white,
                ),
              ),
              showSelectedItems: true,
              showSearchBox: true,
            ),
            compareFn: (item, sItem) => item.cid == sItem.cid,
            dropdownDecoratorProps: DropDownDecoratorProps(
              textAlign: TextAlign.left,
              dropdownSearchDecoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                icon: const Icon(
                  Icons.subject,
                  color: Colors.grey,
                  size: 20,
                ),
                labelText: 'Course *',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _customPopupItemBuilderExample2(
      BuildContext context, Course item, bool isSelected) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: !isSelected
            ? null
            : BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
        child: Text(item.courseName));
  }

  Widget _customDropDownExample(BuildContext context, Course? item) {
    if (item == null) {
      return Container();
    }

    return Text(item.courseName);
  }
}
