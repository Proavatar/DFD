//
//  DataViewController.swift
//  DFD
//
//  Created by Fred Dijkstra on 17/02/2023.
//

// ------------------------------------------------------------------------------------------------
import UIKit
import DataflowDiagramSDK

// ------------------------------------------------------------------------------------------------
class DataViewController: UIViewController
{

    // --------------------------------------------------------------------------------------------
    @IBOutlet weak var dataFilesTableView : UITableView!
    
    // --------------------------------------------------------------------------------------------
    var dataFiles : [String] = []
    weak var dataflowControl : DataflowControl!
    
    // --------------------------------------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }

    // --------------------------------------------------------------------------------------------
    func addDataFileAddedObserver()
    {
        NotificationCenter.default.addObserver( forName: Notification.Name("Data file added"),
        object: nil, queue: nil) { _ in self.updateDataFileList() }
    }
    
    // --------------------------------------------------------------------------------------------
    func updateDataFileList()
    {
        dataFiles = getFileList(extensionString: ".jsonl" )
        dataFilesTableView.reloadData()
    }
    
    // --------------------------------------------------------------------------------------------
    func processDataFile(_ filename: String )
    {
        let jsonLines = readStringFromFile( filename )
        dataflowControl.diagramInputs = readDataflowDiagramInputs( from: jsonLines! )
        dataflowControl.dataFile = filename
    }

}
