import Foundation

/// Which version of a specimen is showing.
///
/// The comparison control flips this and nothing else. Specimens branch
/// internally on it rather than existing as two parallel view trees — parallel
/// trees drift, and branching keeps every place the variant matters greppable.
enum SpecimenVariant: String, CaseIterable, Identifiable {
    case asBuilt
    case withoutIt

    var id: Self { self }

    /// User-facing label. Deliberately not "honest version": that is a verdict
    /// rather than a description, and it frames the deceptive version as the
    /// normal state.
    var title: String {
        switch self {
        case .asBuilt: "With it"
        case .withoutIt: "Without it"
        }
    }

    var accessibilityLabel: String {
        switch self {
        case .asBuilt: "Show the version with the pattern"
        case .withoutIt: "Show the version without the pattern"
        }
    }
}
