//
//  ViewController.swift
//  Lotoria
//
//  Created by MAC on 10/06/21.
//

import UIKit

enum gameType: String {
    case megaSena = "MEGA-SENA"
    case quina = "QUINA"
}

struct numbersOfGame {
    var number: Int = 60
    var range: [Int] = [0, 1, 2, 3, 4, 5]
}

class ViewController: UIViewController {
    @IBOutlet weak var lblgameType: UILabel!
    @IBOutlet weak var segControlgameType: UISegmentedControl!
    @IBOutlet var gameBalls: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        generateNumbers()
    }

    @IBAction func generateGame() {
        var game: [Int] = []
        var type: gameType
        
        switch segControlgameType.selectedSegmentIndex {
            case 0:
                game = generateNumbers()
                type = .megaSena
            default:
                game = generateNumbers()
                type = .quina
            }
        showNumbers(numbers: game, _: type)
    }
    
    func generateNumbers() -> [Int] {
        var result: [Int] = []
        let gameInitial = numbersOfGame()
        
        while (result.count < gameInitial.range.count) {
            let numberRandom = Int.random(in: 0..<gameInitial.number)
            
            if !result.contains(numberRandom){
                result.append(numberRandom)
            }else{
                generateNumbers()
            }
        }

        return result.sorted()
    }
    
    func showNumbers(numbers: Array<Any>, _ type: gameType) {
        lblgameType.text = type.rawValue
        gameBalls.last!.isHidden = false
    
        for (index, _) in gameBalls.enumerated() {
            gameBalls[index].setTitle("\(numbers[index])", for: .normal)
        }
        
        if (type == .quina){
            gameBalls.last!.isHidden = true
        }
    }
}

