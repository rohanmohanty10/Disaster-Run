  

 

local ReplicatedModules = game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules");
local u1, u2;

if game:GetService("RunService"):IsClient() then
    u1 = require(ReplicatedModules.EffectsHandler);
    u2 = game.ReplicatedStorage:WaitForChild("Client Assets");
else
    u1 = nil;
    u2 = nil;
end;

local v32 = {
    Brickbattle_Superball = {
        Properties = {
            MaxBounces = 6,
            Gravity = 2.65,
            Friction = 1,
            Lifetime = 5,
            Speed = 2.75
        },
        Client = {
            PreMovement = function(p3, p4) -- Line: 24, Name: PreMovement
                p3.Color = p4.Color;

                for _, descendant in pairs(p3:GetDescendants()) do
                    if (descendant:IsA("ParticleEmitter") or descendant:IsA("Trail")) and descendant.Name ~= "Disappear" then
                        descendant.Enabled = true;
                    end;
                end;
            end,

            PostMovement = function(u5) -- Line: 33, Name: PostMovement
                u5.Transparency = 1;
                task.delay(3, function() -- Line: 35
                    -- upvalues: u5 (copy)
                    u5:Destroy();
                end);

                for _, descendant in pairs(u5:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                        descendant.Enabled = false;

                        if descendant.Name == "Disappear" then
                            descendant:Emit(descendant:GetAttribute("EmitCount") / 1.5);
                        end;
                    end;
                end;
            end,

            OnCollision = function(p6, p7, p8) -- Line: 48, Name: OnCollision
                -- upvalues: u1 (ref), u2 (ref)
                p6.Bounce:Play();

                if p6:FindFirstChild("BounceEffect") then
                    local v9 = CFrame.new(p8, p8 + p7);
                    u1.CallEffect("Q_EMIT_AT", u2.Brickbattle.Virtuoso.BBounce.BounceEffect, v9 * CFrame.Angles(-1.5707963267948966, 0.017453292519943295, 0) * CFrame.new(0, 0.4, 0));
                end;
            end
        }
    },
    Brickbattle_Rocket = {
        Properties = {
            Gravity = 0,
            Friction = 1,
            Lifetime = 2,
            Speed = 2.25
        },
        Client = {
            PreMovement = function(p10, p11) -- Line: 70, Name: PreMovement
                p10.Color = p11.Color;
                p10.SFX:Play();

                if p10:GetAttribute("SoundId") then
                    p10:FindFirstChild("Explode").SoundId = "rbxassetid://" .. p10:GetAttribute("SoundId");
                end;
            end,

            PostMovement = function(u12) -- Line: 78, Name: PostMovement
                u12.Explode:Destroy();
                u12.Transparency = 1;

                for _, descendant in pairs(u12:GetDescendants()) do
                    if descendant:IsA("Trail") or descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;

                task.delay(1, function() -- Line: 88
                    -- upvalues: u12 (copy)
                    u12:Destroy();
                end);
            end
        }
    },
    Banisher_Bullet = {
        Properties = {
            Gravity = 0.3,
            Friction = 1,
            Lifetime = 2.5,
            Speed = 6,
            InterpolationRate = 0.8
        },
        Client = {
            PreMovement = function(p13, p14) -- Line: 107, Name: PreMovement
                for _, descendant in pairs(p13:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                        descendant.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, p14.Color), ColorSequenceKeypoint.new(1, p14.Color) });
                        descendant.Enabled = true;
                    end;
                end;
            end,

            PostMovement = function(u15) -- Line: 118, Name: PostMovement
                task.delay(2, function() -- Line: 119
                    -- upvalues: u15 (copy)
                    u15:Destroy();
                end);

                for _, descendant in pairs(u15:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                        descendant.Enabled = false;
                    end;
                end;
            end
        }
    },
    ["D4C: Love Train_TBullet"] = {
        Properties = {
            Gravity = 0,
            Friction = 1,
            Lifetime = 10,
            Speed = 8,
            Projectile = "TBullet"
        },
        Client = {
            PreMovement = function(p16) -- Line: 143, Name: PreMovement
                p16.SFX:Play();
            end,

            PostMovement = function(p17) -- Line: 146, Name: PostMovement
                p17:Destroy();
            end
        }
    },
    SilverChariot_RicochetShot = {
        Properties = {
            MaxBounces = 2,
            Gravity = 0,
            Friction = 1,
            Lifetime = 5,
            Speed = 2,
            Projectile = "RicochetShot",
            DestroyOnHum = true,
            CFrameTransform = CFrame.Angles(1.5707963267948966, 0, 0)
        },
        Client = {
            PreMovement = function(p18) -- Line: 167, Name: PreMovement
            end,

            PostMovement = function(p19) -- Line: 170, Name: PostMovement
                p19:Destroy();
            end,

            OnCollision = function(p20, p21) -- Line: 173, Name: OnCollision
                -- upvalues: u1 (ref)
                p20.Bounce:Play();
                u1.CallEffect("RicochetShotSurface", p20, p21);
            end
        }
    },
    Whitesnake_Disc = {
        Properties = {
            Gravity = 1,
            Friction = 0.25,
            Lifetime = 2.5,
            Speed = 3.75,
            Projectile = "Disc",
            CFrameTransform = CFrame.Angles(0, 0, 1.5707963267948966)
        },
        Client = {
            PreMovement = function(p22, p23) -- Line: 192, Name: PreMovement
            end,

            PostMovement = function(u24) -- Line: 195, Name: PostMovement
                task.delay(2, function() -- Line: 196
                    -- upvalues: u24 (copy)
                    u24:Destroy();
                end);

                for _, descendant in pairs(u24:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                        descendant.Enabled = false;
                    end;
                end;
            end
        }
    },
    Whitesnake_Bullet = {
        Properties = {
            Gravity = 0.3,
            Friction = 1,
            Lifetime = 1,
            Speed = 5.25,
            InterpolationRate = 0.8
        },
        Client = {
            PreMovement = function(p25, p26) -- Line: 220, Name: PreMovement
            end,

            PostMovement = function(u27) -- Line: 223, Name: PostMovement
                task.delay(2, function() -- Line: 224
                    -- upvalues: u27 (copy)
                    u27:Destroy();
                end);

                for _, descendant in pairs(u27:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                        descendant.Enabled = false;
                    end;
                end;
            end
        }
    },
    CrazyDiamond_DeadeyeShot = {
        Properties = {
            Gravity = 0.2,
            Friction = 0.5,
            Lifetime = 5,
            Speed = 2.75,
            Projectile = "DeadeyeBullet",
            CFrameTransform = CFrame.Angles(0, -1.5707963267948966, 0)
        },
        Client = {
            PreMovement = function(p28) -- Line: 249, Name: PreMovement
            end,

            PostMovement = function(p29) -- Line: 252, Name: PostMovement
                p29:Destroy();
            end
        }
    },
    Debris_Projectile = {
        Properties = {
            Gravity = 0.2,
            Friction = 0.5,
            Lifetime = 5,
            Speed = 7,
            Projectile = "GERRock",
            CFrameTransform = CFrame.Angles(0, -1.5707963267948966, 0)
        },
        Client = {
            PreMovement = function(p30) -- Line: 269, Name: PreMovement
            end,

            PostMovement = function(p31) -- Line: 272, Name: PostMovement
                p31:Destroy();
            end
        }
    }
};
v32.VirtuosoRocket = v32.Brickbattle_Rocket;

return v32;