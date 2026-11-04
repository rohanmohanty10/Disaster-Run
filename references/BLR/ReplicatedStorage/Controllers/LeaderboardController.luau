  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local Workspace = game:GetService("Workspace");
local Knit = require(ReplicatedStorage.Packages.Knit);
local u1 = nil;
local Background = script:WaitForChild("Background");
local v2 = Knit.CreateController({
    Name = "LeaderboardController",
    WorldBoards = {
        Goals = {
            Stat = "Goals",
            Name = "Goals",
            Board = Workspace.Leaderboards.GOALS
        },
        Assists = {
            Stat = "Assists",
            Name = "Assists",
            Board = Workspace.Leaderboards.Assists
        },
        Saves = {
            Stat = "Saves",
            Name = "Saves",
            Board = Workspace.Leaderboards.Saves
        },
        Ankles = {
            Stat = "Ankles",
            Name = "Ankles",
            Board = Workspace.Leaderboards.Ankles
        },
        MVP = {
            Stat = "MVP",
            Name = "MVP",
            Board = Workspace.Leaderboards.MVP
        }
    },
    RankColors = { Color3.new(1, 0.721569, 0.0666667), Color3.new(0.603922, 0.603922, 0.603922), Color3.new(1, 0.580392, 0.278431) },
    CurrentTimeframes = {},
    CurrentUpdateTasks = {}
});

local function ClearVisualBoard(p3: userdata) -- Line: 32
    if not p3 then
        return;
    end;

    local v4 = p3:FindFirstChildWhichIsA("SurfaceGui");

    if not v4 then
        return;
    end;

    local Players = v4:FindFirstChild("Players");

    if not Players then
        return;
    end;

    for _, child in ipairs(Players:GetChildren()) do
        if child:IsA("ImageLabel") ~= false then
            child:Destroy();
        end;
    end;
end;

local function PopulateVisualBoard(p5: userdata, p6: table, p7: string, p8: table) -- Line: 55
    -- upvalues: Background (copy)
    if not p5 then
        return;
    end;

    local v9 = p5:FindFirstChildWhichIsA("SurfaceGui");

    if not v9 then
        return;
    end;

    local Players = v9:FindFirstChild("Players");

    if not Players then
        return;
    end;

    for _, v in ipairs(p6) do
        local v10 = Background:Clone();
        v10.Rank.Text = "#" .. v.rank;
        v10.Name1.Text = v.userName;
        v10.Time.Text = tostring(v.value) .. " " .. p7;
        local v11 = p8[v.rank] or Color3.new(1, 1, 1);
        v10.Rank.TextColor3 = v11;
        v10.Name1.TextColor3 = v11;
        v10.Photo1.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. v.userId .. "&width=420&height=420&format=png";
        v10.Parent = Players;
    end;
end;

function v2.RefreshBoard(u12: table, p13: string) -- Line: 85
    -- upvalues: u1 (ref), ClearVisualBoard (copy), PopulateVisualBoard (copy)
    local u14 = u12.WorldBoards[p13];

    if not u14 then
        return;
    end;

    local v15 = u12.CurrentTimeframes[p13];

    if not v15 then
        return;
    end;

    if u12.CurrentUpdateTasks[p13] then
        task.cancel(u12.CurrentUpdateTasks[p13]);
        u12.CurrentUpdateTasks[p13] = nil;
    end;

    local u16 = u1:GetCurrentBoard(p13, v15) or {};
    ClearVisualBoard(u14.Board);
    u12.CurrentUpdateTasks[p13] = task.spawn(function() -- Line: 108
        -- upvalues: PopulateVisualBoard (ref), u14 (copy), u16 (ref), u12 (copy)
        PopulateVisualBoard(u14.Board, u16, u14.Name, u12.RankColors);
    end);
end;

function v2.OnTimeframeSelected(p17: table, p18: string, p19: string) -- Line: 113
    if p17.CurrentTimeframes[p18] == p19 then
        return;
    end;

    p17.CurrentTimeframes[p18] = p19;
    p17:RefreshBoard(p18);
end;

function v2.KnitStart(u20) -- Line: 122
    -- upvalues: u1 (ref)
    for i, v in pairs(u20.WorldBoards) do
        u20.CurrentTimeframes[i] = "Lifetime";
        local v21 = v.Board:FindFirstChildWhichIsA("SurfaceGui");

        if v21 then
            local Buttons = v21:WaitForChild("Buttons");

            if Buttons then
                local u22 = i;

                for _, child in ipairs(Buttons:GetChildren()) do
                    if child:IsA("ImageButton") then
                        child.MouseButton1Click:Connect(function() -- Line: 138
                            -- upvalues: u20 (copy), u22 (copy), child (copy)
                            u20:OnTimeframeSelected(u22, child.Name);
                        end);
                    end;
                end;

                u20:RefreshBoard(u22);
            end;
        end;
    end;

    u1.NotifyLeaderboardUpdated:Connect(function(p23: string) -- Line: 147
        -- upvalues: u20 (copy)
        local v24 = p23:split("_");
        local v25 = v24[1];

        if u20.CurrentTimeframes[v25] and v24[2] == u20.CurrentTimeframes[v25] then
            u20:RefreshBoard(v25);
        end;
    end);
end;

function v2.KnitInit(p26) -- Line: 158
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("LeaderboardService");
end;

return v2;