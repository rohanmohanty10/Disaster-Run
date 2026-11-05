  

 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local CameraShaker = require(ReplicatedStorage.ClientModules.CameraShaker);
local _ = game.Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
local u1 = task.wait();
RunService.RenderStepped:Connect(function(p2) -- Line: 11
    -- upvalues: u1 (ref)
    u1 = p2;
end);
local u10 = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p3) -- Line: 15
    -- upvalues: u1 (ref), CurrentCamera (copy)
    local v4 = 60 * u1;
    local v5, v6, v7 = p3:ToOrientation();
    local v8 = CFrame.new(p3.Position * v4) * CFrame.Angles(v5 * v4, v6 * v4, v7 * v4);
    local v9 = CurrentCamera;
    v9.CFrame = v9.CFrame * v8;
end);
u10:Start();

return function(...) -- Line: 28
    -- upvalues: u10 (copy)
    u10:ShakeOnce(unpack(...));
end;