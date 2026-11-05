  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local GenericModule = require(PathShortcuts.GenericModule);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local _ = PathShortcuts.ClientAssets;
Random.new();

return function(p1, p2, p3) -- Line: 8
    -- upvalues: AssetHandler (copy), GenericModule (copy)
    local v4 = RaycastParams.new();
    v4.FilterType = Enum.RaycastFilterType.Whitelist;
    v4.FilterDescendantsInstances = { game.Workspace.Map };
    local v5 = workspace:Raycast(p1, p2, v4);

    if not v5 then
        return;
    end;

    local u6 = AssetHandler.GetAsset("Particles/FierceSlam", p3):Clone();
    u6.CFrame = CFrame.lookAt(v5.Position, v5.Position - v5.Normal) * CFrame.Angles(1.5707963267948966, 0, 0);
    u6.Parent = workspace;

    for _, descendant in pairs(u6:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            GenericModule.Emit(descendant);
        end;
    end;

    task.delay(3, function() -- Line: 28
        -- upvalues: u6 (copy)
        u6:Destroy();
    end);
end;