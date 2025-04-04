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
                statusButton.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 12),
                statusButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                statusButton.widthAnchor.constraint(equalToConstant: 24),
                statusButton.heightAnchor.constraint(equalToConstant: 24),
                
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
                titleLabel.leadingAnchor.constraint(equalTo: statusButton.trailingAnchor, constant: 8),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

                descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
                descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

                dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 6),
                dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
                dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
            ])
        }
    }


extension NoteTableViewCell {
    func configure(with task: NoteEntity) {
        titleLabel.text = task.title
        descriptionLabel.text = task.description
        dateLabel.text = task.formattedDate
        
        changeBttn(with: task.isCompleted)
        changeTitle(with: task.isCompleted)
        changeDescription(with: task.isCompleted)
    }
}

private extension NoteTableViewCell {
    func changeBttn(with isCompleted: Bool) {
        let imageName: Void = isCompleted ? statusButton.setImage(UIImage(named: "checkmark.fill"), for: .normal) : statusButton.setImage(UIImage(named: "checkmark"), for: .normal)
    }
    
    func changeTitle(with isCompleted: Bool) {
        titleLabel.textColor = isCompleted ? ColorExtension.accentLightWhite : ColorExtension.accentWhite
        
        titleLabel.attributedText = isCompleted ?
       NSAttributedString(
        string: titleLabel.text ?? "",
        attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]) :
       NSAttributedString(string: titleLabel.text ?? "")
        
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
