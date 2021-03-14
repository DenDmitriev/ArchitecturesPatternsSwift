import UIKit

//Домашняя работа к уроку 6
//Дмитриев Денис

protocol Coffee {
    var cost: Int { get }
}

class SimpleCoffee: Coffee {
    var cost: Int {
        return 80
    }
}

protocol CoffeeDecorator: Coffee {
    var baseCoffee: Coffee { get }
    init(base: Coffee)
}

//Milk, Whip, Sugar

class CoffeeWithMilk: CoffeeDecorator {
    var baseCoffee: Coffee
    
    required init(base: Coffee) {
        self.baseCoffee = base
    }
    
    var cost: Int {
        baseCoffee.cost + 20
    }
}

class CoffeeWithWhip: CoffeeDecorator {
    var baseCoffee: Coffee
    
    required init(base: Coffee) {
        self.baseCoffee = base
    }
    
    var cost: Int {
        baseCoffee.cost + 30
    }
}

class CoffeeWithSugar: CoffeeDecorator {
    var baseCoffee: Coffee
    
    required init(base: Coffee) {
        self.baseCoffee = base
    }
    
    var cost: Int {
        baseCoffee.cost + 5
    }
}

let coffee = SimpleCoffee()
coffee.cost
let coffeeWithSugar = CoffeeWithSugar(base: coffee)
coffeeWithSugar.cost
let coffeeWithSugarAndMilk = CoffeeWithMilk(base: coffeeWithSugar)
coffeeWithSugarAndMilk.cost
let coffeeWithWhip = CoffeeWithWhip(base: coffee)
coffeeWithWhip.cost
