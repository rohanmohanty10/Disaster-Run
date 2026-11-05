  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Trove = require(ReplicatedStorage.ReplicatedModules.KnitPackage.Trove);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p1) -- Line: 8
    -- upvalues: AssetHandler (copy), Trove (copy), TweenService (copy)
    local v2 = AssetHandler.GetAsset("Models/Needle", {
        AbilityName = "Misaka Mikoto"
    });
    local v3 = p1:WaitForChild("Left Arm", 5);
    local v4 = p1:WaitForChild("Right Arm", 5);

    if not (v3 and v4) then
        return;
    end;

    local u5 = Trove.new();

    local function Weld(p6, p7, p8) -- Line: 19
        -- upvalues: u5 (copy)
        local v9 = u5:Add(Instance.new("Weld"));
        v9.Part0 = p6;
        v9.Part1 = p7;
        v9.Parent = p7;

        return v9;
    end;

    local v10 = { -0.25, 0, 0.25 };

    for i = 1, 3 do
        local v11 = u5:Clone(v2);
        v11.Anchored = false;
        v11.CanCollide = false;
        v11.Massless = true;
        local v12 = u5:Add(Instance.new("Weld"));
        v12.Part0 = v4;
        v12.Part1 = v11;
        v12.Parent = v11;
        v11.Parent = workspace.Effects;
        TweenService:Create(v12, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            C0 = CFrame.new(0, -1, v10[i])
        }):Play();
    end;

    for i = 1, 3 do
        local v13 = u5:Clone(v2);
        v13.Anchored = false;
        v13.CanCollide = false;
        v13.Massless = true;
        local v14 = u5:Add(Instance.new("Weld"));
        v14.Part0 = v3;
        v14.Part1 = v13;
        v14.Parent = v13;
        v13.Parent = workspace.Effects;
        TweenService:Create(v14, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            C0 = CFrame.new(0, -1, v10[i])
        }):Play();
    end;

    task.delay(0.38333333333333336, u5.Destroy, u5);
end;