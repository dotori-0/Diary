//
//  WriteViewController.swift
//  Diary
//
//  Created by SC on 2022/08/24.
//

import UIKit

class WriteViewController: UIViewController {
    
    let writeView = WriteView()
    
    override func loadView() {
        self.view = writeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
