//
//  ViewController.swift
//  camera_app
//
//  Created by 酒井 慎太郎 on 2020/11/15.
//  Copyright © 2020 酒井 慎太郎. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var pictureImage: UIImageView!

    @IBAction func cameraButtonAction(_ sender: Any) {
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("カメラは利用できます")
            //　UIImagePickerControllerインスタンスを作成
            let imagePickerController = UIImagePickerController()
            // sourceTypeにカメラを設定
            imagePickerController.sourceType = .camera
            // delegate設定
            imagePickerController.delegate = self
            // モーダルビューで表示
            present(imagePickerController, animated: true, completion: nil)
        } else {
            print("カメラは利用できません")
        }
    }

    @IBAction func shareButtonAction(_ sender: Any) {
        // 表示さ画像をアンラップしてシェア画像を取り出す
        if let shareImage = pictureImage.image {
            // UIActivityViewControllerに渡す配列を作成
            let shareItems = [shareImage]
            // UIActivityViewControllerにシェア画像を渡す
            let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            // iPadで落ちてしまう対策
            controller.popoverPresentationController?.sourceView = view
            // UIActivityViewControllerの表示
            present(controller, animated: true, completion: nil)
        }
    }

    // 終わった時に呼ばれるdelegateメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 撮影したが画像を配置したpictureImageに渡す
        pictureImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        // モーダルビューを閉じる
        dismiss(animated: true, completion: nil)
    }
}
