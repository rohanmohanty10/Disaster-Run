  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local CameraController = require(ReplicatedStorage.Controllers.CameraController);
local createAfterImage = require(ReplicatedStorage.Shared.AbilityUtils).createAfterImage;

return function(p1) -- Line: 15
    -- upvalues: SoundManager (copy), VfxManager (copy), createAfterImage (copy), Players (copy), TweenService (copy), Lighting (copy), CameraController (copy), Debris (copy)
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

    if p1.State ~= "Stride" then
        if p1.State == "Dash" then
            local Enemy = p1.Enemy;
            SoundManager.SpawnSound("Godspeed Stride Dash", 0.6, workspace, 150);
            Char.Archivable = true;

            for i = 1, 5 do
                createAfterImage(Char):PivotTo(Char:GetPivot());
                task.wait(0.05);
                local _ = i;
            end;

            if Players.LocalPlayer.Character == Enemy then
                TweenService:Create(Lighting.Blur, TweenInfo.new(0.1), {
                    Size = 56
                }):Play();
                CameraController:Shake("Hit");
                task.wait(0.1);
                TweenService:Create(Lighting.Blur, TweenInfo.new(0.5), {
                    Size = 0
                }):Play();

                return;
            end;
        elseif p1.State == "Cleanup" then
            if not v3 then
                return;
            end;

            for _, child in pairs(v3:GetChildren()) do
                VfxManager.Enable(child, false);
            end;

            Debris:AddItem(v3, 2);

            if Lighting.Blur.Size > 0 then
                TweenService:Create(Lighting.Blur, TweenInfo.new(0.1), {
                    Size = 0
                }):Play();
            end;
        end;

        return;
    end;

    SoundManager.SpawnSound("Godspeed Stride", 0.6, workspace, 150).TimePosition = 1;
    local v4 = script.Dribble:Clone();
    v4.Parent = v3;
    VfxManager.Enable(v4, true);
    local Weld = Instance.new("Weld");
    Weld.Parent = v4.Speed1;
    Weld.Part0 = v4.Speed1;
    Weld.Part1 = Char.HumanoidRootPart;
end;