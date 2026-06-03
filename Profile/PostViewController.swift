//
//  PostViewController.swift
//  Navigation
//

import UIKit
import StorageService

final class PostViewController: UIViewController {
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = post?.author ?? "-"
        view.backgroundColor = .systemYellow
        
        // Исправлено: .done → .plain (или .done больше не рекомендуется)
        let barButton = UIBarButtonItem(
            title: "Info",
            style: .plain,           // ← исправлено
            target: self,
            action: #selector(tapInfoButton)
        )
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func tapInfoButton() {
        let infoVC = InfoViewController()
        present(infoVC, animated: true)
    }
}
