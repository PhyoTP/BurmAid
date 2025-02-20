import SwiftUI
import PencilKit
import CoreML
import UIKit
import Vision

struct CanvasView: UIViewRepresentable {
    @Binding var drawing: PKDrawing
    func makeUIView(context: Context) -> PKCanvasView {
        let canvasView = PKCanvasView()
        // Allow finger drawing
        canvasView.drawingPolicy = .anyInput
        canvasView.delegate = context.coordinator
        return canvasView
    }
    
    func updateUIView(_ canvasView: PKCanvasView, context: Context) {
        if drawing != canvasView.drawing {
            canvasView.drawing = drawing
        }
    }
    class Coordinator: NSObject, PKCanvasViewDelegate {
        var drawing: Binding<PKDrawing>
        
        init(drawing: Binding<PKDrawing>) {
            self.drawing = drawing
        }
        
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            drawing.wrappedValue = canvasView.drawing
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(drawing: $drawing)
    }
}

struct DrawView: View{
    @State private var drawing = PKDrawing()
    @State private var classificationLabel: String = "Classified result will appear here!"
    var body: some View{
        ZStack{
            CanvasView(drawing: $drawing)
            VStack{
                Text(classificationLabel)
                Spacer()
                HStack{
                    Spacer()
                    Button{
                        drawing = PKDrawing()
                    }label: {
                        Image(systemName: "eraser.fill")
                    }
                    Button("Submit") {
                        for stroke in drawing.strokes {
                            print("Stroke color: \(stroke.ink.color)")
                        }
                        
                        let size = CGSize(width: 500, height: 500)
                        let image = drawing.image(from: CGRect(origin: .zero, size: size), scale: 1.0)
                        
                        
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                        
                        do {
                            let modelConfiguration = MLModelConfiguration()
                            let model = try VNCoreMLModel(for: BurmeseCharacterClassifier(configuration: modelConfiguration).model)
                            
                            let request = VNCoreMLRequest(model: model) { (request, error) in
                                if let results = request.results as? [VNClassificationObservation], let topResult = results.first {
                                    self.classificationLabel = "Classification: \(topResult.identifier) (\(Int(topResult.confidence * 100))%)"
                                } else {
                                    self.classificationLabel = "Could not classify image."
                                }
                            }
                            if let cgImage = image.cgImage {
                                let handler = VNImageRequestHandler(cgImage: cgImage)
                                try? handler.perform([request])
                            }else{
                                print("no")
                            }
                        } catch {
                            classificationLabel = "Could not load model: \(error.localizedDescription)"
                        }
                    }
                }
                .padding()
                .font(.largeTitle)
            }
        }
        .frame(width: 500, height: 500)
    }
}

#Preview{
    DrawView()
}


// Function to add a background to the image
func imageWithBackground(image: UIImage, size: CGSize, backgroundColor: UIColor) -> UIImage {
    let renderer = UIGraphicsImageRenderer(size: size)
    return renderer.image { context in
        backgroundColor.setFill()
        context.fill(CGRect(origin: .zero, size: size))
        image.draw(in: CGRect(origin: .zero, size: size))
    }
}

