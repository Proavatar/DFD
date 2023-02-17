//
//  DataflowControl.swift
//  DFD
//

import Foundation
import DataflowDiagramSDK

// ------------------------------------------------------------------------------------------------
class DataflowControl
{
    var diagramFile    : String?
    var dataFile       : String?
    var diagram        : DataflowDiagram
    var diagramInputs  : [DataflowDiagramInput]
    var diagramOutputs : [DataflowDiagramOutput]
    
    // --------------------------------------------------------------------------------------------
    init( delegate : VariableOutputUpdatesReceiver )
    {
        diagram = DataflowDiagram( variableOutputUpdatesReceiver: delegate )
        diagramInputs  = []
        diagramOutputs = []
    }
}

