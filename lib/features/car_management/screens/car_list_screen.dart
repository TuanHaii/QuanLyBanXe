// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';
// Nap thu vien hoac module can thiet.
import 'package:go_router/go_router.dart';

// Nap thu vien hoac module can thiet.
import '../../../shared/constants/app_constants.dart';
// Nap thu vien hoac module can thiet.
import '../../../shared/services/service_locator.dart';
// Nap thu vien hoac module can thiet.
import '../models/car_model.dart';
// Nap thu vien hoac module can thiet.
import '../services/car_service.dart';
// Nap thu vien hoac module can thiet.
import '../widgets/car_list_item.dart';

// Dinh nghia lop CarListScreen de gom nhom logic lien quan.
class CarListScreen extends StatefulWidget {
  // Khai bao bien CarListScreen de luu du lieu su dung trong xu ly.
  const CarListScreen({super.key});

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Thuc thi cau lenh hien tai theo luong xu ly.
  State<CarListScreen> createState() => _CarListScreenState();
}

// Dinh nghia lop _CarListScreenState de gom nhom logic lien quan.
class _CarListScreenState extends State<CarListScreen> {
  // Khai bao bien CarService de luu du lieu su dung trong xu ly.
  final CarService _carService = getIt<CarService>();
  // Khai bao bien _cars de luu du lieu su dung trong xu ly.
  List<CarModel> _cars = [];

  // Khai bao bien _searchQuery de luu du lieu su dung trong xu ly.
  String _searchQuery = '';
  // Thuc thi cau lenh hien tai theo luong xu ly.
  CarStatus? _filterStatus;
  // Khai bao bien _isLoading de luu du lieu su dung trong xu ly.
  bool _isLoading = true;
  // Thuc thi cau lenh hien tai theo luong xu ly.
  String? _errorMessage;

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Dinh nghia ham initState de xu ly nghiep vu tuong ung.
  void initState() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.initState();
    // Khai bao constructor _loadCars de khoi tao doi tuong.
    _loadCars();
  }

  // Khai bao bien _loadCars de luu du lieu su dung trong xu ly.
  Future<void> _loadCars({bool showLoader = true}) async {
    // Kiem tra dieu kien de re nhanh xu ly.
    if (showLoader) {
      // Cap nhat state de giao dien duoc render lai.
      setState(() {
        // Gan gia tri cho bien _isLoading.
        _isLoading = true;
        // Gan gia tri cho bien _errorMessage.
        _errorMessage = null;
      });
    }

    // Bao boc khoi lenh co the phat sinh loi de xu ly an toan.
    try {
      // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
      final cars = await _carService.fetchCars();

      // Kiem tra dieu kien de re nhanh xu ly.
      if (!mounted) {
        // Tra ve ket qua cho noi goi ham.
        return;
      }

      // Cap nhat state de giao dien duoc render lai.
      setState(() {
        // Gan gia tri cho bien _cars.
        _cars = cars;
        // Gan gia tri cho bien _errorMessage.
        _errorMessage = null;
      });
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } catch (_) {
      // Kiem tra dieu kien de re nhanh xu ly.
      if (!mounted) {
        // Tra ve ket qua cho noi goi ham.
        return;
      }

      // Cap nhat state de giao dien duoc render lai.
      setState(() {
        // Gan gia tri cho bien _errorMessage.
        _errorMessage = 'Không thể tải danh sách xe. Vui lòng thử lại.';
      });
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } finally {
      // Kiem tra dieu kien de re nhanh xu ly.
      if (mounted && showLoader) {
        // Cap nhat state de giao dien duoc render lai.
        setState(() {
          // Gan gia tri cho bien _isLoading.
          _isLoading = false;
        });
      }
    }
  }

  // Khai bao bien get de luu du lieu su dung trong xu ly.
  List<CarModel> get _filteredCars {
    // Tra ve ket qua cho noi goi ham.
    return _cars.where((car) {
      // Khai bao bien matchesSearch de luu du lieu su dung trong xu ly.
      final matchesSearch = car.name
              // Thuc thi cau lenh hien tai theo luong xu ly.
              .toLowerCase()
              // Thuc thi cau lenh hien tai theo luong xu ly.
              .contains(_searchQuery.toLowerCase()) ||
          // Thuc thi cau lenh hien tai theo luong xu ly.
          car.brand.toLowerCase().contains(_searchQuery.toLowerCase());
      // Khai bao bien matchesStatus de luu du lieu su dung trong xu ly.
      final matchesStatus = _filterStatus == null || car.status == _filterStatus;
      // Tra ve ket qua cho noi goi ham.
      return matchesSearch && matchesStatus;
    // Thuc thi cau lenh hien tai theo luong xu ly.
    }).toList();
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Tra ve ket qua cho noi goi ham.
    return Scaffold(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      appBar: AppBar(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        title: const Text('Danh sách xe'),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        actions: [
          // Goi ham de thuc thi tac vu can thiet.
          IconButton(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            icon: const Icon(Icons.refresh),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onPressed: _loadCars,
          ),
          // Goi ham de thuc thi tac vu can thiet.
          IconButton(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            icon: const Icon(Icons.filter_list),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      body: Column(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: [
          // Search bar
          // Goi ham de thuc thi tac vu can thiet.
          Padding(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            padding: const EdgeInsets.all(16),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: TextField(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              onChanged: (value) {
                // Cap nhat state de giao dien duoc render lai.
                setState(() => _searchQuery = value);
              },
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              decoration: InputDecoration(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                hintText: 'Tìm kiếm xe...',
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                prefixIcon: const Icon(Icons.search),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                suffixIcon: _searchQuery.isNotEmpty
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    ? IconButton(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        icon: const Icon(Icons.clear),
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        onPressed: () {
                          // Cap nhat state de giao dien duoc render lai.
                          setState(() => _searchQuery = '');
                        },
                      )
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    : null,
              ),
            ),
          ),
          // Car list
          // Goi ham de thuc thi tac vu can thiet.
          Expanded(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: _isLoading
                // Thuc thi cau lenh hien tai theo luong xu ly.
                ? const Center(child: CircularProgressIndicator())
                // Thuc thi cau lenh hien tai theo luong xu ly.
                : _errorMessage != null
                // Thuc thi cau lenh hien tai theo luong xu ly.
                ? Center(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    child: Padding(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      child: Column(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        mainAxisAlignment: MainAxisAlignment.center,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        children: [
                          // Goi ham de thuc thi tac vu can thiet.
                          Text(_errorMessage!, textAlign: TextAlign.center),
                          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                          const SizedBox(height: 12),
                          // Goi ham de thuc thi tac vu can thiet.
                          ElevatedButton(
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            onPressed: _loadCars,
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            child: const Text('Thử lại'),
                          ),
                        ],
                      ),
                    ),
                  )
                // Thuc thi cau lenh hien tai theo luong xu ly.
                : _filteredCars.isEmpty
                // Thuc thi cau lenh hien tai theo luong xu ly.
                ? const Center(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    child: Text('Không tìm thấy xe nào'),
                  )
                // Thuc thi cau lenh hien tai theo luong xu ly.
                : RefreshIndicator(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    onRefresh: () => _loadCars(showLoader: false),
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    child: ListView.builder(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      itemCount: _filteredCars.length,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      itemBuilder: (context, index) {
                        // Khai bao bien car de luu du lieu su dung trong xu ly.
                        final car = _filteredCars[index];
                        // Tra ve ket qua cho noi goi ham.
                        return CarListItem(
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          car: car,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          onTap: () {
                            // Thuc thi cau lenh hien tai theo luong xu ly.
                            context.push('/cars/${car.id}');
                          },
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      floatingActionButton: FloatingActionButton(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onPressed: () async {
          // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
          await context.push(RouteNames.addCar);
          // Kiem tra dieu kien de re nhanh xu ly.
          if (mounted) {
            // Khai bao constructor _loadCars de khoi tao doi tuong.
            _loadCars(showLoader: false);
          }
        },
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: const Icon(Icons.add),
      ),
    );
  }

  // Dinh nghia ham _showFilterDialog de xu ly nghiep vu tuong ung.
  void _showFilterDialog() {
    // Goi ham de thuc thi tac vu can thiet.
    showModalBottomSheet(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      context: context,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      builder: (context) => Container(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        padding: const EdgeInsets.all(24),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: Column(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          mainAxisSize: MainAxisSize.min,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          crossAxisAlignment: CrossAxisAlignment.start,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          children: [
            // Goi ham de thuc thi tac vu can thiet.
            Text(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              'Lọc theo trạng thái',
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontWeight: FontWeight.bold,
                  ),
            ),
            // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
            const SizedBox(height: 16),
            // Goi ham de thuc thi tac vu can thiet.
            Wrap(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              spacing: 8,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              children: [
                // Goi ham de thuc thi tac vu can thiet.
                FilterChip(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  label: const Text('Tất cả'),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  selected: _filterStatus == null,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  onSelected: (_) {
                    // Cap nhat state de giao dien duoc render lai.
                    setState(() => _filterStatus = null);
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    Navigator.pop(context);
                  },
                ),
                // Goi ham de thuc thi tac vu can thiet.
                FilterChip(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  label: const Text('Còn hàng'),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  selected: _filterStatus == CarStatus.available,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  onSelected: (_) {
                    // Cap nhat state de giao dien duoc render lai.
                    setState(() => _filterStatus = CarStatus.available);
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    Navigator.pop(context);
                  },
                ),
                // Goi ham de thuc thi tac vu can thiet.
                FilterChip(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  label: const Text('Đã bán'),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  selected: _filterStatus == CarStatus.sold,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  onSelected: (_) {
                    // Cap nhat state de giao dien duoc render lai.
                    setState(() => _filterStatus = CarStatus.sold);
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    Navigator.pop(context);
                  },
                ),
                // Goi ham de thuc thi tac vu can thiet.
                FilterChip(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  label: const Text('Đã đặt'),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  selected: _filterStatus == CarStatus.reserved,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  onSelected: (_) {
                    // Cap nhat state de giao dien duoc render lai.
                    setState(() => _filterStatus = CarStatus.reserved);
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
