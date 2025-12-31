import 'package:chat_app/modal/chat_search_item.dart';
import 'package:chat_app/services/api_client.dart';
import 'package:chat_app/services/debounce.dart';
import 'package:chat_app/services/user_api_service.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/search_screem/search_list_object.dart';
import 'package:flutter/material.dart';

class SearchUserScreen extends StatefulWidget {
  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  final debounce = Debouncer(milliseconds: 300);
  final usersApi = UserApiService(dio: ApiClient.dio);

  List<ChatSearchItem> searchItemsList = [];
  bool isLoading = false;
  String? error;

  void searchFunction(String value) {
    if (value.trim().isEmpty) {
      setState(() {
        searchItemsList.clear();
        isLoading = false;
        error = null;
      });
      return;
    }

    debounce.run(() async {
      setState(() {
        isLoading = true;
        error = null;
      });

      try {
        final users = await usersApi.getUsers(value);

        if (!mounted) return;

        setState(() {
          searchItemsList = users;
          isLoading = false;
        });
      } catch (e) {
        if (!mounted) return;

        setState(() {
          isLoading = false;
          error = "Something went wrong";
        });
      }
    });
  }

  @override
  void dispose() {
    debounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SearchBar(
                onChanged: searchFunction,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                backgroundColor: const WidgetStatePropertyAll(Colors.white),
                padding: const WidgetStatePropertyAll(EdgeInsets.all(8)),
              ),

              const SizedBox(height: 20),

              Expanded(child: _buildBody()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(child: AppText(error!, color: Colors.red));
    }

    if (searchItemsList.isEmpty) {
      return const Center(
        child: AppText("No data found", color: AppColors.backgroundColor),
      );
    }

    return ListView.builder(
      itemCount: searchItemsList.length,
      itemBuilder: (context, index) {
        return SearchListObject(item: searchItemsList[index]);
      },
    );
  }
}
