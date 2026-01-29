import 'package:chat_app/modal/chat_list_item.dart';
import 'package:chat_app/screens/import_address_screem.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/homescreen/chat_list_title.dart';
import 'package:chat_app/widgets/popUp_modal.dart';
import 'package:chat_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class GroupList extends StatefulWidget {
  const GroupList({super.key, required this.items});

  final List<ChatListItem> items;

  @override
  State<GroupList> createState() {
    return _ChatListState();
  }
}

class _ChatListState extends State<GroupList> {
  void showPopup() {
    showDialog(context: context, builder: (context) => PopupModal());
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(image: AssetImage("assets/icons/message-icon-2.png")),
            const SizedBox(height: 10),
            const AppText(
              "No group chat found",
              color: AppColors.secondaryLightColor,
            ),
            const AppText(
              "Start a new one?",
              color: AppColors.secondaryLightColor,
            ),
            const SizedBox(height: 60),
            PrimaryButton(
              text: "Enable Public url",
              fullWidth: false,
              onClick: () => {showPopup()},
            ),
            const SizedBox(height: 10),
            const AppText("or", color: AppColors.placeholderTextColor),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => const ImportAddressScreem(),
                  ),
                );
              },
              child: AppText(
                "import an address",
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: ListView.separated(
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return ChatListTile(item: widget.items[index]);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 20),
      ),
    );
  }
}
