--!strict
-- Combat numbers shared by server and client.

local CombatConfig = {}

-- Health and movement
CombatConfig.RunnerMaxHealth = 100
CombatConfig.BaseWalkSpeed = 16
CombatConfig.BaseJumpPower = 50

-- Damage rules (GAME_PLAN.md Section 2C)
CombatConfig.MaxDamagePerCast = 60 -- one cast can never deal more than this to one target
CombatConfig.MaxDamagePerSecond = 70 -- all sources combined, per target, over any 1s window
CombatConfig.CastMemory = 15 -- seconds a cast id remembers how much damage it dealt

-- Kill credit: a God who dealt at least AssistDamage in the AssistWindow before a kill gets an assist.
CombatConfig.AssistDamage = 20
CombatConfig.AssistWindow = 10

-- Ragdoll
CombatConfig.GetUpStunImmunity = 0.5 -- seconds of stun immunity after standing back up
CombatConfig.MaxRagdollTime = 6

-- Knockback
CombatConfig.MaxKnockbackSpeed = 160

-- Hitboxes
CombatConfig.DefaultMaxTargets = 30
-- Set the workspace attribute "ShowHitboxes" to true to see every hitbox (Studio testing).
CombatConfig.ShowHitboxesAttribute = "ShowHitboxes"

-- Test dummies (Studio only, or when the workspace attribute "SpawnTestDummies" is true)
CombatConfig.TestDummies = {
	Count = 3,
	Origin = Vector3.new(0, 4, -30),
	Spacing = 10,
	RespawnTime = 3,
}

return CombatConfig
