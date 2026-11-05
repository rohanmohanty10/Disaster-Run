  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.GenericModule);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local _ = PathShortcuts.ClientAssets;
require(Knit.Util.Trove);
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = EffectsHandler.GetEffect("Emit Particle V3");

return function(p2, p3, p4) -- Line: 16
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), u1 (copy)
    local v5 = p4 or {};
    local v6 = p2:FindFirstChild("CM_Stand") or p2:FindFirstChild("Stand");

    if v6 then
        v6 = v6:FindFirstChild("Stand Left Arm");
    end;

    local _Blackhole = p2:FindFirstChild("_Blackhole");

    if not p3 then
        if _Blackhole then
            _Blackhole.Name = "_BlackholeEnd";

            for _, descendant in pairs(_Blackhole:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(3, function() -- Line: 31
                -- upvalues: _Blackhole (ref)
                _Blackhole:Destroy();
            end);
        end;

        return;
    end;

    if _Blackhole then
        return;
    end;

    local v7 = AssetHandler.GetAsset("Particles/Blackhole", v5):Clone();
    ParticleHandler.Unusualify(v7, {
        Character = p2
    });
    v7.Name = "_Blackhole";
    local Weld = Instance.new("Weld");
    Weld.Part0 = v6;
    Weld.Part1 = v7;
    Weld.C0 = CFrame.new(0, -1.5, 0);
    Weld.Parent = p2;
    u1({
        Enabled = true,
        Clone = false,
        Destroy = false,
        Parent = false,
        Character = p2,
        Particle = v7,
        SkinName = v5.SkinName
    });
    v7.Parent = p2;
end;