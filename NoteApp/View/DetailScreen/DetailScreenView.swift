import UIKit

final class DetailScreenView: UIView {
    private let titleLabel = LabelFactory.createSuperTitleLabel()
    private let dateLabel = LabelFactory.createOrdinaryLabel()
    private let descriptionLabel = LabelFactory.createTitleLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DetailScreenView {
    func setupView() {
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(descriptionLabel)
        
        descriptionLabel.textColor = ColorExtension.accentWhite
    }
}

private extension DetailScreenView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: DetailScreenEnum.View.Constr.topConstr),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: DetailScreenEnum.View.Constr.leadingConstr),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: DetailScreenEnum.View.Constr.trailingConstr),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: DetailScreenEnum.View.Constr.topConstr),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: DetailScreenEnum.View.Constr.topBigConstr),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
        ])
    }
}

extension DetailScreenView {
    func setupText(title: String,
                   date: String,
                   description: String,
    ) {
        titleLabel.text = title
        dateLabel.text = date
        descriptionLabel.text = description
    }
}

