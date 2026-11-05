  

 

return {
    Avaliable = {
        {
            Name = "Batrang",
            ImageId = "rbxassetid://99468297850283",
            Description = "Batman\'s signature weapon.",
            Hologram = {
                Image = "rbxassetid://70534374310798",
                Rotation = 90,
                Position = UDim2.fromScale(0.689, 0.508),
                Size = UDim2.fromScale(0.705, 0.258)
            },
            Stats = {
                MaxHoldDuration = 1000,
                Damage = 50,
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                Stun = {
                    Time = 0.5
                }
            }
        },
        {
            Name = "Remote Controlled Batrang",
            ImageId = "rbxassetid://110931600678276",
            Description = "Highly maneuverable Batrang that can be controlled after release. Used to hit targets that requires advanced movements in order to avoid obstacles.",
            Hologram = {
                Image = "rbxassetid://130243560620457",
                Rotation = 90,
                Position = UDim2.fromScale(0.689, 0.508),
                Size = UDim2.fromScale(0.705, 0.258)
            },
            Stats = {
                MaxHoldDuration = 1000,
                BatrangDuration = 30,
                Damage = 40,
                Hitbox = {
                    Size = 22
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                Ragdoll = {
                    Time = 2
                },
                Stun = {
                    Time = 2
                },
                Knockback = {
                    Time = 0.2,
                    Speed = 50
                }
            }
        },
        {
            Name = "Smoke Pellet",
            ImageId = "rbxassetid://85752672858998",
            Description = "Flood an area with disorientating smoke to take down enemies in the confusion, or use to escape when under pressure.",
            Hologram = {
                Image = "rbxassetid://109318394332099",
                Rotation = 90,
                Position = UDim2.fromScale(0.709, 0.509),
                Size = UDim2.fromScale(0.425, 0.425)
            },
            Stats = {
                MaxHoldDuration = 1000,
                MaxRange = 50,
                Speed = 115,
                SmokeDuration = 10,
                SpeedBuff = 44
            }
        },
        {
            Name = "Remote Electrical Charge",
            ImageId = "rbxassetid://134252358856558",
            Description = "Fires an electrical charge targetted to administer a localized, non-lethal electric shock to enemies.",
            Hologram = {
                Image = "rbxassetid://106490714208117",
                Rotation = 90,
                Position = UDim2.fromScale(0.7, 0.492),
                Size = UDim2.fromScale(0.35, 0.43)
            },
            Stats = {}
        },
        {
            Name = "Freeze Blast",
            ImageId = "rbxassetid://131563002541776",
            Description = "A projectile that causes an ice-based explosion that will freeze enemies in position for an extended period of time.",
            Hologram = {
                Image = "rbxassetid://79378860046886",
                Rotation = 90,
                Position = UDim2.fromScale(0.709, 0.509),
                Size = UDim2.fromScale(0.425, 0.425)
            },
            Stats = {
                MaxHoldDuration = 1000,
                MaxDistance = 75,
                Speed = 175,
                Damage = 10,
                Stun = {
                    Time = 0.5
                },
                Block = {
                    PerfectBlockable = false,
                    Blockable = true,
                    BlockBreak = true
                },
                Hitbox = {
                    Size = 20
                },
                StatusEffects = { {
                        ApplyTo = "Target",
                        Name = "Freeze",
                        Lifetime = 10
                    } }
            }
        }
    },

    GetGadgetData = function(p1, p2) -- Line: 148, Name: GetGadgetData
        for i, v in p1.Avaliable do
            if v.Name == p2 then
                return {
                    Index = i,
                    Data = v
                };
            end;
        end;
    end,

    GetUIElement = function(p3, p4) -- Line: 159, Name: GetUIElement
        return script[p4];
    end
};