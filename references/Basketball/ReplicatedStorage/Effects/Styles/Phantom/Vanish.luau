 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 13
    -- upvalues: SfxManager (copy), Essentials (copy), VfxManager (copy), Debris (copy)
    local Character = p2.Character;
    local v3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    SfxManager:playSound({
        Sound = "VanishDrive",
        Parent = HumanoidRootPart
    });
    local u4 = script.dissapear:Clone();
    u4.Parent = workspace.Debris;
    local u5 = script.starrrss:Clone();
    u5.Parent = workspace.Debris;
    local u6 = script.kuroko.HumanoidRootPart.enable:Clone();
    u6.Parent = HumanoidRootPart;
    task.delay(0.3 - v3, function() -- Line: 31
        -- upvalues: u5 (copy), HumanoidRootPart (copy), Essentials (ref), VfxManager (ref), u6 (copy), u4 (copy), Debris (ref), Character (copy)
        u5.CFrame = HumanoidRootPart.CFrame;
        Essentials:Weld(u5, HumanoidRootPart);
        VfxManager.Enable(u5, true);
        VfxManager.Enable(u6, true);
        u4.CFrame = HumanoidRootPart.CFrame;
        Essentials:Weld(u4, HumanoidRootPart);
        VfxManager.Emit(u4);
        Debris:AddItem(u4, 5);
        local u7 = { Character:FindFirstChild("BALL", true), Character:FindFirstChild("PlrBall") };

        for _, child in u6:GetChildren() do
            table.insert(u7, child);
        end;

        task.spawn(function() -- Line: 50
            -- upvalues: Essentials (ref), Character (ref), u7 (copy)
            Essentials:HideCharacter(Character, u7);
            task.wait(0.3);
            Essentials:UnhideCharacter(Character, u7);
            task.wait(0.1);
            Essentials:HideCharacter(Character, u7);
            task.wait(0.05);
            Essentials:UnhideCharacter(Character, u7);
            task.wait(0.1);
            Essentials:HideCharacter(Character, u7);
            task.wait(0.05);
            Essentials:UnhideCharacter(Character, u7);
        end);
        task.wait(0.4);
        VfxManager.Enable(u5, false);
        Debris:AddItem(u5, 3);
        VfxManager.Enable(u6, false);
        Debris:AddItem(u6, 5);
    end);
end;