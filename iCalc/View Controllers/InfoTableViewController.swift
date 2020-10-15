//
//  InfoTableViewController.swift
//  Complex Calc
//
//  Created by Дмитрий Селезнев on 05.07.2020.
//  Copyright © 2020 Дмитрий Селезнев. All rights reserved.
//

import UIKit
import CoreData

var roundingValue = 2

class InfoTableViewController: UITableViewController {
    
    
    @IBOutlet weak var currentRoundingView: UIView!
  
    
    @IBOutlet weak var currentRounding: UILabel!

    let coreData = CoreDataMethods.shared
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        currentRounding.text = "\(roundingValue)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        currentRounding.text = "\(roundingValue)"
        currentRoundingView.layer.cornerRadius = currentRoundingView.bounds.height / 6
        currentRoundingView.layer.borderWidth = 1
        currentRoundingView.layer.borderColor = #colorLiteral(red: 0.3529411765, green: 0.7843137255, blue: 0.9803921569, alpha: 1)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            roundingAlert()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    //    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "Rounding")
    //
    //        // Configure the cell...
    //
    //        return cell!
    //    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    
    
}

extension InfoTableViewController {
    private func roundingAlert() {
        let alert = UIAlertController(title: "Current rounding value is \(roundingValue)",
            message: "Enter the new value",
            preferredStyle: .alert)
        var roundingTextField: UITextField!
        
        let apply = UIAlertAction(title: "Apply", style: .default) { _ in
            guard let text = roundingTextField.text else { return }
            guard let num = Int(text) else { return }
            roundingValue = num
            self.currentRounding.text = "\(roundingValue)"
            self.currentRoundingView.layer.borderColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
            self.coreData.saveRoundingValue(roundingValue: roundingValue)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(apply)
        
        alert.addTextField { (textField) in
            roundingTextField = textField
            roundingTextField.keyboardType = .numberPad
            textField.delegate = self
        }
        
        alert.addAction(cancel)
        present(alert, animated: true)
        
    }
}

extension InfoTableViewController: UITextFieldDelegate {
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updateText = currentText.replacingCharacters(in: stringRange, with: string)
        if textField.text!.count > 0 {
            textField.text?.removeFirst()
        }
        return updateText.count <= 2
    }
    
    
}

