//
//  DiagramsViewController.swift
//  DFD
//
//  Created by Fred Dijkstra on 17/02/2023.
//

// ------------------------------------------------------------------------------------------------
import UIKit

// ------------------------------------------------------------------------------------------------
class DiagramsViewController: UIViewController
{
    // --------------------------------------------------------------------------------------------
    @IBOutlet weak var diagramFilesTableView : UITableView!
    
    // --------------------------------------------------------------------------------------------
    var diagramFiles : [String] = []
    weak var dataflowControl : DataflowControl!
    
    // --------------------------------------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        addDiagramAddedObserver()
        updateDiagramFileList()
    }
    
    // --------------------------------------------------------------------------------------------
    func addDiagramAddedObserver()
    {
        NotificationCenter.default.addObserver( forName: Notification.Name("Diagram added"),
        object: nil, queue: nil) { _ in self.updateDiagramFileList() }
    }
    
    // --------------------------------------------------------------------------------------------
    func updateDiagramFileList()
    {
        diagramFiles = getFileList(extensionString: ".dfd" )
        diagramFilesTableView.reloadData()
    }
    
    // --------------------------------------------------------------------------------------------
    func readDiagram(_ filename : String)
    {
        let json = readStringFromFile( filename )
        
        if dataflowControl.diagram.read( from: json! )
        {
            dataflowControl.diagramFile = filename
        }
        else
        {
            dataflowControl.diagramFile = ""
            print( "ERROR: invalid JSON!" )
            return
        }
    }
    
}
