//
//  MyCollectionViewCell.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2020/06/07.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit
import Kingfisher

final class MyCollectionViewCell: UICollectionViewCell {

  static var nib: UINib { UINib.init(nibName: String(describing: MyCollectionViewCell.self), bundle: nil) }
//  static var reuseIdentifier: String { String(describing: MyCollectionViewCell.self) }

  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var icon: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
    configureView()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    configureView()
  }

  private func configureView() {
    titleLabel.text = ""
    titleLabel.isHidden = true
    icon.image = nil
    icon.isHidden = true
  }

  func configure(sampleModel: SampleModel) {

    if let title = sampleModel.title, title.count > 0 {
      titleLabel.text = title
      titleLabel.isHidden = false
    }

    if let iconUrlStr = sampleModel.iconUrlStr,
      let iconUrl = URL.init(string: iconUrlStr) {
      icon.kf.setImage(with: iconUrl)
      icon.isHidden = false
    }

    //値が決まってからlayoutをちゃんと更新する
    layoutIfNeeded()
  }

  func loadNib() {
    
  }
}
