  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local Middleware = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = Middleware.GetMiddleware("CombatService");
local u2 = nil;
Knit.OnStart():andThen(function() -- Line: 16
    -- upvalues: u2 (ref), Knit (copy)
    u2 = Knit.GetService("AchievementService");
end);
local u3 = {
    Damage = 15,
    Priority = Enums.Intangible.Ragdoll,
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 12,
        Predict = false,
        Offset = CFrame.new(0, 0, -6)
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Burn",
            Damage = 0.5,
            Overrides = {
                Lifetime = 6,
                Rate = 0.25
            }
        } },
    HitSounds = {
        Hit = {
            SoundId = 17191619985,
            Volume = 1
        }
    },
    Block = {
        Blockable = false,
        BlockBreak = false,
        BypassCounter = true,
        PerfectBlockable = false
    },
    Ragdoll = {
        Time = 2
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 20,
        Time = 0.25,
        Velocity = Vector3.new(0, 10, 0)
    },
    ColorThemes = {
        Igris = Color3.fromRGB(23, 25, 125),
        ["Frost Knight"] = Color3.fromRGB(110, 183, 217),
        ["Black Knight"] = Color3.fromRGB(25, 25, 25),
        Reinhardt = Color3.fromRGB(52, 177, 255),
        ["Drakonar\'s Flameblade"] = Color3.fromRGB(217, 153, 74)
    }
};
local Trove = require(Knit.Util.Trove);
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
Knit.OnStart():andThen(function() -- Line: 94
    -- upvalues: u4 (ref), Knit (copy), u5 (ref), u6 (ref), u7 (ref)
    u4 = Knit.GetService("RigService");
    u5 = Knit.GetService("EffectService");
    u6 = Knit.GetService("TagService");
    u7 = Knit.GetService("AnimationService");
end);

return {
    PostRig = function(u8) -- Line: 102, Name: PostRig
        -- upvalues: u6 (ref), u7 (ref), Knit (copy), u1 (copy), u2 (ref), Trove (copy), u5 (ref), ParticleHandler (copy), u3 (copy)
        local Character = u8.Character;
        local Player = u8.Player;
        local Trove2 = u8.Trove;

        repeat
            task.wait(0.25);
        until Character:WaitForChild("Head");

        if Player:IsA("Player") then
            Player:HasAppearanceLoaded();
        end;

        local u9 = u8.SkinName == "Reinhardt";
        local Humanoid = Character:FindFirstChild("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

        if not (Humanoid and HumanoidRootPart) then
            warn("Cannot find Humanoid or RootPart");

            return;
        end;

        if not u6:GetContainer(Character) then
            warn("Cannot find Tags");

            return;
        end;

        local u10 = u7.Get(Humanoid:FindFirstChildWhichIsA("Animator"));

        if not u10 then
            warn("Cannot find Animator");

            return;
        end;

        local u11 = Knit.GetService("StatService").GetStatsInfo(Character);

        if u8.AbilityValue ~= 23 then
            u11:SetExternalStats("ArmorStats", nil);

            return;
        end;

        u11:SetExternalStats("ArmorStats", (u11.CreateStatsObject({
            Defense = 10,
            Health = 10
        })));
        local u12 = 0;

        if Player and Player.Data.Skin:GetAttribute("UnusualHueId") then
            u12 = u12 + Player.Data.Skin:GetAttribute("UnusualHueId") * 5;
        end;

        Trove2:Add(function() -- Line: 153
            -- upvalues: u11 (copy), u1 (ref), Character (copy)
            u11:SetExternalStats("ArmorStats", nil);
            u1.AttackHook:Unhook("Inbound", "DKRebirth" .. Character.Name);
        end);

        if not Character:GetAttribute("DKRebirth") then
            u1.AttackHook:Hook("Inbound", "DKRebirth" .. Character.Name, 105, function(p13) -- Line: 159
                -- upvalues: Character (copy), u1 (ref), Humanoid (copy), u2 (ref), Player (copy), Trove (ref), u10 (copy), HumanoidRootPart (copy), u9 (copy), u5 (ref), ParticleHandler (ref), u3 (ref), u8 (copy), u12 (ref)
                if p13.Target ~= Character then
                    return true;
                end;

                local Stats = p13.Stats;

                if Character:GetAttribute("DKRebirth") or p13.State.Halt then
                    return true;
                end;

                local v14 = u1.GetMeter(Character);

                if Stats.Damage and (Humanoid.Health - Stats.Damage < 1 and (v14 >= 100 and not Stats.IgnoreProcessing)) then
                    p13.State.Halt = true;
                    p13.State.Continue = false;
                    u1.Interrupted:Fire(Character, {
                        Type = "Ragdoll"
                    });

                    if Stats.Damage then
                        Stats.Damage = 0;
                    end;

                    Humanoid:SetAttribute("ForcedMaxHealth", 200);
                    task.defer(function() -- Line: 180
                        -- upvalues: Humanoid (ref)
                        Humanoid.MaxHealth = 200;
                        Humanoid.Health = 200;
                    end);
                    Character:SetAttribute("DKRebirth", true);
                    Character:SetAttribute("DKCantHealPassive", true);
                    u2.IncrementAchievement(Player, "UseMove", "RebirthPassive");
                    task.spawn(function() -- Line: 204
                        -- upvalues: Trove (ref), Character (ref), u1 (ref), u10 (ref), HumanoidRootPart (ref), Player (ref), u9 (ref), u5 (ref), ParticleHandler (ref), u3 (ref), u8 (ref), u12 (ref)
                        local u15 = Trove.new();
                        u15:AttachToInstance(Character);
                        u1.PlaySound(Character, "Rebirth");
                        u1.PlaySound(Character, "Rebirth " .. math.random(1, 3));
                        u10:PlayAnimation("Rebirth", 1);
                        local v16 = {
                            Origin = HumanoidRootPart.CFrame,
                            Object = HumanoidRootPart,
                            Player = Player
                        };

                        if u9 then
                            v16.Asset = {
                                Name = "Particles/RebirthExplosion",
                                AbilityName = "Dragon Knight",
                                SkinName = "Reinhardt"
                            };
                        end;

                        u5.FireAllClients("DK Explosion", v16);
                        ParticleHandler.EnableAllParticles(Character, true, "AbilityAura");
                        local PointLight = Instance.new("PointLight");
                        PointLight.Brightness = 5;
                        PointLight.Range = 8;
                        PointLight.Color = u3.ColorThemes[u8.SkinName] or Color3.fromRGB(255, 106, 19);

                        if u12 > 0 then
                            PointLight.Color = ParticleHandler.HSVShift(PointLight.Color, {
                                HueShift = u12
                            });
                        end;

                        u15:Add(PointLight);
                        PointLight.Parent = HumanoidRootPart;

                        if u9 then
                            local Highlight = Instance.new("Highlight");
                            Highlight.OutlineColor = Color3.fromRGB(52, 177, 255);
                            Highlight.FillColor = Color3.fromRGB(97, 121, 255);
                            Highlight.OutlineTransparency = 0;
                            Highlight.FillTransparency = 0.75;
                            Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;

                            if u12 > 0 then
                                Highlight.OutlineColor = ParticleHandler.HSVShift(Highlight.OutlineColor, {
                                    HueShift = u12
                                });
                                Highlight.FillColor = ParticleHandler.HSVShift(Highlight.FillColor, {
                                    HueShift = u12
                                });
                            end;

                            u15:Add(Highlight);
                            Highlight.Parent = Character;
                        end;

                        for _, v in u1.Hitbox({
                            Caster = Character,
                            Stats = u3
                        }) do
                            u1.Attack({
                                Attacker = Character,
                                Target = v.Character,
                                Stats = u3
                            });
                        end;

                        local v17 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild("Dragon Knight", true);
                        require(v17.Common).CreateFireArea({
                            Character = Character,
                            MoveData = {
                                AbilityName = "Dragon Knight",
                                SkinName = Character:GetAttribute("SkinName")
                            },
                            Offset = HumanoidRootPart.CFrame
                        });
                        task.delay(1.5, function() -- Line: 282
                            -- upvalues: u1 (ref), Character (ref)
                            u1.PlaySound(Character, "Rebirth Ambience");
                        end);
                        task.delay(3, function() -- Line: 287
                            -- upvalues: u15 (copy)
                            u15:Destroy();
                        end);
                    end);
                end;

                return true;
            end);
        end;
    end
};