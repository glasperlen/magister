import Foundation

extension Bead {
    public enum Color: String, Codable, CaseIterable {
        case
        blue,
        pink,
        red,
        orange,
        green,
        yellow,
        teal,
        purple,
        indigo
        
        static var random: Self {
            allCases.randomElement()!
        }
    }
}
