import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:doan/main.dart';

class EventDetail extends StatelessWidget {
  const EventDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBase(titleText: 'Thông tin sự kiện'),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: TextButton(
                onPressed: () {},
                child: Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.arrowLeft,
                        color: AppColors.textBlack,
                        size: 18,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Trở lại',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/events_images/huit_open_day.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'HUIT Open Day',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'HUIT Open Day là sự kiện thường niên nhằm giới thiệu về môi trường học tập, cơ hội nghề nghiệp và các ngành đào tạo tại Đại học Công nghệ HUIT.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(FontAwesomeIcons.clock, color: Colors.grey),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Thời gian: 16/03/2025',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '7:00 AM - 5:00 PM',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(FontAwesomeIcons.locationDot, color: Colors.grey),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Địa điểm: Trường đại học Công thương - HUIT',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '140 Lê Trọng Tấn, Tây Thạnh, Tân Phú, TP. HCM',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(FontAwesomeIcons.hand, color: Colors.grey),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Đối tượng tham gia: Học sinh - sinh viên',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(FontAwesomeIcons.chartSimple, color: Colors.grey),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Số lượng sinh viên tham gia: 200',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  LineProgressWidget(valueCurrent: 123, valueMax: 200),

                  const SizedBox(height: 20),
                  const Text(
                    'MÔ TẢ: HUIT OPEN DAY 2025 | RỰC RỠ CÙNG GÁNH HÁT LÔ TÔ HƯƠNG NAM! ✨🎉',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '🔥 Hé lộ khách mời đầu tiên sẽ biểu diễn tại ngày hội tư vấn hướng nghiệp tuyển sinh - HUIT OPEN DAY 2025. Bùng cháy không gian với những màn biểu diễn lô tô đầy màu sắc, hài hước và sôi động từ Gánh Hát Lô Tô Hương Nam!',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '🎶 Cùng hòa mình vào không khí lễ hội, trải nghiệm văn hóa giải trí độc đáo và giao lưu với những nghệ sĩ tài năng.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '📢 Sẵn sàng "xổ số" niềm vui và rinh về những phần quà hấp dẫn! Tag ngay đồng bọn đến quẩy cùng nào!',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '✅ Các hoạt động nổi tại ngày :',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '👉 Tư vấn tuyển sinh: Cập nhật thông tin mới nhất về kỳ thi tốt nghiệp THPT 2025, phương thức xét tuyển và cách chọn ngành, chọn trường phù hợp.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '👉 Trải nghiệm thực tế: Tham gia các hoạt động trải nghiệm thú vị như tham quan VR360 bằng kính thực tế ảo, trò chơi tương tác.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '👉 Gặp gỡ chuyên gia: Gặp gỡ trực tiếp đại diện và chuyên gia của HUIT để giải đáp thắc mắc về chương trình đào tạo, cơ hội nghề nghiệp và các chương trình hợp tác quốc tế.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text(
          'Đăng Ký',
          style: TextStyle(color: AppColors.textWhite, fontSize: 18),
        ),
        backgroundColor: AppColors.primary,
      ),

      drawer: DrawerBase(),
    );
  }
}
