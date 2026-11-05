  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local Petal = _G.Petal;
Petal("New");
Petal("Util");
local v1 = Petal("Extensions");
local _ = PathShortcuts.ClientAssets;
game:GetService("RunService");
require(PathShortcuts.ReplicatedModules.EffectsHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local _ = CFrame.new;
local _ = Vector3.new;
local _ = v1.Rng;

local function Lerp(p2, p3, p4) -- Line: 18
    return p2 + (p3 - p2) * p4;
end;

local ParticleHandler = require(PathShortcuts.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p5) -- Line: 23
    -- upvalues: Trove (copy), AssetHandler (copy), ParticleHandler (copy)
    local Reference = p5.Reference;
    local Character = p5.Character;
    local _ = Character.HumanoidRootPart;
    local u6 = Character:FindFirstChild("Right Arm");
    local v7 = game:GetService("Players"):GetPlayerFromCharacter(Character);
    local u8 = v7 and (v7.Data.Skin:GetAttribute("UnusualHueId") and v7.Data.Skin:GetAttribute("UnusualHueId") * 5) or (p5.HueShift or 0);
    local u9 = Trove.new();
    local v10 = AssetHandler.GetAbilityData(Character);
    local u11 = AssetHandler.GetAsset("Particles/CannonCharge", v10);
    local u12 = {};
    local v13 = u11.ChargeStartup:Clone();
    ParticleHandler.HSVShiftParticles(v13, {
        HueShift = u8
    });
    v13.Parent = u6;
    table.insert(u12, v13);
    u9:Add(v13);

    local function Run(p14) -- Line: 47
        -- upvalues: Reference (ref), u9 (ref), u11 (copy), u6 (copy), u8 (copy), ParticleHandler (ref), u12 (copy)
        if not Reference.Parent then
            u9:Destroy();

            return;
        end;

        local v15 = u11:FindFirstChild((`LEVEL{p14}`)):Clone();
        v15.Parent = u6;

        if u8 ~= 0 then
            ParticleHandler.HSVShiftParticles(v15, {
                HueShift = u8
            });
        end;

        table.insert(u12, v15);
        u9:Add(v15);
    end;

    u9:Connect(Reference:GetPropertyChangedSignal("Value"), function() -- Line: 64
        -- upvalues: Run (copy), Reference (ref)
        Run(Reference.Value);
    end);
    Run(Reference.Value);
    u9:Connect(Reference.AncestryChanged, function() -- Line: 70
        -- upvalues: Reference (ref), u12 (copy), u9 (ref)
        if not Reference.Parent then
            Reference = nil;

            for i = 1, #u12 do
                for _, child in pairs(u12[i]:GetChildren()) do
                    child.Enabled = false;
                end;
            end;

            table.clear(u12);
            task.delay(0.4, function() -- Line: 81
                -- upvalues: u9 (ref)
                u9:Destroy();
                u9 = nil;
            end);
        end;
    end);
end;