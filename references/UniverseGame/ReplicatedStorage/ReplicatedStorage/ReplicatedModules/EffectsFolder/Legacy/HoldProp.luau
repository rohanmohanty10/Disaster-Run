  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game.Players.LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(u1, p2, p3, u4, p5, p6) -- Line: 9
    -- upvalues: ReplicatedStorage (copy), ParticleHandler (copy), PathShortcuts (copy), LocalPlayer (copy)
    local v9 = {
        Knives = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Universal.knifeGrip,
            C0 = CFrame.new(0, -1, 0) * CFrame.Angles(0, 3.141592653589793, 3.141592653589793)
        },
        Bone = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Universal.Bone,
            C0 = CFrame.new(0, -1, 0) * CFrame.Angles(0, 3.141592653589793, 3.141592653589793)
        },
        SKnife = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Sakuya.SKnifeGrip,
            C0 = CFrame.new(0, -1, 0) * CFrame.Angles(0, 3.141592653589793, 3.141592653589793)
        },
        Wine = {
            WeldPart = "ArmWeld",
            Model = ReplicatedStorage["Client Assets"].Universal.JuiceGlass,
            C0 = CFrame.new(0, 0, 0)
        },
        EyeTrails = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Universal.EyeTrails,
            C0 = CFrame.new(0, 0, 0)
        },
        CaseyEyeFlames = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Casey.EyeFlames,
            C0 = CFrame.new(0, 0, 0)
        },
        EyeFlameSP = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Universal.EyeFlameSP,
            C0 = CFrame.new(0, 0, 0)
        },
        EyeFlamesAA = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Universal.EyeFlameAA,
            C0 = CFrame.new(0, 0, 0)
        },
        BlackHole = {
            WeldPart = "literally the model itself",
            Unusual = true,
            Model = ReplicatedStorage["Client Assets"].STWR.BlackHole,
            C0 = CFrame.new(0, 0, 0)
        },
        Shock = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Universal.Shock,
            C0 = CFrame.new(0, 0, 0)
        },
        BleedingParticle = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Universal.BleedingParticle,
            C0 = CFrame.new(0, 0, 0)
        },
        BleedingParticle2 = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Universal.BleedingParticle2,
            C0 = CFrame.new(0, 0, 0)
        },
        yoooooooo = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Universal.yoooooooo,
            C0 = CFrame.new(0, 0, 0)
        },
        Sharingan = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Universal.Sharingan,
            C0 = CFrame.new(0, 0, 0)
        },
        DawnEyeTrails = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Dawn.EyeTrails,
            C0 = CFrame.new(0, 0, 0)
        },
        EyeTrailsAA = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Universal.EyeTrailsAA,
            C0 = CFrame.new(0, 0, 0)
        },
        CaseyEyeTrails = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Casey.EyeTrails,
            C0 = CFrame.new(0, 0, 0)
        },
        ArrowS1 = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Universal.ArrowS1,
            C0 = CFrame.new(0, 0, 0)
        },
        ArrowS2 = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Universal.ArrowS2,
            C0 = CFrame.new(0, 0, 0)
        },
        ArrowS3 = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Universal.ArrowS3,
            C0 = CFrame.new(0, 0, 0)
        },
        RoadRoller = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"]["The World"]["Road roler"],
            C0 = CFrame.new(0, 0, 0)
        },
        Glock = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Universal.GlockWeld,
            C0 = CFrame.new(0, 0, 0)
        },
        GlowingLimb = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Universal.GlowingLimb,
            C0 = CFrame.new(0, 0, 0)
        },
        BlueHeart = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Undertale.BlueHeart,
            C0 = CFrame.new(0, 0, 0)
        },
        BleedingLimb = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Universal.BleedingLimb,
            C0 = CFrame.new(0, 0, 0)
        },
        STWRChair = {
            WeldPart = "Weld",
            Model = ReplicatedStorage["Client Assets"].STWR.STWRChair,
            C0 = CFrame.new(0, 0, 0),

            Unusual = function(p7) -- Line: 192, Name: Unusual
                -- upvalues: ParticleHandler (ref), u1 (copy), PathShortcuts (ref)
                local v8 = ParticleHandler.GetUnusualHSVData({
                    Player = u1
                });
                local Character = u1.Character;

                if v8 ~= nil then
                    ({
                        IncludeParts = true
                    }).HSVData = v8;

                    for _, child in p7.Prop:GetChildren() do
                        if child:IsA("BasePart") and child:GetAttribute("Unusual") then
                            child.Color = ParticleHandler.TryHSVShift(child.Color, v8);

                            if Character and v8.Chroma then
                                PathShortcuts.Remotes.ClientBind:Fire(Character, "Chroma", child);
                            end;
                        end;
                    end;
                end;
            end
        },
        DragForce = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Universal.DragForceLimb,
            C0 = CFrame.new(0, 0, 0)
        },
        SlashingParticles = {
            WeldPart = "literally the model itself",
            Unusual = true,
            Model = ReplicatedStorage["Client Assets"].Universal.SlashingParticles,
            C0 = CFrame.new(0, 0, 0)
        },
        ShockwaveParticles = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Universal.ShockwaveParticles,
            C0 = CFrame.new(0, 0, 2.5)
        },
        BluntHitEffect = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Universal.BluntHitEffect,
            C0 = CFrame.new(0, 0, 0)
        },
        BloodHitEffect = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Universal.BloodHitEffect,
            C0 = CFrame.new(0, 0, 0)
        },
        SnakeAwakens = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Killua.SnakeAwakens,
            C0 = CFrame.new(0, 0, 3.5)
        },
        ["WindUp VFX"] = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Universal.WindUpVFX,
            C0 = CFrame.new(0, 2, 0)
        },
        WindUpthing = {
            WeldPart = "literally the model itself",
            Unusual = true,
            Model = ReplicatedStorage["Client Assets"].Universal.WindUpthing,
            C0 = CFrame.new(0, -0.5, 0)
        },
        HeartBag = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Killua.HeartBagWeld,
            C0 = CFrame.new(0, 0, 0)
        },
        EraserCharge = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Broly.EraserCharge,
            C0 = CFrame.new(0, 1, 0)
        },
        EraserCharge2 = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Broly.EraserCharge2,
            C0 = CFrame.new(0, 1, 0)
        },
        EraserBall = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Broly.EraserBall,
            C0 = CFrame.new(0, 1, 0)
        },
        BrolyStrike = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Broly.StrikeEffect,
            C0 = CFrame.new(0, 0, 0)
        },
        OmegastormWindup = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Broly.OmegastormWindup,
            C0 = CFrame.new(0, 0, 0)
        },
        BrolyAura = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Broly.BrolyAura,
            C0 = CFrame.new(0, 0, 0)
        },
        BrolyCharge = {
            WeldPart = "literally the model itself",
            Model = ReplicatedStorage["Client Assets"].Broly.BrolyCharge,
            C0 = CFrame.new(0, 0, 0)
        },
        AnshenShockwave = {
            WeldPart = "literally the model itself",
            Unusual = true,
            Model = ReplicatedStorage["Client Assets"].Anshen.AnshenShockwave,
            C0 = CFrame.new(0, 0, 0)
        }
    };

    if u4 == 0 then
        for _, child in pairs(workspace.Effects:GetChildren()) do
            if child.Name:match(p2) then
                if child:GetAttribute("Owner") and child:GetAttribute("Owner") == u1.Name then
                    child:Destroy();
                elseif not child:GetAttribute("Owner") then
                    child:Destroy();
                end;
            end;
        end;

        return;
    end;

    if p2 == "TuskNails" then
        local ACTValue = LocalPlayer.Data:FindFirstChild("ACTValue");
        local _ = ACTValue and ACTValue.Value > 2;
        p2 = "TuskNailsGold";
    end;

    local v10 = v9[p2].Model:Clone();
    v10:SetAttribute("User", u1.Name);
    v10.Name = u1.Name .. p2;

    if v9[p2].Unusual then
        if type(v9[p2].Unusual) == "function" then
            v9[p2].Unusual({
                Player = u1,
                Prop = v10
            });
        else
            local v11 = ParticleHandler.GetUnusualHSVData({
                Player = u1
            });

            if v11 ~= nil then
                ParticleHandler.HSVShiftParticles(v10, v11);
            end;
        end;
    end;

    if p6 then
        v10:SetAttribute("Owner", u1.Name);
    end;

    if p2 ~= "STWRChair" then
        if v10:IsA("Model") then
            v10.PrimaryPart.Anchored = false;
        else
            v10.Anchored = false;
        end;
    end;

    local Motor6D = Instance.new("Motor6D");
    Motor6D.Parent = v10;

    if v9[p2].WeldPart == "literally the model itself" then
        if p2 == "STWRChair" then
            Motor6D.Part0 = v10.weld;
        else
            Motor6D.Part0 = v10;
        end;
    else
        Motor6D.Part0 = v10:FindFirstChild(v9[p2].WeldPart);
    end;

    Motor6D.Part1 = p3;
    Motor6D.C0 = p5 or v9[p2].C0;
    v10.Parent = workspace.Effects;

    for _, descendant in pairs(v10:GetDescendants()) do
        coroutine.resume(coroutine.create(function() -- Line: 360
            -- upvalues: descendant (copy), u4 (copy)
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") and descendant.Enabled == false then
                descendant.Enabled = true;
                task.delay(u4 * 0.8, function() -- Line: 363
                    -- upvalues: descendant (ref)
                    if descendant then
                        descendant.Enabled = false;
                    end;
                end);
            end;
        end));
    end;

    game.Debris:AddItem(v10, u4);
end;