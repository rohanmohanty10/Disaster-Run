--!strict
-- Who a hitbox is allowed to hit (FRAMEWORK_PLAN.md Section 2).

local TargetFilterMode = {
	HostileToRunners = "HostileToRunners", -- every living Runner (God calamities)
	SelfOnly = "SelfOnly", -- only the caster (shields, buffs)
	RunnersPvP = "RunnersPvP", -- every other living Runner, never the caster (sabotage)
	All = "All", -- every living character except the caster, plus DestructibleCover parts
}

export type TargetFilterMode = "HostileToRunners" | "SelfOnly" | "RunnersPvP" | "All"

return table.freeze(TargetFilterMode)
