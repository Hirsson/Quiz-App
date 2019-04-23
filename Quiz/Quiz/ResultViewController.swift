//
//  ResultViewController.swift
//  Quiz
//
//  Created by Axel Hirszson on 4/22/19.
//  Copyright © 2019 Axel Hirszson. All rights reserved.
//

import UIKit

protocol ResultViewControllerProtocol {
    func resultViewDismissed()
    
}

class ResultViewController: UIViewController {

    
    var delagete:ResultViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Set rounded corners for the dialog view
        dialogView.layer.cornerRadious = 10
        
    }
    
    func setPopup(withTitle:String, withMessage:String, withAction:String) {
        
        resultLabel.text = withTitle
        feedbackLabel.text = withMEssage
        dismissButton.setTitle(withAction, for: .normal)
    
    }
    
    override func didReaceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any recources that can be recreated.
    }
    
    ---->  func dismissTapped(_ sender: UIButton) {
        
        
        
        
        dimiss(animated: true, campletion: {
            
            // Clear the labels
            self.resultLabel.text = ""
            self.feedbackLabel.text = ""
            
        })
        
        delagate?.resultViewDismissed()
        
    }
 
 }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
