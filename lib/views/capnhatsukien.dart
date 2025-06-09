import 'package:doan/models/doankhoa.dart';
import 'package:doan/models/event.dart';
import 'package:doan/services/cloud_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:doan/main.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class CapNhatSuKien extends StatefulWidget {
  final Event? event;
  const CapNhatSuKien({super.key, required this.event});

  @override
  _CapNhatSuKienState createState() => _CapNhatSuKienState();
}

class _CapNhatSuKienState extends State<CapNhatSuKien> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _participantsTargetController = TextEditingController();
  final TextEditingController _participantsController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _detailedDescriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  String? _meetingLocationController;
  DateTime? _selectedDate;
  DateTime? _selectedEndDate;
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;
  File? _imageFile;
  String? _imageUrl;
  bool _isLoadingImage = false;

  double get deviceWidth => MediaQuery.of(context).size.width;

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

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedEndDate) {
      setState(() {
        _selectedEndDate = picked;
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

  String? _validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập thông tin';
    }
    return null;
  }

  DateTime _combineDateTime(DateTime? _selectedDate, TimeOfDay? _selectedStartTime) {
    if (_selectedDate != null && _selectedStartTime != null) {
      DateTime? _combinedDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedStartTime!.hour,
        _selectedStartTime!.minute,
      );
      return _combinedDateTime;
    } else {
      return DateTime.now();
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      Event newEv = Event(
          id: widget.event!.id,
          DDToChuc: _locationController.text,
          DoiTuong: _participantsTargetController.text,
          DonViToChuc: Provider.of<DoanKhoaProvider>(context, listen: false).doanKhoa!.TenDK,
          HDChinh: "",
          LoaiHD: _meetingLocationController,
          MoTa: _descriptionController.text,
          SLDangKy: 0,
          SLToiDa: int.parse(_participantsController.text),
          TGKetThuc: _combineDateTime(_selectedEndDate, _selectedEndTime),
          TGToChuc: _combineDateTime(_selectedDate, _selectedStartTime),
          TenSuKien: _eventNameController.text,
          ThongTinThem: _detailedDescriptionController.text,
          UrlAnh: _imageUrlController.text
      );
      print(newEv);
      await CloudService().capNhatEvent(newEv);
    }
  }

  void _loadImageFromUrl() {
    if (_imageUrlController.text.isEmpty) return;
    setState(() {
      _isLoadingImage = true;
      _imageUrl = _imageUrlController.text;
      _imageFile = null;
    });
    // Add image loading completion handler
    precacheImage(NetworkImage(_imageUrlController.text), context).then((_) {
      if (mounted) {
        setState(() {
          _isLoadingImage = false;
        });
      }
    }).catchError((_) {
      if (mounted) {
        setState(() {
          _isLoadingImage = false;
        });
      }
    });
  }

  void _resetImage() {
    setState(() {
      _imageUrl = null;
      _imageUrlController.clear();
      _imageFile = null;
    });
  }

  @override
  void initState() {
    super.initState();
    _eventNameController.text = widget.event!.TenSuKien ?? '';
    _locationController.text = widget.event!.DDToChuc ?? '';
    _participantsTargetController.text = widget.event!.SLToiDa.toString() ?? '';
    _meetingLocationController = widget.event!.LoaiHD ?? '';
    _participantsController.text = widget.event!.SLDangKy?.toString() ?? '';
    _descriptionController.text = widget.event!.MoTa ?? '';
    _detailedDescriptionController.text = widget.event!.ThongTinThem ?? '';
    _imageUrlController.text = widget.event!.UrlAnh ?? '';

    _selectedDate = widget.event!.TGToChuc;
    _selectedEndDate = widget.event!.TGKetThuc;
    if (widget.event!.TGToChuc != null) {
      _selectedStartTime = TimeOfDay.fromDateTime(widget.event!.TGToChuc!);
    }
    if (widget.event!.TGKetThuc != null) {
      _selectedEndTime = TimeOfDay.fromDateTime(widget.event!.TGKetThuc!);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadImageFromUrl();
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    _locationController.dispose();
    _participantsTargetController.dispose();
    _participantsController.dispose();
    _descriptionController.dispose();
    _detailedDescriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBase(titleText: 'Tạo sự kiện'),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _imageUrlController,
                        decoration: InputDecoration(
                          labelText: 'URL Ảnh',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _loadImageFromUrl,
                      child: Text('Tải ảnh'),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      onPressed: _resetImage,
                      icon: Icon(Icons.refresh),
                      tooltip: 'Đặt lại ảnh',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    image: (_imageUrl != null)
                        ? DecorationImage(
                      image: NetworkImage(_imageUrl!),
                      fit: BoxFit.contain,
                    )
                        : _imageFile != null
                        ? DecorationImage(
                      image: FileImage(_imageFile!),
                      fit: BoxFit.cover,
                    )
                        : null,
                  ),
                  child: _isLoadingImage
                      ? Center(
                    child: CircularProgressIndicator(),
                  )
                      : _imageUrl == null && _imageFile == null
                      ? Center(
                    child: Icon(
                      Icons.image,
                      size: 50,
                      color: Colors.grey[600],
                    ),
                  )
                      : null,
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
                        constraints: BoxConstraints(
                          maxWidth: deviceWidth - 32, // 32 is total padding (16 * 2)
                        ),
                      ),
                      validator: _validateNotEmpty,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Mô tả sự kiện',
                        border: OutlineInputBorder(),
                        constraints: BoxConstraints(
                          maxWidth: deviceWidth - 32,
                        ),
                      ),
                      maxLines: 3,
                      validator: _validateNotEmpty,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: (deviceWidth / 2) - 21, // Account for padding and spacing
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
                              validator: (value) => _selectedDate == null ? 'Vui lòng chọn ngày' : null,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            width: (deviceWidth / 2) - 21,
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
                              validator: (value) => _selectedStartTime == null ? 'Vui lòng chọn giờ bắt đầu' : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: (deviceWidth / 2) - 21,
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Ngày kết thúc',
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.calendar_today),
                                  onPressed: () => _selectEndDate(context),
                                ),
                              ),
                              controller: TextEditingController(
                                text: _selectedEndDate != null
                                    ? '${_selectedEndDate!.day}/${_selectedEndDate!.month}/${_selectedEndDate!.year}'
                                    : '',
                              ),
                              validator: (value) => _selectedEndDate == null ? 'Vui lòng chọn ngày kết thúc' : null,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            width: (deviceWidth / 2) - 21,
                            child: TextFormField(
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
                              validator: (value) => _selectedEndTime == null ? 'Vui lòng chọn giờ kết thúc' : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: (deviceWidth / 2) - 21,
                            child: TextFormField(
                              controller: _locationController,
                              decoration: InputDecoration(
                                labelText: 'Địa điểm',
                                border: OutlineInputBorder(),
                              ),
                              validator: _validateNotEmpty,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            width: (deviceWidth / 2) - 21,
                            child: TextFormField(
                              controller: _participantsTargetController,
                              decoration: InputDecoration(
                                labelText: 'Đối tượng tham gia',
                                border: OutlineInputBorder(),
                              ),
                              validator: _validateNotEmpty,
                            ),
                          ),
                        ),
                      ],
                    ),                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: (deviceWidth / 2) - 21,
                            child: DropdownButtonFormField<String>(
                              value: _meetingLocationController,
                              decoration: InputDecoration(
                                labelText: 'Loại hoạt động',
                                border: OutlineInputBorder(),
                              ),
                              validator: _validateNotEmpty,
                              items: <String>['Học thuật', 'Cuộc thi', 'Sự kiện'].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  if (newValue != null) {
                                    _meetingLocationController = newValue;
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            width: (deviceWidth / 2) - 21,
                            child: TextFormField(
                              controller: _participantsController,
                              decoration: InputDecoration(
                                labelText: 'Số lượng sinh viên',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              validator: _validateNotEmpty,
                            ),
                          ),
                        ),
                      ],
                    ),


                    SizedBox(height: 10),
                    TextFormField(
                      controller: _detailedDescriptionController,
                      decoration: InputDecoration(
                        labelText: 'Mô tả chi tiết',
                        border: OutlineInputBorder(),
                        constraints: BoxConstraints(
                          maxWidth: deviceWidth - 32,
                        ),
                      ),
                      maxLines: 8,
                      validator: _validateNotEmpty,
                    ),                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _submitForm();
        },
        label: const Text(
          'Cập nhật sự kiện',
          style: TextStyle(
            color: AppColors.textWhite,
            fontSize: 18,
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
      drawer: DrawerBaseKhoa(),
    );
  }
}