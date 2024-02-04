//
//  ViewController.swift
//  HesapMakTest
//
//  Created by Furkan Cingöz on 1.02.2024.
//

import UIKit
import SwiftUI


class ViewController: UIViewController {

  var holder = UIView()
  var firstNumber = 0
  var resultNumber = 0
  var currentOperations : Operation?

  enum Operation {
    case add, subtract, multiply, divide, equal
  }

  private var resultLabel: UILabel = {
    let label = UILabel()
    label.text = "0"
    label.textColor = .white
    label.textAlignment = .right
    label.font = UIFont(name: "Arial", size: 80)
    return label
  }()


  override func viewDidLoad() {
    super.viewDidLoad()
    holder.backgroundColor = .black
    view.addSubview(holder)
    //setupNumberPad()
    setupConstraints()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    setupNumberPad()

  }

  private func setupNumberPad(){
    let space: CGFloat = 5 // veya istediğin boşluk miktarı
    let buttonSize: CGFloat = (view.frame.size.width - 5 * space) / 4

    let zeroButton = UIButton(frame: CGRect(x: space, y: holder.frame.size.height-buttonSize, width: buttonSize*3 + 10, height: buttonSize))
    zeroButton.setTitleColor(.white, for: .normal)
    zeroButton.setTitle("0", for: .normal)
    zeroButton.backgroundColor = .gray
    zeroButton.layer.opacity = 0.75
    zeroButton.layer.cornerRadius = 50
    zeroButton.layer.borderWidth = 2
    zeroButton.tag = 1
    zeroButton.addTarget(self, action: #selector(zeroButtonTap), for: .touchUpInside)
    zeroButton.layer.borderColor = UIColor.black.cgColor
    holder.addSubview(zeroButton)

    for x in 0..<3 {

      let button1 = UIButton(frame: CGRect(x: space + (buttonSize + space) * CGFloat(x), y: holder.frame.size.height-(buttonSize*2) - 5, width: buttonSize, height: buttonSize))
      button1.setTitleColor(.white, for: .normal)
      button1.setTitle("\(x+1)", for: .normal)
      button1.backgroundColor = .gray
      button1.layer.opacity = 0.90
      button1.layer.cornerRadius = button1.frame.size.width / 2
      button1.layer.borderColor = UIColor.black.cgColor
      button1.layer.borderWidth = 2
      button1.tag = x+2
      button1.addTarget(self, action: #selector(numberPressed), for: .touchUpInside)
      holder.addSubview(button1)
    }

    for x in 0..<3 {
      let button2 = UIButton(frame: CGRect(x: space + (buttonSize + space) * CGFloat(x), y: holder.frame.size.height-(buttonSize*3) - 5, width: buttonSize, height: buttonSize))
      button2.setTitleColor(.white, for: .normal)
      button2.setTitle("\(4+x)", for: .normal)
      button2.backgroundColor = .gray
      button2.layer.opacity = 0.90
      button2.layer.cornerRadius = button2.frame.size.width / 2
      button2.layer.borderWidth = 2
      button2.layer.borderColor = UIColor.black.cgColor
      button2.tag = x+5
      button2.addTarget(self, action: #selector(numberPressed), for: .touchUpInside)
      holder.addSubview(button2)
    }

    for x in 0..<3 {
      let button3 = UIButton(frame: CGRect(x: space + (buttonSize + space) * CGFloat(x), y: holder.frame.size.height-(buttonSize*4) - 5, width: buttonSize, height: buttonSize))
      button3.setTitleColor(.white, for: .normal)
      button3.setTitle("\(x+7)", for: .normal)
      button3.backgroundColor = .gray
      button3.layer.opacity = 0.90
      button3.layer.cornerRadius = button3.frame.size.width / 2
      button3.layer.borderWidth = 2
      button3.layer.borderColor = UIColor.black.cgColor
      button3.tag = x+8
      button3.addTarget(self, action: #selector(numberPressed), for: .touchUpInside)
      holder.addSubview(button3)
    }

    let clearButton = UIButton(frame:CGRect(x: 0, y: holder.frame.size.height-(buttonSize*5) - 5, width: buttonSize*3 + 15, height: buttonSize))
    clearButton.setTitleColor(.white, for: .normal)
    clearButton.setTitle("AC", for: .normal)
    clearButton.backgroundColor = .gray
    clearButton.layer.opacity = 0.90
    clearButton.layer.cornerRadius = 50
    clearButton.layer.borderWidth = 2
    clearButton.layer.borderColor = UIColor.black.cgColor
    holder.addSubview(clearButton)


    let operations = ["=","+","-","x","/"]
    for x in 0..<5 {
      let button4 = UIButton(frame: CGRect(x: buttonSize * 3 + 20 , y: holder.frame.size.height-(buttonSize * CGFloat(x+1)), width: buttonSize, height: buttonSize))
      button4.setTitleColor(.white, for: .normal)
      button4.setTitle(operations[x], for: .normal)
      button4.backgroundColor = .orange
      button4.layer.borderWidth = 2
      button4.layer.cornerRadius = button4.frame.size.width / 2
      button4.layer.borderColor = UIColor.black.cgColor
      button4.tag = x+1
      button4.addTarget(self, action: #selector(operationPressed), for: .touchUpInside)
      holder.addSubview(button4)
    }

    resultLabel.frame = CGRect(x: 20, y: clearButton.frame.origin.y - 110.0, width: view.frame.size.width - 40, height: 100)
    holder.addSubview(resultLabel)
    clearButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
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

    if tag == 1 { // Eşit işlemi
      currentOperations = nil
      firstNumber = 0 // Sonuç gösterildikten sonra ilk sayıyı sıfırla
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

//MARK: - View Configure
func setupConstraints() {
  holder.translatesAutoresizingMaskIntoConstraints = false
  NSLayoutConstraint.activate([
    holder.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
    holder.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
    holder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
    holder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
  ])

}
}

