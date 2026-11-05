  

 

local v1 = RaycastParams.new();
v1.FilterType = Enum.RaycastFilterType.Include;
v1.FilterDescendantsInstances = { workspace.Map };
require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p2, p3) -- Line: 7
    if not p2 then
        return;
    end;

    local v4 = script.Avatar:Clone();
    v4.Parent = workspace.Effects;
    local Humanoid = v4.Humanoid;
    local HumanoidRootPart = v4.HumanoidRootPart;
    local u5 = p3 or 21141528;
    pcall(function() -- Line: 19
        -- upvalues: Humanoid (copy), u5 (copy)
        Humanoid:ApplyDescription(game.Players:GetHumanoidDescriptionFromUserId(u5));
    end);
    local HumanoidRootPart2 = p2.HumanoidRootPart;

    repeat
        HumanoidRootPart.CFrame = HumanoidRootPart2.CFrame * CFrame.new(0, -2.5, 0) * CFrame.Angles(-1.5707963267948966, 0, 0);
        task.wait();
    until not (p2:IsDescendantOf(game) and p2:GetAttribute("Mount"));

    v4:Destroy();
end;