import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: SafeArea(child: HomePage()),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final multipleRiveObjects = riveObjects
        .followedBy(riveObjects)
        .followedBy(riveObjects)
        .followedBy(riveObjects)
        .followedBy(riveObjects)
        .followedBy(riveObjects)
        .followedBy(riveObjects)
        .followedBy(riveObjects)
        .followedBy(riveObjects)
        .followedBy(riveObjects)
        .toList();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[const Text("Start Animations")]
            .followedBy(
              chunkList(multipleRiveObjects, 3).map((rList) {
                return Row(
                  children: rList.map((riveObj) {
                    return SizedBox(
                      width: 120,
                      height: 120,
                      child: RiveAnimation.asset(
                        riveObj.resId,
                        stateMachines: riveObj.stateMachineName != null
                            ? [riveObj.stateMachineName!]
                            : [],
                        artboard: riveObj.artboardName,
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            )
            .followedBy([const Text("End Animations")])
            .toList(),
      ),
    );
  }
}

List<List<T>> chunkList<T>(List<T> list, int chunkSize) {
  List<List<T>> chunks = [];
  for (int i = 0; i < list.length; i += chunkSize) {
    chunks.add(list.sublist(
        i, i + chunkSize > list.length ? list.length : i + chunkSize));
  }
  return chunks;
}
