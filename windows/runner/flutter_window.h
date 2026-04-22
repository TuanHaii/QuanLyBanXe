// Khai bao chi thi tien xu ly cho trinh bien dich.
#ifndef RUNNER_FLUTTER_WINDOW_H_
// Khai bao chi thi tien xu ly cho trinh bien dich.
#define RUNNER_FLUTTER_WINDOW_H_

// Khai bao chi thi tien xu ly cho trinh bien dich.
#include <flutter/dart_project.h>
// Khai bao chi thi tien xu ly cho trinh bien dich.
#include <flutter/flutter_view_controller.h>

// Khai bao chi thi tien xu ly cho trinh bien dich.
#include <memory>

// Khai bao chi thi tien xu ly cho trinh bien dich.
#include "win32_window.h"

// A window that does nothing but host a Flutter view.
// Dinh nghia lop FlutterWindow de gom nhom logic lien quan.
class FlutterWindow : public Win32Window {
 // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
 public:
  // Creates a new FlutterWindow hosting a Flutter view running |project|.
  // Thuc thi cau lenh hien tai theo luong xu ly.
  explicit FlutterWindow(const flutter::DartProject& project);
  // Thuc thi cau lenh hien tai theo luong xu ly.
  virtual ~FlutterWindow();

 // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
 protected:
  // Win32Window:
  // Khai bao bien OnCreate de luu du lieu su dung trong xu ly.
  bool OnCreate() override;
  // Thuc thi cau lenh hien tai theo luong xu ly.
  void OnDestroy() override;
  // Thuc thi cau lenh hien tai theo luong xu ly.
  LRESULT MessageHandler(HWND window, UINT const message, WPARAM const wparam,
                         // Thuc thi cau lenh hien tai theo luong xu ly.
                         LPARAM const lparam) noexcept override;

 // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
 private:
  // The project to run.
  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
  flutter::DartProject project_;

  // The Flutter instance hosted by this window.
  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
  std::unique_ptr<flutter::FlutterViewController> flutter_controller_;
};

// Khai bao chi thi tien xu ly cho trinh bien dich.
#endif  // RUNNER_FLUTTER_WINDOW_H_
