//
//  SettingsViewController.swift
//  DFD
//
//  Created by Fred Dijkstra on 23/02/2023.
//

// ------------------------------------------------------------------------------------------------
import UIKit
import DataflowDiagramSDK

// ------------------------------------------------------------------------------------------------
class SettingsViewController: UIViewController
{
    // --------------------------------------------------------------------------------------------
    @IBOutlet weak var diagramFileLabel   : UILabel!
    @IBOutlet weak var constantsTableView : UITableView!
    
    // --------------------------------------------------------------------------------------------
    weak var  dataflowControl : DataflowControl!
    var constants : [(label:String, value:Any)] = []
    
    // --------------------------------------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    
    // --------------------------------------------------------------------------------------------
    func fillConstants()
    {
        constants = dataflowControl.diagram.getConstants()
        constantsTableView.reloadData()
    }

}
