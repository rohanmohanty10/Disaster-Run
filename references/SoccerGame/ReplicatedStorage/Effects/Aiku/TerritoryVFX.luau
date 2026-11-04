  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 13
    -- upvalues: VfxManager (copy), TweenService (copy)
    local Char = p1.Char;
    local _ = p1.Type;
    local Direction = p1.Direction;
    local u2 = script.SnakeHead:Clone();
    u2.Parent = workspace.Debris;
    local u3 = script.Territory:Clone();
    u3:PivotTo(Char.HumanoidRootPart.CFrame);
    u3.Parent = workspace.Debris;
    local v4 = game["Run Service"].Heartbeat:Connect(function() -- Line: 26
        -- upvalues: u3 (copy), Char (copy), Direction (copy), u2 (copy)
        u3:PivotTo(Char.HumanoidRootPart.CFrame * CFrame.new(Direction));
        u2:PivotTo(Char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3));
    end);
    task.wait(1);
    VfxManager.Enable(u3, false);

    for _, child in u2:GetChildren() do
        if child:IsA("BasePart") then
            TweenService:Create(child, TweenInfo.new(0.7), {
                Transparency = 1
            }):Play();
        end;
    end;

    task.wait(1);
    v4:Disconnect();
    u3:Destroy();
    u2:Destroy();
end;