// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';
import 'dart:ui';

import 'package:GeneratedApp/applications/files.dart';
import 'package:GeneratedApp/applications/terminal.dart';
import 'package:GeneratedApp/commons/functions.dart';
import 'package:GeneratedApp/launcher_toggle.dart';
import 'package:GeneratedApp/quick_settings.dart';
import 'package:GeneratedApp/status_tray.dart';
import 'package:GeneratedApp/widgets/app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GeneratedApp/main.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  isTesting = true;
  Box box;
  var settingsInit = () async {
    //TestWidgetsFlutterBinding.ensureInitialized();
    Directory dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox<String>("settings");
    await box.clear(); //start with fresh settings
  };
  //test('Settings init', settingsInit, skip: "This should be ran with every test instead of on its own.");
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(Pangolin());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });
  await settingsInit();
  testWidgets('customBar test', (WidgetTester tester) async {
    print("Launching Pangolin");
    await tester.pumpWidget(Pangolin());
    //print((await tester.pumpAndSettle()).toString() + " frames on load!");
    await tester.pump();
    expect(find.byType(ErrorWidget), findsNothing); //no error widgets here
    print("Testing Files");
    await tester.tap(
      find.byWidgetPredicate(
        (element) => (element is AppLauncherPanelButton && element.app is Files),
        description: "Bottom bar app icon that opens the Files app"
      )
    );
    await tester.pump();
    expect(find.byType(ErrorWidget), findsNothing); //no error widgets here
  //});
  //await settingsInit();
  // testWidgets('Try to open Terminal', (WidgetTester tester) async {
  //   await tester.pumpWidget(Pangolin());
  //   await tester.pump();
  //   expect(find.byType(ErrorWidget), findsNothing); //no error widgets here
    print("Testing Terminal");
    await tester.tap(
      find.byWidgetPredicate(
        (element) => (element is AppLauncherPanelButton && element.app is Terminal),
        description: "AppLauncherPanelButton that launches Terminal"
      )
    );
    await tester.pump();
    //print((await tester.pumpAndSettle()).toString() + " frame(s) on animation!");
    expect(find.byType(ErrorWidget), findsNothing); //no error widgets here
    await tester.pump();
    // finish test
    print("Finishing test");
    await tester.idle();
    //assert(tester.widget(find.byType(TerminalApp)).
    //@bleonard252: wait for Bash to be ready. if it errors, fail
    // I'll probably make more specific Terminal tests,
    // first that it opens, then how it reacts to different platforms
  });/* }); */
  // testWidgets('Try to open Quick Settings', (WidgetTester tester) async {
  //   await tester.pumpWidget(Pangolin());
  //   await tester.pump();
  //   expect(find.byType(ErrorWidget), findsNothing); //no error widgets here
  //   await tester.tap(find.byType(StatusTrayWidget));
  //   print((await tester.pumpAndSettle()).toString() + " frames on animation!");
  //   expect(find.byType(ErrorWidget), findsNothing); //no error widgets here
  // });
  // testWidgets('Try to open Launcher', (WidgetTester tester) async {
  //   await tester.pumpWidget(Pangolin());
  //   await tester.pump();
  //   expect(find.byType(ErrorWidget), findsNothing); //no error widgets here
  //   await tester.tap(find.byType(LauncherToggleWidget));
  //   print((await tester.pumpAndSettle()).toString() + " frames on animation!");
  //   expect(find.byType(ErrorWidget), findsNothing); //no error widgets here
  // });
}
