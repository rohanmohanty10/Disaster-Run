  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 10
    -- upvalues: SoundManager (copy), Essentials (copy), VfxManager (copy)
    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    SoundManager.SpawnSound("UndeadMode", 0.5, HumanoidRootPart, 130, false);
    local u2 = script.new["RUN "]:Clone();
    u2.Parent = workspace.Debris;
    u2.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.15, -0.212, -2.51);
    Essentials:Weld(HumanoidRootPart, u2);
    local u3 = script.new.Aura:Clone();
    local u4 = {};

    for _, child in u3:GetChildren() do
        local v5 = Char:FindFirstChild(child.Name);

        if v5 then
            for _, child2 in child:GetChildren() do
                child2.Parent = v5;
                table.insert(u4, child2);
            end;
        end;
    end;

    task.delay(5, function() -- Line: 36
        -- upvalues: VfxManager (ref), u2 (copy), u4 (copy), u3 (copy)
        VfxManager.Enable(u2, false);

        for _, v in u4 do
            VfxManager.Enable(v, false);
        end;

        task.wait(2);
        u2:Destroy();

        for _, v in u4 do
            v:Destroy();
        end;

        u3:Destroy();
    end);
end;