//
//  WriteViewController.swift
//  Diary
//
//  Created by SC on 2022/08/24.
//

import PhotosUI
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
        
        configureAddPhotoButton()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(closeButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
    }
    
    
    func configureAddPhotoButton() {
        let selectPhoto = UIAction(title: "사진 선택", image: UIImage(systemName: "photo.on.rectangle")) { _ in
            self.selectPhotoClicked()
        }
        
        let takePhoto = UIAction(title: "사진 찍기", image: UIImage(systemName: "camera")) { _ in
            self.takePhotoClicked()
        }
        
        let searchImage = UIAction(title: "사진 검색", image: UIImage(systemName: "magnifyingglass")) { _ in
            self.searchImageClicked()
        }
        
        let menu = UIMenu(title: "",
                          options: .displayInline,
                          children: [selectPhoto, takePhoto, searchImage])
        
        writeView.addPhotoButton.menu = menu
        writeView.addPhotoButton.showsMenuAsPrimaryAction = true
    }
    
    
    func selectPhotoClicked() {
        var configuration = PHPickerConfiguration()
//        var configuration = PHPickerConfiguration(photoLibrary: .shared())
//        configuration.selectionLimit = 1 // 기본값 1
        configuration.filter = .any(of: [.images, .livePhotos])
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        present(picker, animated: true)
    }
    
    
    func takePhotoClicked() {
        
    }
    
    
    func searchImageClicked() {
        
    }

    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    
    @objc func saveButtonClicked() {
        var title = writeView.titleTextField.text!      // 👻 빈 문자 확인하기
        title = title.trimmingCharacters(in: .whitespaces)  // ❔ whitespacesAndNewlines 안 해도 되는 이유? 리턴키를 눌러도 반영되지 않는 이유?
        guard !title.isEmpty else {
            showAlertMessage(title: "제목을 입력해 주세요")
            return
        }
//        let entryDate = writeView.dateTextField.text  // 👻 데이트피커 띄우기
        let contents = writeView.contentsTextView.text
//        let photoURL =
        
        let task = UserDiary(title: title, entryDate: .now, contents: contents, photoURL: nil)
        try! localRealm.write {
            localRealm.add(task)
        }
        print(Date())
        print(Date.now)
        print(Date.now.formatted())
        
        dismiss(animated: true)
    }
}


extension WriteViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let result = results.first
        
    }
}
