  

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
    local script_Attachments = script.Attachments;

    for _, child in script_Attachments:GetChildren() do
        child:Clone().Parent = HumanoidRootPart;
    end;

    local u2 = {};

    for _, child in script:GetChildren() do
        if script_Attachments:FindFirstChild(child.Name) then
            local v3 = child:Clone();
            v3.Parent = workspace.Debris;
            v3.CFrame = HumanoidRootPart:FindFirstChild(v3.Name).WorldCFrame;
            u2[v3.Name] = v3;
        end;
    end;

    task.delay(0.5666666666666667, function() -- Line: 33
        -- upvalues: u2 (copy), HumanoidRootPart (copy), VfxManager (ref)
        for _, v in u2 do
            v.CFrame = HumanoidRootPart:FindFirstChild(v.Name).WorldCFrame;
            VfxManager.Emit(v);
        end;

        task.wait(10);

        for _, v in u2 do
            local v4 = HumanoidRootPart:FindFirstChild(v.Name);

            if v4 then
                v4:Destroy();
            end;

            v:Destroy();
        end;

        table.clear(u2);
    end);
end;