  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local GenericModule = require(PathShortcuts.GenericModule);
local ClientAssets = PathShortcuts.ClientAssets;
Random.new();

return function(p1, p2) -- Line: 7
    -- upvalues: ClientAssets (copy), GenericModule (copy)
    if typeof(p1) == "Instance" and p1:IsA("BasePart") then
        p1 = p1.Position + Vector3.new(0, 2, 0);
    end;

    local v3 = RaycastParams.new();
    v3.FilterType = Enum.RaycastFilterType.Include;
    v3.FilterDescendantsInstances = { game.Workspace.Map };
    local v4 = workspace:Raycast(p1, p2 or Vector3.new(0, -8, 0), v3);

    if not v4 then
        return;
    end;

    local u5 = ClientAssets["Gold Experience Requiem"].Hit.Ground:Clone();
    u5.CFrame = CFrame.lookAt(v4.Position, v4.Position - v4.Normal) * CFrame.Angles(1.5707963267948966, 0, 0);
    u5.Parent = workspace;

    for _, descendant in pairs(u5:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            GenericModule.Emit(descendant);
        end;
    end;

    task.delay(3, function() -- Line: 31
        -- upvalues: u5 (copy)
        u5:Destroy();
    end);
end;