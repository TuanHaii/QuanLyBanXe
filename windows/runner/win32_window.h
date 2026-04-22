// Khai bao chi thi tien xu ly cho trinh bien dich.
#ifndef RUNNER_WIN32_WINDOW_H_
// Khai bao chi thi tien xu ly cho trinh bien dich.
#define RUNNER_WIN32_WINDOW_H_

// Khai bao chi thi tien xu ly cho trinh bien dich.
#include <windows.h>

// Khai bao chi thi tien xu ly cho trinh bien dich.
#include <functional>
// Khai bao chi thi tien xu ly cho trinh bien dich.
#include <memory>
// Khai bao chi thi tien xu ly cho trinh bien dich.
#include <string>

// A class abstraction for a high DPI-aware Win32 Window. Intended to be
// inherited from by classes that wish to specialize with custom
// rendering and input handling
// Dinh nghia lop Win32Window de gom nhom logic lien quan.
class Win32Window {
 // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
 public:
  // Thuc thi cau lenh hien tai theo luong xu ly.
  struct Point {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    unsigned int x;
    // Thuc thi cau lenh hien tai theo luong xu ly.
    unsigned int y;
    // Goi ham de thuc thi tac vu can thiet.
    Point(unsigned int x, unsigned int y) : x(x), y(y) {}
  };

  // Thuc thi cau lenh hien tai theo luong xu ly.
  struct Size {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    unsigned int width;
    // Thuc thi cau lenh hien tai theo luong xu ly.
    unsigned int height;
    // Goi ham de thuc thi tac vu can thiet.
    Size(unsigned int width, unsigned int height)
        // Thuc thi cau lenh hien tai theo luong xu ly.
        : width(width), height(height) {}
  };

  // Khai bao constructor Win32Window de khoi tao doi tuong.
  Win32Window();
  // Thuc thi cau lenh hien tai theo luong xu ly.
  virtual ~Win32Window();

  // Creates a win32 window with |title| that is positioned and sized using
  // |origin| and |size|. New windows are created on the default monitor. Window
  // sizes are specified to the OS in physical pixels, hence to ensure a
  // consistent size this function will scale the inputted width and height as
  // as appropriate for the default monitor. The window is invisible until
  // |Show| is called. Returns true if the window was created successfully.
  // Khai bao bien Create de luu du lieu su dung trong xu ly.
  bool Create(const std::wstring& title, const Point& origin, const Size& size);

  // Show the current window. Returns true if the window was successfully shown.
  // Khai bao bien Show de luu du lieu su dung trong xu ly.
  bool Show();

  // Release OS resources associated with window.
  // Thuc thi cau lenh hien tai theo luong xu ly.
  void Destroy();

  // Inserts |content| into the window tree.
  // Thuc thi cau lenh hien tai theo luong xu ly.
  void SetChildContent(HWND content);

  // Returns the backing Window handle to enable clients to set icon and other
  // window properties. Returns nullptr if the window has been destroyed.
  // Thuc thi cau lenh hien tai theo luong xu ly.
  HWND GetHandle();

  // If true, closing this window will quit the application.
  // Thuc thi cau lenh hien tai theo luong xu ly.
  void SetQuitOnClose(bool quit_on_close);

  // Return a RECT representing the bounds of the current client area.
  // Thuc thi cau lenh hien tai theo luong xu ly.
  RECT GetClientArea();

 // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
 protected:
  // Processes and route salient window messages for mouse handling,
  // size change and DPI. Delegates handling of these to member overloads that
  // inheriting classes can handle.
  // Thuc thi cau lenh hien tai theo luong xu ly.
  virtual LRESULT MessageHandler(HWND window,
                                 // Thuc thi cau lenh hien tai theo luong xu ly.
                                 UINT const message,
                                 // Thuc thi cau lenh hien tai theo luong xu ly.
                                 WPARAM const wparam,
                                 // Thuc thi cau lenh hien tai theo luong xu ly.
                                 LPARAM const lparam) noexcept;

  // Called when CreateAndShow is called, allowing subclass window-related
  // setup. Subclasses should return false if setup fails.
  // Thuc thi cau lenh hien tai theo luong xu ly.
  virtual bool OnCreate();

  // Called when Destroy is called.
  // Thuc thi cau lenh hien tai theo luong xu ly.
  virtual void OnDestroy();

 // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
 private:
  // Thuc thi cau lenh hien tai theo luong xu ly.
  friend class WindowClassRegistrar;

  // OS callback called by message pump. Handles the WM_NCCREATE message which
  // is passed when the non-client area is being created and enables automatic
  // non-client DPI scaling so that the non-client area automatically
  // responds to changes in DPI. All other messages are handled by
  // MessageHandler.
  // Khai bao bien LRESULT de luu du lieu su dung trong xu ly.
  static LRESULT CALLBACK WndProc(HWND const window,
                                  // Thuc thi cau lenh hien tai theo luong xu ly.
                                  UINT const message,
                                  // Thuc thi cau lenh hien tai theo luong xu ly.
                                  WPARAM const wparam,
                                  // Thuc thi cau lenh hien tai theo luong xu ly.
                                  LPARAM const lparam) noexcept;

  // Retrieves a class instance pointer for |window|
  // Khai bao bien Win32Window de luu du lieu su dung trong xu ly.
  static Win32Window* GetThisFromHandle(HWND const window) noexcept;

  // Update the window frame's theme to match the system theme.
  // Khai bao bien void de luu du lieu su dung trong xu ly.
  static void UpdateTheme(HWND const window);

  // Khai bao bien quit_on_close_ de luu du lieu su dung trong xu ly.
  bool quit_on_close_ = false;

  // window handle for top level window.
  // Thuc thi cau lenh hien tai theo luong xu ly.
  HWND window_handle_ = nullptr;

  // window handle for hosted content.
  // Thuc thi cau lenh hien tai theo luong xu ly.
  HWND child_content_ = nullptr;
};

// Khai bao chi thi tien xu ly cho trinh bien dich.
#endif  // RUNNER_WIN32_WINDOW_H_
