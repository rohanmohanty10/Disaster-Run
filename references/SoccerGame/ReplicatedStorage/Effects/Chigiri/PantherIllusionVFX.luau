  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local createAfterImage = require(ReplicatedStorage.Shared.AbilityUtils).createAfterImage;

return function(p1) -- Line: 13
    -- upvalues: SpectatorController (copy), SoundManager (copy), Debris (copy), EmitModule (copy), createAfterImage (copy)
    local Char = p1.Char;
    local firstPos = p1.firstPos;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    SoundManager.SpawnSound("Panther illusion", 0.9, Char.HumanoidRootPart, 130, false);
    local Folder = Instance.new("Folder");
    Folder.Name = "ChigiriHighlight";
    Folder.Parent = Char;
    Debris:AddItem(Folder, 0.7);
    local v2 = script.TPDash:Clone();
    v2.Parent = workspace.Debris;
    v2:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(0, 3.141592653589793, 0));
    EmitModule.emit(v2);
    local v3 = (HumanoidRootPart.Position - firstPos).Magnitude / 5;

    for i = 1, 5 do
        createAfterImage(Char, {
            FillColor = Color3.new(0.976715, 0.190814, 0.73521),
            OutlineColor = Color3.new(0.969375, 0.160708, 0.84744)
        }):PivotTo(CFrame.new(firstPos, HumanoidRootPart.Position) * CFrame.new(0, 0, -v3 * i));
        local _ = i;
    end;

    task.wait(2);
    v2:Destroy();
end;