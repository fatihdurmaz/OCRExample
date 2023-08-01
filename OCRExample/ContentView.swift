//
//  ContentView.swift
//  OCRExample
//
//  Created by Fatih Durmaz on 24.07.2023.
//

import SwiftUI
import ImageOCRUI

struct ContentView: View {
    @State private var texts: [ScannedText] = []
    @State private var showScannerSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                List(texts) { text in
                    Text(text.scannedText)
                }
            }
            .navigationTitle("OCR Image to Text")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Tara") {
                        texts.removeAll()
                        showScannerSheet = true
                    }
                    .sheet(isPresented: $showScannerSheet) {
                        self.createScannerView()
                    }
                }
            }
        }
    }
    
    private func createScannerView() -> ScannerView {
        ScannerView(completion: { detectedTextPerPage in
            if let concatenatedText = detectedTextPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines) {
                let scannedData = ScannedText(scannedText: concatenatedText)
                self.texts.append(scannedData)
            }
            self.showScannerSheet = false
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
