import Foundation

enum SpecimenVariant: String, CaseIterable, Identifiable {
    case asBuilt
    case withoutIt

    var id: Self { self }

    var title: String {
        switch self {
        case .asBuilt: "As built"
        case .withoutIt: "Without it"
        }
    }
}
