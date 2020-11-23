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
    
    @IBAction func effectButtonAction(_ sender: Any) {
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        // モーダルビューを閉じる
        dismiss(animated: true, completion: nil)
    }
}
