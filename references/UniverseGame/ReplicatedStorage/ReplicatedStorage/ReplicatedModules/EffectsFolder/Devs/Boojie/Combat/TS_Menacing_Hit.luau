  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local GenericModule = require(PathShortcuts.GenericModule);
local ClientAssets = PathShortcuts.ClientAssets;

return function(p1, p2) -- Line: 6
    -- upvalues: ClientAssets (copy), GenericModule (copy)
    if not (p1 and p2) then
        return;
    end;

    local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart");
    local HumanoidRootPart2 = p2:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and HumanoidRootPart2) then
        return;
    end;

    local v3, v4, v5 = CFrame.lookAt(HumanoidRootPart2.Position, HumanoidRootPart.Position):ToOrientation();
    local v6 = CFrame.new(HumanoidRootPart2.Position) * CFrame.Angles(v3, v4, v5);
    local u7 = ClientAssets.Combat.TSHit:Clone();
    u7.CFrame = v6;
    u7.Parent = game.Workspace.Effects;

    for _, descendant in pairs(u7:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            GenericModule.Emit(descendant);
        end;
    end;

    task.delay(1.5, function() -- Line: 26
        -- upvalues: u7 (copy)
        u7:Destroy();
    end);
end;