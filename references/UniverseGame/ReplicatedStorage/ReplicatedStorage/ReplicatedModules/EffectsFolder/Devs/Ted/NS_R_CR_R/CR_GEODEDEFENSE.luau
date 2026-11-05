  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local u1 = game.ReplicatedStorage:WaitForChild("Client Assets");
local TweenService = game:GetService("TweenService");

return function(p2, p3) -- Line: 8
    -- upvalues: u1 (copy), TweenService (copy)
    local v4 = p2:FindFirstChildOfClass("Humanoid");
    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and v4) then
        return;
    end;

    if not p3 then
        local Crystal = p2:FindFirstChild("Crystal");

        if Crystal then
            Crystal.Name = "CrsytalOff";
            Crystal:Destroy();
        end;

        return;
    end;

    local v5 = u1.CR_R.Crystal:Clone();
    v5.CFrame = HumanoidRootPart.CFrame;
    v5.Parent = p2;
    v5.Size = Vector3.new(0, 0, 0);
    TweenService:Create(v5, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Size = Vector3.new(12.5, 16, 11.25)
    }):Play();
    v5.Parent = p2;
end;