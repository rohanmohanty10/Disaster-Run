  

 

local function Format(p1) -- Line: 1
    return string.format("%02i", p1);
end;

local function convertToHMS(p2) -- Line: 5
    local v3 = (p2 - p2 % 60) / 60;
    local v4 = (v3 - v3 % 60) / 60;

    return string.format("%02i", v4) .. ":" .. string.format("%02i", v3 - v4 * 60) .. ":" .. string.format("%02i", p2 - v3 * 60);
end;

return function(u5) -- Line: 13
    local _ = u5.Knit;
    local Parent = script.Parent;
    local u6 = `Version 6.2.2 ({game.PlaceVersion})`;

    local function UpdateServerInfo() -- Line: 22
        -- upvalues: Parent (copy), u6 (copy)
        local v7 = workspace:GetAttribute("StartupTime");

        if type(v7) == "number" then
            local v8 = game.Workspace:GetServerTimeNow() - v7;
            local v9 = math.abs(v8);
            local v10 = (v9 - v9 % 60) / 60;
            local v11 = (v10 - v10 % 60) / 60;
            Parent.ServerTime.Text = "Server Time: " .. string.format("%02i", v11) .. ":" .. string.format("%02i", v10 - v11 * 60) .. ":" .. string.format("%02i", v9 - v10 * 60);

            if v9 > 32400 then
                Parent.ServerTime.TextColor3 = Color3.new(1, 0.5, 0.5);
            end;
        end;

        Parent.ServerRegion.Text = `Server Region: {workspace:GetAttribute("ServerRegion") or "Unknown"}`;
        Parent.ServerId.Text = `Server Id: {workspace:GetAttribute("ServerId")}`;
        Parent.GameVersion.Text = u6;
        Parent.Visible = true;
    end;

    local wait = task.wait;
    task.spawn(function() -- Line: 38
        -- upvalues: wait (copy), UpdateServerInfo (copy)
        while wait(1) do
            pcall(UpdateServerInfo);
        end;
    end);
    Parent:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 44
        -- upvalues: Parent (copy)
        if Parent.Visible then
            return;
        end;

        Parent.Visible = true;
    end);
    local u12 = 0;
    local u13 = os.clock();
    game:GetService("RunService").RenderStepped:Connect(function(p14) -- Line: 54
        -- upvalues: u13 (ref), Parent (copy), u5 (copy), u12 (ref)
        if os.clock() - u13 >= 0.25 then
            u13 = os.clock();
            local Ping = Parent.Ping;
            local format = string.format;
            local v15 = u5.Player:GetNetworkPing() * 1000;
            Ping.Text = `Ping: {format("%.2f", (tostring(v15)))}ms`;
        end;

        u12 = u12 + p14;

        if u12 < 0.25 then
            return;
        end;

        u12 = 0;
        Parent.FPS.Text = string.format("FPS: %.1f", 1 / p14);
    end);
end;