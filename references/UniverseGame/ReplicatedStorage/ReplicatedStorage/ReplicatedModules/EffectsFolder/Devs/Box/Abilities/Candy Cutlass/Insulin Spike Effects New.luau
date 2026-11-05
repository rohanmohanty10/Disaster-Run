  

 

game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local PathShortcuts = require(ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p1) -- Line: 10
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), TweenService (copy)
    local v2 = p1 or {};
    local Character = v2.Character;

    if Character == nil then
        return;
    end;

    local v3 = v2.Scale or nil;
    local v4 = v2.Offset or CFrame.new(0, -10, -15);
    local v5;

    if Character then
        v5 = Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart;
        Character:FindFirstChild("Humanoid");
    else
        v5 = nil;
    end;

    if v5 == nil then
        return;
    end;

    local u6 = AssetHandler.CloneAsset("Models/" .. (v2.UseAlternate and "CandyCanesAlt" or "CandyCanes"), {
        AbilityName = "Candy Cutlass",
        SkinName = v2.SkinName
    });
    ParticleHandler.Unusualify(u6, {
        IncludeParts = true,
        Character = v2.Character,
        HSVData = v2.HSVData
    });
    local PrimaryPart = u6.PrimaryPart;

    if v3 then
        u6:ScaleTo(v3);
    end;

    PrimaryPart.CFrame = v5.CFrame * v4;
    u6.Parent = workspace.Effects;
    TweenService:Create(PrimaryPart, TweenInfo.new(0.15), {
        CFrame = PrimaryPart.CFrame * CFrame.new(0, 7, 0)
    }):Play();
    task.delay(3.5, function() -- Line: 42
        -- upvalues: TweenService (ref), PrimaryPart (copy), u6 (copy)
        TweenService:Create(PrimaryPart, TweenInfo.new(0.15), {
            CFrame = PrimaryPart.CFrame * CFrame.new(0, -15, 0)
        }):Play();
        task.delay(0.15, u6.Destroy, u6);
    end);
end;