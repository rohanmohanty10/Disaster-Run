  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local CameraController = require(ReplicatedStorage.Controllers.CameraController);
local LocalPlayer = game.Players.LocalPlayer;

return function(p1) -- Line: 12
    -- upvalues: SoundManager (copy), EmitModule (copy), LocalPlayer (copy), CameraController (copy)
    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if not p1.Hit then
        local u2 = {};
        SoundManager.SpawnSound("GodspeedFreeze", 0.9, Char.HumanoidRootPart, 130, false);
        task.delay(3, function() -- Line: 64
            -- upvalues: u2 (copy)
            for _, v in u2 do
                if v then
                    v:Destroy();
                end;
            end;
        end);

        return;
    end;

    local u3 = {};
    SoundManager.SpawnSound("GodspeedFreezeHit", 0.9, Char.HumanoidRootPart, 130, false);
    local v4 = script.godspeedfreezecatch:Clone();
    v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(
        -0.475234985,
        -0.706535816,
        -2.27606201,
        0.42261833,
        0,
        -0.906307757,
        0,
        1,
        0,
        0.906307757,
        0,
        0.42261833
    );
    v4.Parent = workspace.Debris;
    EmitModule.emit(v4);
    table.insert(u3, v4);

    if LocalPlayer.Character == Char then
        CameraController:Shake2("SmallShake");
    end;

    task.wait(1.0333333333333334);
    local v5 = script.godspeedfreezekick:Clone();
    v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(
        -2.05799866,
        -0.928211212,
        -3.28837585,
        0.996194899,
        0,
        -0.0871554986,
        0,
        1,
        0,
        0.0871554986,
        0,
        0.996194899
    );
    v5.Parent = workspace.Debris;
    EmitModule.emit(v5);
    table.insert(u3, v5);

    if LocalPlayer.Character == Char then
        CameraController:Shake2("BigShake");
    end;

    task.delay(3, function() -- Line: 44
        -- upvalues: u3 (copy)
        for _, v in u3 do
            if v then
                v:Destroy();
            end;
        end;
    end);
end;