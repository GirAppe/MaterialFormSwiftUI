#if canImport(UIKit)

import UIKit

// MARK: - Accessories build & Action

@available(iOS 10, *)
extension MaterialUITextField {

    /// Accessory describes basic left/right view types:
    /// - **none**: no accessory at all
    /// - **view(UIView)**: custom accessory view (same as setting leftView/rightView properties)
    /// - **info(UIImage)**: basic icon tinted same as text
    /// - **error(UIImage)**: basic icon visible only when showing error
    /// - **error(UIImage)**: clickable accessory, tinted with focused color
    public enum Accessory {
        case none
        case view(UIView)
        case info(UIImage)
        case error(UIImage)
        case action(UIImage)
    }

    enum Side {
        case right, left
    }

    func build(_ accessory: Accessory, on side: Side) -> UIView? {
        switch accessory {
        case .none:
            return nil
        case let .view(view):
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        case let .info(icon):
            return buildImageView(with: icon)
        case let .error(icon):
            return buildImageView(with: icon)
        case let .action(icon):
            let button = buildAccessoryButton(with: icon)
            if side == .left {
                button.addTarget(self, action: #selector(didTapLeftAccessory), for: .touchUpInside)
            } else {
                button.addTarget(self, action: #selector(didTapRightAccessory), for: .touchUpInside)
            }
            return button
        }
    }

    func buildRightAccessory() {
        guard isBuilt else { return }

        // Clear old
        rightInputAccessory?.clear()
        rightInputAccessory = build(rightAccessory, on: .right)

        guard let accessory = rightInputAccessory else {
            return rightAccessoryView.isHidden = true
        }

        addSubview(accessory.clear())
        accessory.setContentCompressionResistancePriority(.required, for: .horizontal)
        let compress = accessory.widthAnchor.constraint(equalToConstant: 0)
        compress.priority = .defaultHigh - 1
        compress.isActive = true

        NSLayoutConstraint.activate([
            accessory.leftAnchor.constraint(equalTo: rightAccessoryView.leftAnchor),
            accessory.rightAnchor.constraint(equalTo: rightAccessoryView.rightAnchor),
            accessory.heightAnchor.constraint(equalTo: backgroundView.heightAnchor),
            accessory.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor, constant: 2)
        ])

        rightAccessoryView.isHidden = false
        updateAccessory()
    }

    func buildLeftAccessory() {
        guard isBuilt else { return }

        leftInputAccessory?.clear()
        leftInputAccessory = build(leftAccessory, on: .left)

        guard let accessory = leftInputAccessory else {
            return leftAccessoryView.isHidden = true
        }

        addSubview(accessory.clear())
        accessory.setContentCompressionResistancePriority(.required, for: .horizontal)
        let compress = accessory.widthAnchor.constraint(equalToConstant: 0)
        compress.priority = .defaultHigh - 1
        compress.isActive = true

        NSLayoutConstraint.activate([
            accessory.leftAnchor.constraint(equalTo: leftAccessoryView.leftAnchor),
            accessory.rightAnchor.constraint(equalTo: leftAccessoryView.rightAnchor),
            accessory.heightAnchor.constraint(equalTo: backgroundView.heightAnchor),
            accessory.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor, constant: 2)
        ])

        leftAccessoryView.isHidden = false
        updateAccessory()
    }

    private func buildAccessoryButton(with icon: UIImage) -> UIButton {
        let button = ExtendedUIButton(type: .custom)
        button.backgroundColor = .clear
        button.setImage(icon, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = UIView.buttonTag
        return button
    }

    private func buildImageView(with icon: UIImage) -> UIImageView {
        let imageView = UIImageView(image: icon)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tag = UIView.iconTag
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}

// MARK: - Accessory actions

@available(iOS 10, *)
extension MaterialUITextField {

    @objc func didTapRightAccessory() {
        event = .rightAccessoryTap
    }

    @objc func didTapLeftAccessory() {
        event = .leftAccessoryTap
    }
}

// MARK: - UIView + Button accessory

@available(iOS 10, *)
extension UIView {

    static var buttonTag: Int { return 321823 }
    static var iconTag: Int { return 321824 }

    var asAccessoryButton: UIButton? {
        guard self.tag == UIView.buttonTag else { return nil }
        return self as? UIButton
    }
}

// MARK: - UIButton with extensible tappable area

@available(iOS 10, *)
private class ExtendedUIButton: UIButton {

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let superPoint = super.point(inside: point, with: event)
        let extendedBounds = bounds
            .constrainedTo(minHeight: 40)
            .constrainedTo(minWidth: 40)
        return superPoint || extendedBounds.contains(point)
    }
}

#endif
