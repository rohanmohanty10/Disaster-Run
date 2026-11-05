  

 

local v1 = { "rbxassetid://7290321324", "rbxassetid://7290325561", "rbxassetid://7290327465" };

return {
    Guts = {
        ["LMB Combo V3"] = {
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            Cooldown = 0.15,
            ActualCooldown = 3,
            MaxCombo = 4,
            ComboTick = 1.5,
            Damage = 8,
            Stun = 0.75,
            Startup = { 0.185, 0.185, 0.185, 0.185 },
            EndLag = { 0.385, 0.385, 0.385, 0.385 },
            ModifiedCooldowns = { 0.5, 0.75, 1 },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            Knockback = { 5, 0.05 },
            HitAnimation = v1,
            Remotes = { { "FX", "Pudder Emit Particles", "GutsHit" } },
            ["LMB-4"] = {
                Damage = 12.5,
                Stun = 0.25,
                Knockback = { 75, 0.3 }
            }
        },
        ["Blood & Guts"] = {
            Cooldown = 1,
            Damage = 40,
            Stun = 0.75,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 10),
                Offset = CFrame.new(0, 0, -8)
            },
            HitAnimation = v1,
            Remotes = { { "FX", "HitEffect V2", "GutsHit" } }
        },
        ["Loose Cannon"] = {
            Cooldown = 1,
            Damage = 40,
            Stun = 0.75,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            Knockback = { 50, 0.3 },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            HitAnimation = v1,
            Remotes = { { "FX", "HitEffect" } }
        }
    }
};