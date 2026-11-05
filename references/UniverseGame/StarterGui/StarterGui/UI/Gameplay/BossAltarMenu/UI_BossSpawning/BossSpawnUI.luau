  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);
local u1 = Knit.GetService("AltarService");
local u2 = Knit.GetService("InventoryService");
require(PathShortcuts.ReplicatedModules.Classes.Stack);
require(PathShortcuts.KnitPath.Promise);
local _ = ReplicatedStorage.Remotes.NpcFunc;
local AltarData = require(PathShortcuts.ReplicatedModules.AltarData);
local LocalPlayer = Players.LocalPlayer;
local u3 = {};
u3.__index = u3;

local function RNG(p4, p5) -- Line: 21
    return Random.new():NextNumber(p4, p5);
end;

local function Count(p6) -- Line: 25
    local v7 = 0;

    for _, _ in p6 do
        v7 = v7 + 1;
    end;

    return v7;
end;

function Round(p8, p9)
    local v10 = 10 ^ (p9 or 0);

    return math.floor(p8 * v10 + 0.5) / v10;
end;

local function ExpandEntry(p11) -- Line: 41
    p11:SetAttribute("Expanded", true);
    p11.Requirements.Visible = true;

    for _, child in p11.Requirements:GetChildren() do
        if child:IsA("Frame") then
            child.Visible = true;
        elseif child:IsA("UIPadding") then
            child.PaddingBottom = UDim.new(0, 15);
        end;
    end;

    p11.ExpandLabel.Text = "Click to collapse";
end;

local function CollapseEntry(p12) -- Line: 54
    p12:SetAttribute("Expanded", false);
    p12.Requirements.Visible = false;

    for _, child in p12.Requirements:GetChildren() do
        if child:IsA("Frame") then
            child.Visible = false;
        elseif child:IsA("UIPadding") then
            child.PaddingBottom = UDim.new(0, 3);
        end;
    end;

    p12.ExpandLabel.Text = "Click to expand";
end;

local function ToggleEntry(p13) -- Line: 67
    -- upvalues: CollapseEntry (copy), ExpandEntry (copy)
    if p13:GetAttribute("Expanded") then
        CollapseEntry(p13);

        return;
    end;

    ExpandEntry(p13);
end;

function u3.new(p14, p15) -- Line: 75
    -- upvalues: u3 (copy), Trove (copy)
    local u16 = setmetatable({}, u3);
    u16.UI = p14;
    u16.UIEngine = p15;
    u16.Trove = Trove.new();
    u16.Assets = p14.Assets;
    u16.Cache = {
        Entries = {}
    };
    u16.Entry = u16.Assets.Entry;
    u16.Requirement = u16.Assets.Requirement;
    u16.List = p14.Bosses;
    u16.Close = p14.Close;
    u16.Trove:Connect(u16.Close.MouseButton1Click, function() -- Line: 92
        -- upvalues: u16 (copy)
        u16.UI.Visible = false;
    end);

    return u16;
end;

function u3.CreateEntry(u17, u18) -- Line: 99
    -- upvalues: Trove (copy), LocalPlayer (copy), u2 (copy), CollapseEntry (copy), ExpandEntry (copy), u1 (copy)
    if not (u18 and u18.BossName) then
        return;
    end;

    if u17.Cache.Entries[u18.BossName] then
        u17.Cache.Entries[u18.BossName]:Destroy();
    end;

    local u19 = u17.Entry:Clone();
    local v20 = Trove.new();
    u19.BossNameLabel.Text = u18.BossName;

    if u18.UCoins then
        local Value = LocalPlayer.Data.UCoins.Value;
        local v21 = `<font color="{u18.UCoins <= Value and "#82ff4c" or "#ff4040"}">{Value}</font> / {u18.UCoins}`;
        local v22 = u17.Requirement:Clone();
        v22.NameLabel.Text = `<font color="#ffff00">{u17.UIEngine.UCoinsString}</font>:`;
        v22.CostLabel.Text = v21;
        v22.Parent = u19.Requirements;
    end;

    if u18.Items then
        for i, v in u18.Items do
            local v23 = u2:GetItemCount("ItemInventory", i):expect();
            local v24 = `<font color="{v <= v23 and "#82ff4c" or "#ff4040"}">{v23}</font> / {v}`;
            local v25 = u17.Requirement:Clone();
            v25.NameLabel.Text = `{u17.UIEngine:GetItemText(i)}`;
            v25.CostLabel.Text = v24;
            v25.Parent = u19.Requirements;
        end;
    end;

    v20:Connect(u19.MouseButton1Click, function() -- Line: 132
        -- upvalues: u19 (copy), CollapseEntry (ref), ExpandEntry (ref)
        local v26 = u19;

        if v26:GetAttribute("Expanded") then
            CollapseEntry(v26);

            return;
        end;

        ExpandEntry(v26);
    end);
    v20:Connect(u19.SummonButton.MouseButton1Click, function() -- Line: 146
        -- upvalues: u17 (copy), u18 (copy), u1 (ref)
        u17.UIEngine:PlaySound("Click");
        u17.UIEngine.NewPrompt({
            Delay = 1.5,
            Title = `Spawn {u18.BossName}?`,
            Text = `Are you sure you want to spawn [{u18.BossName}]`,
            Options = { "Yes", "No" },

            Callback = function(p27) -- Line: 154, Name: Callback
                -- upvalues: u17 (ref), u18 (ref), u1 (ref)
                if p27.Choice ~= 1 then
                    return;
                end;

                u17.UIEngine:PlaySound("Click");

                if u18.SecondConfirmationMessage then
                    u17.UIEngine.NewPrompt({
                        Delay = 3,
                        Title = `Spawn {u18.BossName}?`,
                        Text = u18.SecondConfirmationMessage,
                        Options = { "Yes", "No" },

                        Callback = function(p28) -- Line: 164, Name: Callback
                            -- upvalues: u17 (ref), u1 (ref), u18 (ref)
                            if p28.Choice ~= 1 then
                                return;
                            end;

                            u17.UIEngine:PlaySound("Click");
                            u1:SpawnBoss(u18.BossName, u17.SpawnPart);
                            u17:Load();
                        end
                    });

                    return;
                end;

                u1:SpawnBoss(u18.BossName, u17.SpawnPart);
                u17:Load();
            end
        });
    end);
    v20:Add(u19);
    u19.Visible = true;
    u19.Parent = u17.List;
    u17.Cache.Entries[u18.BossName] = v20;
end;

function u3.ClearEntries(p29) -- Line: 187
    for _, v in p29.Cache.Entries do
        v:Destroy();
    end;

    table.clear(p29.Cache.Entries);
end;

function u3.Load(p30, p31) -- Line: 194
    -- upvalues: AltarData (copy)
    p30:ClearEntries();

    if p31 then
        p30.SpawnPart = p31;
        p30.Name = p30.SpawnPart.Name;
    end;

    local v32 = AltarData.GetSpawner(p30.Name);

    if not v32 then
        return;
    end;

    local Bosses = v32.Bosses;
    p30.UI.Visible = true;

    for i = 1, #Bosses do
        local v33 = Bosses[i];

        if table.find(v32.Bosses, v33) then
            local v34 = AltarData.GetBossData(v33);

            if v34 then
                local v35 = AltarData.GetRequirements(v33) or {};
                p30:CreateEntry({
                    BossName = v33,
                    Items = v35.Items,
                    UCoins = v35.UCoins,
                    SecondConfirmationMessage = v34.SecondConfirmationMessage
                });
            end;
        end;
    end;
end;

return u3;