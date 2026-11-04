  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local ReplicatorClient = require(ReplicatedStorage.Modules.ReplicatorClient);
local LocalPlayer = Players.LocalPlayer;
local v1 = Knit.CreateController({
    Name = "PollController"
});

local function comma(p2: number) -- Line: 19
    local v3 = tostring(p2);
    local v4 = -1;

    while v4 ~= 0 do
        v3, v4 = string.gsub(v3, "^(-?%d+)(%d%d%d)", "%1,%2");
    end;

    return v3;
end;

function v1.KnitStart(p5) -- Line: 28
    -- upvalues: Knit (copy), ReplicatorClient (copy), LocalPlayer (copy), comma (copy), RunService (copy)
    local Service = Knit.GetService("PollService");
    local u6 = ReplicatorClient.get("Polls");
    u6:WaitForLoaded();
    local AdminAbusePoll = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("AdminAbusePoll");
    AdminAbusePoll.ResetOnSpawn = false;
    AdminAbusePoll.Enabled = false;
    local AdminAbusePoll2 = AdminAbusePoll:WaitForChild("AdminAbusePoll");
    local TextLabel = AdminAbusePoll2.Header.TextLabel;
    local Title = AdminAbusePoll2.Frame.Title;
    local Info = AdminAbusePoll2.Frame.Info;
    local PlayerVotes = AdminAbusePoll2.Frame.PlayerVotes;
    local Vote = AdminAbusePoll2.Vote;
    local Reward = AdminAbusePoll2.Vote.Reward;
    local u7 = {
        A = AdminAbusePoll2.Frame.List.Option1,
        B = AdminAbusePoll2.Frame.List.Option2
    };
    local u8 = nil;
    local u9 = nil;
    local u10 = false;
    local u11 = false;

    local function getActivePoll() -- Line: 54
        -- upvalues: u6 (copy)
        local v12 = u6:TryIndex({ "activePoll" });

        if v12 then
            return v12, u6:TryIndex({ "polls", v12 });
        end;

        return v12, nil;
    end;

    local function refresh() -- Line: 60
        -- upvalues: getActivePoll (copy), u8 (ref), AdminAbusePoll (copy), u9 (ref), u10 (ref), u11 (ref), TextLabel (copy), Title (copy), Info (copy), u7 (copy), LocalPlayer (ref), PlayerVotes (copy), comma (ref), Vote (copy), Reward (copy)
        local v13, v14 = getActivePoll();

        if not v14 then
            u8 = nil;
            AdminAbusePoll.Enabled = false;

            return;
        end;

        if v13 ~= u8 then
            u8 = v13;
            u9 = nil;
            u10 = false;
            u11 = false;
            TextLabel.Text = v14.header;
            Title.Text = v14.text;
            Info.Text = "Choose one";
            u7.A:FindFirstChild("Name").Text = v14.option1;
            u7.B:FindFirstChild("Name").Text = v14.option2;
        end;

        if u11 then
            AdminAbusePoll.Enabled = false;

            return;
        end;

        AdminAbusePoll.Enabled = true;
        local ServerTimeNow = workspace:GetServerTimeNow();
        local v15 = v14.endsAt <= ServerTimeNow;
        local v16 = v14.voted[tostring(LocalPlayer.UserId)];
        local A = v14.votes.A;
        local B = v14.votes.B;
        local v17 = A + B;
        local math_ceil_ret = math.ceil(v14.endsAt - ServerTimeNow);
        local math_max_ret = math.max(0, math_ceil_ret);
        local v18;

        if v15 then
            v18 = `{comma(v17)} Votes · Ended`;
        else
            v18 = `{comma(v17)} Votes · {math_max_ret}s left`;
        end;

        PlayerVotes.Text = v18;
        local v19 = v16 ~= nil and true or (u10 or v15);
        local v20 = v16 or u9;

        for i, v in u7 do
            local v21;

            if i == "A" then
                v21 = A;
            else
                v21 = B;
            end;

            local v22 = v17 <= 0 and 0 or math.round(v21 / v17 * 100);
            v.VotedAmount.Visible = v19;
            v.VotedAmount.Text = `{v22}%`;
            v.ToggleSelect.Image = v20 == i and "rbxassetid://140475226626438" or "rbxassetid://101730732997509";
        end;

        Vote.ImageTransparency = (v16 ~= nil and true or v15) and 0.45 or 0;
        Reward.Text = v16 and "Voted" or (v15 and "Closed" or "Vote");
    end;

    local function canChoose(p23) -- Line: 111
        -- upvalues: LocalPlayer (ref)
        if not p23 then
            return false;
        end;

        if workspace:GetServerTimeNow() >= p23.endsAt then
            return false;
        end;

        return p23.voted[tostring(LocalPlayer.UserId)] == nil;
    end;

    for i, v in u7 do
        v.ToggleSelect.Activated:Connect(function() -- Line: 122
            -- upvalues: getActivePoll (copy), LocalPlayer (ref), u9 (ref), i (copy), refresh (copy)
            local _, v24 = getActivePoll();
            local v25;

            if v24 and workspace:GetServerTimeNow() < v24.endsAt then
                v25 = v24.voted[tostring(LocalPlayer.UserId)] == nil;
            else
                v25 = false;
            end;

            if not v25 then
                return;
            end;

            u9 = i;
            refresh();
        end);
    end;

    Vote.Activated:Connect(function() -- Line: 132
        -- upvalues: getActivePoll (copy), u9 (ref), LocalPlayer (ref), Service (copy)
        local v26, v27 = getActivePoll();

        if u9 then
            local v28;

            if v27 and workspace:GetServerTimeNow() < v27.endsAt then
                v28 = v27.voted[tostring(LocalPlayer.UserId)] == nil;
            else
                v28 = false;
            end;

            if v28 then
                Service.Vote:Fire(v26, u9);
            end;
        end;
    end);
    AdminAbusePoll2.ShowResults.Activated:Connect(function() -- Line: 140
        -- upvalues: u10 (ref), refresh (copy)
        u10 = true;
        refresh();
    end);
    AdminAbusePoll2.Header.CloseButton.Activated:Connect(function() -- Line: 145
        -- upvalues: u11 (ref), AdminAbusePoll (copy)
        u11 = true;
        AdminAbusePoll.Enabled = false;
    end);
    local u29 = nil;
    u6:Observe({ "activePoll" }, function(p30) -- Line: 151
        -- upvalues: u29 (ref), u6 (copy), refresh (copy)
        if u29 then
            u29();
            u29 = nil;
        end;

        if p30 then
            u29 = u6:Observe({ "polls", p30 }, refresh);
        end;

        refresh();
    end);
    local u31 = 0;
    RunService.Heartbeat:Connect(function(p32) -- Line: 163
        -- upvalues: u31 (ref), u8 (ref), refresh (copy)
        u31 = u31 + p32;

        if u31 < 0.25 then
            return;
        end;

        u31 = 0;

        if u8 then
            refresh();
        end;
    end);
end;

return v1;