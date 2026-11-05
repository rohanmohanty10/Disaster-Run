  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
Knit.OnStart():andThen(function() -- Line: 14
    -- upvalues: u1 (ref), Knit (copy), u4 (ref), u3 (ref), PathShortcuts (copy), u2 (ref)
    u1 = Knit.GetService("RigService");
    u4 = Knit.GetService("EffectService");
    u3 = Knit.GetService("TagService");
    u2 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);

return {
    Inherit = {
        AbilityName = "Ope"
    },
    Animations = {
        Action = {
            PoseIdle = 16947400723,
            PoseTransition = 16947398251
        }
    },
    Stats = {
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                PoseLoop = function(p5, p6) -- Line: 37, Name: PoseLoop
                end,

                PoseTransition = function(p7, p8) -- Line: 41, Name: PoseTransition
                    -- upvalues: u3 (ref), u2 (ref), u1 (ref), AssetHandler (copy), u4 (ref)
                    local _ = p7.Stats;
                    local _ = p7.Player;
                    local Character = p7.Character;
                    local RootPart = p7.RootPart;
                    local Trove = p8.Trove;
                    Trove:Add(u3:Add(p7.Tags, "NoRotate"));
                    u2.PlaySound(Character, "Pose SFX");
                    Trove:Add(function() -- Line: 54
                        -- upvalues: u2 (ref), Character (copy)
                        u2.StopSound(Character, "Pose SFX");
                    end);
                    local Sheath = Character:FindFirstChild("Sheath");

                    if Sheath then
                        local u9 = {};

                        for _, descendant in Sheath:GetDescendants() do
                            if descendant:IsA("BasePart") then
                                u9[descendant] = descendant.Transparency;
                                descendant.Transparency = 1;
                            end;
                        end;

                        Trove:Add(function() -- Line: 66
                            -- upvalues: u9 (copy)
                            for i, v in u9 do
                                if i:IsDescendantOf(game) then
                                    i.Transparency = v;
                                end;
                            end;
                        end);
                    end;

                    local Part = u1.CreateRig(Character, {
                        AbilityValue = 911,
                        DisplayName = "PoseProp",
                        Cloned = true,
                        Type = "Stand",
                        Instance = AssetHandler.GetAsset("Models/PoseProp", p7),
                        Rigs = {
                            Part = {
                                AttachTo = "Right Arm",
                                C0 = CFrame.new(
                                    -1.54762268,
                                    -1.76005554,
                                    -0.0876464844,
                                    -0.0306882411,
                                    -4.23555056e-15,
                                    -0.9995296,
                                    1.19153157e-7,
                                    1,
                                    -3.6583172e-9,
                                    0.999529004,
                                    -7.15255737e-7,
                                    -0.0306882225
                                )
                            }
                        }
                    }, Trove):Get("MainRig").Part;
                    Part.Transparency = 1;
                    task.delay(0.43333333333333335, function() -- Line: 90
                        -- upvalues: Character (copy), Part (copy), u4 (ref), RootPart (copy)
                        if not (Character:IsDescendantOf(game) and (Character:GetAttribute("Posing") and Part:IsDescendantOf(game))) then
                            return;
                        end;

                        u4.FireAllClients("Emit Particle V3", {
                            Path = "Particles/PunctureWille/Shambles",
                            AbilityName = "Ope",
                            PlaySounds = true,
                            Character = Character,
                            AttachTo = {
                                Part = Part,
                                Offset = CFrame.identity
                            }
                        });
                        game.TweenService:Create(Part, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Transparency = 0
                        }):Play();
                        task.wait(1.0333333333333334);

                        if Character:IsDescendantOf(game) and Character:GetAttribute("Posing") then
                            u4.FireAllClients("Rock Debris", {
                                Size = Vector3.new(1.25, 1.25, 1.25),
                                Lifetime = 2,
                                Radius = 5.5,
                                Amount = 13,
                                Origin = RootPart.CFrame * CFrame.new(0, 0, 2.75)
                            });
                            u4.FireAllClients("Emit Particle V3", {
                                Path = "Particles/Pose/Slam",
                                AbilityName = "Ope",
                                SkinName = "Pre Timeskip",
                                Origin = RootPart.CFrame * CFrame.new(0, -2.5, 2.75)
                            });
                        end;
                    end);
                end
            }
        },
        ["Counter Shock"] = {
            Shock = {
                HitRemotes = {
                    {
                        Name = "Output",
                        Arguments = {
                            "FX",
                            "Lightning Impact",
                            "__Target",
                            Color3.fromRGB(71, 126, 255)
                        }
                    }
                }
            }
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 16963623242,
            Volume = 1
        },
        ["Pose SFX"] = {
            SoundId = 17209920579,
            Volume = 1
        }
    }
};