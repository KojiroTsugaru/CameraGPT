//
//  ScannerView.swift
//  Camera GPT
//
//  Created by KJ on 1/6/23.
//

import SwiftUI
import VisionKit

struct ScannerView: UIViewControllerRepresentable {
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(completion: completionHandler)
    }

    final class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        private let completionHandler: ([String]?) -> Void
        init (completion: @escaping ([String]?) -> Void) {
            self.completionHandler = completion
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            let recognizer = TextRecognizer(cameraScan: scan)
            recognizer.recognizeText(withCompletionHandler: completionHandler)
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            completionHandler(nil)
        }
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            completionHandler(nil)
        }
    }
            
            
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let ViewController = VNDocumentCameraViewController()
        ViewController.delegate = context.coordinator
        return ViewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
    }
    
    typealias UIViewControllerType = VNDocumentCameraViewController
    
    private let completionHandler: ([String]?) -> Void
    
    init(completion: @escaping ([String]?) -> Void) {
        self.completionHandler = completion
    }
    
}


//struct ScannerView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScannerView(completion: <#T##([String]?) -> Void#>)
//    }
//}
