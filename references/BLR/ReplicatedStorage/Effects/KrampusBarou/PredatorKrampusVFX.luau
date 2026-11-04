  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Players = game:GetService("Players");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
require(ReplicatedStorage.Controllers.SpectatorController);
local _ = require(ReplicatedStorage.Shared.AbilityUtils).createAfterImage;
require(ReplicatedStorage.AbilityBalancing);
require(ReplicatedStorage.Modules.CutsceneUtils);
local _ = Players.LocalPlayer;

local function getRelativeOffset(p1, p2) -- Line: 20
    return p1:ToObjectSpace(p2);
end;

return function(p3) -- Line: 24
    -- upvalues: Players (copy), SoundManager (copy), RunService (copy)
    local LocalPlayer = Players.LocalPlayer;
    local u4 = {};
    local u5 = SoundManager.SpawnSound("NELIsagiMetavisionLoop", 0.7, workspace, 150, true, true);
    u5:Play();
    local u6 = nil;

    local function Disable() -- Line: 34
        -- upvalues: u6 (ref), u4 (copy), u5 (copy), Disable (ref)
        if u6 then
            u6:Disconnect();
        end;

        task.spawn(function() -- Line: 36
            -- upvalues: u4 (ref)
            for _, v in u4 do
                warn("Destroying");

                if v then
                    v:Destroy();
                end;
            end;
        end);
        u5:Destroy();

        if Disable then
            Disable = nil;
        end;
    end;

    task.spawn(function() -- Line: 48
        -- upvalues: u6 (ref), RunService (ref), LocalPlayer (copy), Disable (ref)
        u6 = RunService.RenderStepped:Connect(function() -- Line: 49
            -- upvalues: LocalPlayer (ref), Disable (ref)
            if LocalPlayer.Character:GetAttribute("PredatorKrampus") then
                return;
            end;

            if Disable then
                Disable();
            end;
        end);
    end);
    local v7 = script.Field:Clone();
    v7:PivotTo(workspace.Field.Field.CFrame * CFrame.new(0, 14, 0));
    v7.Parent = workspace.Debris;
    table.insert(u4, v7);
    task.delay(10, function() -- Line: 63
        -- upvalues: Disable (ref)
        if Disable then
            Disable();
        end;
    end);
end;