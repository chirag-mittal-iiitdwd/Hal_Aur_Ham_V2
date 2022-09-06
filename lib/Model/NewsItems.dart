import 'package:flutter/material.dart';

class News {
  final String news;
  final String description;
  News({this.news,this.description});
}

class NewsItems with ChangeNotifier {
  final List<News> _items = [
    News(
      news: 'Govt. took back three farm laws',
      description:
          "Donec elementum, lorem in molestie tincidunt, magna lorem blandit velit, vitae iaculis metus felis et sapien. Nulla diam tortor, tincidunt eget feugiat in, finibus quis leo. Vivamus sollicitudin viverra mi sit amet convallis. Fusce pretium, nibh in gravida egestas, massa turpis porttitor dolor, sed feugiat est mauris et massa. Aliquam quis ipsum tempus, fermentum metus vitae, fringilla metus. Vestibulum quis cursus tellus. Donec rutrum, arcu vel rhoncus tincidunt, justo eros imperdiet urna, at vestibulum justo elit at diam. Sed eget eros elementum purus efficitur malesuada. Nulla eget arcu ornare, tincidunt justo in, placerat quam. Aenean scelerisque bibendum diam, ac malesuada dolor fermentum vitae. Vestibulum dapibus tempor dui sagittis bibendum. In at libero bibendum dui pretium ultrices. Sed et urna leo. Praesent nec condimentum quam, eget luctus nisi. Nullam facilisis, libero nec pellentesque sodales, nisl ante tempor neque, a elementum mauris neque eget risus. Maecenas rhoncus dapibus tortor, eu accumsan libero tincidunt nec.",
    ),
    News(
      news: 'Headline Number 2',
      description:
          "Donec elementum, lorem in molestie tincidunt, magna lorem blandit velit, vitae iaculis metus felis et sapien. Nulla diam tortor, tincidunt eget feugiat in, finibus quis leo. Vivamus sollicitudin viverra mi sit amet convallis. Fusce pretium, nibh in gravida egestas, massa turpis porttitor dolor, sed feugiat est mauris et massa. Aliquam quis ipsum tempus, fermentum metus vitae, fringilla metus. Vestibulum quis cursus tellus. Donec rutrum, arcu vel rhoncus tincidunt, justo eros imperdiet urna, at vestibulum justo elit at diam. Sed eget eros elementum purus efficitur malesuada. Nulla eget arcu ornare, tincidunt justo in, placerat quam. Aenean scelerisque bibendum diam, ac malesuada dolor fermentum vitae. Vestibulum dapibus tempor dui sagittis bibendum. In at libero bibendum dui pretium ultrices. Sed et urna leo. Praesent nec condimentum quam, eget luctus nisi. Nullam facilisis, libero nec pellentesque sodales, nisl ante tempor neque, a elementum mauris neque eget risus. Maecenas rhoncus dapibus tortor, eu accumsan libero tincidunt nec.",
    ),
    News(
      news: 'Headline Number 3',
      description:
          "Donec elementum, lorem in molestie tincidunt, magna lorem blandit velit, vitae iaculis metus felis et sapien. Nulla diam tortor, tincidunt eget feugiat in, finibus quis leo. Vivamus sollicitudin viverra mi sit amet convallis. Fusce pretium, nibh in gravida egestas, massa turpis porttitor dolor, sed feugiat est mauris et massa. Aliquam quis ipsum tempus, fermentum metus vitae, fringilla metus. Vestibulum quis cursus tellus. Donec rutrum, arcu vel rhoncus tincidunt, justo eros imperdiet urna, at vestibulum justo elit at diam. Sed eget eros elementum purus efficitur malesuada. Nulla eget arcu ornare, tincidunt justo in, placerat quam. Aenean scelerisque bibendum diam, ac malesuada dolor fermentum vitae. Vestibulum dapibus tempor dui sagittis bibendum. In at libero bibendum dui pretium ultrices. Sed et urna leo. Praesent nec condimentum quam, eget luctus nisi. Nullam facilisis, libero nec pellentesque sodales, nisl ante tempor neque, a elementum mauris neque eget risus. Maecenas rhoncus dapibus tortor, eu accumsan libero tincidunt nec.",
    ),
    News(
      news: 'Headline Number 4',
      description:
          "Donec elementum, lorem in molestie tincidunt, magna lorem blandit velit, vitae iaculis metus felis et sapien. Nulla diam tortor, tincidunt eget feugiat in, finibus quis leo. Vivamus sollicitudin viverra mi sit amet convallis. Fusce pretium, nibh in gravida egestas, massa turpis porttitor dolor, sed feugiat est mauris et massa. Aliquam quis ipsum tempus, fermentum metus vitae, fringilla metus. Vestibulum quis cursus tellus. Donec rutrum, arcu vel rhoncus tincidunt, justo eros imperdiet urna, at vestibulum justo elit at diam. Sed eget eros elementum purus efficitur malesuada. Nulla eget arcu ornare, tincidunt justo in, placerat quam. Aenean scelerisque bibendum diam, ac malesuada dolor fermentum vitae. Vestibulum dapibus tempor dui sagittis bibendum. In at libero bibendum dui pretium ultrices. Sed et urna leo. Praesent nec condimentum quam, eget luctus nisi. Nullam facilisis, libero nec pellentesque sodales, nisl ante tempor neque, a elementum mauris neque eget risus. Maecenas rhoncus dapibus tortor, eu accumsan libero tincidunt nec.",
    ),
    News(
      news: 'Headline Number 5',
      description:
          "Donec elementum, lorem in molestie tincidunt, magna lorem blandit velit, vitae iaculis metus felis et sapien. Nulla diam tortor, tincidunt eget feugiat in, finibus quis leo. Vivamus sollicitudin viverra mi sit amet convallis. Fusce pretium, nibh in gravida egestas, massa turpis porttitor dolor, sed feugiat est mauris et massa. Aliquam quis ipsum tempus, fermentum metus vitae, fringilla metus. Vestibulum quis cursus tellus. Donec rutrum, arcu vel rhoncus tincidunt, justo eros imperdiet urna, at vestibulum justo elit at diam. Sed eget eros elementum purus efficitur malesuada. Nulla eget arcu ornare, tincidunt justo in, placerat quam. Aenean scelerisque bibendum diam, ac malesuada dolor fermentum vitae. Vestibulum dapibus tempor dui sagittis bibendum. In at libero bibendum dui pretium ultrices. Sed et urna leo. Praesent nec condimentum quam, eget luctus nisi. Nullam facilisis, libero nec pellentesque sodales, nisl ante tempor neque, a elementum mauris neque eget risus. Maecenas rhoncus dapibus tortor, eu accumsan libero tincidunt nec.",
    ),
  ];

  List<News> get items {
    return [..._items];
  }
}
