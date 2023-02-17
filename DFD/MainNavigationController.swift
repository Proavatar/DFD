//
//  MainNavigationController.swift
//  DFD
//
//  Created by Fred Dijkstra on 17/02/2023.
//

import UIKit
import DataflowDiagramSDK

// ------------------------------------------------------------------------------------------------
class MainNavigationController: UINavigationController, VariableOutputUpdatesReceiver
{
    var dataflowControl : DataflowControl!
    
    // --------------------------------------------------------------------------------------------
    weak var sensorViewController : SensorViewController!
    weak var processViewController : ProcessViewController!

    // --------------------------------------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        dataflowControl = DataflowControl(delegate: self)
    }
    
    // --------------------------------------------------------------------------------------------
    func newVariableOutputUpdates(_ output: DataflowDiagramOutput  )
    {
        dataflowControl.diagramOutputs.append( output )
        sensorViewController.newDiagramOutput( output )
    }
    
    // --------------------------------------------------------------------------------------------
    func allUpdatesProcessed(_ outputs: [DataflowDiagramOutput] )
    {
        dataflowControl.diagramOutputs = outputs
        processViewController.allUpdatesProcessed()
    }

}
