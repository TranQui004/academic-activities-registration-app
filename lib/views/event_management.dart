import 'package:doan/main.dart';
import 'package:flutter/material.dart';

class EventManagementScreen extends StatelessWidget {
  const EventManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBase(titleText: 'Chi tiết sự kiện'),
      body: const EventManagementBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF1565C0),
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class EventManagementBody extends StatelessWidget {
  const EventManagementBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Filter bar
        Container(
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
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1565C0),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Tăng dần",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Giảm dần",
                            style: TextStyle(
                              color: Color(0xFF455A64),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                  Container(
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
                    child: const Row(
                      children: [
                        Text(
                          "Tất cả",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF455A64),
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_drop_down, color: Color(0xFF455A64)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // List of events
        Expanded(
          child: Container(
            color: Colors.grey[50],
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: const [
                // Event Card 1
                EventCard(
                  title: "Workshop Flutter Development",
                  date: "15/11/2023",
                  location: "Phòng H1.01",
                  type: "Học thuật",
                  registered: 45,
                  maxParticipants: 60,
                  color: Color(0xFF1565C0),
                  icon: Icons.code,
                ),

                // Event Card 2
                EventCard(
                  title: "Cuộc thi Hackathon 2023",
                  date: "05/12/2023",
                  location: "Sảnh A",
                  type: "Cuộc thi",
                  registered: 20,
                  maxParticipants: 25,
                  color: Color(0xFFFF8F00),
                  icon: Icons.emoji_events,
                ),

                // Event Card 3
                EventCard(
                  title: "Giao lưu doanh nghiệp CNTT",
                  date: "30/11/2023",
                  location: "Sân vận động trường",
                  type: "Đoàn thể",
                  registered: 75,
                  maxParticipants: 100,
                  color: Color(0xFF2E7D32),
                  icon: Icons.groups,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String location;
  final String type;
  final int registered;
  final int maxParticipants;
  final Color color;
  final IconData icon;

  const EventCard({
    super.key,
    required this.title,
    required this.date,
    required this.location,
    required this.type,
    required this.registered,
    required this.maxParticipants,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = registered / maxParticipants;

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
          // Event Image with Type and Management Buttons
          Container(
            height: 160,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color.withOpacity(0.8), color],
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    icon,
                    size: 70,
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
                Positioned(
                  left: 12,
                  top: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      type,
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
                  child: Row(
                    children: [
                      // Chi tiết
                      Container(
                        margin: const EdgeInsets.only(right: 8),
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
                            onTap: () => _showDetailsDialog(context),
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                Icons.info_outline,
                                color: color.withOpacity(0.9),
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Sửa
                      Container(
                        margin: const EdgeInsets.only(right: 8),
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
                            onTap: () => _showEditDialog(context),
                            borderRadius: BorderRadius.circular(8),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.edit,
                                color: Color(0xFFE65100),
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Xóa
                      Container(
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
                            onTap: () => _showDeleteDialog(context),
                            borderRadius: BorderRadius.circular(8),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.delete,
                                color: Color(0xFFD32F2F),
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Event Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
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
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 6),
                    Text(
                      date,
                      style: TextStyle(color: Colors.grey[700], fontSize: 14),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        location,
                        style: TextStyle(color: Colors.grey[700], fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Đăng ký:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFF455A64),
                          ),
                        ),
                        Text(
                          "$registered/$maxParticipants",
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
                    Stack(
                      children: [
                        // Background
                        Container(
                          width: double.infinity,
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[200],
                          ),
                        ),
                        // Progress
                        Container(
                          width:
                              MediaQuery.of(context).size.width *
                              0.8 *
                              progress,
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
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Hàm hiển thị dialog chi tiết
  void _showDetailsDialog(BuildContext context) {
    final double progress = registered / maxParticipants;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF263238),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _dialogInfoRow(Icons.calendar_today, "Ngày: $date"),
                const SizedBox(height: 8),
                _dialogInfoRow(Icons.location_on, "Địa điểm: $location"),
                const SizedBox(height: 8),
                _dialogInfoRow(Icons.category, "Loại hoạt động: $type"),
                const SizedBox(height: 8),
                _dialogInfoRow(
                  Icons.people,
                  "Số người đăng ký: $registered/$maxParticipants",
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

  // Helper method để hiển thị thông tin trong dialog
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

  // Hàm hiển thị dialog chỉnh sửa
  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text(
              "Chỉnh sửa hoạt động",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF263238),
              ),
            ),
            content: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Form chỉnh sửa hoạt động sẽ hiển thị ở đây",
                style: TextStyle(fontSize: 14, color: Color(0xFF455A64)),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Hủy",
                  style: TextStyle(
                    color: Color(0xFF78909C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Lưu",
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

  // Hàm hiển thị dialog xác nhận xóa
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text(
              "Xác nhận xóa",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF263238),
              ),
            ),
            content: Text(
              "Bạn có chắc muốn xóa \"$title\"?",
              style: const TextStyle(fontSize: 14, color: Color(0xFF455A64)),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Hủy",
                  style: TextStyle(
                    color: Color(0xFF78909C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Xóa",
                  style: TextStyle(
                    color: Color(0xFFD32F2F),
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
}
