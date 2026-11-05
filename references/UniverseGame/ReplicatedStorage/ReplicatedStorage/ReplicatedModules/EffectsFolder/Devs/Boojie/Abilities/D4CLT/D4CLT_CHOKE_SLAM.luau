  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1, p2) -- Line: 5
    -- upvalues: ParticleHandler (copy)
    if typeof(p1) == "Instance" then
        if p1:IsA("BasePart") then
            p1 = p1.Position;
        elseif p1:IsA("Attachment") then
            p1 = p1.WorldPosition;
        elseif p1:IsA("Model") then
            local v3 = p1:FindFirstChild("Torso") or p1:FindFirstChild("HumanoidRootPart");

            if not v3 then
                return;
            end;

            p1 = v3.Position;
        end;
    end;

    local v4;

    if p2 then
        v4 = ParticleHandler.GetUnusualHSVData({
            Character = p2
        });
    else
        v4 = nil;
    end;

    local v5 = RaycastParams.new();
    v5.FilterType = Enum.RaycastFilterType.Whitelist;
    v5.FilterDescendantsInstances = { game.Workspace.Map };
    local v6 = workspace:Raycast(p1, Vector3.new(0, -6, 0), v5);

    if not v6 then
        return;
    end;

    local v7 = CFrame.lookAt(v6.Position, v6.Position - v6.Normal) * CFrame.Angles(1.5707963267948966, 0, 0);
    local v8 = game.ReplicatedStorage["Client Assets"]["D4C: Love Train"].ChokeSlam:Clone();
    ParticleHandler.Unusualify(v8, {
        HSVData = v4
    });
    v8.CFrame = v7 * CFrame.new(0, 0.25, 0);
    v8.Parent = workspace.Terrain;

    for _, descendant in pairs(v8:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            task.spawn(function() -- Line: 44
                -- upvalues: descendant (copy)
                local v9 = descendant:GetAttribute("EmitDelay");

                if v9 and v9 > 0 then
                    task.wait(v9);
                end;

                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end);
        end;
    end;

    task.wait(1.6);
    v8:Destroy();
end;