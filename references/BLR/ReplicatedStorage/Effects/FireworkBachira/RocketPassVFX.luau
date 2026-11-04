  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);

return function(p1) -- Line: 14
    -- upvalues: SoundManager (copy), EmitModule (copy), Debris (copy)
    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local u2 = {};
    SoundManager.SpawnSound("RocketPass", 0.9, Char.HumanoidRootPart, 130, false);
    local Folder = Instance.new("Folder");
    Folder.Name = "FWBachiraHighlight";
    Folder.Parent = Char;
    task.delay(1.4, Folder.Destroy, Folder);
    task.wait(1.15);
    local v3 = script["1"]:Clone();
    v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.410881042, -0.208961487, -1.35569, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    v3.Parent = workspace.Debris;
    table.insert(u2, v3);
    EmitModule.emit(v3);
    Debris:AddItem(v3, 3);
    task.delay(3, function() -- Line: 39
        -- upvalues: u2 (copy)
        for _, v in u2 do
            if v then
                v:Destroy();
            end;
        end;
    end);
end;