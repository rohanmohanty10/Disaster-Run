  

 

local u1 = game.ReplicatedStorage:WaitForChild("Client Assets");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p2, p3, p4) -- Line: 7
    -- upvalues: ParticleHandler (copy), u1 (copy)
    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");
    local HumanoidRootPart2 = p3:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and HumanoidRootPart2) then
        return;
    end;

    local v5;

    if p2 then
        v5 = ParticleHandler.GetUnusualHSVData({
            Character = p2
        });
    else
        v5 = nil;
    end;

    local v6, v7, v8 = CFrame.lookAt(HumanoidRootPart2.Position, HumanoidRootPart.Position):ToOrientation();
    local v9 = CFrame.new(HumanoidRootPart2.Position) * (p4 or CFrame.identity) * CFrame.Angles(v6, v7, v8);
    local u10 = u1["D4C: Love Train"].Swipe:Clone();
    ParticleHandler.Unusualify(u10, {
        HSVData = v5
    });
    u10.CFrame = v9;
    u10.Parent = game.Workspace.Effects;

    for _, descendant in pairs(u10:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
        end;
    end;

    task.delay(3, function() -- Line: 32
        -- upvalues: u10 (copy)
        u10:Destroy();
    end);
end;