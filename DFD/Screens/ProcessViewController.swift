//
//  ProcessViewController.swift
//  DFD
//
//  Created by Fred Dijkstra on 17/02/2023.
//

// ------------------------------------------------------------------------------------------------
import UIKit
import DataflowDiagramSDK

// ------------------------------------------------------------------------------------------------
class ProcessViewController: UIViewController
{
    // --------------------------------------------------------------------------------------------
    @IBOutlet weak var diagramFileLabel : UILabel!
    @IBOutlet weak var dataFileLabel : UILabel!
    @IBOutlet weak var diagramOutputTextView : UITextView!
    
    // --------------------------------------------------------------------------------------------
    weak var  dataflowControl : DataflowControl!

    // --------------------------------------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        diagramFileLabel.text = dataflowControl.diagramFile
        dataFileLabel.text    = dataflowControl.dataFile
    }
    
    // --------------------------------------------------------------------------------------------
    @IBAction func processButtonPressed(_ sender: Any)
    {
        dataflowControl.diagram.processAllUpdates( diagramInputs: dataflowControl.diagramInputs )
    }
    
    // --------------------------------------------------------------------------------------------
    func allUpdatesProcessed()
    {
        for diagramOutput in dataflowControl.diagramOutputs
        {
            for name in diagramOutput.outputs.keys
            {
                let value = diagramOutput.outputs[name]!
                let valueString = getValueString( value )
                diagramOutputTextView.text.append( "\(diagramOutput.timestamp),\(name),\(valueString)\n" )
            }
        }
    }

}
