  

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
local u1 = _G.Petal("Util");
Knit.OnStart():await();
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local u2 = nil;
local u3 = false;
local u4 = nil;
local u5 = false;

return function(p6) -- Line: 20
    -- upvalues: Players (copy), u2 (ref), u5 (ref), u4 (ref), u1 (copy), u3 (ref), EffectsHandler (copy)
    local LocalPlayer = Players.LocalPlayer;
    local Character = LocalPlayer.Character;

    local function IsExtraEnabled(p7) -- Line: 25
        -- upvalues: Players (ref)
        local v8 = Players:GetPlayerFromCharacter(p7);

        if not (v8 and (v8.Settings and v8.Settings.PoseExtrasVisibility)) then
            return true;
        end;

        local Value = v8.Settings.PoseExtrasVisibility.Value;

        if Value >= 3 then
            return false;
        end;

        return Value < 2 and true or p7 == v8.Character;
    end;

    local Value = LocalPlayer.Settings.FieldOfView.Value;

    local function AnimateColorCorrectionLoop() -- Line: 45
        -- upvalues: u2 (ref), u5 (ref), u4 (ref), u1 (ref), AnimateColorCorrectionLoop (copy)
        if not (u2 and u5) then
            return;
        end;

        u4 = u1.TweenCallback(u2, {
            Saturation = 0.25,
            Contrast = 0.25,
            Brightness = 0.2
        }, function() -- Line: 51
            -- upvalues: AnimateColorCorrectionLoop (ref)
            AnimateColorCorrectionLoop();
        end, 0.43333333333333335, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 1, true, 0);
    end;

    local function AnimateFOVLoop() -- Line: 56
        -- upvalues: u5 (ref), u3 (ref), Value (copy), EffectsHandler (ref), AnimateFOVLoop (copy)
        if not u5 then
            return;
        end;

        local v9 = u3 and Value or Value * 0.9;
        u3 = not u3;
        EffectsHandler.CallEffect("FOV Modifier", {
            View = v9,
            TweenInformation = {
                Speed = 0.6066666666666667
            }
        });
        task.wait(0.43333333333333335);
        AnimateFOVLoop();
    end;

    local function Start() -- Line: 73
        -- upvalues: Character (copy), Players (ref), u5 (ref), u2 (ref), AnimateColorCorrectionLoop (copy), AnimateFOVLoop (copy)
        local v10 = Character;
        local v11 = Players:GetPlayerFromCharacter(v10);
        local v12;

        if v11 and (v11.Settings and v11.Settings.PoseExtrasVisibility) then
            local Value2 = v11.Settings.PoseExtrasVisibility.Value;

            if Value2 >= 3 then
                v12 = false;
            else
                v12 = Value2 < 2 and true or v10 == v11.Character;
            end;
        else
            v12 = true;
        end;

        if not v12 then
            return;
        end;

        u5 = true;
        u2 = Instance.new("ColorCorrectionEffect");
        u2.Saturation = 0;
        u2.Contrast = 0;
        u2.Parent = game.Lighting;
        AnimateColorCorrectionLoop();
        task.spawn(AnimateFOVLoop);
    end;

    local function End() -- Line: 86
        -- upvalues: u5 (ref), u4 (ref), u2 (ref), EffectsHandler (ref), Value (copy)
        u5 = false;

        if u4 then
            u4:Cancel();
            u4 = nil;
        end;

        if u2 then
            u2:Destroy();
            u2 = nil;
        end;

        EffectsHandler.CallEffect("FOV Modifier", {
            Priority = true,
            View = Value
        });
    end;

    if not p6.Mode then
        End();

        return;
    end;

    local v13 = Players:GetPlayerFromCharacter(Character);
    local v14;

    if v13 and (v13.Settings and v13.Settings.PoseExtrasVisibility) then
        local Value2 = v13.Settings.PoseExtrasVisibility.Value;

        if Value2 >= 3 then
            v14 = false;
        else
            v14 = Value2 < 2 and true or Character == v13.Character;
        end;
    else
        v14 = true;
    end;

    if not v14 then
        return;
    end;

    u5 = true;
    u2 = Instance.new("ColorCorrectionEffect");
    u2.Saturation = 0;
    u2.Contrast = 0;
    u2.Parent = game.Lighting;
    AnimateColorCorrectionLoop();
    task.spawn(AnimateFOVLoop);
end;