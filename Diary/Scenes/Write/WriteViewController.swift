//
//  WriteViewController.swift
//  Diary
//
//  Created by SC on 2022/08/24.
//

import UIKit

import RealmSwift


class WriteViewController: BaseViewController {
    
    let writeView = WriteView()
    let localRealm = try! Realm()
    
    override func loadView() {
        self.view = writeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUI() {
        writeView.backgroundColor = Constants.Color.backgroundColor
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(closeButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
    }

    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func saveButtonClicked() {
        let title = writeView.titleTextField.text!     // 👻 빈 문자 확인하기
//        let entryDate = writeView.dateTextField.text  // 👻 데이트피커 띄우기
        let contents = writeView.contentsTextView.text
//        let photoURL =
        
        let task = UserDiary(title: title, entryDate: .now, contents: contents, photoURL: nil)
        try! localRealm.write {
            localRealm.add(task)
        }
        print(task)
        
        dismiss(animated: true)
    }
}
