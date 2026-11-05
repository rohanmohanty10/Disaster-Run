  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local ItemData = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);
local PVEPackage = game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("PVEPackage");
local LevelingInfo = require(PVEPackage:WaitForChild("LevelingInfo"));
local u1 = Knit.GetService("LevelService");
Knit.GetService("StatService");
Knit.GetService("CraftingService");
local u2 = {};
u2.__index = u2;

local function Len(p3) -- Line: 17
    local v4 = 0;

    for _, _ in p3 do
        v4 = v4 + 1;
    end;

    return v4;
end;

local u5 = {
    ["Already Max Level"] = { "Exchange Failed", "Ability is already at max level" },
    ["Invalid Shards"] = { "Exchange Failed", "Invalid/Insufficient amount of shards" }
};

function u2.new(p6, p7) -- Line: 30
    -- upvalues: u2 (copy), Trove (copy)
    local u8 = setmetatable({}, u2);
    u8.UI = p6;
    u8.UIEngine = p7;
    u8.Trove = Trove.new();
    u8.Assets = p6.Parent.Parent.Assets;
    u8.Cache = {
        Chosen = {}
    };
    u8.Feed = p6.Feed;
    u8.Shards = p6.Shards;
    u8.RewardLvl = p6.RewardLvl;
    u8.RewardXP = p6.RewardXP;
    u8.AbilityName = p6.AbilityName;
    u8.Feed.MouseButton1Click:Connect(function() -- Line: 48
        -- upvalues: u8 (copy)
        u8:FeedShards();
    end);

    return u8;
end;

function u2.CreateSlot(u9, u10, u11) -- Line: 55
    -- upvalues: ItemData (copy)
    local v12 = ItemData.GetItemInfo(u10);
    local Color = ItemData.Rarities[v12.Rarity].Color;
    local u13 = u9.Shards:FindFirstChild(u10) or u9.Assets.ShardContainer:Clone();
    u13.Button.UIStroke.Color = Color;
    u13.Button.Label.Text = v12.Name .. " Shards";
    u13.Button.Amount.Text = u11;
    u13.Parent = u9.Shards;
    u13.LayoutOrder = ItemData.Rarities[v12.Rarity].Weight;
    u13.Visible = true;
    u13.Name = u10;
    u13.Amount.Text = "";
    u13.Amount.FocusLost:Connect(function() -- Line: 70
        -- upvalues: u13 (copy), u9 (copy), u10 (copy), u11 (copy)
        local v14 = tonumber(string.match(u13.Amount.Text, "%d+"));

        if u9.Cache.Chosen[u10] and u9.Cache.Chosen[u10] == v14 then
            return;
        end;

        if v14 and v14 >= 1 then
            if u11 < v14 then
                v14 = u11 or v14;
            end;

            u9.Cache.Chosen[u10] = v14;
            u13.Amount.Text = u9.Cache.Chosen[u10];
        else
            u9.Cache.Chosen[u10] = nil;
            u13.Amount.Text = "";
        end;

        u9:ViewLevelInfo();
    end);
    u13.Button.MouseButton1Click:Connect(function() -- Line: 88
        -- upvalues: u9 (copy), u10 (copy), u11 (copy), u13 (copy)
        if u9.Cache.Chosen[u10] then
            if u9.Cache.Chosen[u10] < u11 then
                local Chosen = u9.Cache.Chosen;
                local v15 = u10;
                Chosen[v15] = Chosen[v15] + 1;
            else
                u9.Cache.Chosen[u10] = u11;
            end;
        else
            u9.Cache.Chosen[u10] = 1;
        end;

        u13.Amount.Text = u9.Cache.Chosen[u10];
        u9:ViewLevelInfo();
    end);

    return u13;
end;

function u2.DisplayShards(p16) -- Line: 105
    if not p16.UIEngine.FunctionsLoaded then
        return;
    end;

    local v17 = {};

    for i, v in p16.UIEngine:CheckAbilityCrafts() do
        v17[i] = v.Shards;
    end;

    for i, v in v17 do
        p16:CreateSlot(i, v);
    end;
end;

local u18 = nil;
local u19 = nil;

function u2.ViewLevelInfo(p20, p21) -- Line: 122
    -- upvalues: u18 (ref), u1 (copy), u19 (ref), ItemData (copy), LevelingInfo (copy)
    if p21 or not u18 then
        u18 = u1:GetShardXPInfo():expect();
    end;

    if p21 or not u19 then
        u19 = u1:GetAbilityPVEInfo(p20.AbilityId):expect();
    end;

    local CurrentXP = u19.CurrentXP;
    local CurrentLevel = u19.CurrentLevel;
    local v22 = table.clone(u18.XPRates);
    local BaseXPAmount = u18.BaseXPAmount;

    for i, v in v22 do
        v22[i] = v / 100 * BaseXPAmount;
    end;

    local v23 = 0;

    for i, v in p20.Cache.Chosen do
        local v24 = ItemData.GetItemInfo(i);
        v23 = v23 + v22[ItemData.Rarities[v24.Rarity].Name] * v;
    end;

    local v25 = LevelingInfo.GetMaxLevel(u19.AscensionRank);
    local v26 = LevelingInfo.CalculateLevelsFromXP(CurrentLevel, v25, CurrentXP, v23);
    local v27 = v26.LevelsAdded or 0;
    p20.RewardXP.Text = v23 > 1 and `+{v23} EXP` or "";
    p20.RewardLvl.Text = v27 > 0 and `NEW LVL {CurrentLevel + v26.LevelsAdded} ({CurrentLevel} + {v26.LevelsAdded})` or "";
end;

function u2.FeedShards(u28) -- Line: 155
    -- upvalues: u1 (copy), u5 (copy)
    u28.UIEngine.NewPrompt({
        Title = "Exchange Ability Shards",
        Delay = 0.5,
        Text = `Are you sure you want to turn the selected ability shards into experience for {u28.UIEngine:GetItemText((`ABILITY_{u28.AbilityId}`))}?`,
        Options = { "Yes", "No" },

        Callback = function(p29) -- Line: 164, Name: Callback
            -- upvalues: u28 (copy), u1 (ref), u5 (ref)
            u28.UIEngine:PlaySound("Click");

            if p29.Choice ~= 1 then
                return;
            end;

            print(u28.Cache.Chosen);
            local v30 = 0;

            for _, _ in u28.Cache.Chosen do
                v30 = v30 + 1;
            end;

            if v30 > 0 then
                local v31 = u1:ConsumeShardsForXP(u28.Cache.Chosen):expect();

                if type(v31) == "string" then
                    print(v31);
                    local v32 = u5[v31];
                    u28.UIEngine.NewPrompt({
                        Title = v32[1],
                        Text = v32[2]
                    });

                    return;
                end;

                if v31 then
                    task.defer(function() -- Line: 183
                        -- upvalues: u28 (ref)
                        for _, child in u28.Shards:GetChildren() do
                            if child:IsA("Frame") then
                                child:Destroy();
                            end;
                        end;

                        u28.Cache.Chosen = {};
                        u28:DisplayShards();
                        u28:ViewLevelInfo(true);
                    end);
                end;
            end;
        end
    });
end;

function u2.Load(p33, p34) -- Line: 200
    p33.AbilityId = p34;
    p33.AbilityName.Text = p33.UIEngine:GetItemText((`ABILITY_{p34}`));

    for _, child in p33.Shards:GetChildren() do
        if child:IsA("Frame") then
            child:Destroy();
        end;
    end;

    p33.Cache.Chosen = {};
    p33:DisplayShards();
    p33:ViewLevelInfo(true);
end;

return u2;