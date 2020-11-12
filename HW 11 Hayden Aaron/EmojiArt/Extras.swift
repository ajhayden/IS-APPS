//
//  Extras.swift
//  EmojiArt
//
//  Created by Student on 11/12/20.
//

import SwiftUI
import Combine

//    private func listFiles() {
//        let fileManager = FileManager.default
//        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        do {
//            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
//            print("FileURLs")
//            print(fileURLs)
//        } catch {
//            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
//        }
//    }
//
//    private func urlForFile(fileName: String) -> URL? {
//        return try? FileManager.default.url(
//            for: FileManager.SearchPathDirectory.documentDirectory,
//            in: .userDomainMask,
//            appropriateFor: nil,
//            create: true
//        )
//        .appendingPathComponent(fileName)
//        .appendingPathExtension("json")
//    }
//
//    private func writeEmojiFile(data: Data?, fileName: String) {
//        do {
//            if let url = urlForFile(fileName: fileName) {
//                if let fileData = data {
//                    try fileData.write(to: url, options: .atomic)
//                }
//            }
//        } catch {
//            print("There was an error with write")
//        }
//    }
//
//    private func readFileContents(fileName: String) -> Data? {
//        if let url = urlForFile(fileName: fileName) {
//            if let data = try? Data(contentsOf: url) {
//                return data
//            }
//        }
//        print("There was an error with read")
//        return nil
//    }

class ProximitySensorHelper: ObservableObject {
    @Published var proximityState = false
    @Published var proximityCount = 0
    
    private var proximityCancellable: AnyCancellable?
    
    init() {
        UIDevice.current.isProximityMonitoringEnabled = true
        
        if UIDevice.current.isProximityMonitoringEnabled {
            proximityCancellable = NotificationCenter.default
                .publisher(for: UIDevice.proximityStateDidChangeNotification)
                .sink { notification in
                    if let device = notification.object as? UIDevice {
                        self.proximityState = device.proximityState
                        
                        if device.proximityState {
                            self.proximityCount += 1
                        }
                    }
                    
                }
//            NotificationCenter.default.addObserver(
//                self,
//                selector: #selector(proximityStateDidChangeNotification),
//                name: UIDevice.proximityStateDidChangeNotification,
//                object: UIDevice.current
//            )
        }
    }
    
//    @objc private func proximityStateDidChangeNotification(notification: Notification) {
//        if let device = notification.object as? UIDevice {
//            self.proximityState = device.proximityState
//        }
//
//        if device.proximityState {
//
//        }
//    }
}

//@ObservedObject private var proximitySensorHelper = ProximitySensorHelper()
