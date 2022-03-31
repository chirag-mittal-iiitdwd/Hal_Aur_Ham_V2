import 'package:flutter/material.dart';

import './NewsItem.dart';

class NewsItems with ChangeNotifier {
  final List<News> _items = [
    News(
      news: 'Govt. took back three farm laws',
    ),
    News(
      news:
          'PM Modi apologized that he is sorry that he couldn\'t convey his message properly',
    ),
  ];

  List<News> get items {
    return [..._items];
  }
}
