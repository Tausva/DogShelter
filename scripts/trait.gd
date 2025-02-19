class_name Trait extends Resource

enum TraitType {BARKING, NOSY, MISCHEVIOUS, SLEEPY, ENERGETIC}

@export var current_trait: TraitType
@export var hated_traits: Array[TraitType]
