//
//  SensorViewController.swift
//  DFD
//
//  Created by Fred Dijkstra on 17/02/2023.
//

import UIKit
import DataflowDiagramSDK
import CoreMotion
import simd

let updateRate : Double = 60.0

// ------------------------------------------------------------------------------------------------
class SensorViewController: UIViewController
{
    // --------------------------------------------------------------------------------------------
    @IBOutlet weak var recordingButton       : UIButton!
    @IBOutlet weak var diagramFileLabel      : UILabel!
    @IBOutlet weak var diagramOutputTextView : UITextView!
    
    // --------------------------------------------------------------------------------------------
    weak var  dataflowControl : DataflowControl!
    var sampleTimer : Timer?
    var recording : Bool = false
    var startTimestamp : TimeInterval = 0
    var motionManager : CMMotionManager?

    // --------------------------------------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        diagramFileLabel.text = dataflowControl.diagramFile
        initMotionTracker()
    }
    
    // --------------------------------------------------------------------------------------------
    @IBAction func recordingButtonPressed(_ sender: Any)
    {
        if recording
        {
            recordingButton.setTitle("Start", for: .normal)
            stopRecording()
            return
        }
        recordingButton.setTitle("Stop", for: .normal)
        startRecording()
    }
    
    // --------------------------------------------------------------------------------------------
    func startRecording()
    {
        dataflowControl.diagramInputs = []
        dataflowControl.diagram.reset()
        startTimestamp =  CFAbsoluteTimeGetCurrent()
        startMotionTracking()
        recording = true
        
    }
    
    // --------------------------------------------------------------------------------------------
    func stopRecording()
    {
        sampleTimer!.invalidate()
        motionManager!.stopDeviceMotionUpdates()
        createRecording()
    }
    
    // --------------------------------------------------------------------------------------------
    func initMotionTracker()
    {
        motionManager = CMMotionManager()
    }
    
    // --------------------------------------------------------------------------------------------
    func startMotionTracking()
    {
        motionManager!.startDeviceMotionUpdates( using: .xArbitraryCorrectedZVertical )
        sampleTimer = Timer( timeInterval: 1/updateRate,
                             target: self,
                             selector: #selector(sampleTimerExpired),
                             userInfo: nil, repeats: true )
    }
    
    // --------------------------------------------------------------------------------------------
    @objc func sampleTimerExpired()
    {
        let data : CMDeviceMotion? = motionManager!.deviceMotion
        if data == nil { return }
        
        let timestamp = CFAbsoluteTimeGetCurrent() - startTimestamp
        
        let q : CMQuaternion = data!.attitude.quaternion
        let a : CMAcceleration = data!.userAcceleration
        
        let orientation = simd_quatd( ix: q.x, iy: q.y, iz: q.z, r: q.w)
        let acceleration = simd_double3( x: a.x, y: a.y, z: a.z )
        
        newMeasurement( timestamp: timestamp, orientation: orientation, acceleration: acceleration )
    }
    
    // --------------------------------------------------------------------------------------------
    func newMeasurement( timestamp: TimeInterval, orientation: simd_quatd, acceleration: simd_double3 )
    {
        let updatesDictionary : [String:Any] = ["Orientation": orientation, "Acceleration": acceleration]
        let diagramInput = DataflowDiagramInput(timestamp: timestamp, updates: updatesDictionary)
        
        dataflowControl.diagram.updateInputStreams( diagramInput )
        dataflowControl.diagramInputs.append( diagramInput )
    }
    
    // --------------------------------------------------------------------------------------------
    func newDiagramOutput(_ diagramOutput: DataflowDiagramOutput )
    {
        for name in diagramOutput.outputs.keys
        {
            let value = diagramOutput.outputs[name]!
            let valueString = getValueString( value )
            diagramOutputTextView.text.append( "\(diagramOutput.timestamp),\(name),\(valueString)\n" )
        }
    }
    
    // --------------------------------------------------------------------------------------------
    func createRecording()
    {
        //let timeOffset = dataflowControl.diagramInputs[0].
        let jsonLines = createJsonLines( from: dataflowControl.diagramInputs )
        let filename = getDataFilename()
        writeStringToFile( filename: filename, contents: jsonLines )
    }
    

}
