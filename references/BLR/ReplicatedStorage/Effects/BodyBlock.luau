  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
local _ = game.Lighting;
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);

return function(p1) -- Line: 12
    -- upvalues: VfxManager (copy)
    local HumanoidRootPart = p1.Char:FindFirstChild("HumanoidRootPart");

    for _, child in script.Attachments:GetChildren() do
        child:Clone().Parent = HumanoidRootPart;
    end;

    local u2 = {};
    local v3 = script.BodyBEffects:Clone();
    v3.Parent = workspace.Debris;
    v3.CFrame = HumanoidRootPart:FindFirstChild("BodyBEffects").WorldCFrame;
    VfxManager.Emit(v3);
    u2[v3] = v3;
    task.delay(0.26666666666666666, function() -- Line: 30
        -- upvalues: HumanoidRootPart (copy), VfxManager (ref), u2 (copy)
        local v4 = script.BodyBEffects:Clone();
        v4.Parent = workspace.Debris;
        v4.CFrame = HumanoidRootPart:FindFirstChild("BodyBEffects").WorldCFrame;
        VfxManager.Emit(v4);
        u2[v4] = v4;
    end);
    task.delay(10, function() -- Line: 39
        -- upvalues: u2 (copy), HumanoidRootPart (copy)
        for _, v in u2 do
            local v5 = HumanoidRootPart:FindFirstChild(v.Name);

            if v5 then
                v5:Destroy();
            end;

            v:Destroy();
        end;

        table.clear(u2);
    end);
end;