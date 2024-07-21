final services = [
  ServiceItemData(title: 'Засвар үйлчилгээний цаг авах', index: 1, icon: 'assets/icons/ic_plus.png'),
  ServiceItemData(title: 'Захиалсан цаг харах', index: 2, icon: 'assets/icons/ic_clock.png'),
  ServiceItemData(title: 'Засвар үйлчилгээний түүх харах', index: 3, icon: 'assets/icons/ic_status.png'),
];

class ServiceItemData {
  final String title;
  final int? index;
  final String icon;

  ServiceItemData({required this.title, required this.index, required this.icon});

  @override
  String toString() {
    return 'ServiceItemData{title: $title, index: $index, icon: $icon}';
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'index': index,
      'icon': icon
    };
  }
}
