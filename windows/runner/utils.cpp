// Khai bao chi thi tien xu ly cho trinh bien dich.
#include "utils.h"

// Khai bao chi thi tien xu ly cho trinh bien dich.
#include <flutter_windows.h>
// Khai bao chi thi tien xu ly cho trinh bien dich.
#include <io.h>
// Khai bao chi thi tien xu ly cho trinh bien dich.
#include <stdio.h>
// Khai bao chi thi tien xu ly cho trinh bien dich.
#include <windows.h>

// Khai bao chi thi tien xu ly cho trinh bien dich.
#include <iostream>

// Dinh nghia ham CreateAndAttachConsole de xu ly nghiep vu tuong ung.
void CreateAndAttachConsole() {
  // Kiem tra dieu kien de re nhanh xu ly.
  if (::AllocConsole()) {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    FILE *unused;
    // Kiem tra dieu kien de re nhanh xu ly.
    if (freopen_s(&unused, "CONOUT$", "w", stdout)) {
      // Goi ham de thuc thi tac vu can thiet.
      _dup2(_fileno(stdout), 1);
    }
    // Kiem tra dieu kien de re nhanh xu ly.
    if (freopen_s(&unused, "CONOUT$", "w", stderr)) {
      // Goi ham de thuc thi tac vu can thiet.
      _dup2(_fileno(stdout), 2);
    }
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    std::ios::sync_with_stdio();
    // Khai bao constructor FlutterDesktopResyncOutputStreams de khoi tao doi tuong.
    FlutterDesktopResyncOutputStreams();
  }
}

// Thiet lap thuoc tinh cho doi tuong hoac giao dien.
std::vector<std::string> GetCommandLineArguments() {
  // Convert the UTF-16 command line arguments to UTF-8 for the Engine to use.
  // Khai bao bien argc de luu du lieu su dung trong xu ly.
  int argc;
  // Thuc thi cau lenh hien tai theo luong xu ly.
  wchar_t** argv = ::CommandLineToArgvW(::GetCommandLineW(), &argc);
  // Kiem tra dieu kien de re nhanh xu ly.
  if (argv == nullptr) {
    // Tra ve ket qua cho noi goi ham.
    return std::vector<std::string>();
  }

  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
  std::vector<std::string> command_line_arguments;

  // Skip the first argument as it's the binary name.
  // Lap qua tap du lieu theo dieu kien xac dinh.
  for (int i = 1; i < argc; i++) {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    command_line_arguments.push_back(Utf8FromUtf16(argv[i]));
  }

  // Thuc thi cau lenh hien tai theo luong xu ly.
  ::LocalFree(argv);

  // Tra ve ket qua cho noi goi ham.
  return command_line_arguments;
}

// Thiet lap thuoc tinh cho doi tuong hoac giao dien.
std::string Utf8FromUtf16(const wchar_t* utf16_string) {
  // Kiem tra dieu kien de re nhanh xu ly.
  if (utf16_string == nullptr) {
    // Tra ve ket qua cho noi goi ham.
    return std::string();
  }
  // Thuc thi cau lenh hien tai theo luong xu ly.
  unsigned int target_length = ::WideCharToMultiByte(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      CP_UTF8, WC_ERR_INVALID_CHARS, utf16_string,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      -1, nullptr, 0, nullptr, nullptr)
    // Thuc thi cau lenh hien tai theo luong xu ly.
    -1; // remove the trailing null character
  // Khai bao bien input_length de luu du lieu su dung trong xu ly.
  int input_length = (int)wcslen(utf16_string);
  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
  std::string utf8_string;
  // Kiem tra dieu kien de re nhanh xu ly.
  if (target_length == 0 || target_length > utf8_string.max_size()) {
    // Tra ve ket qua cho noi goi ham.
    return utf8_string;
  }
  // Thuc thi cau lenh hien tai theo luong xu ly.
  utf8_string.resize(target_length);
  // Khai bao bien converted_length de luu du lieu su dung trong xu ly.
  int converted_length = ::WideCharToMultiByte(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      CP_UTF8, WC_ERR_INVALID_CHARS, utf16_string,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      input_length, utf8_string.data(), target_length, nullptr, nullptr);
  // Kiem tra dieu kien de re nhanh xu ly.
  if (converted_length == 0) {
    // Tra ve ket qua cho noi goi ham.
    return std::string();
  }
  // Tra ve ket qua cho noi goi ham.
  return utf8_string;
}
