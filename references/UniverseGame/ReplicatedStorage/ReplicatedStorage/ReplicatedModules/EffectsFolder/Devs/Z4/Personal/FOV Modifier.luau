  

 

local TweenService = game:GetService("TweenService");
local CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u1 = nil;

return function(p2) -- Line: 7
    -- upvalues: LocalPlayer (copy), u1 (ref), CurrentCamera (copy), TweenService (copy)
    local v3 = p2 or {};

    if v3.CutsceneCheck == true and LocalPlayer.Settings.CutsceneCamera.Value ~= true then
        return;
    end;

    local v4 = v3.View or (game.Players.LocalPlayer.Settings.FieldOfView.Value or 70);
    local v5 = v3.TweenInformation or {};
    local v6 = v5.RepeatCount or 0;
    local v7 = v5.Reverse or false;
    local v8 = v5.Speed or 1;
    local v9 = v5.EasingStyle or Enum.EasingStyle.Linear;
    local v10 = v5.EasingDirection or Enum.EasingDirection.Out;

    if (v3.Priority or false) and u1 then
        u1:Cancel();
    end;

    if not v3.TweenInformation then
        CurrentCamera.FieldOfView = v4;

        return;
    end;

    local v11 = TweenService:Create(CurrentCamera, TweenInfo.new(v8, v9, v10, v6, v7), {
        FieldOfView = v4
    });
    u1 = v11;
    v11:Play();
end;