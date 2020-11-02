import Foundation

extension Player {
    public enum Order {
        case
        first,
        second
        
        public func active(_ bead: Bead) -> Cell.Active {
            .init(order: self, bead: bead)
        }
    }
}
