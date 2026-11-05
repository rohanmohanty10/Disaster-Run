  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);
Knit.GetService("InventoryService");
require(PathShortcuts.ReplicatedModules.Classes.Stack);
require(PathShortcuts.KnitPath.Promise);
local u1 = Knit.GetService("PartyService");
local LocalPlayer = game.Players.LocalPlayer;
local u2 = {};
u2.__index = u2;
local u3 = {
    Color3.fromRGB(114, 177, 255),
    Color3.fromRGB(245, 130, 255),
    Color3.fromRGB(255, 112, 112),
    Color3.fromRGB(255, 230, 87)
};
local u4 = Color3.fromRGB(0, 179, 255);

local function RNG(p5, p6) -- Line: 26
    return Random.new():NextNumber(p5, p6);
end;

local function GenerateColor() -- Line: 30
    return Color3.fromHSV(Random.new():NextNumber(0, 360) / 360, Random.new():NextNumber(0.5, 0.9), 0.9);
end;

local function Count(p7) -- Line: 34
    local v8 = 0;

    for _, _ in p7 do
        v8 = v8 + 1;
    end;

    return v8;
end;

function u2.new(p9, p10) -- Line: 42
    -- upvalues: u2 (copy), Trove (copy)
    local v11 = setmetatable({}, u2);
    v11.UI = p9;
    v11.UIEngine = p10;
    v11.Trove = Trove.new();
    v11.Assets = p9.Assets;
    v11.Cache = {
        MemberEntries = {},
        MemberNames = {},
        TeamIcons = {}
    };
    v11.MemberEntry = v11.Assets.MemberEntry;
    v11.TeamIcon = v11.Assets.TeamIcon;
    v11.Frame = v11.UI.PartyListFrame;
    v11.Members = v11.Frame.Members;
    print(v11.Members);

    return v11;
end;

function u2.CreateEntry(p12, p13, p14) -- Line: 65
    -- upvalues: u3 (copy), u4 (copy)
    if not p12.Cache.MemberNames[p13] then
        local v15 = p12.MemberEntry:Clone();
        p12.Cache.MemberNames[p13] = true;
        p12.Cache.MemberEntries[p13] = { v15, p13, p14 };
        local v16 = 0;

        for _, _ in p12.Cache.MemberEntries do
            v16 = v16 + 1;
        end;

        if u3[v16] then
            local v17 = 0;

            for _, _ in p12.Cache.MemberEntries do
                v17 = v17 + 1;
            end;

            v15.Labels.Diamond.TextColor3 = u3[v17];
        else
            v15.Labels.Diamond.TextColor3 = Color3.fromHSV(Random.new():NextNumber(0, 360) / 360, Random.new():NextNumber(0.5, 0.9), 0.9);
        end;

        if p14 then
            v15.Labels.NameLabel.TextColor3 = u4;
            v15.LayoutOrder = -1;
        end;

        v15.Labels.NameLabel.Text = p13;
        v15.Parent = p12.Members;
        v15.Visible = true;
        local v18 = 0;

        for _, _ in p12.Cache.MemberEntries do
            v18 = v18 + 1;
        end;

        if v18 > 0 then
            if not p12.UI:GetAttribute("ForcedState") then
                p12.UI.Visible = true;
            end;

            p12.UI:SetAttribute("CanToggle", true);
        end;

        return v15;
    end;
end;

function u2.RemoveEntry(p19, p20) -- Line: 98
    local v21 = p19.Cache.TeamIcons[p20];

    if v21 then
        v21[2]:Destroy();
        p19.Cache.TeamIcons[p20] = nil;
        table.clear(v21);
    end;

    local v22 = p19.Cache.MemberEntries[p20];

    if v22 then
        v22[1]:Destroy();
        p19.Cache.MemberNames[p20] = nil;
        table.clear(v22);
        p19.Cache.MemberEntries[p20] = nil;
    end;

    local v23 = 0;

    for _, _ in p19.Cache.MemberEntries do
        v23 = v23 + 1;
    end;

    if v23 > 0 then
        p19.UI.Visible = true;

        return;
    end;

    p19.UI.Visible = false;
    p19.UI:SetAttribute("CanToggle", false);
end;

function u2.UpdateHealthbars(p24) -- Line: 123
    -- upvalues: Players (copy)
    for _, v in p24.Cache.MemberEntries do
        local v25 = Players:FindFirstChild(v[2]);
        local HPBar = v[1].Bar.HPBar;

        if v25 then
            local Character = v25.Character;

            if Character ~= nil and Character.Parent then
                local v26 = Character:FindFirstChildOfClass("Humanoid");

                if v26 then
                    HPBar.Perc.Size = UDim2.new(v26.Health / v26.MaxHealth, 0, 1, 0);
                end;
            end;
        end;
    end;
end;

function u2.CreateTeamIcon(p27, p28, p29) -- Line: 143
    -- upvalues: LocalPlayer (copy), u4 (copy), u3 (copy)
    if LocalPlayer == p28 then
        return;
    end;

    local v30;

    if p28:IsA("Player") then
        v30 = p28.Character or p28;
    else
        v30 = p28;
    end;

    local v31 = p29 and u4;

    if not v31 then
        local v32 = 0;

        for _, _ in p27.Cache.MemberEntries do
            v32 = v32 + 1;
        end;

        v31 = u3[v32] or Color3.fromHSV(Random.new():NextNumber(0, 360) / 360, Random.new():NextNumber(0.5, 0.9), 0.9);
    end;

    if not v30 then
        return;
    end;

    if p27.Cache.TeamIcons[p28.Name] then
        return;
    end;

    local HumanoidRootPart = v30:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v33 = p27.TeamIcon:Clone();
    v33.Icon.ImageColor3 = v31;
    v33.Parent = HumanoidRootPart;
    p27.Cache.TeamIcons[p28.Name] = { HumanoidRootPart, v33 };
end;

function u2.UpdateIcons(p34) -- Line: 165
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    for _, v in p34.Cache.TeamIcons do
        local v35 = v[2];
        local Magnitude = (Character.Position - v[1].Position).Magnitude;
        local v36 = math.max(Magnitude / 25, 1);
        v35.Size = UDim2.fromScale(v36, v36);

        if Magnitude < 100 then
            v35.Enabled = false;
        else
            v35.Enabled = true;
        end;
    end;
end;

function u2.ClearEntries(p37) -- Line: 189
    for i, v in p37.Cache.MemberEntries do
        v[1]:Destroy();
        table.clear(v);
        p37.Cache.MemberEntries[i] = nil;
    end;

    for _, v in p37.Cache.TeamIcons do
        v[2]:Destroy();
        table.clear(v);
    end;

    table.clear(p37.Cache.MemberNames);
    table.clear(p37.Cache.MemberEntries);
    table.clear(p37.Cache.TeamIcons);
    p37.UI.Visible = false;
    p37.UI:SetAttribute("CanToggle", false);
end;

function u2.Update(p38) -- Line: 209
    -- upvalues: u1 (copy), LocalPlayer (copy)
    local v39 = u1:GetParty():expect();
    local v40 = u1:GetMemberPositions():expect();

    if type(v40) == "table" then
        for _, v in ipairs(v40) do
            LocalPlayer:RequestStreamAroundAsync(v, 1);
        end;
    end;

    p38:ClearEntries();

    if v39 then
        local _Members = v39._Members;
        local _Leader = v39._Leader;
        p38:CreateEntry(_Leader.Name, true);
        p38:CreateTeamIcon(_Leader, true);

        for _, v in _Members do
            p38:CreateEntry(v.Name, false);
            p38:CreateTeamIcon(v);
        end;
    end;
end;

function u2.Load(u41) -- Line: 237
    u41:Update();
    u41.Trove:Connect(game:GetService("RunService").Heartbeat, function() -- Line: 240
        -- upvalues: u41 (copy)
        u41:UpdateHealthbars();
        u41:UpdateIcons();
    end);
end;

return u2;