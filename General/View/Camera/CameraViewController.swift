//
//  CameraViewController.swift
//  recPag
//
//  Created by Isaac Douglas on 10/02/19.
//  Copyright © 2019 Isaac Douglas. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    var qrCodeFrameView: UIView?
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var delegate: StreamDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Pagar"
        navigationItem.largeTitleDisplayMode = .never
        
        camInitialize()
    }
    
    func camInitialize(){
        
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
        
        // Initialize QR Code Frame to highlight the QR code
        qrCodeFrameView = UIView()
        
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubviewToFront(qrCodeFrameView)
        }
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
        
        qrCodeFrameView?.frame = CGRect.zero
    }
    
    func found(code: String) {
        do {
            let data = code.data(using: .utf8)
            let payment = try JSONDecoder().decode(Payment.self, from: data!)
            
            let alert = UIAlertController(title: Localized.confirmPayment, message: "R$\(payment.valor)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Localized.ok, style: .default) { alert in
                
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                let datas = try! encoder.encode(payment)
                print(String(data: datas, encoding: .utf8)!)
                
                self.request(value: payment.valor, destination: payment.destino)
                
                self.delegate?.stream(text: code)
                self.backAction()
            })
            alert.addAction(UIAlertAction(title: Localized.cancel, style: .cancel) { alert in
                self.backAction()
            })
            present(alert, animated: true, completion: nil)
        } catch {
            print("Error")
        }
    }
    
    func request(value: String, destination: String) {
        let payment = Payment()
        payment.valor = "\(value)"
        payment.origem = Constants.id
        payment.destino = destination
        payment.descricao = "R$\(value)"
        
        Requester.postRequest(url: Constants.urlPayment, payment: payment, onError: {_ in
            print("Error")
        }, onSucess: {_ in
            print("Sucess")
        })
    }

}

extension CameraViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        // If the found metadata is equal to the QR code metadata (or barcode) then update the status label's text and set the bounds
        let barCodeObject = previewLayer?.transformedMetadataObject(for: metadataObj)
        qrCodeFrameView?.frame = barCodeObject!.bounds
    }
}
