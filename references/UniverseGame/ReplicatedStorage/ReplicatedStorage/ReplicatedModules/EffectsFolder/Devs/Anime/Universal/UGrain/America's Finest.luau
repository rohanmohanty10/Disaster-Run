  

 

game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local _ = Players.LocalPlayer;

return function(p1) -- Line: 19
    -- upvalues: ParticleHandler (copy), AssetHandler (copy), EffectsHandler (copy), RunService (copy)
    local v2 = p1 or {};
    local u3 = v2.HSVData or ParticleHandler.GetUnusualHSVData({
        Player = v2.Player or v2.AttackerPlayer,
        Character = v2.Character or v2.Attacker
    });
    local Player = v2.Player;
    local Action = v2.Action;
    local ID = v2.ID;
    local Animation = v2.Animation;
    local Replicator = v2.Replicator;
    local v4 = v2.Speed or 1;
    local v5 = os.clock();

    if not (Replicator and Replicator:IsDescendantOf(game)) then
        repeat
            Replicator = workspace.Effects:FindFirstChild((tostring(ID)));
            task.wait();
        until Replicator and Replicator:IsDescendantOf(game) or os.clock() - v5 > 3;
    end;

    if not Replicator then
        return;
    end;

    local u6 = AssetHandler.GetAbilityData(Player);
    local u7 = workspace.Effects:FindFirstChild("Soldier Boy " .. tostring(ID));

    if not u7 and Action == "Spawn" then
        u7 = AssetHandler.CloneAsset("Models/Soldier Boy", u6);
        ParticleHandler.Unusualify(u7, {
            HSVData = u3
        });
        u7.Name = "Soldier Boy " .. tostring(ID);
        u7.Parent = workspace.Effects;
        u7:PivotTo(Replicator.CFrame);
        EffectsHandler.CallEffect("HighlightObject", u7, {
            FillTransparency = -1.5,
            OutlineTransparency = 1,
            Tween = true,
            Lifetime = 0.5,
            Style = "Sine",
            Direction = "In",
            DepthMode = Enum.HighlightDepthMode.Occluded,
            FillColor = ParticleHandler.TryHSVShift(Color3.fromRGB(18, 115, 17), u3)
        });
        EffectsHandler.CallEffect("Emit Particle V3", {
            VFXForgeEmit = true,
            Path = "Particles/America\'s Finest/Start",
            Origin = u7,
            Player = Player
        });
        local HumanoidRootPart = u7:WaitForChild("HumanoidRootPart");
        local u8 = os.clock();
        local u9 = nil;
        u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 78
            -- upvalues: Replicator (ref), u7 (ref), u9 (ref), EffectsHandler (ref), ParticleHandler (ref), HumanoidRootPart (copy), u8 (ref), AssetHandler (ref), u6 (copy), u3 (copy)
            if Replicator and (Replicator.Parent and (u7 and u7.Parent)) then
                HumanoidRootPart.CFrame = HumanoidRootPart.CFrame:Lerp(Replicator.CFrame, 5 * p10);

                if u7:GetAttribute("Running") and os.clock() - u8 > 0.1 then
                    u8 = os.clock();
                    local v11 = AssetHandler.CloneAsset("Particles/America\'s Finest/RunMeshes", u6);
                    ParticleHandler.Unusualify(v11, {
                        HSVData = u3
                    });
                    v11.Parent = workspace.Effects;
                    v11:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 0, -2));
                    EffectsHandler.CallEffect("VFXForge Mesh Emit", v11, 1);
                    task.delay(1, v11.Destroy, v11);
                end;

                return;
            end;

            u9:Disconnect();
            u9 = nil;

            if u7 and u7.Parent then
                task.delay(0.5, u7.Destroy, u7);
                EffectsHandler.CallEffect("SK_VANISH", {
                    Transparency = 1,
                    Character = u7,
                    TweenInfo = { 0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut }
                });
                ParticleHandler.EnableAllParticles(u7, false);
            end;
        end);
    end;

    local Animator = u7:WaitForChild("AnimationController"):WaitForChild("Animator");

    if Animation then
        for _, v in Animator:GetPlayingAnimationTracks() do
            v:Stop();
        end;

        local Animation2 = Instance.new("Animation");
        Animation2.AnimationId = Animation;
        Animation2.Parent = u7;
        Animator:LoadAnimation(Animation2):Play(0, nil, v4);
    end;

    local HumanoidRootPart = u7:WaitForChild("HumanoidRootPart");

    if Action == "Run" then
        u7:SetAttribute("Running", true);
        local u12 = AssetHandler.CloneAsset("Particles/America\'s Finest/Running", u6);
        ParticleHandler.Unusualify(u12, {
            HSVData = u3
        });
        u12.Parent = u7;
        ParticleHandler.AttachTo(u12, {
            Part = HumanoidRootPart
        });
        task.spawn(EffectsHandler.CallEffect, "Character Rock Trail V2", {
            Attribute = "Running",
            MinDistance = 5.5,
            Character = u7,
            RockData = {
                MaxRange = 2,
                SideOffset = NumberRange.new(2.4, 4)
            }
        });
        u7:GetAttributeChangedSignal("Running"):Connect(function() -- Line: 153
            -- upvalues: u7 (ref), ParticleHandler (ref), u12 (copy)
            if not u7:GetAttribute("Running") then
                ParticleHandler.EnableAllParticles(u12, false);
            end;
        end);
    end;

    if Action == "Finish" then
        u7:SetAttribute("Running", false);
        task.delay(0.6333333333333333 / v4, function() -- Line: 163
            -- upvalues: EffectsHandler (ref), u7 (ref), Player (copy)
            EffectsHandler.CallEffect("Emit Particle V3", {
                VFXForgeEmit = true,
                Path = "Particles/America\'s Finest/End",
                Origin = u7,
                Player = Player
            });
            EffectsHandler.CallEffect("UGrain Homerun", {
                Character = u7
            });
        end);
    end;
end;