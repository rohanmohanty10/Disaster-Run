  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local ItemData = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);
local Stands = require(PathShortcuts.ReplicatedModules:WaitForChild("Stands"));
local StatsHandler = require(PathShortcuts.ReplicatedModules.StatsHandler);
local u1 = Knit.GetService("LevelService");
local u2 = Knit.GetService("StatService");
local u3 = {};
u3.__index = u3;
local u4 = {
    Health = "This stat increases your <font color=\"rgb(100, 220, 100)\">HP</font> by 5 per skill point",
    Defense = "This stat will increase your <font color=\"rgb(255, 180, 115)\">damage reduction</font> up to 50%",
    Attack = "This stat will increase the <font color=\"rgb(255, 97, 97)\">damage</font> you deal",
    Special = "This stat will increase the effects of moves in correlation to your current <font color=\"rgb(116, 211, 255)\">ability</font>.<br /><br />Example, Timestop duration"
};
task.wait();

function u3.new(p5, p6) -- Line: 28
    -- upvalues: u3 (copy), Trove (copy), Stands (copy), u2 (copy)
    local u7 = setmetatable({}, u3);
    u7.UI = p5;
    u7.UIEngine = p6;
    u7.Trove = Trove.new();
    u7.Tooltip = p6.Util.Tooltip.GetFromParent(p5:FindFirstAncestorWhichIsA("ScreenGui"):FindFirstChild("Screen"));
    u7.Assets = p5.Assets;
    u7.Cache = {
        StatPoints = 0,
        Stats = {},
        StatsDelta = {}
    };
    u7.StatInfoEntry = u7.Assets.StatInfo;
    u7.Stats = u7.UI.Stats;
    u7.InfoSection = u7.UI.InfoSection;
    u7.StatText = u7.UI.StatText;
    u7.ApplyButton = u7.UI.ApplyButton;
    u7.ResetButton = u7.UI.ResetButton;
    u7.Increment = u7.UI.Increment;
    u7.MasteryFrame = u7.InfoSection.MasteryFrame;
    u7.LevelFrame = u7.InfoSection.LevelFrame;
    u7.AbilityName = u7.InfoSection.AbilityName;
    u7.AbilityPrefix = u7.InfoSection.AbilityPrefix;
    u7.AbilityDescription = u7.InfoSection.AbilityDescription;
    u7.ApplyButton.MouseButton1Click:Connect(function() -- Line: 58
        -- upvalues: u7 (copy)
        u7:ApplyStats();
        u7.UIEngine:PlaySound("Click");
    end);
    u7.ResetButton.MouseButton1Click:Connect(function() -- Line: 63
        -- upvalues: u7 (copy), Stands (ref), u2 (ref)
        u7.UIEngine.NewPrompt({
            Title = "Reset Stats?",
            Text = `Are you sure you want to reset stats on [{Stands[u7.AbilityId]}] for [{u2:GetResetStatsCost(u7.AbilityId):expect()}] UCoins?`,
            Options = { "Yes", "No" },

            Callback = function(p8) -- Line: 71, Name: Callback
                -- upvalues: u7 (ref)
                if p8.Choice == 1 then
                    u7:ResetStats();
                end;
            end
        });
        u7.UIEngine:PlaySound("Click");
    end);

    return u7;
end;

function u3.Load(p9, p10) -- Line: 82
    -- upvalues: u1 (copy), u2 (copy), ItemData (copy), Stands (copy)
    p9.Trove:Clean();
    local Value = p10.Value;
    p9.Ability = p10;
    p9.AbilityId = Value;
    local v11 = u1:GetAbilityPVEInfo(Value):expect() or {};
    local v12 = u2:GetAbilityStats(Value):expect() or {};
    p9.Cache.StatPoints = v12.StatPoints or 0;
    local v13 = ItemData.GetItemInfo((`ABILITY_{Value}`));
    local v14 = "Ability";

    if type(v13.Title) == "string" then
        v14 = v13.Title;
    elseif type(v13.Prefix) == "table" then
        v14 = v13.Prefix.Name;
    elseif type(v13.Prefix) == "string" then
        v14 = v13.Prefix;
    end;

    p9:SetInfo({
        AbilityName = v13.Name,
        AbilityPrefix = v14,
        AbilityPrefixColor = ItemData.Rarities[v13.Rarity].Color,
        AbilityDescription = v13.Description
    });
    p9:UpdateLevelData(v11);
    p9:UpdateMasteryData({
        AbilityName = Stands[Value],
        MasteryRank = p10:GetAttribute("MasteryRank"),
        MasteryPoints = p10:GetAttribute("MasteryPoints"),
        MasteryPointCap = p10:GetAttribute("MasteryPointCap")
    });

    for i, v in v12.Stats or {} do
        p9:AddStat({
            StatName = i,
            StatValue = v
        });
    end;

    if not p9.Tooltip.Connection then
        p9.Tooltip:Connect();
    end;
end;

function u3.SetInfo(p15, p16) -- Line: 135
    p15.AbilityName.Text = p16.AbilityName;
    p15.AbilityPrefix.Text = p16.AbilityPrefix;
    p15.AbilityPrefix.TextColor3 = p16.AbilityPrefixColor;
    p15.AbilityDescription.Text = p16.AbilityDescription;
    p15.StatText.Text = `Stat Points remaining: <font color="#00FF00">{p15.Cache.StatPoints}</font>`;
end;

function u3.AddStat(u17, u18) -- Line: 144
    -- upvalues: u4 (copy)
    local v19 = u17.Stats:FindFirstChild(u18.StatName) or u17.StatInfoEntry:Clone();
    local TextHolder = v19.TextHolder;
    TextHolder.Stat.Text = u18.StatName;
    TextHolder.StatValue.Text = u18.StatValue;
    v19.Visible = true;
    v19.Parent = u17.Stats;
    v19.Name = u18.StatName;
    local Buttons = v19.Buttons;
    u17.Trove:Connect(Buttons.Add.MouseButton1Click, function() -- Line: 154
        -- upvalues: u17 (copy), u18 (copy)
        u17:ModifyStat(u18.StatName, u17:GetIncrement());
        u17.UIEngine:PlaySound("Click");
    end);
    u17.Trove:Connect(Buttons.Subtract.MouseButton1Click, function() -- Line: 158
        -- upvalues: u17 (copy), u18 (copy)
        u17:ModifyStat(u18.StatName, -u17:GetIncrement());
        u17.UIEngine:PlaySound("Click");
    end);
    u17.Trove:Connect(TextHolder.MouseEnter, function(p20, p21) -- Line: 162
        -- upvalues: u17 (copy), u18 (copy), u4 (ref)
        u17.Tooltip:SetTitle(u18.StatName);

        if u4[u18.StatName] then
            u17.Tooltip:SetText(u4[u18.StatName]);
        end;

        u17.Tooltip:Show();
    end);
    u17.Trove:Connect(TextHolder.MouseLeave, function(p22, p23) -- Line: 170
        -- upvalues: u17 (copy), u18 (copy), u4 (ref)
        u17.Tooltip:SetTitle(u18.StatName);

        if u4[u18.StatName] then
            u17.Tooltip:SetText(u4[u18.StatName]);
        end;

        u17.Tooltip:Hide();
    end);
    u17.Cache.Stats[u18.StatName] = u18.StatValue;
    u17.Cache.StatsDelta[u18.StatName] = 0;

    return v19;
end;

function u3.ModifyStat(p24, p25, p26) -- Line: 185
    if not p24.Stats:FindFirstChild(p25) then
        return;
    end;

    local v27 = p24.Cache.StatsDelta[p25];
    local _ = p24.Cache.Stats[p25];

    if v27 + p26 < 0 then
        p26 = math.abs(p26 - (v27 + p26)) * math.sign(p26);
    elseif p24.Cache.StatPoints - p26 < 0 then
        p26 = math.min(p24.Cache.StatPoints, p26);
    end;

    if not v27 or (p24.Cache.StatPoints - p26 < 0 or v27 + p26 < 0) then
        return;
    end;

    local Cache = p24.Cache;
    Cache.StatPoints = Cache.StatPoints - p26;
    local StatsDelta = p24.Cache.StatsDelta;
    StatsDelta[p25] = StatsDelta[p25] + p26;
    p24.StatText.Text = `Stat Points remaining: <font color="#00FF00">{p24.Cache.StatPoints}</font>`;
    p24:ShowStatDelta(p25);
end;

function u3.ShowStatDelta(p28, p29) -- Line: 209
    local v30 = p28.Stats:FindFirstChild(p29);

    if not v30 then
        return;
    end;

    local v31 = p28.Cache.StatsDelta[p29];
    local v32 = p28.Cache.Stats[p29];

    if not v31 then
        return;
    end;

    if v31 == 0 then
        v30.TextHolder.StatValue.Text = v32;

        return;
    end;

    v30.TextHolder.StatValue.Text = v32 .. string.format(v31 > 0 and "<font color=\"rgb(60, 220, 60)\"> + %s</font>" or "<font color=\"rgb(220, 60, 60)\"> - %s</font>", (math.abs(v31)));
end;

function u3.ApplyStats(p33) -- Line: 223
    -- upvalues: u2 (copy)
    if not u2:ApplyStats(p33.AbilityId, p33.Cache.StatsDelta):expect() then
        return;
    end;

    p33:Load(p33.Ability);
end;

function u3.GetIncrement(u34) -- Line: 229
    local success, result = pcall(function() -- Line: 230
        -- upvalues: u34 (copy)
        return tonumber(u34.Increment.Text);
    end);

    return (not success or typeof(result) ~= "number") and 1 or math.max(result, 1);
end;

function u3.ResetStats(p35) -- Line: 241
    -- upvalues: u2 (copy)
    local v36, v37 = u2:ResetStats(p35.AbilityId):expect();
    local v38 = {
        InvalidAbility = { "Invalid Ability", "Could not find ability to reset stats for" },
        InvalidCost = { "Not Enough UCoins", (`You need [{v37}] more UCoins to reset stats for this ability`) },
        Disabled = { "Disabled", "Stat resetting currently disabled" }
    };

    if type(v36) ~= "string" then
        p35:Load(p35.Ability);

        return;
    end;

    local v39 = v38[v36];
    p35.UIEngine.NewPrompt({
        Title = v39[1],
        Text = v39[2]
    });
end;

function u3.UpdateLevelData(p40, p41) -- Line: 262
    local _ = p41.CurrentLevel;
    local v42 = math.clamp(p41.CurrentXP / p41.RequiredXP, 0, 1);
    p40.LevelFrame.Level.Text = p41.CurrentLevel;
    p40.LevelFrame.Progress.BarText.Text = `{p41.CurrentXP} / {p41.RequiredXP}`;
    p40.LevelFrame.Progress.Bar.Size = UDim2.new(v42, 0, 1, 0);
end;

function u3.UpdateMasteryData(p43, p44) -- Line: 273
    -- upvalues: StatsHandler (copy)
    local v45 = StatsHandler.GetStats(p44.AbilityName);

    if not v45.MasteryData then
        p43.MasteryFrame.Visible = false;

        return;
    end;

    local MasteryRank = p44.MasteryRank;
    local MasteryPoints = p44.MasteryPoints;
    local MasteryPointCap = p44.MasteryPointCap;
    local v46 = math.clamp(MasteryPoints / MasteryPointCap, 0, 1);
    p43.MasteryFrame.Progress.Title.Text = `Mastery {MasteryRank}`;
    p43.MasteryFrame.Progress.BarText.Text = `{MasteryPoints} / {MasteryPointCap}`;
    p43.MasteryFrame.Progress.Bar.Size = UDim2.new(v46, 0, 1, 0);

    if v45.MasteryData.MaxMasteryRank <= MasteryRank then
        p43.MasteryFrame.Progress.BarText.Text = "MAX";
        p43.MasteryFrame.Progress.Bar.Size = UDim2.new(1, 0, 1, 0);
    end;

    p43.MasteryFrame.Visible = true;
end;

function u3.AddButtonIndicator(p47, p48, p49) -- Line: 294
    if not p48:FindFirstChild("Indicator") then
        local u50 = p47.Assets.Indicator:Clone();
        task.defer(function() -- Line: 297
            -- upvalues: u50 (copy)
            u50.Visible = true;
        end);
        u50.Parent = p48;
        u50.BackgroundColor3 = p49 or Color3.fromRGB(255, 103, 103);

        return u50;
    end;
end;

function u3.RemoveButtonIndicator(p51, p52) -- Line: 305
    if p52:FindFirstChild("Indicator") then
        p52:FindFirstChild("Indicator"):Destroy();
    end;
end;

return u3;