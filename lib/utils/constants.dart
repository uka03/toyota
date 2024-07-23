final services = [
  ServiceItemData(
    title: 'Засвар үйлчилгээний цаг авах',
    index: 1,
    icon: 'assets/icons/ic_plus.png',
    value: 'booking',
  ),
  ServiceItemData(
    title: 'Захиалсан цаг харах',
    index: 2,
    icon: 'assets/icons/ic_clock.png',
    value: 'booking-order',
  ),
  ServiceItemData(
    title: 'Засвар үйлчилгээний түүх харах',
    index: 3,
    icon: 'assets/icons/ic_status.png',
    value: 'history',
  ),
];

class ServiceItemData {
  final String title;
  final int? index;
  final String icon;
  final String value;

  ServiceItemData({
    required this.title,
    required this.index,
    required this.icon,
    required this.value,
  });

  @override
  String toString() {
    return 'ServiceItemData{title: $title, index: $index, icon: $icon , value: $value  }';
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'index': index,
      'icon': icon,
      'value': value,
    };
  }
}
