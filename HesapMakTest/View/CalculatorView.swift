//
//  CalculatorView.swift
//  HesapMakTest
//
//  Created by Furkan Cingöz on 4.02.2024.
//


import UIKit

class CalculatorView: UIView {
  var resultLabel: UILabel = {
    let label = UILabel()
    label.text = "0"
    label.textColor = .white
    label.textAlignment = .right
    label.font = UIFont(name: "Arial", size: 80)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  var holder: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  var firstNumber = 0
  var currentOperations: Operation?

  enum Operation {
    case add, subtract, multiply, divide, equal
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupLayout()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupLayout() {
    addSubview(resultLabel)

    setupResultLabelConstraints()
    
  }

  private func setupResultLabelConstraints() {
    NSLayoutConstraint.activate([
      resultLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
      resultLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
      resultLabel.heightAnchor.constraint(equalToConstant: 100)
    ])
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    setupNumberPad()
  }

  private func setupNumberPad(){
    let space: CGFloat = 5 // veya istediğin boşluk miktarı
    let buttonSize: CGFloat = (self.frame.size.width - 5 * space) / 4
    var buttons: [UIButton] = []

    let zeroButton = UIButton(frame: CGRect(x: space, y: self.frame.size.height-buttonSize, width: buttonSize*3 + 10, height: buttonSize))
    zeroButton.setTitleColor(.white, for: .normal)
    zeroButton.setTitle("0", for: .normal)
    zeroButton.backgroundColor = .gray
    zeroButton.layer.opacity = 0.75
    zeroButton.layer.cornerRadius = 50
    zeroButton.layer.borderWidth = 2
    zeroButton.tag = 1
    zeroButton.addTarget(self, action: #selector(zeroButtonTap), for: .touchUpInside)
    zeroButton.layer.borderColor = UIColor.black.cgColor
    buttons.append(zeroButton)

    for x in 0..<3 {

      let button1 = UIButton(frame: CGRect(x: space + (buttonSize + space) * CGFloat(x), y: self.frame.size.height-(buttonSize*2) - 5, width: buttonSize, height: buttonSize))
      button1.setTitleColor(.white, for: .normal)
      button1.setTitle("\(x+1)", for: .normal)
      button1.backgroundColor = .gray
      button1.layer.opacity = 0.90
      button1.layer.cornerRadius = button1.frame.size.width / 2
      button1.layer.borderColor = UIColor.black.cgColor
      button1.layer.borderWidth = 2
      button1.tag = x+2
      button1.addTarget(self, action: #selector(numberPressed), for: .touchUpInside)
      buttons.append(button1)
    }

    for x in 0..<3 {
      let button2 = UIButton(frame: CGRect(x: space + (buttonSize + space) * CGFloat(x), y: self.frame.size.height-(buttonSize*3) - 5, width: buttonSize, height: buttonSize))
      button2.setTitleColor(.white, for: .normal)
      button2.setTitle("\(4+x)", for: .normal)
      button2.backgroundColor = .gray
      button2.layer.opacity = 0.90
      button2.layer.cornerRadius = button2.frame.size.width / 2
      button2.layer.borderWidth = 2
      button2.layer.borderColor = UIColor.black.cgColor
      button2.tag = x+5
      button2.addTarget(self, action: #selector(numberPressed), for: .touchUpInside)
      buttons.append(button2)
    }

    for x in 0..<3 {
      let button3 = UIButton(frame: CGRect(x: space + (buttonSize + space) * CGFloat(x), y: self.frame.size.height-(buttonSize*4) - 5, width: buttonSize, height: buttonSize))
      button3.setTitleColor(.white, for: .normal)
      button3.setTitle("\(x+7)", for: .normal)
      button3.backgroundColor = .gray
      button3.layer.opacity = 0.90
      button3.layer.cornerRadius = button3.frame.size.width / 2
      button3.layer.borderWidth = 2
      button3.layer.borderColor = UIColor.black.cgColor
      button3.tag = x+8
      button3.addTarget(self, action: #selector(numberPressed), for: .touchUpInside)
      buttons.append(button3)
    }

    let clearButton = UIButton(frame:CGRect(x: 0, y: self.frame.size.height-(buttonSize*5) - 5, width: buttonSize*3 + 15, height: buttonSize))
    clearButton.setTitleColor(.white, for: .normal)
    clearButton.setTitle("AC", for: .normal)
    clearButton.backgroundColor = .gray
    clearButton.layer.opacity = 0.90
    clearButton.layer.cornerRadius = 50
    clearButton.layer.borderWidth = 2
    clearButton.layer.borderColor = UIColor.black.cgColor
    buttons.append(clearButton)


    let operations = ["=","+","-","x","/"]
    for x in 0..<5 {
      let button4 = UIButton(frame: CGRect(x: buttonSize * 3 + 20 , y: self.frame.size.height-(buttonSize * CGFloat(x+1)), width: buttonSize, height: buttonSize))
      button4.setTitleColor(.white, for: .normal)
      button4.setTitle(operations[x], for: .normal)
      button4.backgroundColor = .orange
      button4.layer.borderWidth = 2
      button4.layer.cornerRadius = button4.frame.size.width / 2
      button4.layer.borderColor = UIColor.black.cgColor
      button4.tag = x+1
      button4.addTarget(self, action: #selector(operationPressed), for: .touchUpInside)
      buttons.append(button4)
    }

    resultLabel.frame = CGRect(x: 20, y: clearButton.frame.origin.y - 110.0, width: self.frame.size.width - 40, height: 100)
    clearButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
    self.addSubviews(resultLabel)

    buttons.forEach { self.addSubview($0) }
  }


  @objc func zeroButtonTap(){
    if resultLabel.text != "0" {
      if let text = resultLabel.text {
        resultLabel.text = "\(text)\(0)"
      }
    }
  }

  @objc func clearResult(){
    resultLabel.text = "0"
    currentOperations = nil

    firstNumber = 0
  }

  @objc func numberPressed(_ sender: UIButton) {
    let tag = sender.tag - 1
    if resultLabel.text == "0" {
      resultLabel.text = "\(tag)"
    } else if let text = resultLabel.text {
      resultLabel.text = "\(text)\(tag)"
    }
  }

  @objc func operationPressed(_ sender: UIButton) {
    let tag = sender.tag

    if let text = resultLabel.text, let value = Int(text), firstNumber == 0 {
      firstNumber = value
      resultLabel.text = "0"
    }
    if let operation = currentOperations {
      var secondNumber = 0
      if let text = resultLabel.text, let value = Int(text){
        secondNumber = value
      }

      switch operation {
      case .add:
        let result = firstNumber + secondNumber
        resultLabel.text = "\(result)"
        break
      case .subtract:
        let result  = firstNumber - secondNumber
        resultLabel.text = "\(result)"
        break
      case .multiply:
        let result  = firstNumber * secondNumber
        resultLabel.text = "\(result)"
        break
      case .divide:
        let result  = firstNumber / secondNumber
        resultLabel.text = "\(result)"
        break
      default:
        break
      }
    }

    if tag == 1 { //
      currentOperations = nil
      firstNumber = 0 //
    } else if tag == 2 {
      currentOperations = .add
    } else if tag == 3 {
      currentOperations = .subtract
    } else if tag == 4 {
      currentOperations = .multiply
    } else if tag == 5 {
      currentOperations = .divide
    }
  }
}


extension UIView {
  func addSubviews(_ views: UIView...) {
    views.forEach {
      addSubview($0)
    }
  }
}
