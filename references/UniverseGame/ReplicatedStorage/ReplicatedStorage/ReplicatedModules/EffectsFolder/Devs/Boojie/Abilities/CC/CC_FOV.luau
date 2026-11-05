  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
Random.new();
local TweenService = game:GetService("TweenService");
local LocalPlayer = game.Players.LocalPlayer;

return function(p1) -- Line: 11
    -- upvalues: TweenService (copy), LocalPlayer (copy)
    local v2 = p1.Out or 0.25;
    local v3 = p1.Time or 1;
    local v4 = p1.StartInfo or { Enum.EasingStyle.Exponential, Enum.EasingDirection.In };
    local v5 = p1.EndInfo or { Enum.EasingStyle.Linear, Enum.EasingDirection.In };
    TweenService:Create(workspace.CurrentCamera, TweenInfo.new(p1.In or 1, unpack(v4)), {
        FieldOfView = LocalPlayer.Settings.FieldOfView.Value + (p1.FieldOfView or 0)
    }):Play();
    task.wait(v3);
    TweenService:Create(workspace.CurrentCamera, TweenInfo.new(v2, unpack(v5)), {
        FieldOfView = LocalPlayer.Settings.FieldOfView.Value
    }):Play();
end;