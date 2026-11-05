  

 

local function Format(p1) -- Line: 1
    return string.format("%02i", p1);
end;

local function convertToHMS(p2) -- Line: 5
    local v3 = (p2 - p2 % 60) / 60;
    local v4 = (v3 - v3 % 60) / 60;

    return string.format("%02i", v4) .. ":" .. string.format("%02i", v3 - v4 * 60) .. ":" .. string.format("%02i", p2 - v3 * 60);
end;

local function Round(p5, p6) -- Line: 13
    local v7 = p5 * math.pow(10, p6 or 1);

    return math.round(v7) / math.pow(10, p6 or 1);
end;

return function(p8) -- Line: 17
    local _ = p8.Knit;
    local Parent = script.Parent;
    local LocalPlayer = game:GetService("Players").LocalPlayer;
    local u9 = {};

    local function UpdateMultipliers() -- Line: 27
        -- upvalues: Parent (copy), u9 (copy), LocalPlayer (copy)
        Parent.Visible = true;
        local wday = os.date("*t").wday;

        if wday == 7 or (wday == 1 or wday == 6) then
            if not u9.Weekend then
                u9.Weekend = {
                    Text = "<i><font color=\"rgb(255, 204, 121)\">+ 2x EXP <b>(Weekend)</b></font></i>"
                };
            end;
        elseif u9.Weekend then
            u9.Weekend = nil;
        end;

        if LocalPlayer:FindFirstChild("Data") and LocalPlayer:FindFirstChild("Data"):FindFirstChild("Ability") then
            local v10 = LocalPlayer:FindFirstChild("Data"):FindFirstChild("Ability"):GetAttribute("AscensionRank");

            if v10 and v10 > 0 then
                local v11 = {};
                local v12 = math.clamp(1 + 0.025 * v10, 1, 3) * 10000;
                v11.Text = `<i><font color="rgb(212, 162, 255)">+ {math.round(v12) / 10000}x EXP <b>(Ascensions)</b></font></i>`;
                u9.Ascension = v11;
            else
                u9.Ascension = nil;
            end;
        end;

        if LocalPlayer.MembershipType == Enum.MembershipType.Premium then
            u9.Premium = {
                Text = `<font color="rgb(212, 212, 212)"><i>+ 1.15x EXP</i> <b>({utf8.char(57345)} )</b></font>`
            };
        else
            u9.Premium = nil;
        end;

        if workspace:GetServerTimeNow() <= DateTime.fromUniversalTime(2025, 8, 15).UnixTimestamp then
            u9.Event = {
                Text = "<font color=\"rgb(255, 225, 58)\"><i>+ 2x EXP</i> <b>(2x XP Event)</b></font>"
            };
        else
            u9.Event = nil;
        end;

        for _, child in pairs(Parent:GetChildren()) do
            if child:IsA("TextLabel") then
                child:Destroy();
            end;
        end;

        for i, v in u9 do
            local v13 = script.Multiplier:Clone();
            v13.Text = v.Text;
            v13.Visible = true;
            v13.Name = i;
            v13.Parent = Parent;
        end;
    end;

    local wait = task.wait;
    task.spawn(function() -- Line: 89
        -- upvalues: wait (copy), UpdateMultipliers (copy)
        while wait(1) do
            pcall(UpdateMultipliers);
        end;
    end);
    Parent:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 95
        -- upvalues: Parent (copy)
        if Parent.Visible then
            return;
        end;

        Parent.Visible = true;
    end);
end;