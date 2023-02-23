//
//  EditConstantViewController.swift
//  DFD
//
//  Created by Fred Dijkstra on 23/02/2023.
//

// ------------------------------------------------------------------------------------------------
import UIKit
import DataflowDiagramSDK

// ------------------------------------------------------------------------------------------------
class EditConstantViewController: UIViewController
{
    // --------------------------------------------------------------------------------------------
    @IBOutlet weak var constantLabel : UILabel!
    @IBOutlet weak var valueTextView : UITextView!
    
    // --------------------------------------------------------------------------------------------
    weak var  dataflowControl : DataflowControl!
    var constant : (label:String, value:Any)!
    
    // --------------------------------------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setValueTextView()
    }
    
    // --------------------------------------------------------------------------------------------
    @IBAction func cancelButtonPressed(_ sender: Any)
    {
        
    }
    
    // --------------------------------------------------------------------------------------------
    @IBAction func saveButtonPressed(_ sender: Any)
    {
        setConstantValue()
        
        
    }
    
    // --------------------------------------------------------------------------------------------
    func setValueTextView()
    {
        valueTextView.text = getValueString( constant.value )
    }
    
    // --------------------------------------------------------------------------------------------
    func setConstantValue()
    {
        setValueFromString( value: &constant.value, string: valueTextView.text! )
        dataflowControl.diagram.setConstant( label:constant.label, newValue: constant.value )
    }

}
