import 'package:flutter/material.dart';

import './NewsItem.dart';

class NewsItems with ChangeNotifier {
  final List<News> _items = [
    News(
      news: 'Govt. took back three farm laws',
    ),
    News(
      news:
          'Headline Number 2',
    ),
    News(
      news:
          'Headline Number 3',
    ),
    News(
      news:
          'Headline Number 4',
    ),
    News(
      news:
          'Headline Number 5',
    ),
  ];

  List<News> get items {
    return [..._items];
  }
}
