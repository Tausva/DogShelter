class_name Trait extends Resource

enum TraitType {BARKING, NOSY, MISCHEVIOUS, SLEEPY, ENERGETIC, FRIENDLY, ALFA}

@export var current_trait: TraitType
@export var hated_traits: Array[TraitType]


func get_trait_name(trait_value: int) -> String:
	for key in TraitType.keys():
		if TraitType[key] == trait_value:
			return key
	return str(trait_value)
