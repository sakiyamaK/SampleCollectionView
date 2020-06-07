//
//  SampleCollectionViewCell.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2020/06/06.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit

final class Sample1CollectionViewCell: UICollectionViewCell {

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

    if let iconUrlStr = sampleModel.iconUrlStr, iconUrlStr.count > 0 {
      icon.isHidden = false
    }
  }
}
