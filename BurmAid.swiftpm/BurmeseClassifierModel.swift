//
// BurmeseCharacterClassifier.swift
//
// This file was automatically generated and should not be edited.
//

import CoreML


/// Model Prediction Input Type
@available(macOS 10.14, iOS 12.0, tvOS 12.0, *)
@available(watchOS, unavailable)
class BurmeseCharacterClassifierInput : MLFeatureProvider {
    
    /// image as color (kCVPixelFormatType_32BGRA) image buffer, 299 pixels wide by 299 pixels high
    var image: CVPixelBuffer
    
    var featureNames: Set<String> {
        get {
            return ["image"]
        }
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "image") {
            return MLFeatureValue(pixelBuffer: image)
        }
        return nil
    }
    
    init(image: CVPixelBuffer) {
        self.image = image
    }
    
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    convenience init(imageWith image: CGImage) throws {
        self.init(image: try MLFeatureValue(cgImage: image, pixelsWide: 299, pixelsHigh: 299, pixelFormatType: kCVPixelFormatType_32BGRA, options: nil).imageBufferValue!)
    }
    
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    convenience init(imageAt image: URL) throws {
        self.init(image: try MLFeatureValue(imageAt: image, pixelsWide: 299, pixelsHigh: 299, pixelFormatType: kCVPixelFormatType_32BGRA, options: nil).imageBufferValue!)
    }
    
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func setImage(with image: CGImage) throws  {
        self.image = try MLFeatureValue(cgImage: image, pixelsWide: 299, pixelsHigh: 299, pixelFormatType: kCVPixelFormatType_32BGRA, options: nil).imageBufferValue!
    }
    
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func setImage(with image: URL) throws  {
        self.image = try MLFeatureValue(imageAt: image, pixelsWide: 299, pixelsHigh: 299, pixelFormatType: kCVPixelFormatType_32BGRA, options: nil).imageBufferValue!
    }
    
}


/// Model Prediction Output Type
@available(macOS 10.14, iOS 12.0, tvOS 12.0, *)
@available(watchOS, unavailable)
class BurmeseCharacterClassifierOutput : MLFeatureProvider {
    
    /// Source provided by CoreML
    private let provider : MLFeatureProvider
    
    /// target as string value
    var target: String {
        return self.provider.featureValue(for: "target")!.stringValue
    }
    
    /// targetProbability as dictionary of strings to doubles
    var targetProbability: [String : Double] {
        return self.provider.featureValue(for: "targetProbability")!.dictionaryValue as! [String : Double]
    }
    
    var featureNames: Set<String> {
        return self.provider.featureNames
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        return self.provider.featureValue(for: featureName)
    }
    
    init(target: String, targetProbability: [String : Double]) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["target" : MLFeatureValue(string: target), "targetProbability" : MLFeatureValue(dictionary: targetProbability as [AnyHashable : NSNumber])])
    }
    
    init(features: MLFeatureProvider) {
        self.provider = features
    }
}


/// Class for model loading and prediction
@available(macOS 10.14, iOS 12.0, tvOS 12.0, *)
@available(watchOS, unavailable)
class BurmeseCharacterClassifier {
    let model: MLModel
    
    /// URL of model assuming it was installed in the same bundle as this class
    class var urlOfModelInThisBundle : URL {
        let resPath = Bundle(for: self).url(forResource: "BurmeseCharacterClassifier", withExtension: "mlmodel")!
        return try! MLModel.compileModel(at: resPath)
    }
    
    /**
     Construct BurmeseCharacterClassifier instance with an existing MLModel object.
     
     Usually the application does not use this initializer unless it makes a subclass of BurmeseCharacterClassifier.
     Such application may want to use `MLModel(contentsOfURL:configuration:)` and `BurmeseCharacterClassifier.urlOfModelInThisBundle` to create a MLModel object to pass-in.
     
     - parameters:
     - model: MLModel object
     */
    init(model: MLModel) {
        self.model = model
    }
    
    /**
     Construct BurmeseCharacterClassifier instance by automatically loading the model from the app's bundle.
     */
    @available(*, deprecated, message: "Use init(configuration:) instead and handle errors appropriately.")
    convenience init() {
        try! self.init(contentsOf: type(of:self).urlOfModelInThisBundle)
    }
    
    /**
     Construct a model with configuration
     
     - parameters:
     - configuration: the desired model configuration
     
     - throws: an NSError object that describes the problem
     */
    convenience init(configuration: MLModelConfiguration) throws {
        try self.init(contentsOf: type(of:self).urlOfModelInThisBundle, configuration: configuration)
    }
    
    /**
     Construct BurmeseCharacterClassifier instance with explicit path to mlmodelc file
     - parameters:
     - modelURL: the file url of the model
     
     - throws: an NSError object that describes the problem
     */
    convenience init(contentsOf modelURL: URL) throws {
        try self.init(model: MLModel(contentsOf: modelURL))
    }
    
    /**
     Construct a model with URL of the .mlmodelc directory and configuration
     
     - parameters:
     - modelURL: the file url of the model
     - configuration: the desired model configuration
     
     - throws: an NSError object that describes the problem
     */
    convenience init(contentsOf modelURL: URL, configuration: MLModelConfiguration) throws {
        try self.init(model: MLModel(contentsOf: modelURL, configuration: configuration))
    }
    
    /**
     Construct BurmeseCharacterClassifier instance asynchronously with optional configuration.
     
     Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.
     
     - parameters:
     - configuration: the desired model configuration
     - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
     */
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    class func load(configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<BurmeseCharacterClassifier, Error>) -> Void) {
        return self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration, completionHandler: handler)
    }
    
    /**
     Construct BurmeseCharacterClassifier instance asynchronously with optional configuration.
     
     Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.
     
     - parameters:
     - configuration: the desired model configuration
     */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    class func load(configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> BurmeseCharacterClassifier {
        return try await self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration)
    }
    
    /**
     Construct BurmeseCharacterClassifier instance asynchronously with URL of the .mlmodelc directory with optional configuration.
     
     Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.
     
     - parameters:
     - modelURL: the URL to the model
     - configuration: the desired model configuration
     - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
     */
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<BurmeseCharacterClassifier, Error>) -> Void) {
        MLModel.load(contentsOf: modelURL, configuration: configuration) { result in
            switch result {
            case .failure(let error):
                handler(.failure(error))
            case .success(let model):
                handler(.success(BurmeseCharacterClassifier(model: model)))
            }
        }
    }
    
    /**
     Construct BurmeseCharacterClassifier instance asynchronously with URL of the .mlmodelc directory with optional configuration.
     
     Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.
     
     - parameters:
     - modelURL: the URL to the model
     - configuration: the desired model configuration
     */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> BurmeseCharacterClassifier {
        let model = try await MLModel.load(contentsOf: modelURL, configuration: configuration)
        return BurmeseCharacterClassifier(model: model)
    }
    
    /**
     Make a prediction using the structured interface
     
     It uses the default function if the model uses multi-function description syntax.
     
     - parameters:
     - input: the input to the prediction as BurmeseCharacterClassifierInput
     
     - throws: an NSError object that describes the problem
     
     - returns: the result of the prediction as BurmeseCharacterClassifierOutput
     */
    func prediction(input: BurmeseCharacterClassifierInput) throws -> BurmeseCharacterClassifierOutput {
        return try self.prediction(input: input, options: MLPredictionOptions())
    }
    
    /**
     Make a prediction using the structured interface
     
     It uses the default function if the model uses multi-function description syntax.
     
     - parameters:
     - input: the input to the prediction as BurmeseCharacterClassifierInput
     - options: prediction options 
     
     - throws: an NSError object that describes the problem
     
     - returns: the result of the prediction as BurmeseCharacterClassifierOutput
     */
    func prediction(input: BurmeseCharacterClassifierInput, options: MLPredictionOptions) throws -> BurmeseCharacterClassifierOutput {
        let outFeatures = try model.prediction(from: input, options:options)
        return BurmeseCharacterClassifierOutput(features: outFeatures)
    }
    
    /**
     Make an asynchronous prediction using the structured interface
     
     It uses the default function if the model uses multi-function description syntax.
     
     - parameters:
     - input: the input to the prediction as BurmeseCharacterClassifierInput
     - options: prediction options 
     
     - throws: an NSError object that describes the problem
     
     - returns: the result of the prediction as BurmeseCharacterClassifierOutput
     */
    @available(macOS 14.0, iOS 17.0, tvOS 17.0, watchOS 10.0, *)
    func prediction(input: BurmeseCharacterClassifierInput, options: MLPredictionOptions = MLPredictionOptions()) async throws -> BurmeseCharacterClassifierOutput {
        let outFeatures = try await model.prediction(from: input, options:options)
        return BurmeseCharacterClassifierOutput(features: outFeatures)
    }
    
    /**
     Make a prediction using the convenience interface
     
     It uses the default function if the model uses multi-function description syntax.
     
     - parameters:
     - image: color (kCVPixelFormatType_32BGRA) image buffer, 299 pixels wide by 299 pixels high
     
     - throws: an NSError object that describes the problem
     
     - returns: the result of the prediction as BurmeseCharacterClassifierOutput
     */
    func prediction(image: CVPixelBuffer) throws -> BurmeseCharacterClassifierOutput {
        let input_ = BurmeseCharacterClassifierInput(image: image)
        return try self.prediction(input: input_)
    }
    
    /**
     Make a batch prediction using the structured interface
     
     It uses the default function if the model uses multi-function description syntax.
     
     - parameters:
     - inputs: the inputs to the prediction as [BurmeseCharacterClassifierInput]
     - options: prediction options 
     
     - throws: an NSError object that describes the problem
     
     - returns: the result of the prediction as [BurmeseCharacterClassifierOutput]
     */
    func predictions(inputs: [BurmeseCharacterClassifierInput], options: MLPredictionOptions = MLPredictionOptions()) throws -> [BurmeseCharacterClassifierOutput] {
        let batchIn = MLArrayBatchProvider(array: inputs)
        let batchOut = try model.predictions(from: batchIn, options: options)
        var results : [BurmeseCharacterClassifierOutput] = []
        results.reserveCapacity(inputs.count)
        for i in 0..<batchOut.count {
            let outProvider = batchOut.features(at: i)
            let result =  BurmeseCharacterClassifierOutput(features: outProvider)
            results.append(result)
        }
        return results
    }
}


