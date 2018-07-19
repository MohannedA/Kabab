/*
 QRScannerViewController
 */
/*
import AVFoundation
import UIKit
import SnapKit

// MARK: ~ QRScannerDelegate
protocol QRScannerDelegate: class {
    /*To get the string code value*/
    func getCodeStringValue(_ codeStringValue: String)
    /*To set the preview view of the code scanner*/
    func setPreviewView() -> UIView
    /*To draw bounding squares*/
    func drawBoundingSquares(codeStringValue: String) -> (label: String?, labelPosition: SquareLabelPositions, labelColor: UIColor?, color: CGColor?)?
    /*To get code bounds*/
    func getCodeBounds(_ codeBounds: CGRect, _ codeStringValue: String)
}

// MARK: ~ SquareLabelPositions Enum
enum SquareLabelPositions: String {
    case Top, Center, Bottom
}


open class QRScannerView: UIView, AVCaptureMetadataOutputObjectsDelegate {
    // MARK: ~ Variables
    var video = AVCaptureVideoPreviewLayer()
    var previewView = UIView()
    private let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
                                      AVMetadataObject.ObjectType.code39,
                                      AVMetadataObject.ObjectType.code39Mod43,
                                      AVMetadataObject.ObjectType.code93,
                                      AVMetadataObject.ObjectType.code128,
                                      AVMetadataObject.ObjectType.ean8,
                                      AVMetadataObject.ObjectType.ean13,
                                      AVMetadataObject.ObjectType.aztec,
                                      AVMetadataObject.ObjectType.pdf417,
                                      AVMetadataObject.ObjectType.itf14,
                                      AVMetadataObject.ObjectType.dataMatrix,
                                      AVMetadataObject.ObjectType.interleaved2of5,
                                      AVMetadataObject.ObjectType.qr]

    // Define square view variables.
    var squareView = UIView()
    var squareLabel: String?
    var squareLabelPosition: SquareLabelPositions = .Top
    var squareLabelColor: UIColor?
    var squareColor: CGColor?
    
    // Define delegate variable.
    weak var delegate: QRScannerDelegate?
    
    // MARK: ~ Life Cycle
    
    // MARK: ~ Inits
    public override init(frame: CGRect) {
        super.init(frame: frame)
        // Create session.
        let session = AVCaptureSession()
        
        // Get the back-facing camera for capturing videos.
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        
        // Define capture devcie.
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get the camera device")
            return
        }
        
        // Set up the input of the QR scanner.
        do
        {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        }
        catch
        {
            print ("QR scanner cannot get the input.")
        }
        
        // Set up the output of the QR scanner.
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = supportedCodeTypes
        
        // Add the set session to the preview layer.
        video = AVCaptureVideoPreviewLayer(session: session)
        // Set the preview view.
        previewView = (delegate?.setPreviewView())!
        // Set the size of the video.
        video.videoGravity = AVLayerVideoGravity.resizeAspectFill
        // Make the video(preview view) size = the main view size.
        video.frame = previewView.layer.bounds
        // Add the created viedo(preview view) to the main view.
        previewView.layer.addSublayer(video)
        
        // Start running the camera.
        session.startRunning()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: ~ QR Scanner Methods
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        cleanScreen(superView: self.previewView) // Clear from the old bounding squares.
        // If there is a code.
        if metadataObjects.count != 0
        {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
            {
                // If the detected code is QR code.
                if supportedCodeTypes.contains(object.type)
                {
                    // Use code stringValue.
                    delegate?.getCodeStringValue(object.stringValue!)
                    let barCodeObject = self.video.transformedMetadataObject(for: object)
                    // Use code bounds.
                    delegate?.getCodeBounds((barCodeObject?.bounds)!, object.stringValue!)
                    setSquareView(code: object, barCodeObject: barCodeObject!) // The code bounding square.
                }
            }
        }
    }
    
    // MARK: ~ Private Methods
    private func cleanScreen(superView: UIView) {
        for view in superView.subviews {
            // Check if it is square view or not.
            if let viewWithTag = view.viewWithTag(100), view == viewWithTag {
                view.removeFromSuperview()
            }
            // Check if it is square label view or not.
            if let viewWithTag = view.viewWithTag(200), view == viewWithTag {
                view.removeFromSuperview()
            }
            
        }
    }
    
    private func setSquareView(code: AVMetadataMachineReadableCodeObject, barCodeObject: AVMetadataObject) {
        // Get square properties.
        guard let (squareLabel, squareLabelPosition, squareLabelColor, squareColor) = (delegate?.drawBoundingSquares(codeStringValue: code.stringValue!)) else { // If there are no bounding square properties.
            return
        }
        // Initialize square view to highlight the QR code.
        squareView = UIView()
        squareView.tag = 100
        previewView.addSubview(squareView)
        squareView.layer.borderWidth = 2
        squareView.frame = barCodeObject.bounds
        // Set up the square label if there is.
        if squareLabel != "" {
            let label = UILabel()
            label.tag = 200
            label.text = squareLabel
            label.textColor = squareLabelColor ?? UIColor.black
            previewView.addSubview(label)
            // Set up the label position.
            switch squareLabelPosition {
            case .Top:
                label.snp.makeConstraints{(make) in
                    make.top.equalTo(squareView.snp.top).offset(-25)
                    make.centerX.equalTo(squareView.snp.centerX)
                }
            case .Center:
                label.snp.makeConstraints{(make) in
                    make.centerY.equalTo(squareView.snp.centerY)
                    make.centerX.equalTo(squareView.snp.centerX)
                }
            case .Bottom:
                label.snp.makeConstraints{(make) in
                    make.bottom.equalTo(squareView.snp.bottom).offset(25)
                    make.centerX.equalTo(squareView.snp.centerX)
                }
            }
            
        }
        // Set up the new sqaure color if there is, otherwise set the default color.
        squareView.layer.borderColor = squareColor ?? UIColor.darkGray.cgColor
        // Add the created square view to the preview view.
        previewView.bringSubview(toFront: squareView)
    }
}
*/
