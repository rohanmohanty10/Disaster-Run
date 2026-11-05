  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local GenericModule = require(PathShortcuts.GenericModule);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local _ = PathShortcuts.ClientAssets;

return function(p1, p2, p3) -- Line: 7
    -- upvalues: AssetHandler (copy), GenericModule (copy)
    local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local u4;

    if p2 then
        u4 = p2:Clone();
    else
        u4 = AssetHandler.GetAsset("Particles/Teleport", p3):Clone();
    end;

    u4.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(0, 1.5707963267948966, 0);
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = HumanoidRootPart;
    WeldConstraint.Part1 = u4;
    WeldConstraint.Parent = u4;
    u4.Parent = game.Workspace.Effects;

    for _, descendant in pairs(u4:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            GenericModule.Emit(descendant);
        end;
    end;

    task.delay(2.5, function() -- Line: 29
        -- upvalues: u4 (copy)
        u4:Destroy();
    end);
end;