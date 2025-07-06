# Ứng dụng Đăng ký Hoạt động Học thuật và Đoàn thể cho Sinh viên Khoa CNTT

## Giới thiệu

Đây là đồ án môn học "Lập trình di động" của nhóm sinh viên Trường Đại học Công Thương TP. HCM, Khoa Công nghệ Thông tin. Dự án nhằm mục đích xây dựng một ứng dụng di động để tối ưu hóa quy trình đăng ký, quản lý và theo dõi các hoạt động học thuật và hoạt động Đoàn - Hội dành cho sinh viên Khoa Công nghệ Thông tin.

Trong bối cảnh hiện tại, việc quản lý các hoạt động sinh viên còn gặp nhiều bất cập như quy trình thủ công, thông tin bị phân tán, khó khăn trong việc thống kê và đánh giá hiệu quả. Ứng dụng này ra đời nhằm giải quyết các vấn đề đó, mang lại sự tiện lợi, chính xác và hiệu quả cho cả sinh viên và ban tổ chức.

## Tính năng chính

Ứng dụng cung cấp các chức năng chính cho hai đối tượng người dùng: Sinh viên và Cán bộ Đoàn/Khoa.

### Đối với Sinh viên

*   **Xem thông tin hoạt động:**
    *   Truy cập danh sách tất cả các hoạt động Đoàn, Khoa đang được tổ chức.
    *   Xem chi tiết thông tin hoạt động: tên, thời gian, địa điểm, nội dung, yêu cầu tham gia.
    *   Lọc và tìm kiếm hoạt động theo các tiêu chí (thời gian, loại hoạt động, khoa tổ chức).
    *   Theo dõi trạng thái đăng ký của bản thân, thông tin cá nhân (điểm, mã số sinh viên, lớp).
*   **Đăng ký tham gia hoạt động:**
    *   Đăng ký tham gia các hoạt động một cách nhanh chóng và thuận tiện.
    *   Xác nhận thông tin cá nhân trước khi đăng ký.
    *   Nhận thông báo xác nhận sau khi đăng ký thành công.
*   **Hủy đăng ký:**
    *   Hủy đăng ký tham gia hoạt động trong thời gian quy định.

### Đối với Cán bộ Đoàn/Khoa và Hỗ trợ viên

*   **Quản lý hoạt động:**
    *   Tạo mới hoạt động với đầy đủ thông tin (tên, mô tả, thời gian, địa điểm, số lượng tham gia tối đa).
    *   Xóa hoạt động khi hoạt động bị hủy hoặc không còn phù hợp.
*   **Quản lý danh sách đăng ký:**
    *   Xem danh sách sinh viên đã đăng ký tham gia từng hoạt động cụ thể.
    *   Thống kê số lượng sinh viên đăng ký theo các tiêu chí khác nhau.
*   **Hỗ trợ tổ chức hoạt động:**
    *   Gửi thông báo đến sinh viên đã đăng ký về thông tin quan trọng.
    *   Điểm danh sinh viên tham gia hoạt động bằng QR code.
    *   Cập nhật kết quả tham gia để phục vụ chấm điểm rèn luyện.
*   **Giám sát và thống kê:**
    *   Theo dõi tình hình đăng ký của từng hoạt động.
    *   Thống kê tổng quan về hoạt động Đoàn, Khoa trong từng kỳ.
    *   Báo cáo về mức độ tham gia của sinh viên các khoa, lớp.

## Công nghệ sử dụng

*   **Framework:** Flutter (ngôn ngữ Dart)
*   **IDE:** VS Code, Android Studio
*   **Database:** Firebase (Firestore Database)
*   **Thiết bị chạy thử:** Điện thoại Android, giả lập trên Android Studio
*   **Hệ điều hành phát triển:** Windows 11
*   **Thư viện hỗ trợ:**
    *   `barcode_widget`: Để tạo mã QR.
    *   `google_mlkit_barcode_scanning`: Để quét mã QR.
    *   `Provider`: Để quản lý trạng thái ứng dụng.

## Cấu trúc dự án

Dự án được tổ chức rõ ràng với 3 thư mục chính trong `lib/`:

*   `models/`: Định nghĩa các lớp dữ liệu (model) đại diện cho các thực thể như `sinhvien`, `event`, `doankhoa`, `sv_dangky`.
*   `services/`: Chứa các lớp xử lý logic nghiệp vụ như đăng nhập (`auth.dart`), thao tác với Firestore (`cloud_service.dart`, `dangky_services.dart`).
*   `views/`: Giao diện người dùng, chia theo chức năng như `login.dart` (đăng nhập), `list_event.dart` (danh sách sự kiện), `chitietsukien.dart` (chi tiết sự kiện), `ds_sv_dangky.dart` (danh sách sinh viên đã đăng ký), `capnhatsukien.dart`, `creating_event.dart` (tạo và cập nhật sự kiện), `qr_scanner.dart` (quét mã QR điểm danh), `taoqrdiemdanh.dart` (tạo mã QR cho sự kiện), `thongtindiemdan.dart` (hiển thị thông tin điểm danh).

## Cài đặt và chạy ứng dụng

Để cài đặt và chạy ứng dụng trên máy cục bộ, bạn cần:

1.  **Cài đặt Flutter SDK:** Theo hướng dẫn chính thức từ [Flutter.dev](https://flutter.dev/docs/get-started/install ).
2.  **Cài đặt Android Studio hoặc VS Code:** Với các plugin cần thiết cho Flutter.
3.  **Cấu hình Firebase:**
    *   Tạo một dự án Firebase mới trên [Firebase Console](https://console.firebase.google.com/ ).
    *   Thêm ứng dụng Android vào dự án Firebase của bạn và tải xuống tệp `google-services.json`, đặt nó vào thư mục `android/app/` của dự án Flutter.
    *   Kích hoạt Firestore Database trong dự án Firebase của bạn.
    *   Cấu hình các quy tắc bảo mật cho Firestore theo yêu cầu của ứng dụng.
4.  **Clone repository:**
    ```bash
    git clone https://github.com/your_username/your_repo_name.git
    cd your_repo_name
    ```
    (Thay `your_username` và `your_repo_name` bằng thông tin của bạn ).
5.  **Cài đặt các dependencies:**
    ```bash
    flutter pub get
    ```
6.  **Chạy ứng dụng:**
    *   Kết nối một thiết bị Android vật lý hoặc khởi động một trình giả lập Android.
    *   Chạy lệnh:
        ```bash
        flutter run
        ```

## Nhóm thực hiện

**Giảng viên hướng dẫn:**
*   ThS. Vũ Văn Vinh

**Sinh viên thực hiện:**
1.  2001221146 – Lăng Minh Hải – 13DHTH03
    *   Phân công: Tạo giao diện và xử lý chức năng lịch sử hoạt động, thông tin sinh viên, xác nhận đăng ký, thông tin sau quét QR.
2.  2001223968 – Trần Trọng Quí – 13DHTH03
    *   Phân công: Tạo giao diện và xử lý các chức năng trong danh sách sự kiện.
3.  2001224715 – Nguyễn Văn Thành – 13DHTH03
    *   Phân công: Quản lý tiến độ, tổng hợp, chỉnh sửa giao diện và chức năng, xử lý đăng nhập, QR code, xử lý đăng ký sự kiện.
4.  2001224936 – Nguyễn Hoành Thịnh – 13DHTH03
    *   Phân công: Tạo giao diện và xử lý chức năng chi tiết sự kiện, quản lý sự kiện.

## Liên hệ

Nếu có bất kỳ câu hỏi hoặc góp ý nào, vui lòng liên hệ với nhóm qua GitHub Issues.

---

**TP. HỒ CHÍ MINH, tháng 05 năm 2025**
