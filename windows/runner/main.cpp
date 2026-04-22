// Khai bao chi thi tien xu ly cho trinh bien dich.
#include <flutter/dart_project.h>
// Khai bao chi thi tien xu ly cho trinh bien dich.
#include <flutter/flutter_view_controller.h>
// Khai bao chi thi tien xu ly cho trinh bien dich.
#include <windows.h>

// Khai bao chi thi tien xu ly cho trinh bien dich.
#include "flutter_window.h"
// Khai bao chi thi tien xu ly cho trinh bien dich.
#include "utils.h"

// Khai bao bien APIENTRY de luu du lieu su dung trong xu ly.
int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      _In_ wchar_t *command_line, _In_ int show_command) {
  // Attach to console when present (e.g., 'flutter run') or create a
  // new console when running with a debugger.
  // Kiem tra dieu kien de re nhanh xu ly.
  if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
    // Khai bao constructor CreateAndAttachConsole de khoi tao doi tuong.
    CreateAndAttachConsole();
  }

  // Initialize COM, so that it is available for use in the library and/or
  // plugins.
  // Thuc thi cau lenh hien tai theo luong xu ly.
  ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
  flutter::DartProject project(L"data");

  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
  std::vector<std::string> command_line_arguments =
      // Khai bao constructor GetCommandLineArguments de khoi tao doi tuong.
      GetCommandLineArguments();

  // Thuc thi cau lenh hien tai theo luong xu ly.
  project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

  // Thuc thi cau lenh hien tai theo luong xu ly.
  FlutterWindow window(project);
  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
  Win32Window::Point origin(10, 10);
  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
  Win32Window::Size size(1280, 720);
  // Kiem tra dieu kien de re nhanh xu ly.
  if (!window.Create(L"quan_ly_ban_xe", origin, size)) {
    // Tra ve ket qua cho noi goi ham.
    return EXIT_FAILURE;
  }
  // Thuc thi cau lenh hien tai theo luong xu ly.
  window.SetQuitOnClose(true);

  // Thuc thi cau lenh hien tai theo luong xu ly.
  ::MSG msg;
  // Lap lai khoi lenh khi dieu kien con dung.
  while (::GetMessage(&msg, nullptr, 0, 0)) {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    ::TranslateMessage(&msg);
    // Thuc thi cau lenh hien tai theo luong xu ly.
    ::DispatchMessage(&msg);
  }

  // Thuc thi cau lenh hien tai theo luong xu ly.
  ::CoUninitialize();
  // Tra ve ket qua cho noi goi ham.
  return EXIT_SUCCESS;
}
