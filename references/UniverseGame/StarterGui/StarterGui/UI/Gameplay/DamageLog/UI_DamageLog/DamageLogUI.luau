  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);
Knit.GetService("InventoryService");
require(PathShortcuts.ReplicatedModules.Classes.Stack);
require(PathShortcuts.KnitPath.Promise);
Knit.GetService("PartyService");
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
u1.__index = u1;
Color3.fromRGB(0, 179, 255);

local function RNG(p2, p3) -- Line: 19
    return Random.new():NextNumber(p2, p3);
end;

local function Count(p4) -- Line: 23
    local v5 = 0;

    for _, _ in p4 do
        v5 = v5 + 1;
    end;

    return v5;
end;

function Round(p6, p7)
    local v8 = 10 ^ (p7 or 0);

    return math.floor(p6 * v8 + 0.5) / v8;
end;

local function FindPlayer(p9) -- Line: 36
    -- upvalues: Players (copy), LocalPlayer (copy)
    local v10 = p9:lower();

    for _, v in ipairs(Players:GetPlayers()) do
        if (v.DisplayName:lower():find(v10) or v.Name:lower():find(v10)) and v ~= LocalPlayer then
            return v;
        end;
    end;
end;

function u1.new(p11, p12) -- Line: 46
    -- upvalues: u1 (copy), Trove (copy)
    local v13 = setmetatable({}, u1);
    v13.UI = p11;
    v13.UIEngine = p12;
    v13.Trove = Trove.new();
    v13.Assets = p11.Assets;
    v13.Header = p11.Header;
    v13.Cache = {
        Task = nil,
        Entries = {}
    };
    v13.Entry = v13.Assets.Entry;
    v13.List = p11.List;

    return v13;
end;

function u1.CreateEntry(p14, p15, p16) -- Line: 66
    local v17 = p14.Entry:Clone();
    v17.NameLabel.Text = p15;
    v17.DamageLabel.Text = `<stroke thickness="1" color="rgb(59,59,59)"><font color="rgb(93, 228, 255)">{p16.Damage}</font> | <font color="rgb(99, 255, 88)">{p16.Percentage}%</font></stroke>`;

    if p14.Cache.Entries[p15] then
        p14.Cache.Entries[p15]:Destroy();
        p14.Cache.Entries[p15] = nil;
    end;

    p14.Cache.Entries[p15] = v17;
    v17.LayoutOrder = 0 - p16.Damage * 100;
    v17.Visible = true;
    v17.Parent = p14.List;
end;

function u1.ClearEntries(p18) -- Line: 82
    for _, v in p18.Cache.Entries do
        v:Destroy();
    end;

    table.clear(p18.Cache.Entries);
end;

function u1.Load(u19, p20, p21, p22) -- Line: 90
    if not (p20 and p20.Parent) then
        return;
    end;

    if not p20:FindFirstChildOfClass("Humanoid") then
        return;
    end;

    local v23 = p20:FindFirstChildOfClass("Humanoid");
    local v24 = {};

    for i, v in p22 do
        local v25 = v / v23.MaxHealth;
        local v26 = {};
        local v27 = Round(v, 1);
        v26.Damage = math.clamp(v27, 0, v23.MaxHealth);
        local v28 = Round(v25 * 100, 1);
        v26.Percentage = math.clamp(v28, 0, 100);
        u19:CreateEntry(i, v26);
        v24[i] = v;
    end;

    local v29 = 0;

    for _, _ in v24 do
        v29 = v29 + 1;
    end;

    if v29 > 0 then
        u19.UI.Visible = true;
    end;

    u19.Header.TargetName.Text = `{p20.Name}`;
    table.clear(v24);

    if u19.Cache.Task then
        task.cancel(u19.Cache.Task);
        u19.Cache.Task = nil;
    end;

    u19.Cache.Task = task.delay(p21, function() -- Line: 121
        -- upvalues: u19 (copy)
        u19:ClearEntries();
        u19.UI.Visible = false;
    end);
end;

return u1;