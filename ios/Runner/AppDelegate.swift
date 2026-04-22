// Nap thu vien hoac module can thiet.
import Flutter
// Nap thu vien hoac module can thiet.
import UIKit

// Khai bao annotation cho phan tu ben duoi.
@main
// Khai bao annotation cho phan tu ben duoi.
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  // Thuc thi cau lenh hien tai theo luong xu ly.
  override func application(
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _ application: UIApplication,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  // Thuc thi cau lenh hien tai theo luong xu ly.
  ) -> Bool {
    // Tra ve ket qua cho noi goi ham.
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // Dinh nghia ham didInitializeImplicitFlutterEngine de xu ly nghiep vu tuong ung.
  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
