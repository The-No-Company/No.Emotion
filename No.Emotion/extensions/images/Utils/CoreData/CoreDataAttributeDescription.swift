import CoreData

/// Used to create `NSAttributeDescription`
struct CoreDataAttributeDescription {
    static func attribute(name: String, type: NSAttributeType,
                          isOptional: Bool = false) -> CoreDataAttributeDescription {
        CoreDataAttributeDescription(name: name, attributeType: type, isOptional: isOptional)
    }

    var name: String

    var attributeType: NSAttributeType

    var isOptional: Bool

    func makeAttribute() -> NSAttributeDescription {
        let attribute = NSAttributeDescription()
        attribute.name = name
        attribute.attributeType = attributeType
        attribute.isOptional = isOptional

        return attribute
    }
}
