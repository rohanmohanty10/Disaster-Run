  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);
local u1 = Knit.GetService("InventoryService");
require(PathShortcuts.ReplicatedModules.Classes.Stack);
require(PathShortcuts.KnitPath.Promise);
local NpcFunc = ReplicatedStorage.Remotes.NpcFunc;
local LocalPlayer = Players.LocalPlayer;
local u2 = {};
u2.__index = u2;

local function RNG(p3, p4) -- Line: 18
    return Random.new():NextNumber(p3, p4);
end;

local function Count(p5) -- Line: 22
    local v6 = 0;

    for _, _ in p5 do
        v6 = v6 + 1;
    end;

    return v6;
end;

function Round(p7, p8)
    local v9 = 10 ^ (p8 or 0);

    return math.floor(p7 * v9 + 0.5) / v9;
end;

local function ExpandEntry(p10) -- Line: 38
    p10:SetAttribute("Expanded", true);
    p10.Requirements.Visible = true;

    for _, child in p10.Requirements:GetChildren() do
        if child:IsA("Frame") then
            child.Visible = true;
        elseif child:IsA("UIPadding") then
            child.PaddingBottom = UDim.new(0, 15);
        end;
    end;

    p10.ExpandLabel.Text = "Click to collapse";
end;

local function CollapseEntry(p11) -- Line: 51
    p11:SetAttribute("Expanded", false);
    p11.Requirements.Visible = false;

    for _, child in p11.Requirements:GetChildren() do
        if child:IsA("Frame") then
            child.Visible = false;
        elseif child:IsA("UIPadding") then
            child.PaddingBottom = UDim.new(0, 3);
        end;
    end;

    p11.ExpandLabel.Text = "Click to expand";
end;

local function ToggleEntry(p12) -- Line: 64
    -- upvalues: CollapseEntry (copy), ExpandEntry (copy)
    if p12:GetAttribute("Expanded") then
        CollapseEntry(p12);

        return;
    end;

    ExpandEntry(p12);
end;

function u2.new(p13, p14) -- Line: 72
    -- upvalues: u2 (copy), Trove (copy)
    local u15 = setmetatable({}, u2);
    u15.UI = p13;
    u15.UIEngine = p14;
    u15.Trove = Trove.new();
    u15.Assets = p13.Assets;
    u15.Cache = {
        Entries = {}
    };
    u15.Entry = u15.Assets.Entry;
    u15.Requirement = u15.Assets.Requirement;
    u15.List = p13.Bosses;
    u15.Close = p13.Close;
    u15.Trove:Connect(u15.Close.MouseButton1Click, function() -- Line: 89
        -- upvalues: u15 (copy)
        u15.UI.Visible = false;
    end);

    return u15;
end;

function u2.CreateEntry(u16, u17) -- Line: 96
    -- upvalues: Trove (copy), LocalPlayer (copy), u1 (copy), CollapseEntry (copy), ExpandEntry (copy), NpcFunc (copy)
    if not (u17 and u17.BossName) then
        return;
    end;

    if u16.Cache.Entries[u17.BossName] then
        u16.Cache.Entries[u17.BossName]:Destroy();
    end;

    local u18 = u16.Entry:Clone();
    local v19 = Trove.new();
    u18.BossNameLabel.Text = u17.DisplayName or u17.BossName;

    if u17.UCoins then
        local Value = LocalPlayer.Data.UCoins.Value;
        local v20 = `<font color="{u17.UCoins <= Value and "#82ff4c" or "#ff4040"}">{Value}</font> / {u17.UCoins}`;
        local v21 = u16.Requirement:Clone();
        v21.NameLabel.Text = `<font color="#ffff00">{u16.UIEngine.UCoinsString}</font>:`;
        v21.CostLabel.Text = v20;
        v21.Parent = u18.Requirements;
    end;

    if u17.Items then
        for i, v in u17.Items do
            local v22 = u1:GetItemCount("ItemInventory", i):expect();
            local v23 = `<font color="{v <= v22 and "#82ff4c" or "#ff4040"}">{v22}</font> / {v}`;
            local v24 = u16.Requirement:Clone();
            v24.NameLabel.Text = `{u16.UIEngine:GetItemText(i)}`;
            v24.CostLabel.Text = v23;
            v24.Parent = u18.Requirements;
        end;
    end;

    v19:Connect(u18.MouseButton1Click, function() -- Line: 129
        -- upvalues: u18 (copy), CollapseEntry (ref), ExpandEntry (ref)
        local v25 = u18;

        if v25:GetAttribute("Expanded") then
            CollapseEntry(v25);

            return;
        end;

        ExpandEntry(v25);
    end);
    local u26 = {
        InvalidSpawn = "Could not find the boss summon",
        InvalidBoss = "Could not find the boss",
        Expired = "Boss can longer be spawned",
        InvalidCost = "You do not have enough UCoins to summon the boss",
        InvalidUCoins = "You do not have enough UCoins to summon the boss",
        InvalidItems = "You do not have enough items to summon the boss",
        AlreadySpawned = "Kill the current altar boss before trying to spawn another"
    };
    v19:Connect(u18.SummonButton.MouseButton1Click, function() -- Line: 142
        -- upvalues: u16 (copy), u17 (copy), NpcFunc (ref), u26 (copy)
        u16.UIEngine:PlaySound("Click");
        u16.UIEngine.NewPrompt({
            Delay = 1.5,
            Title = `Spawn {u17.BossName}?`,
            Text = `Are you sure you want to spawn [{u17.BossName}]`,
            Options = { "Yes", "No" },

            Callback = function(p27) -- Line: 150, Name: Callback
                -- upvalues: u16 (ref), u17 (ref), NpcFunc (ref), u26 (ref)
                if p27.Choice ~= 1 then
                    return;
                end;

                u16.UIEngine:PlaySound("Click");

                if u17.SecondConfirmationMessage then
                    u16.UIEngine.NewPrompt({
                        Delay = 3,
                        Title = `Spawn {u17.BossName}?`,
                        Text = u17.SecondConfirmationMessage,
                        Options = { "Yes", "No" },

                        Callback = function(p28) -- Line: 159, Name: Callback
                            -- upvalues: u16 (ref), NpcFunc (ref), u17 (ref), u26 (ref)
                            if p28.Choice ~= 1 then
                                return;
                            end;

                            u16.UIEngine:PlaySound("Click");
                            local v29 = NpcFunc:InvokeServer("Spawn Boss Altar", u17.BossName, u16.SpawnPart);

                            if type(v29) == "string" then
                                warn(v29);
                                u16.UIEngine.NewPrompt({
                                    Title = "Spawn Failed",
                                    Text = u26[v29]
                                });
                            end;

                            u16:Load();
                        end
                    });

                    return;
                end;

                local v30 = NpcFunc:InvokeServer("Spawn Boss Altar", u17.BossName, u16.SpawnPart);

                if type(v30) == "string" then
                    warn(v30);
                    u16.UIEngine.NewPrompt({
                        Title = "Spawn Failed",
                        Text = u26[v30]
                    });
                end;

                u16:Load();
            end
        });
    end);
    v19:Add(u18);
    u18.Visible = true;
    u18.Parent = u16.List;
    u16.Cache.Entries[u17.BossName] = v19;
end;

function u2.ClearEntries(p31) -- Line: 199
    for _, v in p31.Cache.Entries do
        v:Destroy();
    end;

    table.clear(p31.Cache.Entries);
end;

function u2.Load(p32, p33) -- Line: 206
    -- upvalues: NpcFunc (copy)
    p32:ClearEntries();

    if p33 then
        p32.SpawnPart = p33;
    end;

    local v34 = NpcFunc:InvokeServer("Get Boss Data");

    if not v34 then
        return;
    end;

    p32.UI.Visible = true;

    for i, v in v34 do
        if not v.Expiration or os.time() < v.Expiration then
            p32:CreateEntry({
                BossName = i,
                Items = v.Items,
                UCoins = v.UCoins,
                DisplayName = v.DisplayName,
                SecondConfirmationMessage = v.SecondConfirmationMessage
            });
        end;
    end;
end;

return u2;