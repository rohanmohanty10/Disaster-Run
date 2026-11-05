  

 

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
local rad = math.rad;

return function(u4) -- Line: 17
    -- upvalues: Trove (copy), RunService (copy), Angles (copy), rad (copy)
    if not u4.Parent then
        warn("No character");

        return;
    end;

    local u5 = Trove.new();
    local Halo = u4:WaitForChild("Halo", 5);

    if not Halo then
        return;
    end;

    local Mid = Halo:WaitForChild("Mid");
    local u6 = 1;
    local u7 = u4:GetAttribute("ChronoClockSpeed");

    if u4:GetAttribute("ChronoClientPassive") then
        return;
    end;

    u4:SetAttribute("ChronoClientPassive", true);
    u5:Connect(u4.AncestryChanged, function() -- Line: 35
        -- upvalues: u4 (copy), u5 (copy)
        if not u4.Parent then
            u5:Destroy();
        end;
    end);
    u5:Connect(u4:GetAttributeChangedSignal("ChronoClockSpeed"), function() -- Line: 41
        -- upvalues: u7 (ref), u4 (copy)
        u7 = u4:GetAttribute("ChronoClockSpeed");
    end);
    u5:Connect(u4:GetAttributeChangedSignal("Timestopped"), function() -- Line: 45
        -- upvalues: u4 (copy), u7 (ref)
        if u4:GetAttribute("Timestopped") == true then
            u7 = 0.1;

            return;
        end;

        u7 = u4:GetAttribute("ChronoClockSpeed");
    end);
    local MinuteHand = Mid.MinuteHand;
    local HourHand = Mid.HourHand;
    local Main = Mid.Main;
    local u8 = u4:FindFirstChild("Head") and u4:FindFirstChild("Head"):FindFirstChild("HaloAttach");
    local u9;

    if u8 then
        u9 = u8.C1;
    else
        u9 = u8;
    end;

    local _ = Halo.Numbers;
    local u10 = {};

    for _, child in Mid:GetChildren() do
        if child:IsA("Weld") and (child.Part1 and child.Part1.Parent == Halo.Numbers) then
            table.insert(u10, { child, child.C0 });
        end;
    end;

    local u11 = 0;
    local u12 = math.random(1, 12);
    u5:Connect(RunService.Heartbeat, function(p13) -- Line: 73
        -- upvalues: u6 (ref), u7 (ref), Main (copy), Angles (ref), rad (ref), MinuteHand (copy), HourHand (copy), u9 (copy), u8 (copy), u4 (copy), u10 (copy), u11 (ref), u12 (ref)
        local v14 = u6;
        u6 = v14 + (u7 * (p13 * 60) - v14) * 0.3;
        local v15 = Main;
        v15.C0 = v15.C0 * Angles(0, rad(-u6 / 1.5), 0);
        local v16 = MinuteHand;
        v16.C0 = v16.C0 * Angles(0, rad(u6 * 4), 0);
        local v17 = HourHand;
        v17.C0 = v17.C0 * Angles(0, rad(u6), 0);

        if u9 then
            local v18 = tick() * 3;
            local v19 = math.sin(v18) * -2.5;
            local v20 = math.rad(v19);
            local v21 = tick() * 3;
            local v22 = math.cos(v21) * -2.5;
            u8.C1 = u9 * Angles(v20, 0, (math.rad(v22)));
        end;

        if u4:GetAttribute("ChronoResurrection") then
            for i = 1, #u10 do
                local v23 = u10[i];
                local u24 = v23[1];
                local u25 = v23[2];

                if os.clock() - u11 > 0.05 and u12 == i then
                    u24.C0 = u24.C0:Lerp(u24.C0 * Angles(rad((math.random(-8, 8))), rad((math.random(-8, 8))), (rad((math.random(-7, 7))))), 0.4);
                    task.delay(math.random(20, 35) / 100, function() -- Line: 94
                        -- upvalues: u24 (copy), u25 (copy), u11 (ref), u12 (ref)
                        for i2 = 1, 10 do
                            task.wait();
                            u24.C0 = u24.C0:Lerp(u25, i2 / 15);
                        end;

                        u11 = os.clock();
                        u12 = math.random(1, 12);
                    end);
                end;
            end;
        end;
    end);
end;