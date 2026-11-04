  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 11
    -- upvalues: VfxManager (copy), Debris (copy), RunService (copy), Players (copy), TweenService (copy)
    local char = p1.char;
    local _ = p1.Team;
    char:FindFirstChild("HumanoidRootPart");
    local v2 = script.HioriLazerPass:Clone();
    v2.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0);
    v2.Parent = workspace.Debris;
    VfxManager.Emit(v2);
    Debris:AddItem(v2, 2);
    local u3 = script.DarknessScreen:Clone();
    u3.Parent = workspace.Debris;
    local v4 = RunService.Heartbeat:Connect(function() -- Line: 28
        -- upvalues: u3 (copy)
        u3.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -1);
    end);
    local v5 = script.IceVignette:Clone();
    v5.Overlay.ImageTransparency = 1;
    v5.Parent = Players.LocalPlayer.PlayerGui;
    TweenService:Create(v5.Overlay, TweenInfo.new(0.2), {
        ImageTransparency = 0
    }):Play();
    task.wait(3);
    VfxManager.Enable(u3, false);
    TweenService:Create(v5.Overlay, TweenInfo.new(1), {
        ImageTransparency = 1
    }):Play();
    Debris:AddItem(v5, 1);
    task.wait(1);
    v4:Disconnect();
    u3:Destroy();
end;