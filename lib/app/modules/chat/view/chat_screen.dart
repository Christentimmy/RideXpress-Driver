import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:ridexpressdriver/app/modules/support/widget/support_widgets.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';
import 'package:ridexpressdriver/app/widgets/custom_textfield.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.02),
            Container(
              width: Get.width * 0.3,
              height: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "Today",
                style: GoogleFonts.inter(color: Colors.black),
              ),
            ),
            SizedBox(height: Get.height * 0.05),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(bottom: 12),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Hello, how can I help you?",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "12:15",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(bottom: 12),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Hello, how can I help you?",
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "12:15",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // _buildMessageInput(),
            const Spacer(),
            CustomTextField(
              prefixIcon: Icons.mic,
              hintText: "Type a message...",
              suffixIcon: Icons.send,
              suffixIconcolor: AppColors.primaryColor,
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar({required BuildContext context} ) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          CircleAvatar(backgroundImage: AssetImage("assets/images/ai.jpg")),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tamado Tanjiro',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                'offline',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.primaryColor),
      actions: [
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
