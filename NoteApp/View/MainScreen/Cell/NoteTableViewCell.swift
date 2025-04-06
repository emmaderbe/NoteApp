import UIKit

final class NoteTableViewCell: UITableViewCell {
    
    private let titleLabel = LabelFactory.createTitleLabel()
    private let descriptionLabel = LabelFactory.createOrdinaryLabel()
    private let dateLabel = LabelFactory.createOrdinaryLabel()
    private let statusButton = ButtonFactory.createStatusButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) не реализован")
    }
}

private extension NoteTableViewCell {
    func setupCell() {
        backgroundColor = .clear
        [titleLabel, descriptionLabel, dateLabel, statusButton].forEach(contentView.addSubview)
    }
    
    func setupConstraints() {
            NSLayoutConstraint.activate([
                statusButton.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: MainScreenEnum.Cell.Constr.topBigConstr),
                statusButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: MainScreenEnum.Cell.Constr.bttnLeadingConstr),
                statusButton.widthAnchor.constraint(equalToConstant: MainScreenEnum.Cell.Constr.bttnWidthConstr),
                statusButton.heightAnchor.constraint(equalTo: statusButton.widthAnchor),
                
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: MainScreenEnum.Cell.Constr.topBigConstr),
                titleLabel.leadingAnchor.constraint(equalTo: statusButton.trailingAnchor, constant: MainScreenEnum.Cell.Constr.titleLeadingConstr),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: MainScreenEnum.Cell.Constr.titleTrailingConstr),

                descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: MainScreenEnum.Cell.Constr.topConstr),
                descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

                dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: MainScreenEnum.Cell.Constr.topConstr),
                dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
                dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: MainScreenEnum.Cell.Constr.dateBottomConstr)
            ])
        }
    }


extension NoteTableViewCell {
    func configure(with task: NoteEntity) {
        descriptionLabel.text = task.description
        dateLabel.text = task.formattedDate
        
        changeBttn(with: task.isCompleted)
        changeTitle(text: task.title, isCompleted: task.isCompleted)
        changeDescription(with: task.isCompleted)
    }
}

private extension NoteTableViewCell {
    func changeBttn(with isCompleted: Bool) {
        let imageName: Void = isCompleted ? statusButton.setImage(UIImage(named: MainScreenEnum.Cell.Icon.pressedBttn), for: .normal) : statusButton.setImage(UIImage(named: MainScreenEnum.Cell.Icon.defaultBttn), for: .normal)
    }
    
    func changeTitle(text: String, isCompleted: Bool) {
        let attributes: [NSAttributedString.Key: Any] = isCompleted
            ? [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            : [:]
        
        titleLabel.textColor = isCompleted ? ColorExtension.accentLightWhite : ColorExtension.accentWhite
        titleLabel.attributedText = NSAttributedString(string: text, attributes: attributes)
    }

    
    func changeDescription(with isCompleted: Bool) {
        descriptionLabel.textColor = isCompleted ? ColorExtension.accentLightWhite : ColorExtension.accentWhite
    }
}

extension NoteTableViewCell {
    static var identifier: String {
        String(describing: NoteTableViewCell.self)
    }
}
