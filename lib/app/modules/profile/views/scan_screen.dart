

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';
import 'package:ridexpressdriver/app/widgets/custom_button.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  bool _isCameraInitialized = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isNotEmpty) {
        _cameraController = CameraController(
          _cameras.first,
          ResolutionPreset.high,
          enableAudio: false,
        );
        await _cameraController!.initialize();
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      print('Error initializing camera: $e');
      // Show error dialog or snackbar
      Get.snackbar(
        'Camera Error',
        'Failed to initialize camera',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _takePicture() async {
    if (!_cameraController!.value.isInitialized) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final XFile image = await _cameraController!.takePicture();
      
      // Here you can process the captured image
      // For example, navigate to a preview screen or save the image
      print('Image captured: ${image.path}');
      
      // Show success message
      Get.snackbar(
        'Success',
        'Document captured successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
      // You can navigate to next screen or process the image
      // Get.to(() => DocumentPreviewScreen(imagePath: image.path));
      
    } catch (e) {
      print('Error taking picture: $e');
      Get.snackbar(
        'Error',
        'Failed to capture image',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        title: Text(
          "Scan",
          style: GoogleFonts.manrope(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Color(0xFF555555),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: Get.height * 0.05),
              Center(
                child: Text(
                  "Scan Document",
                  style: GoogleFonts.manrope(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  "Kindly keep the entire document inside\nthe scanning frame for it to capture the\nwhole document.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.manrope(
                    color: Color(0xFF898A8D),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.09),

              // Camera view implementation
              Container(
                height: Get.height * 0.25,
                width: Get.width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: _isCameraInitialized
                      ? Stack(
                          children: [
                            // Camera preview
                            SizedBox.expand(
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: SizedBox(
                                  width: _cameraController!.value.previewSize!.height,
                                  height: _cameraController!.value.previewSize!.width,
                                  child: CameraPreview(_cameraController!),
                                ),
                              ),
                            ),
                            // Document scanning frame overlay
                            Center(
                              child: Container(
                                width: Get.width * 0.7,
                                height: Get.height * 0.15,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Stack(
                                  children: [
                                    // Corner indicators
                                    Positioned(
                                      top: -1,
                                      left: -1,
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(color: Colors.green, width: 3),
                                            left: BorderSide(color: Colors.green, width: 3),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: -1,
                                      right: -1,
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(color: Colors.green, width: 3),
                                            right: BorderSide(color: Colors.green, width: 3),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: -1,
                                      left: -1,
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(color: Colors.green, width: 3),
                                            left: BorderSide(color: Colors.green, width: 3),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: -1,
                                      right: -1,
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(color: Colors.green, width: 3),
                                            right: BorderSide(color: Colors.green, width: 3),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Initializing Camera...',
                                style: GoogleFonts.manrope(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
              SizedBox(height: Get.height * 0.15),
              CustomButton(
                width: Get.width * 0.55,
                height: 45,
                isLoading: _isLoading.obs,
                bgColor: Color(0xFF555555),
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(25),
                ontap: _isCameraInitialized ? _takePicture : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "Take Picture",
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}