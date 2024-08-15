import UIKit

final class ViewController: UIViewController {
    //MARK:- Variables

    private lazy var menu: UIStackView = {
        createStackView()
    }()
    
    private lazy var menuButton: UIButton = {
        UIButton(primaryAction: UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.menuIsOpen = !self.menuIsOpen
        }))
    }()
    
    private var constraintToAnimate: NSLayoutConstraint!
        
    private var menuIsOpen = true {
        didSet {
            toggleMenu()
        }
    }
}

//MARK:- UIViewController
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Menu
        view.addSubview(menu)
        menu.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalContstraint = NSLayoutConstraint(item: menu, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: menu, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: menu, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 300)
        let heightConstraint = NSLayoutConstraint(item: menu, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        
        constraintToAnimate = heightConstraint
        
        view.addConstraints([
            horizontalContstraint,
            verticalConstraint,
            widthConstraint,
            heightConstraint
        ])
        
        // Menu Button
        view.addSubview(menuButton)
        menuButton.setTitle("Close Menu", for: .normal)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraintButton = NSLayoutConstraint(item: menuButton, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraintButton = NSLayoutConstraint(item: menuButton, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: -200)
        let widthConstraintButton = NSLayoutConstraint(item: menuButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 400)
        let heightConstraintButton = NSLayoutConstraint(item: menuButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        
        view.addConstraints([
            horizontalConstraintButton,
            verticalConstraintButton,
            widthConstraintButton,
            heightConstraintButton
        ])
    }
}

//MARK:- private
private extension ViewController {
    func toggleMenu() {
        let text = menuIsOpen ? "Hide Menu" : "Show Menu"
        menuButton.setTitle(text, for: .normal)
        view.layoutIfNeeded()
        constraintToAnimate.constant = menuIsOpen ? 100 : 0
        UIView.animate(
            withDuration: 0.33,
            delay: 0.33,
            options: .curveEaseInOut
        ) {
            self.view.layoutIfNeeded()
        }
    }
}

extension ViewController {
    func createImageView(image: UIImage) -> UIImageView {
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        
       // Add constraints
        let widthConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 44)
        let heightConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 44)
        view.addConstraints([widthConstraint, heightConstraint])
        return view
    }
    
    func createStackView() -> UIStackView {
        let view = UIStackView(arrangedSubviews: [
            createImageView(image: .add),
            createImageView(image: .actions),
            createImageView(image: .remove)
        ])
        
        view.distribution = .equalCentering
        view.alignment = .center
        return view
    }
}
