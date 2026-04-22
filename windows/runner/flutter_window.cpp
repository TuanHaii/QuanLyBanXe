// Khai bao chi thi tien xu ly cho trinh bien dich.
#include "flutter_window.h"

// Khai bao chi thi tien xu ly cho trinh bien dich.
#include <optional>

// Khai bao chi thi tien xu ly cho trinh bien dich.
#include "flutter/generated_plugin_registrant.h"

// Thiet lap thuoc tinh cho doi tuong hoac giao dien.
FlutterWindow::FlutterWindow(const flutter::DartProject& project)
    // Thuc thi cau lenh hien tai theo luong xu ly.
    : project_(project) {}

// Thiet lap thuoc tinh cho doi tuong hoac giao dien.
FlutterWindow::~FlutterWindow() {}

// Khai bao bien FlutterWindow de luu du lieu su dung trong xu ly.
bool FlutterWindow::OnCreate() {
  // Kiem tra dieu kien de re nhanh xu ly.
  if (!Win32Window::OnCreate()) {
    // Tra ve ket qua cho noi goi ham.
    return false;
  }

  // Thuc thi cau lenh hien tai theo luong xu ly.
  RECT frame = GetClientArea();

  // The size here must match the window dimensions to avoid unnecessary surface
  // creation / destruction in the startup path.
  // Gan gia tri cho bien flutter_controller_.
  flutter_controller_ = std::make_unique<flutter::FlutterViewController>(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      frame.right - frame.left, frame.bottom - frame.top, project_);
  // Ensure that basic setup of the controller was successful.
  // Kiem tra dieu kien de re nhanh xu ly.
  if (!flutter_controller_->engine() || !flutter_controller_->view()) {
    // Tra ve ket qua cho noi goi ham.
    return false;
  }
  // Goi ham de thuc thi tac vu can thiet.
  RegisterPlugins(flutter_controller_->engine());
  // Goi ham de thuc thi tac vu can thiet.
  SetChildContent(flutter_controller_->view()->GetNativeWindow());

  // Thuc thi cau lenh hien tai theo luong xu ly.
  flutter_controller_->engine()->SetNextFrameCallback([&]() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this->Show();
  });

  // Flutter can complete the first frame before the "show window" callback is
  // registered. The following call ensures a frame is pending to ensure the
  // window is shown. It is a no-op if the first frame hasn't completed yet.
  // Thuc thi cau lenh hien tai theo luong xu ly.
  flutter_controller_->ForceRedraw();

  // Tra ve ket qua cho noi goi ham.
  return true;
}

// Thuc thi cau lenh hien tai theo luong xu ly.
void FlutterWindow::OnDestroy() {
  // Kiem tra dieu kien de re nhanh xu ly.
  if (flutter_controller_) {
    // Gan gia tri cho bien flutter_controller_.
    flutter_controller_ = nullptr;
  }

  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
  Win32Window::OnDestroy();
}

// Thuc thi cau lenh hien tai theo luong xu ly.
LRESULT
// Thiet lap thuoc tinh cho doi tuong hoac giao dien.
FlutterWindow::MessageHandler(HWND hwnd, UINT const message,
                              // Thuc thi cau lenh hien tai theo luong xu ly.
                              WPARAM const wparam,
                              // Thuc thi cau lenh hien tai theo luong xu ly.
                              LPARAM const lparam) noexcept {
  // Give Flutter, including plugins, an opportunity to handle window messages.
  // Kiem tra dieu kien de re nhanh xu ly.
  if (flutter_controller_) {
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    std::optional<LRESULT> result =
        // Thuc thi cau lenh hien tai theo luong xu ly.
        flutter_controller_->HandleTopLevelWindowProc(hwnd, message, wparam,
                                                      // Thuc thi cau lenh hien tai theo luong xu ly.
                                                      lparam);
    // Kiem tra dieu kien de re nhanh xu ly.
    if (result) {
      // Tra ve ket qua cho noi goi ham.
      return *result;
    }
  }

  // Bat dau re nhanh theo nhieu truong hop gia tri.
  switch (message) {
    // Xu ly mot truong hop cu the trong switch.
    case WM_FONTCHANGE:
      // Thuc thi cau lenh hien tai theo luong xu ly.
      flutter_controller_->engine()->ReloadSystemFonts();
      // Thuc thi cau lenh hien tai theo luong xu ly.
      break;
  }

  // Tra ve ket qua cho noi goi ham.
  return Win32Window::MessageHandler(hwnd, message, wparam, lparam);
}
