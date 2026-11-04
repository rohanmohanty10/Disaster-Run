  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 14
    -- upvalues: SpectatorController (copy), EmitModule (copy), Debris (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;
    local HumanoidRootPart = Char.HumanoidRootPart;

    if p1.Type ~= "Start" then
        local v2 = script.End:Clone();
        v2:PivotTo(HumanoidRootPart.CFrame);
        v2.Parent = workspace.Debris;
        EmitModule.emit(v2);
        task.wait(2);
        v2:Destroy();

        return;
    end;

    local v3 = script.Startup:Clone();
    v3:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0));
    v3.Parent = workspace.Debris;
    EmitModule.emit(v3);
    local Folder = Instance.new("Folder");
    Folder.Name = "KuronaHighlight";
    Folder.Parent = Char;
    Debris:AddItem(Folder, 1);
    task.wait(2);
    v3:Destroy();
end;