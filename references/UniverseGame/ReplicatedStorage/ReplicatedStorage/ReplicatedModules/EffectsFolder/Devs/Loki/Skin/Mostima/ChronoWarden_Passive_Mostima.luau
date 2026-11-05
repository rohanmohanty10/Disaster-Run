  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
require(Knit.Util.Promise);
require(Knit.Util.TableUtil);
game:GetService("Players");
local RunService = game:GetService("RunService");

local function Lerp(p1, p2, p3) -- Line: 11
    return p1 + (p2 - p1) * p3;
end;

local Angles = CFrame.Angles;
local _ = math.rad;

return function(u4) -- Line: 17
    -- upvalues: Trove (copy), RunService (copy), Angles (copy)
    if not u4.Parent then
        warn("No character");

        return;
    end;

    local u5 = Trove.new();
    local Halo = u4:WaitForChild("Halo", 5);
    local Torso = u4:WaitForChild("Torso", 5);

    if not (Halo and (Torso and Torso:WaitForChild("Left Wing Piece 1", 5))) then
        return;
    end;

    local Mid = Halo:WaitForChild("Mid");
    local u6 = u4:FindFirstChildOfClass("Humanoid");
    local u7 = 1;
    local u8 = u4:GetAttribute("ChronoClockSpeed");

    if u4:GetAttribute("ChronoClientPassive") then
        return;
    end;

    u4:SetAttribute("ChronoClientPassive", true);
    u5:Connect(u4.AncestryChanged, function() -- Line: 39
        -- upvalues: u4 (copy), u5 (copy)
        if not u4.Parent then
            u5:Destroy();
        end;
    end);
    u5:Connect(u4:GetAttributeChangedSignal("ChronoClockSpeed"), function() -- Line: 45
        -- upvalues: u8 (ref), u4 (copy)
        u8 = u4:GetAttribute("ChronoClockSpeed");
    end);
    u5:Connect(u4:GetAttributeChangedSignal("Timestopped"), function() -- Line: 49
        -- upvalues: u4 (copy), u8 (ref)
        if u4:GetAttribute("Timestopped") == true then
            u8 = 0.1;

            return;
        end;

        u8 = u4:GetAttribute("ChronoClockSpeed");
    end);
    local _ = Mid.MinuteHand;
    local _ = Mid.HourHand;
    local _ = Mid.Main;
    local u9 = u4:FindFirstChild("Head") and u4:FindFirstChild("Head"):FindFirstChild("HaloAttach");
    local u10;

    if u9 then
        u10 = u9.C1;
    else
        u10 = u9;
    end;

    local u11;

    if u9 then
        u11 = u9.C0;
    else
        u11 = u9;
    end;

    local function GetWingPiece(p12) -- Line: 62
        -- upvalues: Torso (copy)
        return Torso:FindFirstChild(p12);
    end;

    local u13 = {
        {
            Torso:FindFirstChild("Left Wing Piece 1"),
            Torso:FindFirstChild("Left Wing Piece 2"),
            Torso:FindFirstChild("Left Wing Piece 3"),
            GetWingPiece("Left Wing Piece 4")
        },
        {
            Torso:FindFirstChild("Right Wing Piece 1"),
            Torso:FindFirstChild("Right Wing Piece 2"),
            Torso:FindFirstChild("Right Wing Piece 3"),
            GetWingPiece("Right Wing Piece 4")
        }
    };
    local u14 = {};

    for i = 1, #u13 do
        for i2 = 1, #u13[i] do
            u14[u13[i][i2]] = u13[i][i2].C0;
        end;
    end;

    local u15 = 0;
    local u16 = 1;
    u5:Connect(RunService.Heartbeat, function(p17) -- Line: 92
        -- upvalues: u7 (ref), u8 (ref), u15 (ref), u13 (copy), u14 (copy), u16 (ref), u10 (copy), u11 (copy), u9 (copy), Angles (ref), u6 (copy), u4 (copy)
        local v18 = u7;
        u7 = v18 + (u8 * (p17 * 60) - v18) * 0.3;
        u15 = u15 + p17 * 1.2 * u8;

        for i = 1, #u13 do
            for i2 = 1, #u13[i] do
                local v19 = u13[i][i2];
                local C0 = v19.C0;
                local v20 = u14[v19] * CFrame.new((i == 1 and 0.1 or -0.1) * math.sin((u15 + i2 / 2.75) * 1.5 * u16), math.cos((u15 + i2 / 2.75) * 2 * u16) * 0.2, math.cos((u15 + i2 / 2.75) * 1.5 * u16) * 0.1);
                local Angles2 = CFrame.Angles;
                local v21 = math.cos((u15 + i2 / 2.75) * 2 * u16) * 2;
                local v22 = math.rad(v21);
                local v23 = (i == 1 and 3 or -3) * math.sin((u15 + i2 / 2.75) * 2 * u16);
                local v24 = math.rad(v23);
                local v25 = (i == 1 and 2 or -2) * math.sin((u15 + i2 / 2.75) * u16);
                v19.C0 = C0:Lerp(v20 * Angles2(v22, v24, (math.rad(v25))), 0.75);
            end;
        end;

        if u10 and u11 then
            u9.C0 = u11 * CFrame.new(0, math.cos(u15 * 1.5) * 0.15, 0);
            local v26 = math.sin(u15 * 2) * -2.5;
            local v27 = math.rad(v26);
            local v28 = math.cos(u15 * 2) * -2.5;
            u9.C1 = u10 * Angles(v27, 0, (math.rad(v28)));
        end;

        if u6.MoveDirection.Magnitude > 0.5 then
            u16 = 1.75;
        else
            u16 = 1;
        end;

        u4:GetAttribute("ChronoResurrection");
    end);
end;