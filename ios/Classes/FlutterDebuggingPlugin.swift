import Flutter
import UIKit
import Network

public class FlutterDebuggingPlugin: NSObject, FlutterPlugin {
    private let CHANNEL = "com.nexever/debugging"

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: registrar.messenger())
        let instance = FlutterDebuggingPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "isUsbDebuggingEnabled":
            result(isUsbDebuggingEnabled())
        case "isVpnConnected":
            result(isVpnConnected())
        case "isDeviceRooted":
            result(isDeviceRooted())
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func isUsbDebuggingEnabled() -> Bool {
        // iOS does not provide a direct way to check for USB debugging.
        // Implement necessary iOS-specific functionality or return false.
        return false
    }

    private func isVpnConnected() -> Bool {
        let monitor = NWPathMonitor()
        var isConnected = false
        let semaphore = DispatchSemaphore(value: 0)

        monitor.pathUpdateHandler = { path in
            isConnected = path.usesInterfaceType(.wifi) || path.usesInterfaceType(.cellular)
            semaphore.signal()
        }

        monitor.start(queue: DispatchQueue.global())
        _ = semaphore.wait(timeout: .distantFuture)

        return isConnected
    }

    private func isDeviceRooted() -> Bool {
        let fileManager = FileManager.default
        let paths = [
            "/Applications/Cydia.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt"
        ]

        for path in paths {
            if fileManager.fileExists(atPath: path) {
                return true
            }
        }

        return false
    }
}
