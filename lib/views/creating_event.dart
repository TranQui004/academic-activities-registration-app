import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:doan/main.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreatingEvent extends StatefulWidget {
  const CreatingEvent({super.key});

  @override
  _CreatingEventState createState() => _CreatingEventState();
}

class _CreatingEventState extends State<CreatingEvent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _participantsTargetController = TextEditingController(); // Controller mới
  final TextEditingController _meetingLocationController = TextEditingController();
  final TextEditingController _participantsController = TextEditingController();
  final TextEditingController _registeredStudentsController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _detailedDescriptionController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedStartTime) {
      setState(() {
        _selectedStartTime = picked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedEndTime) {
      setState(() {
        _selectedEndTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBase(titleText: 'Thông tin sự kiện'),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                        Icon(FontAwesomeIcons.arrowLeft, color: AppColors.textBlack, size: 18),
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
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      image: _imageFile != null
                          ? DecorationImage(
                              image: FileImage(_imageFile!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _imageFile == null
                        ? Center(
                            child: Icon(
                              Icons.add_a_photo,
                              size: 50,
                              color: Colors.grey[600],
                            ),
                          )
                        : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _eventNameController,
                      decoration: InputDecoration(
                        labelText: 'Tên sự kiện',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Mô tả sự kiện',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Ngày',
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.calendar_today),
                                onPressed: () => _selectDate(context),
                              ),
                            ),
                            controller: TextEditingController(
                              text: _selectedDate != null
                                  ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                  : '',
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Giờ bắt đầu',
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.access_time),
                                onPressed: () => _selectStartTime(context),
                              ),
                            ),
                            controller: TextEditingController(
                              text: _selectedStartTime != null
                                  ? '${_selectedStartTime!.hour}:${_selectedStartTime!.minute}'
                                  : '',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Giờ kết thúc',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.access_time),
                          onPressed: () => _selectEndTime(context),
                        ),
                      ),
                      controller: TextEditingController(
                        text: _selectedEndTime != null
                            ? '${_selectedEndTime!.hour}:${_selectedEndTime!.minute}'
                            : '',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        labelText: 'Địa điểm',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _participantsTargetController,
                      decoration: InputDecoration(
                        labelText: 'Đối tượng tham gia',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _meetingLocationController,
                      decoration: InputDecoration(
                        labelText: 'Địa điểm tập trung',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _participantsController,
                      decoration: InputDecoration(
                        labelText: 'Số lượng sinh viên tham gia',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _registeredStudentsController,
                      decoration: InputDecoration(
                        labelText: 'Số lượng sinh viên đã đăng ký',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _detailedDescriptionController,
                      decoration: InputDecoration(
                        labelText: 'Mô tả chi tiết',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 8,
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Xử lý dữ liệu khi nhấn nút
                          print('Tên sự kiện: ${_eventNameController.text}');
                          print('Mô tả: ${_descriptionController.text}');
                          print('Mô tả chi tiết: ${_detailedDescriptionController.text}');
                          print('Ngày: $_selectedDate');
                          print('Giờ bắt đầu: $_selectedStartTime');
                          print('Giờ kết thúc: $_selectedEndTime');
                          print('Địa điểm: ${_locationController.text}');
                          print('Đối tượng tham gia: ${_participantsTargetController.text}');
                          print('Địa điểm tập trung: ${_meetingLocationController.text}');
                          print('Số lượng sinh viên: ${_participantsController.text}');
                          print('Số lượng đã đăng ký: ${_registeredStudentsController.text}');
                          if (_imageFile != null) {
                            print('Ảnh: ${_imageFile!.path}');
                          }
                        },
                        child: Text('Lưu sự kiện'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Xử lý dữ liệu khi nhấn nút
          print('Tên sự kiện: ${_eventNameController.text}');
          print('Mô tả: ${_descriptionController.text}');
          print('Mô tả chi tiết: ${_detailedDescriptionController.text}');
          print('Ngày: $_selectedDate');
          print('Giờ bắt đầu: $_selectedStartTime');
          print('Giờ kết thúc: $_selectedEndTime');
          print('Địa điểm: ${_locationController.text}');
          print('Đối tượng tham gia: ${_participantsTargetController.text}');
          print('Địa điểm tập trung: ${_meetingLocationController.text}');
          print('Số lượng sinh viên: ${_participantsController.text}');
          print('Số lượng đã đăng ký: ${_registeredStudentsController.text}');
          if (_imageFile != null) {
            print('Ảnh: ${_imageFile!.path}');
          }
        },
        label: const Text(
          'Tạo sự kiện',
          style: TextStyle(
            color: AppColors.textWhite,
            fontSize: 18,
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
      drawer: DrawerBase(),
    );
  }
}