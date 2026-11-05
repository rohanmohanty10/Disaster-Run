  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = game.ReplicatedStorage:WaitForChild("Client Assets");

return function(p2, p3) -- Line: 6
    -- upvalues: ParticleHandler (copy), u1 (copy)
    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");
    local HumanoidRootPart2 = p3:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and HumanoidRootPart2) then
        return;
    end;

    local v4;

    if p2 then
        v4 = ParticleHandler.GetUnusualHSVData({
            Character = p2
        });
    else
        v4 = nil;
    end;

    local v5, v6, v7 = CFrame.lookAt(HumanoidRootPart2.Position, HumanoidRootPart.Position):ToOrientation();
    local v8 = CFrame.new(HumanoidRootPart2.Position) * CFrame.Angles(v5, v6, v7) * CFrame.Angles(0, 3.141592653589793, 0);
    local u9 = u1["D4C: Love Train"].LTHit1:Clone();
    ParticleHandler.Unusualify(u9, {
        HSVData = v4
    });
    u9.CFrame = v8;
    u9.Parent = game.Workspace.Effects;

    for _, descendant in pairs(u9:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
        end;
    end;

    task.delay(3, function() -- Line: 31
        -- upvalues: u9 (copy)
        u9:Destroy();
    end);
end;