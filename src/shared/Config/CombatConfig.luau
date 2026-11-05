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

-- Cover (GAME_PLAN.md Section 1: Runners hide in cover; heavy strikes crumble it).
-- God strikes come from the sky: a Runner with solid cover above them (a roof, a tree, a bunker)
-- isn't hit, unless the skill destroys that cover first (DestroyCover) or ignores it (IgnoreCover).
CombatConfig.CoverBlocksStrikes = true
CombatConfig.CoverCheckHeight = 80 -- studs above the Runner's head that count as "above"

-- Ragdoll
CombatConfig.GetUpStunImmunity = 0.5 -- seconds of stun immunity after standing back up
CombatConfig.MaxRagdollTime = 6

-- Knockback
CombatConfig.MaxKnockbackSpeed = 160

-- Hitboxes
CombatConfig.DefaultMaxTargets = 30
-- Set the workspace attribute "ShowHitboxes" to true to see every hitbox (Studio testing).
CombatConfig.ShowHitboxesAttribute = "ShowHitboxes"

-- Test dummies, in the dev test area (TestAreaConfig). Spawned in Studio, when the workspace
-- attribute "SpawnTestDummies" is true, or when an admin enters the test area.
CombatConfig.TestDummies = {
	Count = 5,
	Origin = Vector3.new(-400, 4, -30), -- TestAreaConfig.Center + (0, 4, -30)
	Spacing = 10,
	RespawnTime = 3,
}

return CombatConfig
