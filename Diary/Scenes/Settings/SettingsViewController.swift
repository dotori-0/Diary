//
//  SettingsViewController.swift
//  Diary
//
//  Created by SC on 2022/08/27.
//

import UIKit

import Zip
import UniformTypeIdentifiers

class SettingsViewController: BaseViewController {
    
    // MARK: - Properties
    
    let settingsView = SettingsView()
    
    var backupFileNames: [String] = [] {
        didSet {
            settingsView.tableView.reloadData()
        }
    }
    
    
    // MARK: - Functions
    
    override func loadView() {
        view = settingsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        title = "타이틀"  // Tab Bar Title
        fetchBackupFiles()
    }

    override func setUI() {
        super.setUI()
        print(self, #function)
        
        settingsView.navigationBar.delegate = self
        settingsView.tableView.dataSource = self
        settingsView.tableView.delegate = self
        settingsView.tableView.register(BackupFileTableViewCell.self, forCellReuseIdentifier: BackupFileTableViewCell.reuseIdentifier)
    }
    
    override func setConstraints() {
    }
    
    override func setActions() {
        settingsView.backupButton.addTarget(self, action: #selector(backupButtonClicked), for: .touchUpInside)
        settingsView.bringBackupFileButton.addTarget(self, action: #selector(bringBackupFileButtonClicked), for: .touchUpInside)
    }
    
    func fetchBackupFiles() {
        if let backupFileNames = fetchDiaryFilesFromDocuments() {
            self.backupFileNames = backupFileNames
        }
    }
    
    @objc func backupButtonClicked() {
        var urlPaths = [URL]()  // 백업할 파일의 배열
        
        // 1. 도큐먼트 위치에 백업 파일이 있는지 확인
//        guard let documentsPath = getDocumentsDirectoryPath() else {
//            showAlertMessage(title: "앱 내 도큐먼트 위치에 오류가 있습니다.")
//            return
//        }
        guard let documentsPath = getDocumentsDirectoryPath() else { return }
        
        let realmFilePath = documentsPath.appendingPathComponent("default.realm")  // 렘 파일 경로 가져오기
        
        // realm 파일 존재 여부 확인
        guard FileManager.default.fileExists(atPath: realmFilePath.path) else {  // 👻 (atPath:isDirectory) 써 보기
            showAlertMessage(title: "백업할 파일이 없습니다.")
            return
        }
        
        urlPaths.append(realmFilePath)  //  urlPaths.append(URL(string: realmFile.path)!)와 동일
        
        // 2. 백업 파일을 압축: URL (오픈소스 활용)
        do {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd_HH:mm:ss"
//            formatter.dateFormat = "yyyy-MM-dd_HH:mm:ss"
//            formatter.dateFormat = "yyyy-MM-dd_HH.mm.ss"
            print(formatter.string(from: Date.now))
            let fileName = formatter.string(from: Date.now)
            
            var isValidExtension = Zip.isValidFileExtension("diary")
            print("isValidExtension: \(isValidExtension)")
            Zip.addCustomFileExtension("diary")
            isValidExtension = Zip.isValidFileExtension("diary")
            print("isValidExtension: \(isValidExtension)")
            
//            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: fileName)  // 👻 quickZipFiles의 progress 파라미터 써 보기
            let zipFilePath = documentsPath.appendingPathComponent("\(fileName).diary")
            try Zip.zipFiles(paths: urlPaths, zipFilePath: zipFilePath, password: nil, progress: { progress in
                print(progress)
            })

            print("Archive Location: \(zipFilePath)")

            showAlertMessage(title: "백업 완료", message: "백업이 완료되었습니다.\n 백업 파일을 안전한 곳으로 내보내 주세요!") { _ in
                self.showActivityViewController(backupFileURL: zipFilePath)
//                self.settingsView.tableView.reloadData()
                self.fetchBackupFiles()
            }
        } catch let error {
            showAlertMessage(title: "백업 파일 압축에 실패했습니다.")
            print(error)
        }
    }
    
    func showActivityViewController(backupFileURL: URL) {
        let activityVC = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
        present(activityVC, animated: true)
    }
    
    @objc func bringBackupFileButtonClicked() {
        let diaryUTType = UTType("com.app.diary")!
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [diaryUTType], asCopy: true)  // 지정한 타입 재외하고 선택 비활성화 | asCopy: 가져 왔을 때 파일앱에서 파일이 날아가거나 하지 않게
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        
        self.present(documentPicker, animated: true)
        
    }
}


extension SettingsViewController: UIDocumentPickerDelegate {
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        // 선택한 파일의 URL
        guard let selectedFileURL = urls.first else {  // 실패할 가능성은 적지만 가져오는 와중에 파일 앱에 들어가서 파일을 삭제한다거나 할 수 있기 때문에
            showAlertMessage(title: "선택하신 파일을 찾을 수 없습니다.")
            return
        }
        
        guard let documentsDirectoryPath = getDocumentsDirectoryPath() else { return }
        
        // Sandbox-Documents에 저장할 위치 + 파일명
        let sandboxFileURL = documentsDirectoryPath.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        // Sandbox-Documents에 이미 있는 파일인지 확인
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            showAlertMessage(title: "이미 Diary 앱 내에 존재하는 파일입니다.")
        } else {
            do {
                // 파일 앱의 백업 파일 -> 도큐먼트 폴더에 복사
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                fetchBackupFiles()
                showAlertMessage(title: "백업 파일을 성공적으로 가져왔습니다.")  // 👻 토스트로 바꾸기
            } catch let error {
                print(error)
            }
        }
    }
}


extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return backupFileNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BackupFileTableViewCell.reuseIdentifier) as? BackupFileTableViewCell else {
            print("Cannot find BackupFileTableViewCell")
            return UITableViewCell()
        }
        
        cell.fileNameLabel.text = backupFileNames[indexPath.row]
        cell.fileSizeLabel.text = "파일 크기"
        print(cell.fileIconImageView.frame.height)
        print(cell.fileIconImageView.frame.width)
        
        return cell
    }
}


extension SettingsViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
