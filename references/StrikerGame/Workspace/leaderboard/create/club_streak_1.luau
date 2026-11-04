 
 

local v1 = script:FindFirstAncestorWhichIsA("Folder");
local club_streak = v1.club_streak;
local Template = v1.createleaderboard.Template;
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Club = require(ReplicatedStorage.Club);

local function update_leaderboard() -- Line: 18
    -- upvalues: Club (copy), club_streak (copy), Template (copy)
    local TopClubs = Club.GetTopClubs();

    for _, child in club_streak.sufui.List:GetChildren() do
        if child:IsA("Frame") then
            child:Destroy();
        end;
    end;

    for _, v in ipairs(TopClubs) do
        local v2 = Template:Clone();
        local ClubInfo = Club.GetClubInfo(v.club);
        v2.pname.Text = ClubInfo and ClubInfo.Name or v.club;
        v2.score.Text = v.streak;
        v2.ImageLabel.Image = ClubInfo and (`rbxassetid://{ClubInfo.Icon}` or "") or "";
        local v3;

        if ClubInfo == nil then
            v3 = false;
        else
            v3 = ClubInfo.Icon ~= 0;
        end;

        v2.ImageLabel.Visible = v3;
        v2.topgradient.Enabled = v.rank <= 5;
        v2.LayoutOrder = v.rank;
        v2.Parent = club_streak.sufui.List;
    end;
end;

local function update_rewards() -- Line: 40
    -- upvalues: Players (copy), Club (copy)
    local v4 = {};

    for _, v in Players:GetPlayers() do
        local ClubData, v5 = Club.GetClubData(v);

        if v5 then
            if not v4[v5] then
                v4[v5] = {
                    Members = {},
                    Streak = ClubData.Streak or 0
                };
            end;

            table.insert(v4[v5].Members, v);
        end;
    end;

    for i, v in v4 do
        Club.CheckStreakMilestones(i, v.Streak, v.Members);
    end;
end;

return function(p6) -- Line: 57
    -- upvalues: update_leaderboard (copy), update_rewards (copy)
    local v7 = true;

    while task.wait(v7 and math.lerp(p6[2][1], p6[2][2], math.random()) or p6[1]) do
        if v7 then
            v7 = false;
        end;

        xpcall(update_leaderboard, function(p8) -- Line: 61
            warn((`[club_streak Leaderboard Update]: {p8}`));
        end);
        xpcall(update_rewards, function(p9) -- Line: 64
            warn((`[club_streak Rewards Update]: {p9}`));
        end);
    end;
end;