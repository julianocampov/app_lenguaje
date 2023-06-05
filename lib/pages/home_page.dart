import 'dart:io';

import 'package:app_lenguaje/services/bd_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:camera/camera.dart';

late List<CameraDescription> cameras;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras.first, ResolutionPreset.high);
    _initializeControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.cent,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  const Text(
                    "App Lenguaje de Señas",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                      future: _initializeControllerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return SizedBox(
                              width: 400,
                              height: 800,
                              child: CameraPreview(_cameraController));
                        } else {
                          return _IconLoading(
                              size: MediaQuery.of(context).size,
                              colorIndic:
                                  const Color.fromARGB(74, 134, 134, 134));
                        }
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Hecho por:\nManuel Cely\nJulián Ocampo\n\nUniversidad de Antioquia",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _IconLoading extends StatelessWidget {
  const _IconLoading({
    required this.size,
    required this.colorIndic,
  });

  final Size size;
  final Color colorIndic;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 500,
      color: Colors.black,
      child: Center(
          child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorIndic,
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.white,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Esperando cámara...',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      )),
    );
  }
}
