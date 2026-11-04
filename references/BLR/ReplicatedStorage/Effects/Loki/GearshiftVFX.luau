  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 13
    -- upvalues: VfxManager (copy), Debris (copy)
    local Char = p1.Char;

    if not Char then
        return;
    end;

    if not Char:FindFirstChild("HumanoidRootPart") then
        return;
    end;

    local v2 = script.Name .. " VFX " .. Char.Name;
    local v3 = workspace.Debris:FindFirstChild(v2);

    if not v3 then
        v3 = Instance.new("Folder");
        v3.Name = v2;
        v3.Parent = workspace.Debris;
    end;

    if p1.State ~= "Start" then
        if p1.State == "Cleanup" then
            for _, child in pairs(v3:GetChildren()) do
                VfxManager.Enable(child, false);
            end;

            Debris:AddItem(v3, 1);
        end;

        return;
    end;

    local v4 = script.GearShift:Clone();
    v4.Parent = v3;
    local Weld = Instance.new("Weld");
    Weld.Parent = v4;
    Weld.Part0 = v4;
    Weld.Part1 = Char.HumanoidRootPart;
end;