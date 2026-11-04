  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 14
    -- upvalues: SpectatorController (copy), SoundManager (copy), EmitModule (copy), Debris (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        table.clear(p1);

        return;
    end;

    if p1.Type == "Start" then
        SoundManager.SpawnSound("ScytheSlam", 1, p1.Char.HumanoidRootPart, 150, nil);
        local v2 = script.Startup:Clone();
        v2:PivotTo(p1.Char.PrimaryPart.CFrame * CFrame.new(0, -2.5, 0));
        v2.Parent = workspace.Debris;
        local Motor6D = Instance.new("Motor6D");
        local v3 = script.Handle:Clone();
        v3.CFrame = p1.Char["Right Arm"].CFrame * CFrame.new(0.2, -1, 0);
        v3.Parent = p1.Char;
        Motor6D.Parent = p1.Char["Right Arm"];
        Motor6D.Part0 = p1.Char["Right Arm"];
        Motor6D.Part1 = v3;
        local v4 = script["Blr Scythe"]:Clone();
        v4.Parent = p1.Char;

        for _, child in v3:GetChildren() do
            child.Part0 = v3;
            child.Part1 = v4:FindFirstChild(child.Name);
        end;

        EmitModule.emit(v2);
        Debris:AddItem(v2, 3);
        Debris:AddItem(Motor6D, 2);
        Debris:AddItem(v4, 2);

        return;
    end;

    local v5 = script.GroundFX:Clone();
    v5:PivotTo(p1.Char.PrimaryPart.CFrame * CFrame.new(0, -2.5, 0));
    v5.Parent = workspace.Debris;
    EmitModule.emit(v5);
    Debris:AddItem(v5, 3);
    local v6 = script.ShootMesh:Clone();
    v6:PivotTo(p1.Char.PrimaryPart.CFrame * CFrame.fromOrientation(0, -1.5707963267948966, 0));
    v6.Parent = workspace.Debris;
    local v7 = script.Model:Clone();
    v7:PivotTo(p1.Char.PrimaryPart.CFrame * CFrame.fromOrientation(1.5707963267948966, -1.5707963267948966, 0));
    v7.Parent = workspace.Debris;
    local v8 = script.Model:Clone();
    v8:PivotTo(p1.Char.PrimaryPart.CFrame * CFrame.fromOrientation(0, 0, 3.141592653589793));
    v8.Parent = workspace.Debris;
    EmitModule.emit(v6);
    EmitModule.emit(v7);
    EmitModule.emit(v8);
    Debris:AddItem(v6, 2);
    Debris:AddItem(v7, 2);
    Debris:AddItem(v8, 2);
end;