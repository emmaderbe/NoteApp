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
        
        let imageName = task.isCompleted ? "checkmark.circle.fill" : "circle"
        statusButton.setImage(UIImage(systemName: imageName), for: .normal)
        
        titleLabel.textColor = task.isCompleted ? .gray : .white
        descriptionLabel.textColor = task.isCompleted ? .gray : .white
        titleLabel.attributedText = task.isCompleted ?
            NSAttributedString(string: task.title, attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]) :
            NSAttributedString(string: task.title)
    }
}

extension NoteTableViewCell {
    static var identifier: String {
        String(describing: NoteTableViewCell.self)
    }
}
