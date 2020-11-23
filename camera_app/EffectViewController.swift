//
//  EffectViewController.swift
//  camera_app
//
//  Created by 酒井 慎太郎 on 2020/11/23.
//  Copyright © 2020 酒井 慎太郎. All rights reserved.
//

import UIKit

class EffectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        effectImage.image = originalImage
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // エフェクト前の画像
    // 前の画面より画像を設定
    var originalImage : UIImage?
    
    @IBOutlet weak var effectImage: UIImageView!
    
    let filterArray = ["CIPhotoEffectMeno",     // モノクロ
                       "CIPhotoEffectChrome",   // Chrome
                       "CIPhotoEffectFade",     // Fade
                       "CIPhotoEffectInstant",  // Instant
                       "CIPhotoEffectNoir",     // Noir
                       "CIPhotoEffectProcess",  // Process
                       "CIPhotoEffectTonal",    // Tonal
                       "CIPhotoEffectTransfer", // Transfer
                       "CISepaTone"             // Sepa Tone
    ]
    
    var filterSelectNumber = 0
    
    @IBAction func effectButtonAction(_ sender: Any) {
        // 元の画像をアンラップしてエフェクト用画像として取り出す
        if let image = originalImage {
            // フィルタ名を指定
            let filterName = filterArray[filterSelectNumber]
            // エフェクト添字更新
            filterSelectNumber += 1
            // 添字と配列Keyと一致しているか確認
            if filterSelectNumber == filterArray.count {
                filterSelectNumber = 0
            }
            // 元々の画像の回転角度を取得
            let rotate = image.imageOrientation
            // UIImageをCIImageに変換
            let inputImage = CIImage(image: image)
            // フィルターの種別を引数で指定されたし種類を指定してCIFilterのインスタンスを取得
            guard let effectFilter = CIFilter(name: filterName) else {
                return
            }
            // エフェクトのパラメータを初期化
            effectFilter.setDefaults()
            // インスタンスにエフェクトする元画像を指定
            effectFilter.setValue(inputImage, forKey: kCIInputImageKey)
            // エフェクト後のCIImage形式の画像を取り出す
            guard let outputImage = effectFilter.outputImage else {
                return
            }
            //
            let ciContext = CIContext(options: nil)
            //
            guard let cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) else {
                return
            }
            //
            effectImage.image = UIImage(cgImage: cgImage, scale: 1.0, orientation: rotate)
        }
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        // 表示さ画像をアンラップしてシェア画像を取り出す
        if let shareImage = effectImage.image {
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
    
    @IBAction func closeButtonAction(_ sender: Any) {
        // モーダルビューを閉じる
        dismiss(animated: true, completion: nil)
    }
}
