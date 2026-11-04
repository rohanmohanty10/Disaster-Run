  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 13
    -- upvalues: Essentials (copy), VfxManager (copy), Debris (copy), ReplicatedStorage (copy), RunService (copy), TweenService (copy)
    local Char = p1.Char;
    local v2 = script.ShootStartUp:Clone();
    v2.CFrame = Char.Torso.CFrame;
    v2.Parent = workspace.Debris;
    Essentials:Weld(v2, Char.HumanoidRootPart);
    VfxManager.Emit(v2);
    Debris:AddItem(v2, 1);
    task.wait(0.35);
    local v3 = script.Shoot:Clone();
    v3.CFrame = Char.Torso.CFrame * CFrame.new(0, -2, -1);
    v3.Parent = workspace.Debris;
    VfxManager.Emit(v3);
    Debris:AddItem(v3, 1);
    local Value = ReplicatedStorage.Football.Value;
    local u4 = script.ShotTrail:Clone();
    u4:PivotTo(Char.HumanoidRootPart.CFrame);
    u4.Parent = workspace.Debris;
    local u5 = 2;
    local u6 = nil;
    u6 = RunService.RenderStepped:Connect(function(p7) -- Line: 42
        -- upvalues: u5 (ref), Value (copy), u6 (ref), VfxManager (ref), u4 (copy), TweenService (ref)
        u5 = u5 - p7;

        if u5 > 0 and (Value and Value.Parent) then
            u4:PivotTo(CFrame.lookAlong(Value.CFrame.Position, Value.CFrame.LookVector) * CFrame.Angles(0, 1.5707963267948966, 0));

            return;
        end;

        u6:Disconnect();
        VfxManager.Enable(u4, false);

        for _, child in u4.SnakeHead1:GetChildren() do
            TweenService:Create(child, TweenInfo.new(1), {
                Transparency = 1
            }):Play();
        end;

        task.delay(1, function() -- Line: 50
            -- upvalues: u4 (ref)
            u4:Destroy();
        end);
    end);
end;