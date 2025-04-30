import SwiftUI

enum Keys: String {
    case time = "time"
    case currentLevel = "currentLevel"
    case coin = "coin"
    case bomb = "bomb"
    case isSoundEnabled = "isSoundEnabled"
    case isMusicEnabled = "isMusicEnabled"
    case levelScores = "levelScores"
    case lastShowKey = "lastDailyViewShowDate"
}

class UserDefaultsManager: ObservableObject {
    static let defaults = UserDefaults.standard
    
    func canShowDailyView() -> Bool {
        if let lastDate = UserDefaults.standard.object(forKey: Keys.lastShowKey.rawValue) as? Date {
            return Date().timeIntervalSince(lastDate) >= 24 * 60 * 60
        }
        return true
    }
    
    func updateLastShowDate() {
        UserDefaults.standard.set(Date(), forKey: Keys.lastShowKey.rawValue)
    }
    
    func firstLaunch() {
        if UserDefaultsManager.defaults.object(forKey: Keys.currentLevel.rawValue) == nil {
            UserDefaultsManager.defaults.set(1000,  forKey: Keys.coin.rawValue)
            UserDefaultsManager.defaults.set(1,  forKey: Keys.currentLevel.rawValue)
            UserDefaultsManager.defaults.set(2,  forKey: Keys.time.rawValue)
            UserDefaultsManager.defaults.set(2,  forKey: Keys.bomb.rawValue)
            UserDefaultsManager.defaults.set(true, forKey: Keys.isSoundEnabled.rawValue)
            UserDefaultsManager.defaults.set(true, forKey: Keys.isMusicEnabled.rawValue)
        }
    }
    
    func toggleMusic() {
        let current = isMusicEnabled()
        UserDefaults.standard.set(!current, forKey: Keys.isMusicEnabled.rawValue)
        objectWillChange.send()
    }
    
    func toggleSound() {
        let current = isSoundEnabled()
        UserDefaults.standard.set(!current, forKey: Keys.isSoundEnabled.rawValue)
        objectWillChange.send()
    }
    
    func buyBomb() {
        let currentBomb = UserDefaultsManager.defaults.object(forKey: Keys.bomb.rawValue) as? Int ?? 1
        let coin = UserDefaultsManager.defaults.object(forKey: Keys.coin.rawValue) as? Int ?? 1
        if coin >= 100 {
            UserDefaultsManager.defaults.set(coin - 100, forKey: Keys.coin.rawValue)
            UserDefaultsManager.defaults.set(currentBomb + 1, forKey: Keys.bomb.rawValue)
        }
    }
    
    func buyTime() {
        let currentLife = UserDefaultsManager.defaults.object(forKey: Keys.time.rawValue) as? Int ?? 1
        let coin = UserDefaultsManager.defaults.object(forKey: Keys.coin.rawValue) as? Int ?? 1
        if coin >= 100 {
            UserDefaultsManager.defaults.set(coin - 100, forKey: Keys.coin.rawValue)
            UserDefaultsManager.defaults.set(currentLife + 1, forKey: Keys.time.rawValue)
        }
    }
    
    func daily() {
        let coin = UserDefaultsManager.defaults.object(forKey: Keys.coin.rawValue) as? Int ?? 1
        UserDefaultsManager.defaults.set(coin + 100, forKey: Keys.coin.rawValue)
    }
    
    func saveSoundSettings(isSoundEnabled: Bool) {
        UserDefaultsManager.defaults.set(isSoundEnabled, forKey: Keys.isSoundEnabled.rawValue)
    }
    
    func saveMusicSettings(isMusicEnabled: Bool) {
        UserDefaultsManager.defaults.set(isMusicEnabled, forKey: Keys.isMusicEnabled.rawValue)
    }
    
    func isSoundEnabled() -> Bool {
        return UserDefaultsManager.defaults.bool(forKey: Keys.isSoundEnabled.rawValue)
    }
    
    func isMusicEnabled() -> Bool {
        return UserDefaultsManager.defaults.bool(forKey: Keys.isMusicEnabled.rawValue)
    }
    
    func increaseLevel() {
        let currentLevel = UserDefaultsManager.defaults.object(forKey: Keys.currentLevel.rawValue) as? Int ?? 1
        let coin = UserDefaultsManager.defaults.object(forKey: Keys.coin.rawValue) as? Int ?? 1
        
        UserDefaultsManager.defaults.set(coin + 100, forKey: Keys.coin.rawValue)
        UserDefaultsManager.defaults.set(currentLevel + 1, forKey: Keys.currentLevel.rawValue)
    }
    
    func saveLevelScore(level: Int, score: Int) {
        var levelScores = getLevelScores()
        let currentBest = levelScores[level] ?? 0
        if score > currentBest {
            levelScores[level] = score
            let stringKeyScores = levelScores.reduce(into: [String: Int]()) { (dict, pair) in
                dict[String(pair.key)] = pair.value
            }
            UserDefaultsManager.defaults.set(stringKeyScores, forKey: Keys.levelScores.rawValue)
        }
    }
    
    func getLevelScores() -> [Int: Int] {
        if let savedScores = UserDefaultsManager.defaults.dictionary(forKey: Keys.levelScores.rawValue) as? [String: Int] {
            var intKeyScores = [Int: Int]()
            for (key, value) in savedScores {
                if let intKey = Int(key) {
                    intKeyScores[intKey] = value
                }
            }
            return intKeyScores
        }
        return [:]
    }
    
    
    func getScore(for level: Int) -> Int {
        return getLevelScores()[level] ?? 0
    }
    
    func getTotalScore() -> Int {
        let levelScores = getLevelScores()
        return levelScores.values.reduce(0, +)
    }
}
