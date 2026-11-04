 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local v1 = Knit.CreateController({
    Name = "OnboardingController"
});
local u2 = 1;
local u3 = nil;
local u4 = { "On defense, you can press BUTTON to steal the ball, and jump to block the ball.", "Dribble with BUTTON ! You can dribble 3 times before you get tired.", "To Pass, press BUTTON while looking at a team-mate", "To shoot, press BUTTON while looking at the goal!", "Note: The closer you are to the goal, the more likely your shot is to go in. Try taking smart shots!" };
local u5 = { {
        Mobile = "STEAL",
        Console = "R1",
        PC = "E"
    }, {
        Mobile = "DRIBBLE",
        Console = "R1",
        PC = "Q"
    }, {
        Mobile = "PASS",
        Console = "L2",
        PC = "RIGHT CLICK"
    }, {
        Mobile = "SHOOT",
        Console = "R2",
        PC = "LEFT CLICK"
    }, {
        Mobile = "",
        Console = "",
        PC = ""
    } };

function v1.Progress(p6) -- Line: 31
    -- upvalues: u3 (ref), u2 (ref), u4 (copy), u5 (copy), ReplicatedStorage (copy), Effects (copy)
    if u3 == nil then
        return;
    end;

    if u3.ServerType == "Tutorial" then
        return;
    end;

    if u3.Player.Statistics.Matches > 2 then
        return;
    end;

    if u2 >= 5 then
        return;
    end;

    u2 = u2 + 1;
    local string_gsub_ret = string.gsub(u4[u2], "BUTTON", u5[u2][ReplicatedStorage.Controllers.Device.Value]);

    if u2 ~= 4 then
        Effects:Popup(string_gsub_ret, 7, Color3.new(1, 0.811765, 0.486275), UDim2.fromScale(0.8, 0.3));

        return;
    end;

    u2 = 5;
    Effects:Popup(string_gsub_ret, 7, Color3.new(1, 0.811765, 0.486275), UDim2.fromScale(0.8, 0.3));
    task.wait(0.5);
    Effects:Popup(u4[5], 7, Color3.new(1, 0.94902, 0.792157), UDim2.fromScale(0.8, 0.2));
end;

function v1.KnitStart(p7) -- Line: 52
    -- upvalues: u3 (ref), Knit (copy), LocalPlayer (copy), ReplicatedStorage (copy), u2 (ref), u4 (copy), u5 (copy), Effects (copy)
    u3 = Knit.GetController("Network");

    if u3.ServerType == "Tutorial" then
        return;
    end;

    if u3.Player.Statistics.Matches > 2 then
        return;
    end;

    local u8 = false;
    LocalPlayer:GetPropertyChangedSignal("Team"):Connect(function() -- Line: 59
        -- upvalues: ReplicatedStorage (ref), LocalPlayer (ref), u3 (ref), u2 (ref), u8 (ref), u4 (ref), u5 (ref), Effects (ref)
        if ReplicatedStorage.GameValues.State.Value == "Playing" then
            if LocalPlayer.Team == game.Teams.Visitor then
                return;
            end;

            if u3.Player.Statistics.Matches > 2 then
                return;
            end;

            if u2 == 1 and not u8 then
                u8 = true;
                task.wait(1);
                Effects:Popup(string.gsub(u4[u2], "BUTTON", u5[u2][ReplicatedStorage.Controllers.Device.Value]), 7, Color3.new(1, 0.811765, 0.486275), UDim2.fromScale(0.8, 0.3));
            end;
        end;
    end);
    ReplicatedStorage.GameValues.State:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 75
        -- upvalues: ReplicatedStorage (ref), LocalPlayer (ref), u3 (ref), u2 (ref), u8 (ref), u4 (ref), u5 (ref), Effects (ref)
        if ReplicatedStorage.GameValues.State.Value == "Playing" then
            if LocalPlayer.Team == game.Teams.Visitor then
                return;
            end;

            if u3.Player.Statistics.Matches > 2 then
                return;
            end;

            if u2 == 1 and not u8 then
                u8 = true;
                task.wait(1);
                Effects:Popup(string.gsub(u4[u2], "BUTTON", u5[u2][ReplicatedStorage.Controllers.Device.Value]), 7, Color3.new(1, 0.811765, 0.486275), UDim2.fromScale(0.8, 0.3));
            end;
        end;
    end);
end;

return v1;