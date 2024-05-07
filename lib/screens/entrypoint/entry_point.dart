import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/screens/entrypoint/main_entry_screen.dart';
import 'package:schedule_app/screens/entrypoint/widgets/custom_sidebar_x.dart';
import 'package:schedule_app/screens/loader_hub.dart';
import 'package:schedule_app/store/session_context.dart';
import 'package:sidebarx/sidebarx.dart';

class EntryPointScreen extends StatefulWidget {
  const EntryPointScreen({
    super.key,
    required this.selectedIndex,
  });
  final int selectedIndex;

  @override
  State<EntryPointScreen> createState() => _EntryPointScreenState();
}

class _EntryPointScreenState extends State<EntryPointScreen> {
  SidebarXController? _controller;
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    _controller =
        SidebarXController(selectedIndex: widget.selectedIndex, extended: true);
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    return Consumer<SessionContext>(builder: (_, sessionContext, __) {
      return Observer(
        builder: (_) => LoaderHud(
          inAsyncCall: false,
          loading: const CircularProgressIndicator(),
          child: Scaffold(
            appBar: isSmallScreen
                ? AppBar(
                    backgroundColor: canvasColor,
                    leading: IconButton(
                      onPressed: () {
                        _key.currentState?.openDrawer();
                      },
                      icon: const Icon(Icons.menu),
                    ),
                  )
                : null,
            body: Row(
              children: [
                if (!isSmallScreen) CustomSidebarX(controller: _controller!),
                Expanded(
                  child: Center(
                    child: MainEntryScreen(controller: _controller!),
                  ),
                ),
              ],
            ),
            drawer: CustomSidebarX(controller: _controller!),
          ),
        ),
      );
    });
  }
}
