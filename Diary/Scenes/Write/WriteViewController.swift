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

        print("Realm is located at:", localRealm.configuration.fileURL!)
    }
    
    
    override func setUI() {
        super.setUI()
        
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
        var title = writeView.titleTextField.text!
        title = title.trimmingCharacters(in: .whitespaces)  // ❔ whitespacesAndNewlines 안 해도 되는 이유? 리턴키를 눌러도 반영되지 않는 이유?
        guard !title.isEmpty else {
            showAlertMessage(title: "제목을 입력해 주세요")
            return
        }
//        let entryDate = writeView.dateTextField.text  // 👻 데이트 픽커 띄우기
        let contents = writeView.contentsTextView.text
//        let photoURL =
        
        let task = UserDiary(title: title, entryDate: .now, contents: contents, photoURL: nil)
        // 👻 do-catch 문 적용하기
        try! localRealm.write {
            localRealm.add(task)
        }
        print(Date())
        print(Date.now)
        print(Date.now.formatted())
        
        if let image = writeView.imageView.image {
            let fileName = "\(task.objectId).jpg"
            
            saveImageToDocuments(fileName: fileName, image: image)
        }
        
        dismiss(animated: true)
    }
}


extension WriteViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        guard let result = results.first else {
            showAlertMessage(title: "이미지 선택에 실패하였습니다.")
            // 👻 Attempt to present <UIAlertController: 0x14184e400> on <UINavigationController: 0x143025c00> (from <Diary.WriteViewController: 0x13fd07660>) which is already presenting <PHPickerViewController: 0x13d8566e0>.
            return
        }
        
        let itemProvider = result.itemProvider
        
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    guard let image = image as? UIImage else {
                        self.showAlertMessage(title: "이미지 로드에 실패하였습니다.")
                        return
                    }
                    self.writeView.imageView.image = image
                    self.dismiss(animated: true)
                }
            }
        } else {
            showAlertMessage(title: "이미지 로드에 실패하였습니다.")
        }
    }
}
