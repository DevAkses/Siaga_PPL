import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/getstarted_controller.dart';

class GetstartedView extends GetView<GetstartedController> {
  const GetstartedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GetstartedView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GetstartedView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
