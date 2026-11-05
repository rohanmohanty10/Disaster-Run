  

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local Constants = require(script.Parent.Parent.Constants);
local Units = require(script.Parent.Parent.Units);
local PlayerGui = Players.LocalPlayer.PlayerGui;
local SpeedometerGui = script.SpeedometerGui;
local Parent = script.Parent.Parent.Parent;
local Chassis = Parent.Chassis;
local Engine = Parent.Engine;
local u1 = false;
local u2 = nil;
local u3 = nil;

local function update() -- Line: 19
    -- upvalues: u2 (ref), Constants (copy), Chassis (copy), Units (copy), Engine (copy)
    local v4 = math.min(u2.AbsoluteSize.X, u2.AbsoluteSize.Y) < Constants.UI_SMALL_SCREEN_THRESHOLD;
    u2.Speedometer.UIScale.Scale = not v4 and 1 or Constants.UI_SMALL_SCREEN_SCALE;
    local v5 = Units.studsPerSecondToMilesPerHour(Chassis.AssemblyLinearVelocity.Magnitude);
    local v6 = math.round(v5);
    local v7 = tostring(v6);
    u2.Speedometer.SpeedFrame.SpeedLabel.Text = v7;
    local v8 = Engine:GetAttribute(Constants.ENGINE_NITRO_ATTRIBUTE);
    u2.Speedometer.NitroFrame.Nitro.Bar.Size = UDim2.fromScale(v8, 1);
end;

return {
    enable = function(p9) -- Line: 39, Name: enable
        -- upvalues: u1 (ref), SpeedometerGui (copy), PlayerGui (copy), u2 (ref), u3 (ref), RunService (copy), update (copy)
        if u1 then
            return;
        end;

        u1 = true;
        local v10 = SpeedometerGui:Clone();
        v10.Parent = PlayerGui;
        u2 = v10;
        u3 = RunService.Heartbeat:Connect(update);
    end,

    disable = function(p11) -- Line: 52, Name: disable
        -- upvalues: u1 (ref), u3 (ref), u2 (ref)
        if not u1 then
            return;
        end;

        u1 = false;

        if u3 then
            u3:Disconnect();
            u3 = nil;
        end;

        if u2 then
            u2:Destroy();
            u2 = nil;
        end;
    end
};