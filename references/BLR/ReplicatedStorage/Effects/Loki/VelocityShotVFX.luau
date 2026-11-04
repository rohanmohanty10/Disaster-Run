  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local CameraController = require(ReplicatedStorage.Controllers.CameraController);
local LocalPlayer = game:GetService("Players").LocalPlayer;

return function(p1) -- Line: 16
    -- upvalues: EmitModule (copy), Debris (copy), SoundManager (copy), LocalPlayer (copy), CameraController (copy), TweenService (copy), Lighting (copy)
    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local u2 = {};
    local v3 = script.Startup:Clone();
    v3:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.84838033, -0.757770538, 0.00298922369, 0, -1, 0, -1, 0, -1, 0, -0.00298900018));
    v3.Parent = workspace.Debris;
    table.insert(u2, v3);
    EmitModule.emit(v3);
    Debris:AddItem(v3, 3);
    task.wait(0.46);
    SoundManager.SpawnSound("VelocityShot", 0.9, Char.HumanoidRootPart, 130, false);
    local v4 = script.ShotEmit:Clone();
    v4:PivotTo(HumanoidRootPart.CFrame * CFrame.new(1, 0.542420149, -3.84673691, 0.040637739, 0, -0.999174118, 0, 1, 0, 0.999174118, 0, 0.0406377502));
    v4.Parent = workspace.Debris;
    table.insert(u2, v4);
    EmitModule.emit(v4);
    Debris:AddItem(v4, 3);

    if (Char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 then
        CameraController:Shake2("Hit");
        TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
            TintColor = Color3.new(1, 0.752941, 0.00784314)
        }):Play();
        task.delay(0.1, function() -- Line: 48
            -- upvalues: TweenService (ref), Lighting (ref)
            TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.6), {
                TintColor = Color3.new(1, 1, 1)
            }):Play();
        end);
    end;

    task.delay(3, function() -- Line: 53
        -- upvalues: u2 (copy)
        for _, v in u2 do
            if v then
                v:Destroy();
            end;
        end;
    end);
end;