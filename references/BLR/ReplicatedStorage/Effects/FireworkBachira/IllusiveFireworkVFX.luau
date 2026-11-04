  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);

return function(p1) -- Line: 14
    -- upvalues: EmitModule (copy), Debris (copy), SoundManager (copy)
    if p1.Explode then
        local v2 = {};

        for _, v in p1.Explode do
            local Attribute = v:GetAttribute("Color");
            local v3 = script[`clonefireworkemit{Attribute}`]:Clone();
            v3.CFrame = v.HumanoidRootPart.CFrame;
            v3.Parent = workspace.Debris;
            table.insert(v2, v3);
            EmitModule.emit(v3);
            Debris:AddItem(v3, 3);
        end;

        return;
    end;

    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local u4 = {};
    SoundManager.SpawnSound("IllusiveFireworks", 0.9, Char.HumanoidRootPart, 130, false);
    local v5 = script.Start:Clone();
    v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.0762939453, 0.912938833, 0.964286804, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    v5.Parent = workspace.Debris;
    table.insert(u4, v5);
    EmitModule.emit(v5);
    Debris:AddItem(v5, 3);
    task.delay(3, function() -- Line: 51
        -- upvalues: u4 (copy)
        for _, v in u4 do
            if v then
                v:Destroy();
            end;
        end;
    end);
end;