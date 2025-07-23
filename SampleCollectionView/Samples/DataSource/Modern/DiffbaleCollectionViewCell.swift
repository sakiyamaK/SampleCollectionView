//
//  DiffbaleCollectionViewCell.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2025/07/24.
//

import UIKit

final class DiffbaleCollectionViewCell: UICollectionViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.backgroundColor = .brown
        return label
    }()

    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.backgroundColor = .gray
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subTitleLabel.text = nil
        subTitleLabel.isHidden = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.contentView.addSubview(stackView)
        stackView.applyArroundConstraint(equalTo: self.contentView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(subTitleLabel)

        self.backgroundColor = .systemBlue

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(sampleModel: IdentifableModel) {
        titleLabel.text = sampleModel.title

        if let subTitle = sampleModel.subTitle, !subTitle.isEmpty {
            subTitleLabel.text = subTitle
            subTitleLabel.isHidden = false
        } else {
            subTitleLabel.isHidden = true
        }
    }
}
