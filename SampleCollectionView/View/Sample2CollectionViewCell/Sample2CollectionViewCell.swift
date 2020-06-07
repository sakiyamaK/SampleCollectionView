//
//  Sample2CollectionViewCell.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2020/06/06.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit

final class Sample2CollectionViewCell: UICollectionViewCell {
//  private static let mockReviewCell: Sample2CollectionViewCell = UINib.init(nibName: "Sample2CollectionViewCell", bundle: nil).instantiate(withOwner: self, options: nil).first as! Sample2CollectionViewCell

  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var icon: UIImageView!
  @IBOutlet private weak var descriptionLabel: UILabel!

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
    descriptionLabel.text = ""
    descriptionLabel.isHidden = true
  }

  func configure(sampleModel: SampleModel) {

    if let title = sampleModel.title, title.count > 0 {
      titleLabel.text = title
      titleLabel.isHidden = false
    }

    if let iconUrlStr = sampleModel.iconUrlStr, iconUrlStr.count > 0 {
      icon.isHidden = false
    }

    if let description = sampleModel.description, description.count > 0 {
      descriptionLabel.text = description
      descriptionLabel.isHidden = false
    }
  }

  static func calcSize(width: CGFloat, sampleModel: SampleModel) -> CGSize {
    return CGSize(width: 100, height: 100)
//    mockReviewCell.frame.size.width = width
//    mockReviewCell.layoutIfNeeded()
//    mockReviewCell.configure(sampleModel: sampleModel)
//    let size = mockReviewCell.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize,
//                                                      withHorizontalFittingPriority: .required,
//                                                      verticalFittingPriority: .fittingSizeLevel)
//    return CGSize(width: size.width, height: ceil(size.height))
  }
}
