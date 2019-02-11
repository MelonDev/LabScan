//
//  ScanViewController.swift
//  LabScan
//
//  Created by Android on 18/1/2562 BE.
//  Copyright © 2562 Android. All rights reserved.
//

import UIKit
import AVFoundation
import ARKit
import SceneKit
import CoreML
import Vision

class ScanViewController: UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate{
    
    
    @IBOutlet weak var collectMasterView: UIView!
    @IBOutlet weak var previewView: PreviewView!
    @IBOutlet weak var mlSwitch: UISwitch!
    
    var slot :ArraySlice<VNClassificationObservation> = []
    
    
    
    let configuration = ARWorldTrackingConfiguration()
    let augmentedRealitySession = ARSession()
    var timer :Timer?
    var time :Int = 0
    var swiML :Bool = true
    
    let alert = UIAlertController(title: nil, message: "กรุณารอสักครู่...", preferredStyle: .alert)
    
    
    @IBAction func cancelAction(_ sender: Any) {
        MainConfig.init().dismissAction(viewController: self)
    }
    
    private let session = AVCaptureSession()
    private var isSessionRunning = false
    private let sessionQueue = DispatchQueue(label: "Camera Session Queue", attributes: [], target: nil)
    private var permissionGranted = false
    
    //let captureSession = AVCaptureSession()
    //var previewLayer: CALayer!
    //var captureDevice :AVCaptureDevice!
    
    @IBOutlet weak var ScanCollection: UICollectionView!
    
    
    var model: VNCoreMLModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem.titleView?.hero.id = "TITLE"
        
        ScanCollection.register(UINib.init(nibName: "ScanVIewCell", bundle: nil), forCellWithReuseIdentifier: "ScanCVC")
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        layout.itemSize = CGSize(width: 250, height: ScanCollection.bounds.height - 10)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 15
        ScanCollection.collectionViewLayout = layout
        
        ScanCollection.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
        /*
         let flowLayout = UPCarouselFlowLayout()
         flowLayout.itemSize = CGSize(width: 200, height: ScanCollection.bounds.height)
         flowLayout.scrollDirection = .horizontal
         
         flowLayout.sideItemScale = 1.0
         flowLayout.sideItemAlpha = 1.0
         flowLayout.sideItemShift = 0.0
         flowLayout.spacingMode = .fixed(spacing: 0.0)
         ScanCollection.collectionViewLayout = flowLayout
         */
        
        self.loadCameraView()
        self.loadModel()
        
        startTimer()
        
        
        ScanCollection.delegate = self
        ScanCollection.dataSource = self
        
        
        //showLoadingDialog()
        
        //print("Test3")
        //showLoadingDialog()
        
        
        let config = MainConfig()
        config.initVC(viewController: self)
        
        
        
        /*
         DispatchQueue.global(qos: .background).async {
         //self.showLoadingDialog()
         
         self.loadModel()
         
         DispatchQueue.main.async {
         
         self.loadCameraView()
         
         
         //self.stopLoadingDialog()
         }
         }
         */
        
        
        
        
        //let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        //let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //blurEffectView.frame = view.bounds
        
        //self.view.insertSubview(blurEffectView, at: 1)
        
        //self.navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        self.navigationController?.navigationBar.tintColor = UIColor.blue
        //self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont(name: "SukhumvitSet-Bold", size: 21)!]
        
        self.navigationItem.title = "สแกนอุปกรณ์"
        
        
        
        ShotButtonSetup()
        
        //prepareCamera()
        
        
    }
    
    func startTimer() {
        if timer == nil {
            time = 0
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.loop), userInfo: nil, repeats: true)
            
        }
    }
    
    func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
            time = 0
            swiML = true
        }
    }
    
    @objc func loop() {
        if(self.mlSwitch.isOn){
            time += 1
            if(swiML){
                swiML = false
            }else {
                swiML = true
            }
        }else {
            swiML = false
        }
        
        
        //print(time)
        
    }
    
    func ShotButtonSetup() {
        //shotVEV.layer.borderWidth = 2
        //shotVEV.layer.borderColor = UIColor.white.cgColor
        //shotVEV.roundCorner(corners: [.topLeft, .topRight ,.bottomLeft,.bottomRight], radius: 20)
    }
    
    
    func showLoadingDialog() {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func stopLoadingDialog() {
        MainConfig.init().dismissAction(viewController: alert)
        
    }
    
    func dismissLoadingDialog() {
        alert.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //print("Test2")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //stopTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //print("TEST")
        
        

        
        self.sessionQueue.async {
            self.session.startRunning()
            self.isSessionRunning = self.session.isRunning
            
        }
        
        self.navigationItem.largeTitleDisplayMode = .never
        
        MainConfig.init().lightStatusBar(animated: animated)
    }
    
    func loadCameraView(){
        
        //self.previewView.videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        //self.previewView.session = session
        
        self.previewView.isHidden = false
        
        let preview = PreviewView(frame:CGRect(x: 0,y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        preview.backgroundColor = UIColor.black
        
        preview.videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        preview.session = session
        
        self.view.insertSubview(preview, at: 0)
        
        
        
        
        self.checkPermission()
        
        self.sessionQueue.async { [unowned self] in
            self.configureSession()
        }
        
    }
    
    private func checkPermission() {
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
        case .authorized:
            self.permissionGranted = true
        case .notDetermined:
            self.requestPermission()
        default:
            self.permissionGranted = false
        }
    }
    
    // Request permission if not given
    private func requestPermission() {
        sessionQueue.suspend()
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { [unowned self] granted in
            self.permissionGranted = granted
            self.sessionQueue.resume()
        }
    }
    
    private func configureSession() {
        guard permissionGranted else { return }
        
        self.session.beginConfiguration()
        self.session.sessionPreset = .hd1920x1080
        
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back) else { return }
        guard let captureDeviceInput = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        guard self.session.canAddInput(captureDeviceInput) else { return }
        self.session.addInput(captureDeviceInput)
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sample buffer"))
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String : kCVPixelFormatType_32BGRA]
        videoOutput.alwaysDiscardsLateVideoFrames = true
        guard self.session.canAddOutput(videoOutput) else { return }
        self.session.addOutput(videoOutput)
        
        self.session.commitConfiguration()
        videoOutput.setSampleBufferDelegate(self, queue: sessionQueue)
    }
    
    
    private func loadModel() {
        
        
        model = try? VNCoreMLModel(for: Inceptionv3().model)
        //model = try? VNCoreMLModel(for: Inceptionv3().model)
        //model = try? VNCoreMLModel(for: MobileNet().model)
        
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // TODO: Do ML Here
        
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        
        
        if(model != nil){
            
            let request = VNCoreMLRequest(model: model!, completionHandler: { [weak self] request, error in
                //processClassifications(for: request, error: error)
                
                self!.processClassifications(for: request, error: error)
                
            })
            
            try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
            
        }else {
            print("Not found Model")
        }
        
        /*let request = VNCoreMLRequest(model: model!) {
         
         
         (finishedReq, err) in
         guard let results = finishedReq.results as? [VNClassificationObservation] else { return }
         
         
         
         
         guard let firstObservation = results.first else { return }
         
         DispatchQueue.main.async {
         self.classLabel.text = firstObservation.identifier
         
         //self.confidenceLabel.text = NSString(format: "%.4f", firstObservation.confidence) as String
         }
         
         
         
         }
         
         */
        
        
        
        
    }
    
    func processClassifications(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            
            if(self.swiML){
                self.swiML = false
                
                guard let results = request.results else {
                    //self.classLabel.text = "Unable to classify image.\n\(error!.localizedDescription)"
                    print("Unable to classify image.\n\(error!.localizedDescription)")
                    return
                }
                // The `results` will always be `VNClassificationObservation`s, as specified by the Core ML model in this project.
                let classifications = results as! [VNClassificationObservation]
                
                self.slot = classifications.prefix(5)
                self.ScanCollection.reloadData()

                
                /*
                 if classifications.isEmpty {
                 print("Nothing recognized.")
                 //self.classLabel.text = "Nothing recognized."
                 } else {
                 // Display top classifications ranked by confidence in the UI.
                 let topClassifications = classifications.prefix(2)
                 
                 
                 let descriptions = topClassifications.map { classification in
                 //Formats the classification for display; e.g. "(0.37) cliff, drop, drop-off".
                 
                 return String(format: "  (%.2f) %@", classification.confidence*100, classification.identifier)
                 
                 
                 
                 
                 
                 }
                 
                 
                 
                 
                 
                 print(descriptions.joined(separator: "\n"))
                 
                 //self.classLabel.isHidden = true
                 //self.classLabel.text =  descriptions.joined(separator: "\n")
                 }
                 */
                
                
                /*if let collectionView = self.collectionMainView {
                 collectionView.reloadData()
                 }
                 
                 if(!self.stopProcess){
                 
                 
                 guard let results = request.results else {
                 self.classLabel.text = "Unable to classify image.\n\(error!.localizedDescription)"
                 return
                 }
                 // The `results` will always be `VNClassificationObservation`s, as specified by the Core ML model in this project.
                 let classifications = results as! [VNClassificationObservation]
                 
                 self.slot = classifications.prefix(5)
                 
                 if classifications.isEmpty {
                 self.classLabel.text = "Nothing recognized."
                 } else {
                 // Display top classifications ranked by confidence in the UI.
                 let topClassifications = classifications.prefix(2)
                 
                 
                 let descriptions = topClassifications.map { classification in
                 //Formats the classification for display; e.g. "(0.37) cliff, drop, drop-off".
                 
                 return String(format: "  (%.2f) %@", classification.confidence*100, classification.identifier)
                 
                 
                 }
                 self.classLabel.isHidden = true
                 //self.classLabel.text =  descriptions.joined(separator: "\n")
                 }
                 }
                 */
            }
        }
    }
    
    
}

extension ScanViewController :UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let arr = Array(slot)
        var arrs :Array<String> = Array()
        for i in arr {
            if(i.confidence > 0.1){
                arrs.append("ITEM")
            }
        }
        
        
        if(arrs.count > 0){
            self.collectMasterView.isHidden = false

        }else {
            self.collectMasterView.isHidden = true
        }
        
        return arrs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = ScanCollection.dequeueReusableCell(withReuseIdentifier: "ScanCVC", for: indexPath) as! ScanVIewCell
        
        var arr = Array(slot)
        let fullName = arr[indexPath.row].identifier.characters.split{$0 == ","}.map(String.init)[0]

        
        cell.titleName.text = fullName
        cell.percentage.text = String(format: "%.0f", arr[indexPath.row].confidence*100) + "%"
        
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width  = (view.frame.width-20)/3
        return CGSize(width: width, height: width)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
   
            let vc = MainConfig().requireViewController(storyboard: CallCenter.init().AppStoryboard, viewController: CallCenter.init().DetailViewController) as! DetailViewController
            MainConfig().actionNavVC(this: self, viewController: vc)
        
        
        
    }
    
    
    
}



