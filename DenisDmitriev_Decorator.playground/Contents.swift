import UIKit

//Домашняя работа к уроку 6
//Дмитриев Денис

enum Volume: Int {
    case tall = 250
    case grande = 350
    case venti = 450
}

protocol Coffee {
    var cost: Int { get }
    var volume: Volume { get }
}

class SimpleCoffee: Coffee {
    var volume: Volume
    
    var cost: Int {
        return 50 * volume.rawValue / Volume.tall.rawValue
    }
    
    init(with volume: Volume) {
        self.volume = volume
    }
}

protocol CoffeeDecorator: Coffee {
    var baseCoffee: Coffee { get }
    init(base: Coffee)
}

//Milk, Whip, Sugar

class CoffeeWithMilk: CoffeeDecorator {
    var volume: Volume
    
    var baseCoffee: Coffee
    
    required init(base: Coffee) {
        self.baseCoffee = base
        self.volume = base.volume
    }
    
    var cost: Int {
        baseCoffee.cost + (20 * volume.rawValue / Volume.tall.rawValue)
    }
}

class CoffeeWithWhip: CoffeeDecorator {
    var volume: Volume
    
    var baseCoffee: Coffee
    
    required init(base: Coffee) {
        self.baseCoffee = base
        self.volume = base.volume
    }
    
    var cost: Int {
        baseCoffee.cost + (30 * volume.rawValue / Volume.tall.rawValue)
    }
}

class CoffeeWithSugar: CoffeeDecorator {
    var volume: Volume
    
    var baseCoffee: Coffee
    
    required init(base: Coffee) {
        self.baseCoffee = base
        self.volume = base.volume
    }
    
    var cost: Int {
        baseCoffee.cost + (5 * volume.rawValue / Volume.tall.rawValue)
    }
}

let coffeeTall = SimpleCoffee(with: .tall)
coffeeTall.cost

let coffeeVenti = SimpleCoffee(with: .venti)
coffeeVenti.cost

let coffeeGrande = SimpleCoffee(with: .grande)
coffeeGrande.cost

let coffeeTallWithSugar = CoffeeWithSugar(base: coffeeTall)
coffeeTallWithSugar.cost

let coffeeTallWithSugarAndMilk = CoffeeWithMilk(base: coffeeTallWithSugar)
coffeeTallWithSugarAndMilk.cost

let coffeeVentiWithWhip = CoffeeWithWhip(base: coffeeVenti)
coffeeVentiWithWhip.cost

let coffeeGrandeWithDoubleMilk = CoffeeWithMilk(
    base: CoffeeWithMilk(base: coffeeGrande)
)
coffeeGrandeWithDoubleMilk.cost
