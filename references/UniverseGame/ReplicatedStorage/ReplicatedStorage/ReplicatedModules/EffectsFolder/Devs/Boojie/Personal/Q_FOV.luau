  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
Random.new();
local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 9
    -- upvalues: TweenService (copy)
    local v2 = p1.Info and TweenInfo.new(unpack(p1.Info)) or TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local v3;

    if p1.StartInfo then
        v3 = TweenInfo.new(unpack(p1.StartInfo)) or v2;
    else
        v3 = v2;
    end;

    if p1.EndInfo then
        v2 = TweenInfo.new(unpack(p1.EndInfo)) or v2;
    end;

    local v4 = p1.Time or 1;
    TweenService:Create(workspace.CurrentCamera, v3, {
        FieldOfView = p1.FieldOfView or 70
    }):Play();
    task.wait(v4);
    TweenService:Create(workspace.CurrentCamera, v2, {
        FieldOfView = game.Players.LocalPlayer.Settings.FieldOfView.Value
    }):Play();
end;