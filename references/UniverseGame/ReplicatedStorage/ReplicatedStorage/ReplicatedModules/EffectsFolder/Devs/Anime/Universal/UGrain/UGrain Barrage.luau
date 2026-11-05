  

 

game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local u1 = Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local _ = Players.LocalPlayer;
local u2 = {
    Default = Color3.fromRGB(105, 141, 192),
    ["Reverse Flash"] = Color3.fromRGB(172, 12, 12),
    ["CW Flash"] = Color3.fromRGB(188, 125, 69),
    ["Injustice Flash"] = Color3.fromRGB(234, 201, 15)
};

return function(p3) -- Line: 27
    -- upvalues: ParticleHandler (copy), AssetHandler (copy), u1 (copy), EffectsHandler (copy), u2 (copy), RunService (copy)
    local v4 = p3 or {};
    local v5 = v4.HSVData or ParticleHandler.GetUnusualHSVData({
        Player = v4.Player or v4.AttackerPlayer,
        Character = v4.Character or v4.Attacker
    });
    local Player = v4.Player;
    local Character = v4.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local v6 = AssetHandler.GetAbilityData(Player);
    local v7 = AssetHandler.CloneAsset("Particles/Barrage/Loop", v6);
    ParticleHandler.Unusualify(v7, {
        HSVData = v5
    });
    v7.Parent = HumanoidRootPart;
    ParticleHandler.AttachTo(v7, {
        Part = HumanoidRootPart
    });
    ParticleHandler.Emit(v7, ParticleHandler.GenerateEmitInfo(v7));
    ParticleHandler.EnableAllParticles(v7, true);

    local function Sign() -- Line: 46
        return math.random(1, 2) == 1 and 1 or -1;
    end;

    local function Bezier(p8, p9, p10, p11) -- Line: 50
        local v12 = 1 - p11;

        return p8 * (v12 * v12) + p9 * (2 * v12 * p11) + p10 * (p11 * p11);
    end;

    repeat
        local v13 = math.random(1, 2) == 1 and 1 or -1;
        local v14 = HumanoidRootPart.CFrame * CFrame.new(v13 * u1:NextNumber(5, 12), math.random(-4, 4), math.random(5, 8));
        local v15 = HumanoidRootPart.CFrame * CFrame.new(v13 * u1:NextNumber(2.5, 5), u1:NextNumber(-1, 1), u1:NextNumber(-8, -6));
        local v16 = CFrame.new(v15.Position, v15.Position + (v15.Position - v14.Position).Unit);
        local v17 = AssetHandler.CloneAsset("Particles/Barrage/RandomHit", v6);
        ParticleHandler.Unusualify(v17, {
            IncludeParts = true,
            IncludeTextures = true,
            HSVData = v5
        });
        v17.Parent = workspace.Effects;
        v17:PivotTo(v16);
        EffectsHandler.CallEffect("VFXForge Mesh Emit", v17, 1);
        task.delay(1, v17.Destroy, v17);
        local v18 = CFrame.new(v15.Position, v15.Position + (v15.Position - v14.Position).Unit);
        local u19 = AssetHandler.CloneAsset("Particles/Barrage/Trail", v6);
        ParticleHandler.Unusualify(u19, {
            HSVData = v5
        });
        ParticleHandler.EnableAllParticles(u19, false);
        u19.Parent = workspace.Effects;
        local Position = (HumanoidRootPart.CFrame * CFrame.new(v13 * u1:NextNumber(4, 6), u1:NextNumber(-2, 2), u1:NextNumber(8, 11))).Position;
        local Position2 = (HumanoidRootPart.CFrame * CFrame.new(v13 * (math.random(1, 2) == 1 and 1 or -1) * u1:NextNumber(11, 15), u1:NextNumber(-1, 3), u1:NextNumber(0, 5))).Position;
        local Position3 = v18.Position;
        local v20 = u1:NextNumber(-4, 4);
        local v21 = u1:NextNumber(-3, 3);
        local u22 = Position3 + Vector3.new(v20, v21, u1:NextNumber(-4.5, 0.5));
        local u23 = u1:NextNumber(0.1, 0.25);
        local u24 = os.clock();
        u19.CFrame = CFrame.new(Position);
        local v25 = u19:FindFirstChildOfClass("Attachment");
        v25:SetAttribute("Enabled", true);
        task.spawn(EffectsHandler.CallEffect, "LightningTrail", {
            Size = 0.2,
            MinLength = 0.15,
            Color = ColorSequence.new(ParticleHandler.TryHSVShift(u2[v4.SkinName] or u2.Default, v5)),
            DurationMultiplier = Character:GetAttribute("Flashtime") and 2 or 1,
            Reference = v25,
            Player = Player,
            Character = Character
        });
        local u26 = nil;
        u26 = RunService.RenderStepped:Connect(function() -- Line: 104
            -- upvalues: u24 (copy), u23 (copy), u26 (ref), ParticleHandler (ref), u19 (copy), Position (copy), Position2 (copy), u22 (copy)
            local v27 = (os.clock() - u24) / u23;

            if v27 >= 1 then
                u26:Disconnect();
                u26 = nil;
                ParticleHandler.EnableAllParticles(u19, false);
                task.delay(1, u19.Destroy, u19);

                return;
            end;

            local v28 = 1 - v27;
            local v29 = math.min(v27 + 0.05, 1);
            local v30 = 1 - v29;
            u19.CFrame = CFrame.new(Position * (v28 * v28) + Position2 * (2 * v28 * v27) + u22 * (v27 * v27), Position * (v30 * v30) + Position2 * (2 * v30 * v29) + u22 * (v29 * v29));
        end);
        EffectsHandler.Wait(0.04);
    until HumanoidRootPart.Parent == nil or not Character:GetAttribute("UGrainBarrage");

    ParticleHandler.EnableAllParticles(v7, false);
    ParticleHandler.DestroyEmit(v7);
end;