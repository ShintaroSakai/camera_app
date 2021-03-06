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
        // カメラフォトライブラリーどちらから画像を取得するか選択
        let alertController = UIAlertController(title: "確認", message: "選択してください", preferredStyle: .actionSheet)

        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // カメラを起動するための選択肢を定義
            let cameraAction = UIAlertAction(title: "カメラ", style: .default, handler: { (action) in
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .camera
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }

        // フォトライブラリーが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // フォトライブラリーを起動するための選択肢を定義
            let photoLibraryAction = UIAlertAction(title: "フォトライブラリー", style: .default, handler: { (action) in
                //
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .photoLibrary
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }

        // キャンセルの選択肢を定義
        let cancelAction = UIAlertAction(title: "キャンセル", style: .default, handler: nil)
        alertController.addAction(cancelAction)

        // iPadで落ちてしまう対策
        alertController.popoverPresentationController?.sourceView = view

        // 選択肢を画面を表示
        present(alertController, animated: true, completion: nil)
    }

    // 終わった時に呼ばれるdelegateメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 撮影したが画像を配置したpictureImageに渡す
        captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        dismiss(animated: true, completion: {
            // エフェクト画面に遷移
            self.performSegue(withIdentifier: "showEffectView", sender: nil)
        })
    }
    
    // 次の画面に遷移するときに渡す画像を格納する場所
    var captureImage : UIImage?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 次の画面のインスタンスを格納
        if let nextViewConroller = segue.destination as? EffectViewController {
            nextViewConroller.originalImage = captureImage
        }
    }
}
