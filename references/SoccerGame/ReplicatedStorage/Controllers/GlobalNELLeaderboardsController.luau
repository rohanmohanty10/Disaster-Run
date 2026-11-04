  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local KnitClient = require(ReplicatedStorage.Packages.Knit.KnitClient);
local SalaryConfig = require(ReplicatedStorage.Shared.Configs.SalaryConfig);
local _ = Players.LocalPlayer;
local v1 = KnitClient.CreateController({
    Name = "GlobalNELLeaderboardsController"
});
local u2 = { "Lifetime", "Weekly", "Monthly" };

local function comma(p3) -- Line: 13
    local v4 = tonumber(p3) or 0;
    local math_floor_ret = math.floor(v4);
    local v5 = tostring(math_floor_ret);
    local v6;

    repeat
        v5, v6 = string.gsub(v5, "^(-?%d+)(%d%d%d)", "%1,%2");
    until v6 == 0;

    return v5;
end;

local function shortYen(p7) -- Line: 23
    -- upvalues: comma (copy)
    local v8 = tonumber(p7) or 0;

    if v8 >= 1000000000 then
        return string.format("%.1fB", v8 / 1000000000);
    end;

    if v8 >= 1000000 then
        return string.format("%.0fM", v8 / 1000000);
    end;

    return comma(v8);
end;

local function teamIcon(p9) -- Line: 30
    -- upvalues: SalaryConfig (copy)
    return p9 and (p9 ~= "" and SalaryConfig.TeamIcons[p9] or "") or "";
end;

function v1.HighlightButtons(p10, p11) -- Line: 34
    -- upvalues: u2 (copy)
    if not p11.btns then
        return;
    end;

    for _, v in u2 do
        local v12 = p11.btns:FindFirstChild(v);

        if v12 then
            v12.ImageTransparency = v == p11.period and 0 or 0.45;
        end;
    end;
end;

function v1.RenderBoard(p13, p14) -- Line: 42
    -- upvalues: comma (copy), SalaryConfig (copy), Players (copy)
    local _data = p13._data;
    local v15 = _data and _data[p14.kind] and (_data[p14.kind][p14.period] or {}) or {};

    for i, v in p14.rows do
        local v16 = v15[i];
        v.Visible = v16 ~= nil;

        if v16 then
            local Num = v:FindFirstChild("Num");

            if Num then
                Num.Text = "#" .. i;
            end;

            local Name = v:FindFirstChild("Name");

            if Name then
                Name.Text = v16.Name or "?";
            end;

            local Amount = v:FindFirstChild("Amount");

            if Amount then
                if p14.kind == "Wins" then
                    Amount.Text = comma(v16.Value) .. " WINS";
                else
                    local v17 = tonumber(v16.Value) or 0;
                    local v18;

                    if v17 >= 1000000000 then
                        v18 = string.format("%.1fB", v17 / 1000000000);
                    elseif v17 >= 1000000 then
                        v18 = string.format("%.0fM", v17 / 1000000);
                    else
                        v18 = comma(v17);
                    end;

                    Amount.Text = "¥ " .. v18;
                end;
            end;

            local TeamLogo = v:FindFirstChild("TeamLogo");

            if TeamLogo then
                local Team = v16.Team;
                TeamLogo.Image = Team and Team ~= "" and (SalaryConfig.TeamIcons[Team] or "") or "";
            end;

            local ProfileIMG = v:FindFirstChild("ProfileIMG");

            if ProfileIMG then
                ProfileIMG = ProfileIMG:FindFirstChild("PlayerID");
            end;

            if ProfileIMG then
                local UserId = v16.UserId;
                task.spawn(function() -- Line: 67
                    -- upvalues: Players (ref), UserId (copy), ProfileIMG (copy)
                    local success, result = pcall(function() -- Line: 68
                        -- upvalues: Players (ref), UserId (ref)
                        return Players:GetUserThumbnailAsync(UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150);
                    end);

                    if success then
                        ProfileIMG.Image = result;
                    end;
                end);
            end;
        end;
    end;
end;

function v1.Refresh(u19) -- Line: 78
    task.spawn(function() -- Line: 79
        -- upvalues: u19 (copy)
        local success, result = pcall(function() -- Line: 80
            -- upvalues: u19 (ref)
            return u19.Service:GetGlobalLeaderboards();
        end);

        if success and result then
            u19._data = result;

            for _, v in u19._boards do
                u19:RenderBoard(v);
            end;
        end;
    end);
end;

function v1._Setup(u20, p21, p22) -- Line: 88
    -- upvalues: u2 (copy)
    local v23 = workspace:WaitForChild("NELGlobalLeaderboards"):FindFirstChild(p21);

    if not v23 then
        return;
    end;

    local v24 = v23:FindFirstChildOfClass("SurfaceGui");

    if not v24 then
        return;
    end;

    local Players2 = v24:FindFirstChild("Players");

    if not Players2 then
        return;
    end;

    local v25 = {};

    for _, child in Players2:GetChildren() do
        if child:IsA("Frame") then
            local v26 = tostring(child.Name);
            local v27 = tonumber(v26:match("%d+"));

            if v27 then
                table.insert(v25, {
                    rank = v27,
                    frame = child
                });
            end;
        end;
    end;

    table.sort(v25, function(p28, p29) -- Line: 103
        return p28.rank < p29.rank;
    end);
    local v30 = {};

    for _, v in v25 do
        table.insert(v30, v.frame);
    end;

    local u31 = {
        period = "Lifetime",
        kind = p22,
        rows = v30,
        surface = v24,
        btns = v24:FindFirstChild("Buttons")
    };
    table.insert(u20._boards, u31);

    if u31.btns then
        for _, v in u2 do
            local v32 = u31.btns:FindFirstChild(v);

            if v32 and v32:IsA("GuiButton") then
                v32.Activated:Connect(function() -- Line: 112
                    -- upvalues: u31 (copy), v (copy), u20 (copy)
                    u31.period = v;
                    u20:RenderBoard(u31);
                    u20:HighlightButtons(u31);
                end);
            end;
        end;
    end;

    u20:HighlightButtons(u31);
end;

function v1.KnitStart(u33) -- Line: 123
    -- upvalues: KnitClient (copy)
    u33.Service = KnitClient.GetService("GlobalNELLeaderboardsService");
    u33._boards = {};
    u33:_Setup("NELTEAMWINS", "Wins");
    u33:_Setup("NELSALARY", "Salary");
    u33:Refresh();
    task.delay(12, function() -- Line: 129
        -- upvalues: u33 (copy)
        u33:Refresh();
    end);
    task.spawn(function() -- Line: 130
        -- upvalues: u33 (copy)
        while true do
            task.wait(300);
            u33:Refresh();
        end;
    end);
end;

return v1;