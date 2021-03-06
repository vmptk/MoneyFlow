//
//  FilePickeri.swift
//  iosApp (iOS)
//
//  Created by Marco Gomiero on 18/10/2020.
//

import Foundation
import SwiftUI
import MobileCoreServices
import UniformTypeIdentifiers


struct FilePickerController: UIViewControllerRepresentable {
    var callback: (URL) -> ()
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<FilePickerController>) {
        // Update the controller
    }
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        print("Making the picker")
//        let controller = UIDocumentPickerViewController(documentTypes: [String(kUTTypeText)], in: .open)
        
        let supportedTypes: [UTType] = [UTType.item]
        let controller = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)

        
        controller.delegate = context.coordinator
        print("Setup the delegate \(context.coordinator)")
        
        return controller
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: FilePickerController
        
        init(_ pickerController: FilePickerController) {
            self.parent = pickerController
            print("Setup a parent")
            print("Callback: \(parent.callback)")
        }
       
//        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//            print("Selected a document: \(didPickDocumentsAt[0])")
////            parent.callback(didPickDocumentsAt[0])
//        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            print("her")
            print(urls[0])
            self.parent.callback(urls[0])
        }
        
        func documentPickerWasCancelled() {
            print("Document picker was thrown away :(")
        }
        
        deinit {
            print("Coordinator going away")
        }
    }
}
