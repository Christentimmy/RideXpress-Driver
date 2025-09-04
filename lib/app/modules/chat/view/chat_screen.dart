import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ridexpressdriver/app/controller/socket_controller.dart';
import 'package:ridexpressdriver/app/controller/user_controller.dart';
import 'package:ridexpressdriver/app/data/models/message_model.dart';
import 'package:ridexpressdriver/app/data/models/ride_model.dart';
import 'package:ridexpressdriver/app/modules/chat/widgets/chat_loader_shimmer.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';
import 'package:ridexpressdriver/app/widgets/custom_textfield.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  final RideModel rideModel;
  const ChatScreen({super.key, required this.rideModel});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final userController = Get.find<UserController>();
  final socketController = Get.find<SocketController>();
  final messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userController.getMessageHistory(rideId: widget.rideModel.id ?? "");
      socketController.joinRoom(rideId: widget.rideModel.id ?? "");
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

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
            Expanded(
              child: Obx(() {
                if (userController.isloading.value) {
                  return const ChatShimmerEffect();
                }
                if (userController.chatHistoryAndLiveMessage.isEmpty) {
                  return const Center(child: Text("No Message"));
                }
                return ListView.builder(
                  reverse: true,
                  addRepaintBoundaries: true,
                  addAutomaticKeepAlives: true,
                  itemCount: userController.chatHistoryAndLiveMessage.length,
                  itemBuilder: (context, index) {
                    final allMessages =
                        userController.chatHistoryAndLiveMessage;
                    final reversedIndex = allMessages.length - 1 - index;
                    final message = allMessages[reversedIndex];
                    return message.senderId ==
                            userController.userModel.value?.id
                        ? buildSenderCard(message: message)
                        : buildReceiverCard(message: message);
                  },
                );
              }),
            ),

            CustomTextField(
              controller: messageController,
              prefixIcon: Icons.mic,
              minLines: 1,
              maxLines: 3,
              hintText: "Type a message...",
              suffixIcon: Icons.send,
              suffixIconcolor: AppColors.primaryColor,
              onSuffixTap: sendMessage,
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void sendMessage() {
    if (messageController.text.isEmpty) return;
    final uuid = Uuid().v4();
    final message = MessageModel(
      clientGeneratedId: uuid,
      message: messageController.text,
      createdAt: DateTime.now(),
      rideId: widget.rideModel.id ?? "",
      senderId: userController.userModel.value?.id ?? "",
    
    );
    userController.chatHistoryAndLiveMessage.add(message);
    socketController.sendMessage(message: message);
    messageController.clear();
  }

  Align buildReceiverCard({required MessageModel message}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(maxWidth: Get.width * 0.8),
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
             message.message ?? "",
              style: GoogleFonts.inter(color: Colors.black, fontSize: 14),
            ),
            Text(
              DateFormat("hh:mm a").format(message.createdAt ?? DateTime.now()),
              style: GoogleFonts.inter(color: Colors.white, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Align buildSenderCard({required MessageModel message}) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(maxWidth: Get.width * 0.8),
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
              message.message ?? "",
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
            ),
            Text(
              DateFormat("hh:mm a").format(message.createdAt ?? DateTime.now()),
              style: GoogleFonts.inter(color: Colors.white, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar({required BuildContext context}) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          CircleAvatar(backgroundImage: AssetImage("assets/images/ai.jpg")),
          SizedBox(width: 10),
          Text(
            'Tamado Tanjiro',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
