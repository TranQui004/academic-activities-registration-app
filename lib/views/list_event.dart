import 'package:doan/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan/models/event.dart';
import 'package:doan/models/sinhvien.dart';
import 'package:doan/services/cloud_service.dart';
import 'package:doan/views/chitietsukien.dart';
import 'package:doan/views/thongtindiendanh.dart';
import 'package:flutter/material.dart';
import 'package:doan/views/xacnhandangky.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// Màn hình danh sách hoạt động
class EventsListScreen extends StatelessWidget {
  const EventsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithDrawer(
      appBar: const AppBarBase(titleText: 'Hoạt động khoa CNTT'),
      body: const EventListBody(),
    );
  }
}

// Thân màn hình danh sách hoạt động
class EventListBody extends StatefulWidget {
  const EventListBody({super.key});

  @override
  State<EventListBody> createState() => _EventListBodyState();
}

class _EventListBodyState extends State<EventListBody> {
  bool isAscending = false;
  String searchQuery = '';
  String selectedType = 'Tất cả';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _eventTypes = [
    'Tất cả',
    'Học thuật',
    'Cuộc thi',
    'Sự kiện',
  ];

  // Hàm lọc và sắp xếp sự kiện
  List<Map<String, dynamic>> _filterAndSort(List<Map<String, dynamic>> events) {
    var filtered =
    events.where((event) {
      final title = event['TenSuKien'].toString().toLowerCase();
      final location = event['DDToChuc'].toString().toLowerCase();
      final type = event['LoaiHD'].toString().toLowerCase();
      final searchLower = searchQuery.toLowerCase();
      return title.contains(searchLower) ||
          location.contains(searchLower) ||
          type.contains(searchLower);
    }).toList();
    if (selectedType != 'Tất cả') {
      filtered =
          filtered.where((event) => event['LoaiHD'] == selectedType).toList();
    }
    filtered.sort((a, b) {
      final dateA = _parseDate(a['TGToChuc']);
      final dateB = _parseDate(b['TGToChuc']);
      return isAscending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
    });
    return filtered;
  }

  DateTime _parseDate(Timestamp date) {
    DateTime dateTime = date.toDate();
    return dateTime;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final sv = Provider.of<SinhVienProvider>(context).sinhVien!;
    return Column(
      children: [
        // Thanh tìm kiếm
        EventListSearchBar(
          controller: _searchController,
          onChanged: (value) => setState(() => searchQuery = value),
        ),
        // Thanh lọc và sắp xếp
        EventListFilterBar(
          isAscending: isAscending,
          onSortChanged: (asc) => setState(() => isAscending = asc),
          selectedType: selectedType,
          eventTypes: _eventTypes,
          onTypeChanged: (type) => setState(() => selectedType = type),
        ),
        // Danh sách sự kiện
        Expanded(
          child: Container(
            color: Colors.grey[50],
            child: StreamBuilder<QuerySnapshot>(
              stream: CloudService().getEvents(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Có lỗi xảy ra'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final events =
                snapshot.data!.docs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  data['id'] = doc.id;
                  return data;
                }).toList();
                final filtered = _filterAndSort(events);
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final event = filtered[index];
                    Event e = Event.fromMap(event);
                    return EventCard(
                      event: e
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

// Thanh tìm kiếm
class EventListSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const EventListSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Tìm kiếm hoạt động...',
          prefixIcon: const Icon(Icons.search, color: Color(0xFF1565C0)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF1565C0)),
          ),
          filled: true,
          fillColor: Colors.grey[50],
        ),
      ),
    );
  }
}

// Thanh lọc và sắp xếp
class EventListFilterBar extends StatelessWidget {
  final bool isAscending;
  final ValueChanged<bool> onSortChanged;
  final String selectedType;
  final List<String> eventTypes;
  final ValueChanged<String> onTypeChanged;
  const EventListFilterBar({
    super.key,
    required this.isAscending,
    required this.onSortChanged,
    required this.selectedType,
    required this.eventTypes,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Sắp xếp theo ngày:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF263238),
                ),
              ),
              Row(
                children: [
                  _SortButton(
                    label: "Tăng dần",
                    selected: isAscending,
                    onTap: () => onSortChanged(true),
                  ),
                  _SortButton(
                    label: "Giảm dần",
                    selected: !isAscending,
                    onTap: () => onSortChanged(false),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Loại hoạt động:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF263238),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                      title: const Text(
                        "Chọn loại hoạt động",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF263238),
                        ),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:
                        eventTypes
                            .map(
                              (type) => ListTile(
                            title: Text(
                              type,
                              style: TextStyle(
                                color:
                                type == selectedType
                                    ? const Color(0xFF1565C0)
                                    : const Color(0xFF455A64),
                                fontWeight:
                                type == selectedType
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            onTap: () {
                              onTypeChanged(type);
                              Navigator.pop(context);
                            },
                          ),
                        )
                            .toList(),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(
                        selectedType,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF455A64),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF455A64),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Nút sắp xếp
class _SortButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _SortButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF1565C0) : Colors.grey[300],
          borderRadius:
          label == "Tăng dần"
              ? const BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          )
              : const BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : const Color(0xFF455A64),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// Card hiển thị từng hoạt động
class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = event.SLDangKy / event.SLToiDa;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EventCardHeader(
            event: event,
            onInfo: () => null, //() => _showDetailsDialog(context),
          ),
          EventCardDetails(
            event: event,
            progress: progress,
            onInfo: () => _showDetailsDialog(context),
          ),
        ],
      ),
    );
  }

  void _showDetailsDialog(BuildContext context) {
    final double progress = event.SLDangKy / event.SLToiDa;
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
        title: Text(
          event.TenSuKien.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF263238),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dialogInfoRow(Icons.calendar_today, "Ngày: ${event.TGToChuc}"),
            const SizedBox(height: 8),
            _dialogInfoRow(Icons.location_on, "Địa điểm: ${event.DDToChuc}"),
            const SizedBox(height: 8),
            _dialogInfoRow(Icons.category, "Loại hoạt động: ${event.LoaiHD}"),
            const SizedBox(height: 8),
            _dialogInfoRow(
              Icons.people,
              "Số người đăng ký: ${event.SLDangKy} / ${event.SLToiDa}",
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                progress >= 0.9
                    ? Colors.red
                    : progress >= 0.7
                    ? Colors.orange
                    : Colors.green,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Đóng",
              style: TextStyle(
                color: Color(0xFF1565C0),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _dialogInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.grey[800]),
          ),
        ),
      ],
    );
  }
}

// Header của card hoạt động
class EventCardHeader extends StatelessWidget {
  final Event event;
  final VoidCallback onInfo;
  const EventCardHeader({
    super.key,
    required this.event,
    required this.onInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue.withOpacity(0.8), Colors.blue],
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Image.network(event.UrlAnh.toString()),
          ),
          Positioned(
            left: 12,
            top: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: Text(
                event.LoaiHD.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          Positioned(
            right: 12,
            bottom: 12,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EventDetail(event: event),
                        ));
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      Icons.info_outline,
                      color: Colors.blue.withOpacity(0.9),
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Chi tiết card hoạt động
class EventCardDetails extends StatelessWidget {
  final Event event;
  final double progress;
  final VoidCallback onInfo;
  const EventCardDetails({
    super.key,
    required this.event,
    required this.progress,
    required this.onInfo,
  });

  @override
  Widget build(BuildContext context) {
    final sv = Provider.of<SinhVienProvider>(context).sinhVien!;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.TenSuKien.toString(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF263238),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 6),
              Text(
                  DateFormat('dd/MM/yyyy HH:mm').format(event.TGToChuc),
                style: TextStyle(color: Colors.grey[700], fontSize: 14),
              ),
              const SizedBox(width: 16),
              Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  event.DDToChuc.toString(),
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Đăng ký: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xFF455A64),
                        ),
                      ),
                      Text(
                        "${event.SLDangKy}/${event.SLToiDa}",
                        style: TextStyle(
                          color:
                          progress >= 0.9
                              ? Colors.red
                              : const Color(0xFF455A64),
                          fontWeight:
                          progress >= 0.9
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 180,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200],
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: 180 * progress,
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors:
                              progress >= 0.9
                                  ? [
                                const Color(0xFFE53935),
                                const Color(0xFFD32F2F),
                              ]
                                  : progress >= 0.7
                                  ? [
                                const Color(0xFFFB8C00),
                                const Color(0xFFEF6C00),
                              ]
                                  : [
                                const Color(0xFF43A047),
                                const Color(0xFF2E7D32),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: (progress >= 0.9
                                    ? const Color(0xFFE53935)
                                    : progress >= 0.7
                                    ? const Color(0xFFFB8C00)
                                    : const Color(0xFF43A047))
                                    .withOpacity(0.4),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(
                  //   builder: (context) => XacNhanDangKyScreen(
                  //     idSuKien: event.id,
                  //     TenSK: event.TenSuKien,
                  //     DdToChuc: event.DDToChuc,
                  //     TgToChuc: event.TGToChuc,
                  //   ),
                  // ));
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ThongTinSVSauQuet(
                      sv: sv,
                      sk: event,
                    ),
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Đăng ký",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
