  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local ItemData = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);
local PVEPackage = game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("PVEPackage");
local LevelingInfo = require(PVEPackage:WaitForChild("LevelingInfo"));
local LocalPlayer = game:GetService("Players").LocalPlayer;
require(PathShortcuts.ReplicatedModules:WaitForChild("Stands"));
Knit:OnStart():await();
local u1 = Knit.GetService("LevelService");
Knit.GetService("StatService");
local u2 = Knit.GetService("InventoryService");
local u3 = {};
u3.__index = u3;
local u4 = {
    UCoins = {
        Name = "UCoins",
        String = "<font color=\"#ffff00\">UCoins</font>",
        Color = "#ffff00"
    },
    UShards = {
        Name = "Currency",
        String = "<font color=\"#00aaff\"><s>u</s>S</font>"
    }
};
local u5 = {
    ITEM = "ItemInventory",
    SKIN = "SkinInventory",
    ABILITY = "AbilityInventory"
};
task.wait();

function u3.new(p6, p7) -- Line: 41
    -- upvalues: u3 (copy), Trove (copy)
    local u8 = setmetatable({}, u3);
    u8.UI = p6;
    u8.UIEngine = p7;
    u8.Trove = Trove.new();
    u8.Tooltip = p7.Util.Tooltip.GetFromParent(p6:FindFirstAncestorWhichIsA("ScreenGui"):FindFirstChild("Screen"));
    u8.Assets = p6.Assets;
    u8.Cache = {
        AbilityId = nil
    };
    u8.Entry = u8.Assets.Entry;
    u8.BenefitEntry = u8.Assets.BenefitEntry;
    u8.InfoSection = u8.UI.InfoSection;
    u8.AscendSection = u8.UI.AscendSection;
    u8.ApplyButton = u8.UI.ApplyButton;
    u8.Benefits = u8.AscendSection.Benefits;
    u8.Requirements = u8.AscendSection.Requirements;
    u8.AbilityName = u8.InfoSection.AbilityName;
    u8.AbilityPrefix = u8.InfoSection.AbilityPrefix;
    u8.AbilityDescription = u8.InfoSection.AbilityDescription;
    u8.ApplyButton.MouseButton1Click:Connect(function() -- Line: 68
        -- upvalues: u8 (copy)
        u8:Apply(u8.Cache.AbilityId);
        u8.UIEngine:PlaySound("Click");
    end);

    return u8;
end;

function u3.AddEntries(p9, p10) -- Line: 76
    -- upvalues: u4 (copy), u5 (copy)
    if not (p10 and p10.Requirements) then
        warn("No data found");

        return;
    end;

    for i, v in p10.Requirements do
        if i == "UCoins" then
            local v11 = p9:GetAmount(i, nil);
            local v12 = `<font color="{v <= v11 and "#82ff4c" or "#ff4040"}">{v11}</font> / {v}`;
            local String = u4[i].String;
            local v13 = p9.Requirements:FindFirstChild(i) or p9.Entry:Clone();
            v13.NameLabel.Text = String;
            v13.AmountLabel.Text = v12;
            v13.Name = i;
            v13.Visible = true;
            v13.Parent = p9.Requirements;
        elseif i == "Items" then
            for i2, v2 in v do
                local v14 = p9:GetAmount(i2, u5[string.match(i2, "(%w+)_")]);
                local v15 = `<font color="{v2 <= v14 and "#82ff4c" or "#ff4040"}">{v14}</font> / {v2}`;
                local v16;

                if u4[i2] then
                    v16 = u4[i2].String;
                else
                    v16 = p9.UIEngine:GetItemText(i2);
                end;

                local v17 = p9.Requirements:FindFirstChild(i2) or p9.Entry:Clone();
                v17.NameLabel.Text = v16;
                v17.AmountLabel.Text = v15;
                v17.Name = i2;
                v17.Visible = true;
                v17.Parent = p9.Requirements;
            end;
        end;
    end;

    local v18 = `<font color="{p10.CurrentLevel >= p10.CurrentMaxLevel and "#82ff4c" or "#ff4040"}">{p10.CurrentLevel}</font> / {p10.CurrentMaxLevel}`;
    local v19 = p9.Requirements:FindFirstChild("Level") or p9.Entry:Clone();
    v19.NameLabel.Text = "Ability Level";
    v19.AmountLabel.Text = v18;
    v19.Name = "Level";
    v19.Visible = true;
    v19.Parent = p9.Requirements;
    local v20 = p9.Benefits:FindFirstChild("Rank") or p9.BenefitEntry:Clone();
    v20.NameLabel.Text = "Ascension Rank";
    v20.AmountLabel.Text = p10.NextRank;
    v20.Name = "Rank";
    v20.Visible = true;
    v20.Parent = p9.Benefits;

    if p9.Benefits:FindFirstChild("KillEffect") then
        p9.Benefits:FindFirstChild("KillEffect"):Destroy();
    end;

    local _ = p10.NextRank % 2 == 0;

    if p10.NextRank % 5 == 0 then
        local v21 = p9.Benefits:FindFirstChild("KillEffect") or p9.BenefitEntry:Clone();
        v21.NameLabel.Text = "Random Kill Effect";
        v21.AmountLabel.Text = "x1";
        v21.Name = "KillEffect";
        v21.Visible = true;
        v21.Parent = p9.Benefits;
    end;
end;

function u3.Load(u22, p23) -- Line: 186
    -- upvalues: ItemData (copy)
    u22.Trove:Clean();
    u22.Cache.AbilityId = p23;
    local v24 = ItemData.GetItemInfo((`ABILITY_{p23}`));
    local v25 = "Ability";

    if type(v24.Title) == "string" then
        v25 = v24.Title;
    elseif type(v24.Prefix) == "table" then
        v25 = v24.Prefix.Name;
    elseif type(v24.Prefix) == "string" then
        v25 = v24.Prefix;
    end;

    u22:SetInfo({
        AbilityName = v24.Name,
        AbilityPrefix = v25,
        AbilityPrefixColor = ItemData.Rarities[v24.Rarity].Color,
        AbilityDescription = v24.Description
    });
    local u26 = task.spawn(function() -- Line: 210
        -- upvalues: u22 (copy)
        while true do
            u22:Update(u22.Cache.AbilityId);
            task.wait(3);
        end;
    end);
    u22.Trove:Add(function() -- Line: 217
        -- upvalues: u26 (copy)
        task.cancel(u26);
    end);
end;

function u3.GetAmount(p27, p28, p29) -- Line: 222
    -- upvalues: u4 (copy), LocalPlayer (copy), u2 (copy)
    if u4[p28] then
        return LocalPlayer:FindFirstChild("Data"):FindFirstChild(u4[p28].Name).Value;
    end;

    return u2:GetItemCount(p29, p28):expect();
end;

function u3.Update(p30, p31) -- Line: 235
    local v32 = p30:GetAscensionData(p31);
    p30.InfoSection.AscensionInfoFrame.Rank.Text = v32.CurrentRank;
    p30.NextAscensionRank = v32.NextRank;
    p30:AddEntries(v32);
end;

function u3.GetAscensionData(p33, p34) -- Line: 242
    -- upvalues: u1 (copy), LevelingInfo (copy)
    local v35 = u1:GetAbilityPVEInfo(p34):expect() or {};
    local AscensionRank = v35.AscensionRank;
    local v36 = LevelingInfo.GetAscensionData(AscensionRank + 1);

    return {
        CurrentRank = AscensionRank,
        NextRank = AscensionRank + 1,
        Requirements = v36.Requirements,
        MaxLevel = v36.MaxLevel or LevelingInfo.MaxLevel,
        CurrentLevel = v35.CurrentLevel,
        CurrentMaxLevel = LevelingInfo.GetMaxLevel(AscensionRank)
    };
end;

function u3.SetInfo(p37, p38) -- Line: 257
    p37.AbilityName.Text = p38.AbilityName;
    p37.AbilityPrefix.Text = p38.AbilityPrefix;
    p37.AbilityPrefix.TextColor3 = p38.AbilityPrefixColor;
    p37.AbilityDescription.Text = p38.AbilityDescription;
end;

local u39 = {
    InvalidUCoins = { "Insufficient UCoins", "You do not have enough UCoins to ascend your ability" },
    InvalidItems = { "Insufficient Items", "You do not have the required items to ascend your ability" },
    OnCooldown = { "On Cooldown", "Please try again in a moment" },
    Disabled = { "Disabled", "This is currently disabled" },
    AbilityNotFound = { "Ability not found", "Could not find pve data for this ability" },
    InvalidAscensionCost = { "Ascension Failed", "Could not find ascension data for next ascension rank" },
    NotMaxLevel = { "Ascension Failed", "Ability must be max level before ascending" },
    Capped = { "Ascension Failed", "Ascension Rank is currently capped" }
};

function u3.Apply(u40, u41) -- Line: 275
    -- upvalues: ItemData (copy), u1 (copy), u39 (copy)
    local v42 = ItemData.GetItemInfo((`ABILITY_{u41}`));

    if not v42 then
        warn("No ability info for", u41);

        return;
    end;

    u40.UIEngine:PlaySound("Click");
    u40.UIEngine.NewPrompt({
        Title = "Ascend Ability",
        Delay = 1,
        Text = `Are you sure you want to ascend <font color="#00FFFF">[{v42.Name}]</font> to Ascension Rank <font color="#FFFF00">[{u40.NextAscensionRank}]</font>?`,
        Options = { "Yes", "No" },

        Callback = function(p43) -- Line: 288, Name: Callback
            -- upvalues: u1 (ref), u41 (copy), u39 (ref), u40 (copy)
            if p43.Choice == 2 then
                return;
            end;

            local v44 = u1:AscendAbility(u41):expect();

            if type(v44) ~= "string" then
                if type(v44) == "number" then
                    u40:Update(u41);
                    print(v44);
                end;

                return;
            end;

            print(v44);
            local v45 = u39[v44];

            if v45 then
                u40.UIEngine.NewPrompt({
                    Title = v45[1],
                    Text = v45[2]
                });
            end;
        end
    });
end;

return u3;