//  Created by Daniyar Mamadov on 17.05.2022.

import UIKit

final internal class ViewController: UIViewController {
    
    private var isFinishedTypingNumber: Bool = true
        
    private let mainStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 14
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stack1: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 14
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stack2: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 14
        return view
    }()
    
    private let stack3: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 14
        return view
    }()
    
    private let stack4: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 14
        return view
    }()
            
    private let displayLabel: UILabel = {
        let view = UILabel()
        view.text = "0"
        view.font = .systemFont(ofSize: 80, weight: .light)
        view.textColor = .white
        view.textAlignment = .right
        view.numberOfLines = 0
        view.sizeToFit()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("Cannot convert dipslayLabel to Double")
            }
            return number
        }
        set {
            displayLabel.text = String(newValue)
        }
    }

    private lazy var clear: UIButton = {
        let view = UIButton()
        view.setTitle("AC", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 32, weight: .light)
        view.backgroundColor = UIColor(named: "LightGray")
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.sizeToFit()
        view.addTarget(self, action: #selector(calcButtonPressed(_:)), for: .touchUpInside)
        return view
    }()

    private lazy var negative: UIButton = {
        let view = UIButton()
        view.setTitle("+/-", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 32, weight: .light)
        view.backgroundColor = UIColor(named: "LightGray")
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.addTarget(self, action: #selector(calcButtonPressed(_:)), for: .touchUpInside)
        return view
    }()

    private lazy var percent: UIButton = {
        let view = UIButton()
        view.setTitle("%", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 32, weight: .regular)
        view.backgroundColor = UIColor(named: "LightGray")
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.addTarget(self, action: #selector(calcButtonPressed(_:)), for: .touchUpInside)
        return view
    }()

    private lazy var divide: UIButton = {
        let view = UIButton()
        view.setTitle("÷", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 32, weight: .regular)
        view.backgroundColor = UIColor(named: "Orange")
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.addTarget(self, action: #selector(calcButtonPressed(_:)), for: .touchUpInside)
        return view
    }()
    
    private lazy var multiply: UIButton = {
        let view = UIButton()
        view.setTitle("x", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 32, weight: .regular)
        view.backgroundColor = UIColor(named: "Orange")
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.addTarget(self, action: #selector(calcButtonPressed(_:)), for: .touchUpInside)
        return view
    }()

    private lazy var subtract: UIButton = {
        let view = UIButton()
        view.setTitle("-", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 32, weight: .regular)
        view.backgroundColor = UIColor(named: "Orange")
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.addTarget(self, action: #selector(calcButtonPressed(_:)), for: .touchUpInside)
        return view
    }()
    
    private lazy var add: UIButton = {
        let view = UIButton()
        view.setTitle("+", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 32, weight: .regular)
        view.backgroundColor = UIColor(named: "Orange")
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.addTarget(self, action: #selector(calcButtonPressed(_:)), for: .touchUpInside)
        return view
    }()
    
    private lazy var equal: UIButton = {
        let view = UIButton()
        view.setTitle("=", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 32, weight: .regular)
        view.backgroundColor = UIColor(named: "Orange")
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(calcButtonPressed(_:)), for: .touchUpInside)
        return view
    }()
    
    private lazy var decimal: UIButton = {
        let view = UIButton()
        view.setTitle(",", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 32, weight: .regular)
        view.backgroundColor = UIColor(named: "DarkGray")
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(decimalButtonDidTap(_:)), for: .touchUpInside)
        return view
    }()

    private lazy var zero: UIButton = {
        let view = UIButton()
        view.setTitle("0", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 32, weight: .regular)
        view.backgroundColor = UIColor(named: "DarkGray")
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(numButtonDidTap(_:)), for: .touchUpInside)
        return view
    }()
    
    private lazy var one: UIButton = {
        let view = UIButton()
        view.setTitle("1", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 32, weight: .regular)
        view.backgroundColor = UIColor(named: "DarkGray")
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.addTarget(self, action: #selector(numButtonDidTap(_:)), for: .touchUpInside)
        return view
    }()

    private lazy var two: UIButton = {
        let view = UIButton()
        view.setTitle("2", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 32, weight: .regular)
        view.backgroundColor = UIColor(named: "DarkGray")
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.addTarget(self, action: #selector(numButtonDidTap(_:)), for: .touchUpInside)
        return view
    }()

    private lazy var three: UIButton = {
        let view = UIButton()
        view.setTitle("3", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 32, weight: .regular)
        view.backgroundColor = UIColor(named: "DarkGray")
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.addTarget(self, action: #selector(numButtonDidTap(_:)), for: .touchUpInside)
        return view
    }()
    
    private lazy var four: UIButton = {
        let view = UIButton()
        view.setTitle("4", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 32, weight: .regular)
        view.backgroundColor = UIColor(named: "DarkGray")
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.addTarget(self, action: #selector(numButtonDidTap(_:)), for: .touchUpInside)
        return view
    }()

    private lazy var five: UIButton = {
        let view = UIButton()
        view.setTitle("5", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 32, weight: .regular)
        view.backgroundColor = UIColor(named: "DarkGray")
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.addTarget(self, action: #selector(numButtonDidTap(_:)), for: .touchUpInside)
        return view
    }()

    private lazy var six: UIButton = {
        let view = UIButton()
        view.setTitle("6", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 32, weight: .regular)
        view.backgroundColor = UIColor(named: "DarkGray")
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.addTarget(self, action: #selector(numButtonDidTap(_:)), for: .touchUpInside)
        return view
    }()

    private lazy var seven: UIButton = {
        let view = UIButton()
        view.setTitle("7", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 32, weight: .regular)
        view.backgroundColor = UIColor(named: "DarkGray")
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.addTarget(self, action: #selector(numButtonDidTap(_:)), for: .touchUpInside)
        return view
    }()

    private lazy var eight: UIButton = {
        let view = UIButton()
        view.setTitle("8", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 32, weight: .regular)
        view.backgroundColor = UIColor(named: "DarkGray")
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.addTarget(self, action: #selector(numButtonDidTap(_:)), for: .touchUpInside)
        return view
    }()

    private lazy var nine: UIButton = {
        let view = UIButton()
        view.setTitle("9", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 32, weight: .regular)
        view.backgroundColor = UIColor(named: "DarkGray")
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.addTarget(self, action: #selector(numButtonDidTap(_:)), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(displayLabel)
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(stack1)
        mainStack.addArrangedSubview(stack2)
        mainStack.addArrangedSubview(stack3)
        mainStack.addArrangedSubview(stack4)
        stack1.addArrangedSubview(clear)
        stack1.addArrangedSubview(negative)
        stack1.addArrangedSubview(percent)
        stack1.addArrangedSubview(divide)
        stack2.addArrangedSubview(seven)
        stack2.addArrangedSubview(eight)
        stack2.addArrangedSubview(nine)
        stack2.addArrangedSubview(multiply)
        stack3.addArrangedSubview(four)
        stack3.addArrangedSubview(five)
        stack3.addArrangedSubview(six)
        stack3.addArrangedSubview(subtract)
        stack4.addArrangedSubview(one)
        stack4.addArrangedSubview(two)
        stack4.addArrangedSubview(three)
        stack4.addArrangedSubview(add)
        view.addSubview(zero)
        view.addSubview(decimal)
        view.addSubview(equal)
        NSLayoutConstraint.activate([
            zero.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -74),
            zero.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            zero.widthAnchor.constraint(equalToConstant: ((view.coordinateSpace.bounds.width-74)/2) + 14),
            zero.heightAnchor.constraint(equalToConstant: (view.coordinateSpace.bounds.width-74)/4),
            decimal.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -74),
            decimal.leadingAnchor.constraint(equalTo: zero.trailingAnchor, constant: 14),
            decimal.widthAnchor.constraint(equalToConstant: (view.coordinateSpace.bounds.width-74)/4),
            decimal.heightAnchor.constraint(equalToConstant: (view.coordinateSpace.bounds.width-74)/4),
            equal.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -74),
            equal.leadingAnchor.constraint(equalTo: decimal.trailingAnchor, constant: 14),
            equal.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            equal.heightAnchor.constraint(equalToConstant: (view.coordinateSpace.bounds.width-74)/4),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: zero.topAnchor, constant: -14),
            stack1.heightAnchor.constraint(equalToConstant: (view.coordinateSpace.bounds.width-74)/4),
            stack2.heightAnchor.constraint(equalToConstant: (view.coordinateSpace.bounds.width-74)/4),
            stack3.heightAnchor.constraint(equalToConstant: (view.coordinateSpace.bounds.width-74)/4),
            stack4.heightAnchor.constraint(equalToConstant: (view.coordinateSpace.bounds.width-74)/4),
            displayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            displayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            displayLabel.bottomAnchor.constraint(equalTo: mainStack.topAnchor, constant: -31)
        ])
        clear.layer.cornerRadius = (view.coordinateSpace.bounds.width-74)/8
        negative.layer.cornerRadius = (view.coordinateSpace.bounds.width-74)/8
        percent.layer.cornerRadius = (view.coordinateSpace.bounds.width-74)/8
        divide.layer.cornerRadius = (view.coordinateSpace.bounds.width-74)/8
        multiply.layer.cornerRadius = (view.coordinateSpace.bounds.width-74)/8
        subtract.layer.cornerRadius = (view.coordinateSpace.bounds.width-74)/8
        add.layer.cornerRadius = (view.coordinateSpace.bounds.width-74)/8
        equal.layer.cornerRadius = (view.coordinateSpace.bounds.width-74)/8
        decimal.layer.cornerRadius = (view.coordinateSpace.bounds.width-74)/8
        zero.layer.cornerRadius = (view.coordinateSpace.bounds.width-74)/8
        one.layer.cornerRadius = (view.coordinateSpace.bounds.width-74)/8
        two.layer.cornerRadius = (view.coordinateSpace.bounds.width-74)/8
        three.layer.cornerRadius = (view.coordinateSpace.bounds.width-74)/8
        four.layer.cornerRadius = (view.coordinateSpace.bounds.width-74)/8
        five.layer.cornerRadius = (view.coordinateSpace.bounds.width-74)/8
        six.layer.cornerRadius = (view.coordinateSpace.bounds.width-74)/8
        seven.layer.cornerRadius = (view.coordinateSpace.bounds.width-74)/8
        eight.layer.cornerRadius = (view.coordinateSpace.bounds.width-74)/8
        nine.layer.cornerRadius = (view.coordinateSpace.bounds.width-74)/8
    }
    
    
    
    @objc private func decimalButtonDidTap(_ sender: UIButton) {
        clear.setTitle("C", for: .normal)
        if displayLabel.text!.contains(".") {
            return
        } else {
            isFinishedTypingNumber = false
            displayLabel.text?.append(".")
        }
    }

    @objc private func numButtonDidTap(_ sender: UIButton) {
        clear.setTitle("C", for: .normal)
        if let number = sender.currentTitle {
            if isFinishedTypingNumber {
                displayLabel.text = number
                isFinishedTypingNumber = false
            } else {
                displayLabel.text?.append(number)
            }
        }
    }

    @objc private func calcButtonPressed(_ sender: UIButton) {
        
        isFinishedTypingNumber = true
        
        if let calcMethod = sender.currentTitle {
            let calculator = CalculatorLogic(number: displayValue)
            guard let result = calculator.calculate(symbol: calcMethod) else {
                fatalError("The result of the calculation is nil")
            }
            displayValue = result
        }
    }
}
