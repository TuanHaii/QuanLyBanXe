// Khai bao chi thi tien xu ly cho trinh bien dich.
#include "win32_window.h"

// Khai bao chi thi tien xu ly cho trinh bien dich.
#include <dwmapi.h>
// Khai bao chi thi tien xu ly cho trinh bien dich.
#include <flutter_windows.h>

// Khai bao chi thi tien xu ly cho trinh bien dich.
#include "resource.h"

// Thuc thi cau lenh hien tai theo luong xu ly.
namespace {

/// Window attribute that enables dark mode window decorations.
///
/// Redefined in case the developer's machine has a Windows SDK older than
/// version 10.0.22000.0.
/// See: https://docs.microsoft.com/windows/win32/api/dwmapi/ne-dwmapi-dwmwindowattribute
// Khai bao chi thi tien xu ly cho trinh bien dich.
#ifndef DWMWA_USE_IMMERSIVE_DARK_MODE
// Khai bao chi thi tien xu ly cho trinh bien dich.
#define DWMWA_USE_IMMERSIVE_DARK_MODE 20
// Khai bao chi thi tien xu ly cho trinh bien dich.
#endif

// Thuc thi cau lenh hien tai theo luong xu ly.
constexpr const wchar_t kWindowClassName[] = L"FLUTTER_RUNNER_WIN32_WINDOW";

/// Registry key for app theme preference.
///
/// A value of 0 indicates apps should use dark mode. A non-zero or missing
/// value indicates apps should use light mode.
// Thuc thi cau lenh hien tai theo luong xu ly.
constexpr const wchar_t kGetPreferredBrightnessRegKey[] =
  // Thuc thi cau lenh hien tai theo luong xu ly.
  L"Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize";
// Thuc thi cau lenh hien tai theo luong xu ly.
constexpr const wchar_t kGetPreferredBrightnessRegValue[] = L"AppsUseLightTheme";

// The number of Win32Window objects that currently exist.
// Khai bao bien int de luu du lieu su dung trong xu ly.
static int g_active_window_count = 0;

// Thuc thi cau lenh hien tai theo luong xu ly.
using EnableNonClientDpiScaling = BOOL __stdcall(HWND hwnd);

// Scale helper to convert logical scaler values to physical using passed in
// scale factor
// Khai bao bien Scale de luu du lieu su dung trong xu ly.
int Scale(int source, double scale_factor) {
  // Tra ve ket qua cho noi goi ham.
  return static_cast<int>(source * scale_factor);
}

// Dynamically loads the |EnableNonClientDpiScaling| from the User32 module.
// This API is only needed for PerMonitor V1 awareness mode.
// Dinh nghia ham EnableFullDpiSupportIfAvailable de xu ly nghiep vu tuong ung.
void EnableFullDpiSupportIfAvailable(HWND hwnd) {
  // Thuc thi cau lenh hien tai theo luong xu ly.
  HMODULE user32_module = LoadLibraryA("User32.dll");
  // Kiem tra dieu kien de re nhanh xu ly.
  if (!user32_module) {
    // Tra ve ket qua cho noi goi ham.
    return;
  }
  // Thuc thi cau lenh hien tai theo luong xu ly.
  auto enable_non_client_dpi_scaling =
      // Thuc thi cau lenh hien tai theo luong xu ly.
      reinterpret_cast<EnableNonClientDpiScaling*>(
          // Goi ham de thuc thi tac vu can thiet.
          GetProcAddress(user32_module, "EnableNonClientDpiScaling"));
  // Kiem tra dieu kien de re nhanh xu ly.
  if (enable_non_client_dpi_scaling != nullptr) {
    // Khai bao constructor enable_non_client_dpi_scaling de khoi tao doi tuong.
    enable_non_client_dpi_scaling(hwnd);
  }
  // Khai bao constructor FreeLibrary de khoi tao doi tuong.
  FreeLibrary(user32_module);
}

// Thuc thi cau lenh hien tai theo luong xu ly.
}  // namespace

// Manages the Win32Window's window class registration.
// Dinh nghia lop WindowClassRegistrar de gom nhom logic lien quan.
class WindowClassRegistrar {
 // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
 public:
  // Thuc thi cau lenh hien tai theo luong xu ly.
  ~WindowClassRegistrar() = default;

  // Returns the singleton registrar instance.
  // Khai bao bien WindowClassRegistrar de luu du lieu su dung trong xu ly.
  static WindowClassRegistrar* GetInstance() {
    // Kiem tra dieu kien de re nhanh xu ly.
    if (!instance_) {
      // Gan gia tri cho bien instance_.
      instance_ = new WindowClassRegistrar();
    }
    // Tra ve ket qua cho noi goi ham.
    return instance_;
  }

  // Returns the name of the window class, registering the class if it hasn't
  // previously been registered.
  // Khai bao bien wchar_t de luu du lieu su dung trong xu ly.
  const wchar_t* GetWindowClass();

  // Unregisters the window class. Should only be called if there are no
  // instances of the window.
  // Thuc thi cau lenh hien tai theo luong xu ly.
  void UnregisterWindowClass();

 // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
 private:
  // Goi ham de thuc thi tac vu can thiet.
  WindowClassRegistrar() = default;

  // Khai bao bien WindowClassRegistrar de luu du lieu su dung trong xu ly.
  static WindowClassRegistrar* instance_;

  // Khai bao bien class_registered_ de luu du lieu su dung trong xu ly.
  bool class_registered_ = false;
};

// Thuc thi cau lenh hien tai theo luong xu ly.
WindowClassRegistrar* WindowClassRegistrar::instance_ = nullptr;

// Khai bao bien wchar_t de luu du lieu su dung trong xu ly.
const wchar_t* WindowClassRegistrar::GetWindowClass() {
  // Kiem tra dieu kien de re nhanh xu ly.
  if (!class_registered_) {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    WNDCLASS window_class{};
    // Thuc thi cau lenh hien tai theo luong xu ly.
    window_class.hCursor = LoadCursor(nullptr, IDC_ARROW);
    // Thuc thi cau lenh hien tai theo luong xu ly.
    window_class.lpszClassName = kWindowClassName;
    // Thuc thi cau lenh hien tai theo luong xu ly.
    window_class.style = CS_HREDRAW | CS_VREDRAW;
    // Thuc thi cau lenh hien tai theo luong xu ly.
    window_class.cbClsExtra = 0;
    // Thuc thi cau lenh hien tai theo luong xu ly.
    window_class.cbWndExtra = 0;
    // Thuc thi cau lenh hien tai theo luong xu ly.
    window_class.hInstance = GetModuleHandle(nullptr);
    // Thuc thi cau lenh hien tai theo luong xu ly.
    window_class.hIcon =
        // Goi ham de thuc thi tac vu can thiet.
        LoadIcon(window_class.hInstance, MAKEINTRESOURCE(IDI_APP_ICON));
    // Thuc thi cau lenh hien tai theo luong xu ly.
    window_class.hbrBackground = 0;
    // Thuc thi cau lenh hien tai theo luong xu ly.
    window_class.lpszMenuName = nullptr;
    // Thuc thi cau lenh hien tai theo luong xu ly.
    window_class.lpfnWndProc = Win32Window::WndProc;
    // Khai bao constructor RegisterClass de khoi tao doi tuong.
    RegisterClass(&window_class);
    // Gan gia tri cho bien class_registered_.
    class_registered_ = true;
  }
  // Tra ve ket qua cho noi goi ham.
  return kWindowClassName;
}

// Thuc thi cau lenh hien tai theo luong xu ly.
void WindowClassRegistrar::UnregisterWindowClass() {
  // Khai bao constructor UnregisterClass de khoi tao doi tuong.
  UnregisterClass(kWindowClassName, nullptr);
  // Gan gia tri cho bien class_registered_.
  class_registered_ = false;
}

// Thiet lap thuoc tinh cho doi tuong hoac giao dien.
Win32Window::Win32Window() {
  // Thuc thi cau lenh hien tai theo luong xu ly.
  ++g_active_window_count;
}

// Thiet lap thuoc tinh cho doi tuong hoac giao dien.
Win32Window::~Win32Window() {
  // Thuc thi cau lenh hien tai theo luong xu ly.
  --g_active_window_count;
  // Khai bao constructor Destroy de khoi tao doi tuong.
  Destroy();
}

// Khai bao bien Win32Window de luu du lieu su dung trong xu ly.
bool Win32Window::Create(const std::wstring& title,
                         // Khai bao bien Point de luu du lieu su dung trong xu ly.
                         const Point& origin,
                         // Khai bao bien Size de luu du lieu su dung trong xu ly.
                         const Size& size) {
  // Khai bao constructor Destroy de khoi tao doi tuong.
  Destroy();

  // Khai bao bien wchar_t de luu du lieu su dung trong xu ly.
  const wchar_t* window_class =
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      WindowClassRegistrar::GetInstance()->GetWindowClass();

  // Khai bao bien POINT de luu du lieu su dung trong xu ly.
  const POINT target_point = {static_cast<LONG>(origin.x),
                              // Thuc thi cau lenh hien tai theo luong xu ly.
                              static_cast<LONG>(origin.y)};
  // Thuc thi cau lenh hien tai theo luong xu ly.
  HMONITOR monitor = MonitorFromPoint(target_point, MONITOR_DEFAULTTONEAREST);
  // Thuc thi cau lenh hien tai theo luong xu ly.
  UINT dpi = FlutterDesktopGetDpiForMonitor(monitor);
  // Khai bao bien scale_factor de luu du lieu su dung trong xu ly.
  double scale_factor = dpi / 96.0;

  // Thuc thi cau lenh hien tai theo luong xu ly.
  HWND window = CreateWindow(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      window_class, title.c_str(), WS_OVERLAPPEDWINDOW,
      // Goi ham de thuc thi tac vu can thiet.
      Scale(origin.x, scale_factor), Scale(origin.y, scale_factor),
      // Goi ham de thuc thi tac vu can thiet.
      Scale(size.width, scale_factor), Scale(size.height, scale_factor),
      // Thuc thi cau lenh hien tai theo luong xu ly.
      nullptr, nullptr, GetModuleHandle(nullptr), this);

  // Kiem tra dieu kien de re nhanh xu ly.
  if (!window) {
    // Tra ve ket qua cho noi goi ham.
    return false;
  }

  // Khai bao constructor UpdateTheme de khoi tao doi tuong.
  UpdateTheme(window);

  // Tra ve ket qua cho noi goi ham.
  return OnCreate();
}

// Khai bao bien Win32Window de luu du lieu su dung trong xu ly.
bool Win32Window::Show() {
  // Tra ve ket qua cho noi goi ham.
  return ShowWindow(window_handle_, SW_SHOWNORMAL);
}

// static
// Thuc thi cau lenh hien tai theo luong xu ly.
LRESULT CALLBACK Win32Window::WndProc(HWND const window,
                                      // Thuc thi cau lenh hien tai theo luong xu ly.
                                      UINT const message,
                                      // Thuc thi cau lenh hien tai theo luong xu ly.
                                      WPARAM const wparam,
                                      // Thuc thi cau lenh hien tai theo luong xu ly.
                                      LPARAM const lparam) noexcept {
  // Kiem tra dieu kien de re nhanh xu ly.
  if (message == WM_NCCREATE) {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    auto window_struct = reinterpret_cast<CREATESTRUCT*>(lparam);
    // Goi ham de thuc thi tac vu can thiet.
    SetWindowLongPtr(window, GWLP_USERDATA,
                     // Thuc thi cau lenh hien tai theo luong xu ly.
                     reinterpret_cast<LONG_PTR>(window_struct->lpCreateParams));

    // Thuc thi cau lenh hien tai theo luong xu ly.
    auto that = static_cast<Win32Window*>(window_struct->lpCreateParams);
    // Khai bao constructor EnableFullDpiSupportIfAvailable de khoi tao doi tuong.
    EnableFullDpiSupportIfAvailable(window);
    // Thuc thi cau lenh hien tai theo luong xu ly.
    that->window_handle_ = window;
  // Thuc thi cau lenh hien tai theo luong xu ly.
  } else if (Win32Window* that = GetThisFromHandle(window)) {
    // Tra ve ket qua cho noi goi ham.
    return that->MessageHandler(window, message, wparam, lparam);
  }

  // Tra ve ket qua cho noi goi ham.
  return DefWindowProc(window, message, wparam, lparam);
}

// Thuc thi cau lenh hien tai theo luong xu ly.
LRESULT
// Thiet lap thuoc tinh cho doi tuong hoac giao dien.
Win32Window::MessageHandler(HWND hwnd,
                            // Thuc thi cau lenh hien tai theo luong xu ly.
                            UINT const message,
                            // Thuc thi cau lenh hien tai theo luong xu ly.
                            WPARAM const wparam,
                            // Thuc thi cau lenh hien tai theo luong xu ly.
                            LPARAM const lparam) noexcept {
  // Bat dau re nhanh theo nhieu truong hop gia tri.
  switch (message) {
    // Xu ly mot truong hop cu the trong switch.
    case WM_DESTROY:
      // Gan gia tri cho bien window_handle_.
      window_handle_ = nullptr;
      // Khai bao constructor Destroy de khoi tao doi tuong.
      Destroy();
      // Kiem tra dieu kien de re nhanh xu ly.
      if (quit_on_close_) {
        // Khai bao constructor PostQuitMessage de khoi tao doi tuong.
        PostQuitMessage(0);
      }
      // Tra ve ket qua cho noi goi ham.
      return 0;

    // Xu ly mot truong hop cu the trong switch.
    case WM_DPICHANGED: {
      // Thuc thi cau lenh hien tai theo luong xu ly.
      auto newRectSize = reinterpret_cast<RECT*>(lparam);
      // Thuc thi cau lenh hien tai theo luong xu ly.
      LONG newWidth = newRectSize->right - newRectSize->left;
      // Thuc thi cau lenh hien tai theo luong xu ly.
      LONG newHeight = newRectSize->bottom - newRectSize->top;

      // Goi ham de thuc thi tac vu can thiet.
      SetWindowPos(hwnd, nullptr, newRectSize->left, newRectSize->top, newWidth,
                   // Thuc thi cau lenh hien tai theo luong xu ly.
                   newHeight, SWP_NOZORDER | SWP_NOACTIVATE);

      // Tra ve ket qua cho noi goi ham.
      return 0;
    }
    // Xu ly mot truong hop cu the trong switch.
    case WM_SIZE: {
      // Thuc thi cau lenh hien tai theo luong xu ly.
      RECT rect = GetClientArea();
      // Kiem tra dieu kien de re nhanh xu ly.
      if (child_content_ != nullptr) {
        // Size and position the child window.
        // Goi ham de thuc thi tac vu can thiet.
        MoveWindow(child_content_, rect.left, rect.top, rect.right - rect.left,
                   // Thuc thi cau lenh hien tai theo luong xu ly.
                   rect.bottom - rect.top, TRUE);
      }
      // Tra ve ket qua cho noi goi ham.
      return 0;
    }

    // Xu ly mot truong hop cu the trong switch.
    case WM_ACTIVATE:
      // Kiem tra dieu kien de re nhanh xu ly.
      if (child_content_ != nullptr) {
        // Khai bao constructor SetFocus de khoi tao doi tuong.
        SetFocus(child_content_);
      }
      // Tra ve ket qua cho noi goi ham.
      return 0;

    // Xu ly mot truong hop cu the trong switch.
    case WM_DWMCOLORIZATIONCOLORCHANGED:
      // Khai bao constructor UpdateTheme de khoi tao doi tuong.
      UpdateTheme(hwnd);
      // Tra ve ket qua cho noi goi ham.
      return 0;
  }

  // Tra ve ket qua cho noi goi ham.
  return DefWindowProc(window_handle_, message, wparam, lparam);
}

// Thuc thi cau lenh hien tai theo luong xu ly.
void Win32Window::Destroy() {
  // Khai bao constructor OnDestroy de khoi tao doi tuong.
  OnDestroy();

  // Kiem tra dieu kien de re nhanh xu ly.
  if (window_handle_) {
    // Khai bao constructor DestroyWindow de khoi tao doi tuong.
    DestroyWindow(window_handle_);
    // Gan gia tri cho bien window_handle_.
    window_handle_ = nullptr;
  }
  // Kiem tra dieu kien de re nhanh xu ly.
  if (g_active_window_count == 0) {
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    WindowClassRegistrar::GetInstance()->UnregisterWindowClass();
  }
}

// Thuc thi cau lenh hien tai theo luong xu ly.
Win32Window* Win32Window::GetThisFromHandle(HWND const window) noexcept {
  // Tra ve ket qua cho noi goi ham.
  return reinterpret_cast<Win32Window*>(
      // Goi ham de thuc thi tac vu can thiet.
      GetWindowLongPtr(window, GWLP_USERDATA));
}

// Thuc thi cau lenh hien tai theo luong xu ly.
void Win32Window::SetChildContent(HWND content) {
  // Gan gia tri cho bien child_content_.
  child_content_ = content;
  // Khai bao constructor SetParent de khoi tao doi tuong.
  SetParent(content, window_handle_);
  // Thuc thi cau lenh hien tai theo luong xu ly.
  RECT frame = GetClientArea();

  // Goi ham de thuc thi tac vu can thiet.
  MoveWindow(content, frame.left, frame.top, frame.right - frame.left,
             // Thuc thi cau lenh hien tai theo luong xu ly.
             frame.bottom - frame.top, true);

  // Khai bao constructor SetFocus de khoi tao doi tuong.
  SetFocus(child_content_);
}

// Thuc thi cau lenh hien tai theo luong xu ly.
RECT Win32Window::GetClientArea() {
  // Thuc thi cau lenh hien tai theo luong xu ly.
  RECT frame;
  // Khai bao constructor GetClientRect de khoi tao doi tuong.
  GetClientRect(window_handle_, &frame);
  // Tra ve ket qua cho noi goi ham.
  return frame;
}

// Thuc thi cau lenh hien tai theo luong xu ly.
HWND Win32Window::GetHandle() {
  // Tra ve ket qua cho noi goi ham.
  return window_handle_;
}

// Thuc thi cau lenh hien tai theo luong xu ly.
void Win32Window::SetQuitOnClose(bool quit_on_close) {
  // Gan gia tri cho bien quit_on_close_.
  quit_on_close_ = quit_on_close;
}

// Khai bao bien Win32Window de luu du lieu su dung trong xu ly.
bool Win32Window::OnCreate() {
  // No-op; provided for subclasses.
  // Tra ve ket qua cho noi goi ham.
  return true;
}

// Thuc thi cau lenh hien tai theo luong xu ly.
void Win32Window::OnDestroy() {
  // No-op; provided for subclasses.
}

// Thuc thi cau lenh hien tai theo luong xu ly.
void Win32Window::UpdateTheme(HWND const window) {
  // Thuc thi cau lenh hien tai theo luong xu ly.
  DWORD light_mode;
  // Thuc thi cau lenh hien tai theo luong xu ly.
  DWORD light_mode_size = sizeof(light_mode);
  // Thuc thi cau lenh hien tai theo luong xu ly.
  LSTATUS result = RegGetValue(HKEY_CURRENT_USER, kGetPreferredBrightnessRegKey,
                               // Thuc thi cau lenh hien tai theo luong xu ly.
                               kGetPreferredBrightnessRegValue,
                               // Thuc thi cau lenh hien tai theo luong xu ly.
                               RRF_RT_REG_DWORD, nullptr, &light_mode,
                               // Thuc thi cau lenh hien tai theo luong xu ly.
                               &light_mode_size);

  // Kiem tra dieu kien de re nhanh xu ly.
  if (result == ERROR_SUCCESS) {
    // Khai bao bien enable_dark_mode de luu du lieu su dung trong xu ly.
    BOOL enable_dark_mode = light_mode == 0;
    // Goi ham de thuc thi tac vu can thiet.
    DwmSetWindowAttribute(window, DWMWA_USE_IMMERSIVE_DARK_MODE,
                          // Thuc thi cau lenh hien tai theo luong xu ly.
                          &enable_dark_mode, sizeof(enable_dark_mode));
  }
}
