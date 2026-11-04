  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
game:GetService("Lighting");
local _ = game:GetService("Players").LocalPlayer;
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
require(ReplicatedStorage.Controllers.HighlightController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 18
    -- upvalues: SpectatorController (copy), SoundManager (copy), Debris (copy), VfxManager (copy)
    local Char = p1.Char;
    local _ = p1.x;

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    SoundManager.SpawnSound("ZombieDash", 0.6, Char.HumanoidRootPart, 130, false);
    local u2 = {};

    for _, child in pairs(script.VFX.HumanoidRootPart:GetChildren()) do
        local v3 = child:Clone();
        v3.Parent = Char.HumanoidRootPart;
        table.insert(u2, v3);
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "GoldenDefense";
    Folder.Parent = Char;
    Debris:AddItem(Folder, 1.5);
    local script_VFX = script.VFX;

    for _, v in { "Head", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "Torso" } do
        local v4 = Char:FindFirstChild(v);

        if v4 then
            for _, child in script_VFX[v ~= "Head" and v ~= "Torso" and "Right Arm" or v]:GetChildren() do
                local v5 = child:Clone();
                v5.Parent = v4;

                if v5.Name == "PartHead" then
                    local Part = v5.Part;
                    Part.Part0 = v4;
                    Part.Part1 = v5;
                end;

                if v5:IsA("ParticleEmitter") then
                    v5.Enabled = true;
                else
                    VfxManager.Enable(v5, true);
                end;

                table.insert(u2, v5);
            end;
        end;
    end;

    VfxManager.Emit(Char.HumanoidRootPart.ZDDirtEmit);
    task.delay(0.05, function() -- Line: 67
        -- upvalues: u2 (copy), VfxManager (ref), Char (copy)
        for _, v in u2 do
            VfxManager.Enable(v, true);
        end;

        for _, descendant in pairs(Char:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(0.4, function() -- Line: 80
        -- upvalues: u2 (copy), VfxManager (ref)
        local v6 = script.VFX.ZombieDribbleEmit1:Clone();
        v6.CFrame = CFrame.new(0, -1.7, -2);
        v6.Parent = workspace.Debris;
        table.insert(u2, v6);
        VfxManager.Emit(v6);
    end);
    task.delay(1.05, function() -- Line: 88
        -- upvalues: VfxManager (ref), Char (copy)
        VfxManager.Emit(Char);
    end);
    task.delay(1.55, function() -- Line: 92
        -- upvalues: u2 (copy), VfxManager (ref), Char (copy)
        for _, v in u2 do
            VfxManager.Enable(v, false);
        end;

        for _, descendant in pairs(Char:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.wait(3);

    for _, v in u2 do
        v:Destroy();
    end;
end;