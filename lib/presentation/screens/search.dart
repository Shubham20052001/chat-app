import 'package:chat_app/presentation/constants/constants.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Column(
        children: [
          Container(
            color: const Color(0x54FFFFFF),
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchTextEditingController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'search username...',
                      hintStyle: TextStyle(
                        color: Colors.white54,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 40,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0x36FFFFFF),
                        Color(0x0FFFFFFF),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Image.asset('assets/images/search_white.png'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
