import 'package:client/data/data_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/base/base_bloc_builder.dart';
import '../bloc/base/base_bloc_listener.dart';
import '../bloc/base/base_state.dart';
import '../bloc/home/home_bloc.dart';
import '../bloc/home/home_event.dart';
import '../bloc/home/home_state.dart';
import '../utils/messenger.dart';
import '../utils/screen_utils.dart';
import 'flashcard_list_screen.dart';
import 'mcq_screen.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  HomeScreen({super.key});

  static Widget buildHomeScreen({Key? key}) {
    return BlocProvider(
      create: (ctx) => HomeBloc(dataRepository: ctx.read<DataRepository>()),
      child: HomeScreen(
        key: key,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int currentScreen = 0;
    ScreenUtils().init(context);
    final homeBloc = context.read<HomeBloc>();

    return SafeArea(
        child: Scaffold(
      key: _key,
      body: BaseBlocListener(
        bloc: homeBloc,
        messenger: Messenger(context),
        listener: (listenerCtx, listenerState) {
          if (listenerState is DisplayFullScreenLoadingDialogState) {
            homeBloc.add(HomeEventUploadDocument(
                documentPath: (listenerState.nextEventObject as String)));
          }else if (listenerState is HomeStateUploadDocumentError){

          }
        },
        child: BaseBlocBuilder(
          bloc: homeBloc,
          builder: (builderCtx, builderState) {
            return (currentScreen == 0)
                ? FlashcardScreen.buildFlashcardScreen(
                    key: UniqueKey(),
                  )
                : McqScreen(
                    key: UniqueKey(),
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _onpenFilePicker(homeBloc);
        },
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Guest"),
              accountEmail: Text("No email provided"),
              currentAccountPicture: FlutterLogo(),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: const Text('Flashcards'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('MCQ'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const AboutListTile(
              icon: Icon(
                Icons.info,
              ),
              applicationIcon: Icon(
                Icons.local_play,
              ),
              applicationName: 'Auto flashcards',
              applicationVersion: '0.0.1',
              applicationLegalese: '© 2024 LTech',
              aboutBoxChildren: [
                ///Content goes here...
              ],
              child: Text('About app'),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  _key.currentState?.openDrawer();
                }),
            // const Spacer(),
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
      ),
    ));
  }

  _onpenFilePicker(HomeBloc bloc) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      debugPrint("home_screen::_openFilePicker:: Some files chosen");
      for (PlatformFile file in result.files) {
        debugPrint("home_screen::_openFilePicker:: new file: ${file.path}");
        if (file.path != null) {
          bloc.add(HomeEventTriggerUploadLoading(documentPath: file.path!));
        }
      }
    } else {
      debugPrint("home_screen::_openFilePicker:: No file chosen");
    }
  }
}
