  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 14
    -- upvalues: SpectatorController (copy), Debris (copy), VfxManager (copy), EmitModule (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;
    local HumanoidRootPart = Char.HumanoidRootPart;

    if p1.Type ~= "Effect" then
        local v2 = script["3Ai"]:Clone();
        v2.CFrame = HumanoidRootPart.CFrame;
        v2.Parent = workspace.Debris;
        EmitModule.emit(v2);
        task.wait(2);
        v2:Destroy();

        return;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "NessHighlight";
    Folder.Parent = Char;
    Debris:AddItem(Folder, 0.6);
    local v3 = script.Trail:Clone();
    v3.Parent = Char["Right Arm"];
    local v4 = script.Trail:Clone();
    v4.Parent = Char["Left Arm"];
    task.wait(1);
    VfxManager.Enable(v3, false);
    VfxManager.Enable(v4, false);
    task.wait(1);
    v3:Destroy();
    v4:Destroy();
    Folder:Destroy();
end;