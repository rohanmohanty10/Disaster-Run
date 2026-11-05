  

 

local v1 = {
    Moveset = {
        MovesInfo = {
            ["Fightsabre - Shoot"] = {
                DefaultKeybind = "T+",
                Unlocked = true,
                Description = "Fire a quick gun-shot using your fightsabre, you must have ammo."
            },
            ["Fightsabre - Reload"] = {
                DefaultKeybind = "Y+",
                Unlocked = true,
                Description = "Pull out fightsabre and move it around two times while reloading your ammo."
            }
        }
    },
    Stats = {},
    Animations = {
        Action2 = {
            ["Fightsabre Shoot"] = 109518776171733,
            ["Fightsabre Reload"] = 88224010581688
        }
    },
    Sounds = {}
};
v1.Stats["Fightsabre - Shoot"] = {
    Active = true,
    Damage = 3,
    Stun = 0.25,
    Distance = 2.5,
    HitAnimations = "Default",
    Actionable = {
        Active = true,

        Check = function(p2) -- Line: 29, Name: Check
            return p2:GetAttribute("FightsabreAmmo") and (typeof(p2:GetAttribute("FightsabreAmmo")) == "number" and p2:GetAttribute("FightsabreAmmo") >= 1) and true or false;
        end
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    HitSounds = {
        Hit = {
            SoundId = 17487881331,
            Volume = 2
        }
    },
    HitRemotes = {
        {
            Name = "Output",
            Arguments = {
                "FX",
                "Shadow_Hit",
                {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    LookAt = "Attacker",
                    Particle = game.ReplicatedStorage["Client Assets"].Universal.BloodVFX
                }
            }
        }
    }
};
v1.Stats["Fightsabre - Reload"] = {
    Active = true,
    Damage = 15,
    HitAnimations = "Default",
    Properties = {
        Armor = true
    },
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Block = {
        PerfectBlockable = false
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 20,
        Time = 0.1
    },
    HitSounds = {},
    HitRemotes = {
        {
            Name = "Output",
            Arguments = {
                "FX",
                "HitEffect V3",
                {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    AutoSerialize = true,
                    LookAt = "Attacker",
                    Particle = game.ReplicatedStorage["Client Assets"].Universal.UniversalHeavyVFX,
                    Offset = CFrame.Angles(0, 3.141592653589793, 0),
                    Color = Color3.fromRGB(255, 255, 255)
                }
            }
        }
    }
};

return v1;