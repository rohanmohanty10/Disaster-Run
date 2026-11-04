  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Teams = game:GetService("Teams");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local Icon = require(ReplicatedStorage.Shared.TopbarPlus.Icon);
local LocalPlayer = Players.LocalPlayer;
local Color3_fromRGB_ret = Color3.fromRGB(69, 195, 64);
local Color3_new_ret = Color3.new(1, 1, 1);
local u1 = {
    Money = "rbxassetid://123572707549677",
    Flow = "rbxassetid://89367411223809",
    Spin = "rbxassetid://102393117398440"
};
local u2 = {
    Spin = "rbxassetid://125339871021518",
    Flow = "rbxassetid://133558083095603",
    Money = "rbxassetid://73450831489751"
};
local u8 = {
    Match = function(p3) -- Line: 35, Name: Match
        return "Play " .. tostring(p3) .. " Matches!";
    end,

    Goal = function(p4) -- Line: 38, Name: Goal
        return "Score " .. tostring(p4) .. " Goals!";
    end,

    Assist = function(p5) -- Line: 41, Name: Assist
        return "Score " .. tostring(p5) .. " Assists!";
    end,

    Steal = function(p6) -- Line: 44, Name: Steal
        return "Steal the ball " .. tostring(p6) .. " times!";
    end,

    Ankle = function(p7) -- Line: 47, Name: Ankle
        return "Do " .. tostring(p7) .. " Ankle Breakers!";
    end
};

local function questText(p9: table) -- Line: 52
    -- upvalues: u8 (copy)
    local Amount = p9.Requirements.Amount;
    local v10 = u8[p9.Requirements.Mission];

    if v10 then
        return v10(Amount);
    end;

    return "Complete " .. tostring(Amount) .. " " .. tostring(p9.Requirements.Mission);
end;

local function rewardText(p11: table) -- Line: 61
    -- upvalues: Essentials (copy)
    if p11.Name == "Spin" then
        return "+" .. tostring(p11.Amount) .. " Spins";
    end;

    if p11.Name == "Flow" then
        return "+" .. tostring(p11.Amount) .. " Flow Spins";
    end;

    if p11.Name == "Money" then
        return "+" .. Essentials:formatNumberWithCommas(p11.Amount) .. " Cash";
    end;

    return nil;
end;

local function isValidQuest(p12) -- Line: 72
    local v13;

    if typeof(p12) == "table" and (typeof(p12.AmountDone) == "number" and typeof(p12.Requirements) == "table") then
        v13 = typeof(p12.Requirements.Amount) == "number";
    else
        v13 = false;
    end;

    return v13;
end;

local function isComplete(p14: table) -- Line: 79
    return p14.Done == true and true or p14.AmountDone >= p14.Requirements.Amount;
end;

local v15 = Knit.CreateController({
    Name = "DailyQuestTrackerController"
});

function v15.KnitStart(p16) -- Line: 87
    -- upvalues: Knit (copy), LocalPlayer (copy), Icon (copy), Teams (copy), u8 (copy), Color3_fromRGB_ret (copy), Color3_new_ret (copy), Essentials (copy), u1 (copy), u2 (copy)
    local Service = Knit.GetService("QuestsService");
    local Service2 = Knit.GetService("OnboardingService");
    local DailyQuestTracker = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("DailyQuestTracker");
    local Container = DailyQuestTracker:WaitForChild("Container");
    local Panel = Container:WaitForChild("Panel");
    local List = Panel:WaitForChild("List");
    local Collapse = Panel:WaitForChild("Collapse");
    local Tab = Container:WaitForChild("Tab");
    local u17 = Icon.new():setName("DailyQuests"):setImage(18853233929):setLabel("Daily Quests"):align("Right"):setEnabled(false);
    local u18 = false;
    local u19 = nil;
    local u20 = {
        Quest1 = List:WaitForChild("Quest1"),
        Quest2 = List:WaitForChild("Quest2"),
        Quest3 = List:WaitForChild("Quest3")
    };
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line: 111, Name: updateLayout
        -- upvalues: Container (copy), u17 (copy)
        local v21 = workspace.CurrentCamera.ViewportSize.X < 1000 and 0.42 or 0.22;
        Container.Size = UDim2.fromScale(v21, 0.4);
        Container.Position = UDim2.fromScale(not u17.isSelected and 0 or v21 + 0.008, 0.22);
    end);
    local v22 = workspace.CurrentCamera.ViewportSize.X < 1000 and 0.42 or 0.22;
    Container.Size = UDim2.fromScale(v22, 0.4);
    Container.Position = UDim2.fromScale(not u17.isSelected and 0 or v22 + 0.008, 0.22);

    local function inMatch() -- Line: 121
        -- upvalues: LocalPlayer (ref), Teams (ref)
        local Team = LocalPlayer.Team;
        local v23;

        if Team == nil then
            v23 = false;
        else
            v23 = Team ~= Teams:FindFirstChild("Visitor");
        end;

        return v23;
    end;

    local function render() -- Line: 126
        -- upvalues: u19 (ref), u20 (copy), u8 (ref), Color3_fromRGB_ret (ref), Color3_new_ret (ref), Essentials (ref), u1 (ref), u2 (ref), u17 (copy)
        local v24 = u19;

        if not v24 then
            return;
        end;

        local v25 = {};

        for i, v in v24 do
            local v26;

            if typeof(v) == "table" and (typeof(v.AmountDone) == "number" and typeof(v.Requirements) == "table") then
                v26 = typeof(v.Requirements.Amount) == "number";
            else
                v26 = false;
            end;

            if v26 then
                table.insert(v25, i);
            end;
        end;

        table.sort(v25);
        local v27 = {};
        local v28 = 0;

        for i, v in v25 do
            local v29 = v24[v];
            v27[v] = true;
            local v30 = u20[v];
            local v31 = `Missing authored daily quest row {v}`;
            local v32 = assert(v30, v31);
            v32.Visible = true;
            local math_max_ret = math.max(v29.Requirements.Amount, 1);
            local math_clamp_ret = math.clamp(v29.AmountDone, 0, math_max_ret);
            local v33 = v29.Done == true and true or v29.AmountDone >= v29.Requirements.Amount;

            if v33 then
                v28 = v28 + 1;
            end;

            local Quest = v32:FindFirstChild("Quest");
            local v34 = v32:FindFirstChild("ProgressBar"):FindFirstChild("ProgressBarFill"):FindFirstChildOfClass("UIGradient");
            local Count = v32:FindFirstChild("Count");
            local RewardBox = v32:FindFirstChild("RewardBox");
            v32.LayoutOrder = i;
            local Amount = v29.Requirements.Amount;
            local v35 = u8[v29.Requirements.Mission];
            local v36;

            if v35 then
                v36 = v35(Amount);
            else
                v36 = "Complete " .. tostring(Amount) .. " " .. tostring(v29.Requirements.Mission);
            end;

            Quest.Text = v36;

            if v34 then
                v34.Offset = Vector2.new((v33 and 1 or math_clamp_ret / math_max_ret) - 1, 0);
            end;

            Count.Text = v33 and "DONE" or tostring(math_clamp_ret) .. "/" .. tostring(math_max_ret);
            local v37;

            if v33 then
                v37 = Color3_fromRGB_ret;
            else
                v37 = Color3_new_ret;
            end;

            Count.TextColor3 = v37;
            local Reward = v29.Reward;
            local v38;

            if typeof(Reward) == "table" then
                if Reward.Name == "Spin" then
                    v38 = "+" .. tostring(Reward.Amount) .. " Spins";
                elseif Reward.Name == "Flow" then
                    v38 = "+" .. tostring(Reward.Amount) .. " Flow Spins";
                elseif Reward.Name == "Money" then
                    v38 = "+" .. Essentials:formatNumberWithCommas(Reward.Amount) .. " Cash";
                else
                    v38 = nil;
                end;
            else
                v38 = nil;
            end;

            RewardBox.Visible = v38 ~= nil;

            if Reward and v38 then
                RewardBox.Image = u1[Reward.Name] or RewardBox.Image;
                local RewardIcon = RewardBox:FindFirstChild("RewardIcon");

                if RewardIcon then
                    RewardIcon.Image = u2[Reward.Name] or RewardIcon.Image;
                end;

                RewardBox:FindFirstChild("Text").Text = v38;
            end;
        end;

        for i, v in u20 do
            if not v27[i] then
                v.Visible = false;
            end;
        end;

        local v39 = "Daily Quests " .. tostring(v28) .. "/" .. tostring(#v25);
        u17:setLabel(v39, "Deselected");
        u17:setLabel(v39, "Selected");
        u17:setLabel(v39, "Viewing");
    end;

    local function refreshVisibility() -- Line: 195
        -- upvalues: u19 (ref), LocalPlayer (ref), Teams (ref), u18 (ref), u17 (copy), Container (copy), DailyQuestTracker (copy), Panel (copy), Tab (copy)
        local v40;

        if u19 == nil or next(u19) == nil then
            v40 = false;
        else
            local Team = LocalPlayer.Team;

            if Team == nil then
                v40 = false;
            else
                v40 = Team ~= Teams:FindFirstChild("Visitor");
            end;

            if v40 then
                v40 = not u18;
            end;
        end;

        u17:setEnabled(v40);

        if not v40 then
            u17:deselect();
        end;

        local v41 = workspace.CurrentCamera.ViewportSize.X < 1000 and 0.42 or 0.22;
        Container.Size = UDim2.fromScale(v41, 0.4);
        Container.Position = UDim2.fromScale(not u17.isSelected and 0 or v41 + 0.008, 0.22);
        local v42;

        if v40 then
            v42 = u17.isSelected;
        else
            v42 = v40;
        end;

        DailyQuestTracker.Enabled = v42;

        if v40 then
            v40 = u17.isSelected;
        end;

        Panel.Visible = v40;
        Tab.Visible = false;
    end;

    local function applyData(p43) -- Line: 207
        -- upvalues: u19 (ref), render (copy), refreshVisibility (copy)
        if typeof(p43) ~= "table" or typeof(p43.Quests) ~= "table" then
            return;
        end;

        u19 = p43.Quests;
        render();
        refreshVisibility();
    end;

    local u44 = false;

    local function fetchQuests() -- Line: 217
        -- upvalues: u44 (ref), Service (copy), LocalPlayer (ref), u19 (ref), render (copy), refreshVisibility (copy)
        if u44 then
            return;
        end;

        u44 = true;
        task.spawn(function() -- Line: 222
            -- upvalues: Service (ref), LocalPlayer (ref), u44 (ref), u19 (ref), render (ref), refreshVisibility (ref)
            local Quests = Service:GetQuests();

            while Quests == nil and LocalPlayer.Parent do
                task.wait(2);
                Quests = Service:GetQuests();
            end;

            u44 = false;

            if typeof(Quests) == "table" then
                if typeof(Quests.Quests) ~= "table" then
                    return;
                end;

                u19 = Quests.Quests;
                render();
                refreshVisibility();
            end;
        end);
    end;

    Collapse.Activated:Connect(function() -- Line: 233
        -- upvalues: u17 (copy)
        u17:deselect();
    end);
    u17.selected:Connect(refreshVisibility);
    u17.deselected:Connect(refreshVisibility);
    Service.Quest:Connect(applyData);
    Service2.SetCurrentStep:Connect(function(p45) -- Line: 242
        -- upvalues: u18 (ref), refreshVisibility (copy)
        u18 = p45 ~= nil;
        refreshVisibility();
    end);
    LocalPlayer:GetPropertyChangedSignal("Team"):Connect(function() -- Line: 247
        -- upvalues: refreshVisibility (copy), LocalPlayer (ref), Teams (ref), u44 (ref), Service (copy), u19 (ref), render (copy)
        refreshVisibility();
        local Team = LocalPlayer.Team;
        local v46;

        if Team == nil then
            v46 = false;
        else
            v46 = Team ~= Teams:FindFirstChild("Visitor");
        end;

        if v46 then
            if u44 then
                return;
            end;

            u44 = true;
            task.spawn(function() -- Line: 222
                -- upvalues: Service (ref), LocalPlayer (ref), u44 (ref), u19 (ref), render (ref), refreshVisibility (ref)
                local Quests = Service:GetQuests();

                while Quests == nil and LocalPlayer.Parent do
                    task.wait(2);
                    Quests = Service:GetQuests();
                end;

                u44 = false;

                if typeof(Quests) == "table" then
                    if typeof(Quests.Quests) ~= "table" then
                        return;
                    end;

                    u19 = Quests.Quests;
                    render();
                    refreshVisibility();
                end;
            end);
        end;
    end);

    if not u44 then
        u44 = true;
        task.spawn(function() -- Line: 222
            -- upvalues: Service (copy), LocalPlayer (ref), u44 (ref), u19 (ref), render (copy), refreshVisibility (copy)
            local Quests = Service:GetQuests();

            while Quests == nil and LocalPlayer.Parent do
                task.wait(2);
                Quests = Service:GetQuests();
            end;

            u44 = false;

            if typeof(Quests) == "table" then
                if typeof(Quests.Quests) ~= "table" then
                    return;
                end;

                u19 = Quests.Quests;
                render();
                refreshVisibility();
            end;
        end);
    end;

    refreshVisibility();
end;

return v15;