  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local RankedData = require(ReplicatedStorage.Shared.Ranked.RankedData);
local Popup = require(ReplicatedStorage.Shared.Popup);
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local u1 = Knit.CreateController({
    Name = "RankRewardsController"
});
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = false;
local u11 = nil;
local u12 = false;

local function findRewardsUI() -- Line: 30
    -- upvalues: PlayerGui (copy), u4 (ref), u3 (ref), u5 (ref), u9 (ref), u6 (ref), u7 (ref), u8 (ref)
    for _, child in PlayerGui:WaitForChild("Modes"):WaitForChild("Frame"):GetChildren() do
        if child.Name == "Rewards" and child:IsA("ImageButton") then
            u4 = child;
        elseif child.Name == "Rewards" and child:IsA("Frame") then
            u3 = child;
        end;
    end;

    if not (u3 and u4) then
        warn("[RankRewardsController] Could not find Rewards UI elements");

        return false;
    end;

    u5 = u3:FindFirstChild("Close");
    local Rewards = u3:FindFirstChild("Rewards");

    if not Rewards then
        return false;
    end;

    u9 = Rewards:FindFirstChild("Timer");
    u6 = Rewards:FindFirstChild("Rewards");

    if not u6 then
        return false;
    end;

    u7 = u6:FindFirstChild("Content");
    local Progress = u6:FindFirstChild("Progress");

    if Progress then
        u8 = Progress:FindFirstChild("Fill");
    end;

    return true;
end;

local function getSortedRankTiers() -- Line: 68
    -- upvalues: u7 (ref)
    local v13 = {};

    for _, child in u7:GetChildren() do
        if child.Name == "RankTier" and child:IsA("Frame") then
            table.insert(v13, child);
        end;
    end;

    table.sort(v13, function(p14, p15) -- Line: 75
        return p14.LayoutOrder < p15.LayoutOrder;
    end);

    return v13;
end;

function u1.RefreshUI(p16) -- Line: 81
    -- upvalues: u2 (ref), RankedData (copy), getSortedRankTiers (copy), u8 (ref), TweenService (copy), u7 (ref), u6 (ref)
    local success, result = pcall(function() -- Line: 82
        -- upvalues: u2 (ref)
        return u2:GetRankRewardsData();
    end);

    if not (success and result) then
        warn("[RankRewardsController] Failed to get rank rewards data");

        return;
    end;

    local HighestElo = result.HighestElo;
    local v17 = result.RankRewards or {};
    local Rank, v18 = RankedData.GetRank(HighestElo);
    local RankOrder = RankedData.GetRankOrder(Rank, v18);
    local RewardSlots = RankedData.GetRewardSlots();
    local v19 = getSortedRankTiers();
    local v20 = 0;

    for i, v in v19 do
        local v21 = RewardSlots[i];

        if v21 then
            local Rank2 = v:FindFirstChild("Rank");
            local Reward = v:FindFirstChild("Reward");

            if Reward then
                local Icon = Reward:FindFirstChild("Icon");
                local Claim = Reward:FindFirstChild("Claim");
                local Locked = Reward:FindFirstChild("Locked");
                local Claimed = Reward:FindFirstChild("Claimed");

                if Rank2 and v21.BadgeImage then
                    Rank2.Image = v21.BadgeImage;
                end;

                if Icon and v21.Reward then
                    Icon.Image = v21.Reward.Icon or "";
                end;

                local v22 = v21.RankName .. "_" .. tostring(v21.Division);
                local v23 = RankedData.GetRankOrder(v21.RankName, v21.Division) <= RankOrder;

                if v23 then
                    v20 = i;
                end;

                if v17[v22] == true then
                    if Claim then
                        Claim.Visible = false;
                    end;

                    if Locked then
                        Locked.Visible = false;
                    end;

                    if Claimed then
                        Claimed.Visible = true;
                    end;
                elseif v23 then
                    if Claim then
                        Claim.Visible = true;
                    end;

                    if Locked then
                        Locked.Visible = false;
                    end;

                    if Claimed then
                        Claimed.Visible = false;
                    end;
                else
                    if Claim then
                        Claim.Visible = false;
                    end;

                    if Locked then
                        Locked.Visible = true;
                    end;

                    if Claimed then
                        Claimed.Visible = false;
                    end;
                end;
            end;
        end;
    end;

    if u8 then
        local v24;

        if v20 > 0 then
            local DivisionProgress = RankedData.GetDivisionProgress(HighestElo);
            v24 = (v20 - 1 + DivisionProgress) / math.max(#v19 - 1, 1);
        else
            v24 = 0;
        end;

        TweenService:Create(u8, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(math.clamp(v24, 0, 1), 0, 1, 0)
        }):Play();
    end;

    if v20 > 0 and v20 <= #v19 then
        local u25 = v19[math.min(v20 + 1, #v19)];
        task.defer(function() -- Line: 164
            -- upvalues: u25 (copy), u7 (ref), u6 (ref)
            local math_max_ret = math.max(0, u25.AbsolutePosition.X - u7.AbsolutePosition.X - u6.AbsoluteSize.X / 2);
            u6.CanvasPosition = Vector2.new(math_max_ret, 0);
        end);
    end;
end;

local function wireClaimButtons() -- Line: 172
    -- upvalues: RankedData (copy), getSortedRankTiers (copy), u12 (ref), u2 (ref), u1 (copy)
    local RewardSlots = RankedData.GetRewardSlots();

    for i, v in getSortedRankTiers() do
        local u26 = RewardSlots[i];

        if u26 then
            local Reward = v:FindFirstChild("Reward");

            if Reward then
                local Claim = Reward:FindFirstChild("Claim");

                if Claim then
                    Claim.Activated:Connect(function() -- Line: 185
                        -- upvalues: u12 (ref), u2 (ref), u26 (copy), u1 (ref)
                        if u12 then
                            return;
                        end;

                        u12 = true;
                        local success, _ = pcall(function() -- Line: 189
                            -- upvalues: u2 (ref), u26 (ref)
                            return u2:ClaimRankReward(u26.RankName, u26.Division);
                        end);

                        if success then
                            u1:RefreshUI();
                        end;

                        task.delay(0.5, function() -- Line: 197
                            -- upvalues: u12 (ref)
                            u12 = false;
                        end);
                    end);
                end;
            end;
        end;
    end;
end;

function u1.StartTimer(p27) -- Line: 204
    -- upvalues: u11 (ref), RunService (copy), u9 (ref), RankedData (copy)
    p27:StopTimer();
    u11 = RunService.Heartbeat:Connect(function() -- Line: 206
        -- upvalues: u9 (ref), RankedData (ref)
        if not u9 then
            return;
        end;

        local v28 = (workspace:GetAttribute("RankedExpiresAt") or RankedData.ExpiresAt) - os.time();

        if v28 <= 0 then
            u9.Text = "SEASON ENDED";

            return;
        end;

        local math_floor_ret = math.floor(v28 / 86400);
        local math_floor_ret2 = math.floor(v28 % 86400 / 3600);
        local math_floor_ret3 = math.floor(v28 % 3600 / 60);
        u9.Text = string.format("SEASON ENDS IN %02d:%02d:%02d:%02d", math_floor_ret, math_floor_ret2, math_floor_ret3, v28 % 60);
    end);
end;

function u1.StopTimer(p29) -- Line: 222
    -- upvalues: u11 (ref)
    if u11 then
        u11:Disconnect();
        u11 = nil;
    end;
end;

function u1.KnitStart(u30) -- Line: 229
    -- upvalues: u2 (ref), Knit (copy), findRewardsUI (copy), u3 (ref), u4 (ref), Popup (copy), LocalPlayer (copy), u5 (ref), u10 (ref), wireClaimButtons (copy)
    u2 = Knit.GetService("RankedService");

    if not findRewardsUI() then
        warn("[RankRewardsController] UI not found, aborting");

        return;
    end;

    u3.Visible = false;
    u4.Activated:Connect(function() -- Line: 242
        -- upvalues: Popup (ref), LocalPlayer (ref)
        Popup.Popup(LocalPlayer, "Rewards coming soon");
    end);

    if u5 then
        u5.Activated:Connect(function() -- Line: 259
            -- upvalues: u10 (ref), u3 (ref), u30 (copy)
            u10 = false;
            u3.Visible = false;
            u30:StopTimer();
        end);
    end;

    wireClaimButtons();
end;

return u1;