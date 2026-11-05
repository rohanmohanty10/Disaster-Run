--!strict
-- Every status effect StatusEffectService understands. Each one is mirrored to a boolean
-- attribute of the same name on the character, so clients can react to it.

local StatusEffectType = {
	Stunned = "Stunned", -- can't move, jump or cast
	Silenced = "Silenced", -- can move, can't cast
	Rooted = "Rooted", -- can't move or jump, can cast
	Slowed = "Slowed", -- movement speed multiplied (strongest slow wins)
	Invulnerable = "Invulnerable", -- iframes: hits and hostile effects are ignored
	Ragdolled = "Ragdolled", -- physics ragdoll, can't move or cast
	StunImmunity = "StunImmunity", -- new stuns are ignored (e.g. right after getting up)
	InfiniteVoid = "InfiniteVoid", -- true stun plus the client's warped camera / muted audio
}

export type StatusEffectType = "Stunned" | "Silenced" | "Rooted" | "Slowed" | "Invulnerable" | "Ragdolled" | "StunImmunity" | "InfiniteVoid"

return table.freeze(StatusEffectType)
