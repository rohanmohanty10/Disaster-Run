  

 

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
local LocalPlayer = Players.LocalPlayer;
local u2 = {};
u2.__index = u2;
Color3.fromRGB(0, 179, 255);

local function RNG(p3, p4) -- Line: 19
    return Random.new():NextNumber(p3, p4);
end;

local function FindPlayer(p5) -- Line: 23
    -- upvalues: Players (copy), LocalPlayer (copy)
    local v6 = p5:lower();

    for _, v in ipairs(Players:GetPlayers()) do
        if (v.DisplayName:lower():find(v6) or v.Name:lower():find(v6)) and v ~= LocalPlayer then
            return v;
        end;
    end;
end;

local u7 = {
    Kick = {
        Title = "Kick",
        Description = "Kick the member from the pary"
    },
    Promote = {
        Title = "Promote",
        Description = "Transfer party ownership to this member"
    }
};

function u2.new(p8, p9) -- Line: 44
    -- upvalues: u2 (copy), Trove (copy)
    local v10 = setmetatable({}, u2);
    v10.UI = p8;
    v10.UIEngine = p9;
    v10.Trove = Trove.new();
    v10.Assets = p8.Assets;
    v10.Cache = {
        LastSelectedEntry = nil,
        SelectedMember = nil,
        CurrentTab = "NoParty",
        MemberEntries = {},
        Party = {}
    };
    v10.MemberEntry = v10.Assets.MemberEntry;
    v10.PartyTab = p8.Party;
    v10.NoPartyTab = p8.NoParty;
    v10.Title = v10.PartyTab.Title;
    v10.Members = v10.PartyTab.Members;
    v10.MemberList = v10.Members.List;
    v10.Buttons = v10.Title.Buttons;
    v10.PlayerBox = v10.Title.PlayerBox;
    v10.Tooltip = v10.UIEngine.Util.Tooltip.GetFromParent(v10.UIEngine.UI:FindFirstChild("Screen"));

    return v10;
end;

function u2.CreateEntry(u11, u12) -- Line: 75
    -- upvalues: Trove (copy), LocalPlayer (copy), u7 (copy)
    if u11.MemberList:FindFirstChild(u12) then
        u11.MemberList:FindFirstChild(u12):Destroy();
    end;

    local u13 = u11.MemberEntry:Clone();
    u13.Name = u12;
    u13.NameLabel.Text = u12;
    local v14 = Trove.new();
    v14:Add(u13);
    local Party = u11.Cache.Party;

    if Party and Party._Leader == LocalPlayer then
        u13.Kick.Visible = true;
        u13.Promote.Visible = true;
        v14:Connect(u13.Kick.MouseButton1Click, function() -- Line: 91
            -- upvalues: u11 (copy), u12 (copy)
            u11:Kick(u12);
        end);
        v14:Connect(u13.Promote.MouseButton1Click, function() -- Line: 94
            -- upvalues: u11 (copy), u12 (copy)
            u11:Promote(u12);
        end);

        for _, child in u13:GetChildren() do
            if child:IsA("TextButton") then
                v14:Connect(child.MouseEnter, function() -- Line: 100
                    -- upvalues: u7 (ref), child (copy), u11 (copy)
                    local v15 = u7[child.Name];

                    if not v15 then
                        return;
                    end;

                    u11.Tooltip:SetTitle(v15.Title);
                    u11.Tooltip:SetText(v15.Description);
                    u11.Tooltip:Show();
                end);
                v14:Connect(child.MouseLeave, function() -- Line: 108
                    -- upvalues: u7 (ref), child (copy), u11 (copy)
                    if not u7[child.Name] then
                        return;
                    end;

                    u11.Tooltip:Hide();
                end);
            end;
        end;
    end;

    task.defer(function() -- Line: 119
        -- upvalues: u13 (copy)
        if u13.Parent then
            u13.Size = UDim2.new(1, 0, 0, 35);
        end;
    end);
    u11.Cache.MemberEntries[u12] = { u13, u12, v14 };
    u13.Parent = u11.MemberList;
    u13.Visible = true;
end;

function u2.RemoveEntry(p16, p17) -- Line: 131
    local v18 = p16.Cache.MemberEntries[p17];

    if not v18 then
        return;
    end;

    v18[3]:Destroy();
    table.clear(v18);
    p16.Cache.MemberEntries[p17] = nil;
end;

function u2.ClearEntries(p19) -- Line: 139
    for i, v in p19.Cache.MemberEntries do
        v[1]:Destroy();
        table.clear(v);
        p19.Cache.MemberEntries[i] = nil;
    end;

    table.clear(p19.Cache.MemberEntries);
end;

function u2.Update(p20) -- Line: 149
    -- upvalues: u1 (copy), LocalPlayer (copy)
    local v21 = u1:GetParty():expect();
    p20:ClearEntries();
    p20.Cache.Party = v21;

    if v21 == nil then
        p20:SetTabVisible("NoParty", true);
    else
        local _Leader = v21._Leader;
        p20:SetTabVisible("Party", true);
        p20.Title.PartyLabel.Text = `{_Leader.Name}'s Party`;

        for _, v in v21._Members do
            p20:CreateEntry(v.Name);
        end;

        if _Leader == LocalPlayer then
            p20.Buttons.Leave.Visible = false;
            p20.Buttons.Disband.Visible = true;
            p20.Buttons.Invite.Visible = true;
            p20.PlayerBox.Visible = true;
        else
            p20.Buttons.Leave.Visible = true;
            p20.Buttons.Disband.Visible = false;
            p20.Buttons.Invite.Visible = false;
            p20.PlayerBox.Visible = false;
        end;
    end;

    p20.UIEngine.Cache.PartyMemberList:Update();
end;

function u2.MakeParty(p22) -- Line: 182
    -- upvalues: u1 (copy)
    if u1:CreateParty():expect() then
        p22:Update();
    end;
end;

function u2.Disband(u23) -- Line: 190
    -- upvalues: u1 (copy)
    u23.UIEngine.NewPrompt({
        Title = "Disband Party",
        Text = "Are you sure you want to disband your party?",
        Options = { "Cancel", "Confirm" },

        Callback = function(p24) -- Line: 198, Name: Callback
            -- upvalues: u1 (ref), u23 (copy)
            if p24.Choice == 1 then
                return true;
            end;

            u1:DisbandParty():expect();
            u23:Update();
        end
    });
end;

function u2.Invite(p25) -- Line: 209
    -- upvalues: FindPlayer (copy), u1 (copy)
    local Text = p25.PlayerBox.Text;

    if Text == "" then
        return;
    end;

    local v26 = FindPlayer(Text);

    if v26 then
        u1:SendPartyInvite(v26);
    end;
end;

function u2.Leave(p27) -- Line: 220
    -- upvalues: u1 (copy)
    u1:LeaveParty();
end;

function u2.Kick(p28, p29) -- Line: 224
    -- upvalues: Players (copy), u1 (copy)
    local v30 = Players:FindFirstChild(p29);

    if not v30 then
        return;
    end;

    u1:RemoveMemberFromParty(v30):expect();
end;

function u2.Promote(p31, p32) -- Line: 231
    -- upvalues: Players (copy), u1 (copy)
    local u33 = Players:FindFirstChild(p32);

    if not u33 then
        return;
    end;

    p31.UIEngine.NewPrompt({
        Title = "Transfer Ownership",
        Text = `Are you sure you want to tranfer party ownership to {p32}?`,
        Options = { "Cancel", "Confirm" },

        Callback = function(p34) -- Line: 242, Name: Callback
            -- upvalues: u1 (ref), u33 (copy)
            if p34.Choice == 1 then
                return true;
            end;

            u1:MakePartyLeader(u33);
        end
    });
end;

function u2.SetTabVisible(p35, p36, p37) -- Line: 252
    local v38 = {
        NoParty = p35.NoPartyTab,
        Party = p35.PartyTab
    };

    if p36 ~= p35.Cache.CurrentTab then
        v38[p35.Cache.CurrentTab].Visible = false;
        p35.Cache.CurrentTab = p36;
    end;

    if not v38[p36] then
        return;
    end;

    v38[p36].Visible = p37;
end;

function u2.GetSelectedMember(p39) -- Line: 268
    -- upvalues: FindPlayer (copy)
    local SelectedMember = p39.Cache.SelectedMember;

    if SelectedMember then
        return FindPlayer(SelectedMember);
    end;
end;

function u2.Load(u40) -- Line: 276
    -- upvalues: u1 (copy)
    for _, child in u40.Title.Buttons:GetChildren() do
        if child:IsA("TextButton") then
            u40.Trove:Connect(child.MouseButton1Click, function() -- Line: 279
                -- upvalues: u40 (copy), child (copy)
                local v41 = u40[child.Name];

                if v41 then
                    v41(u40);
                end;
            end);
        end;
    end;

    u40.Trove:Connect(u40.NoPartyTab.CreateParty.MouseButton1Click, function() -- Line: 288
        -- upvalues: u40 (copy)
        u40:MakeParty();
    end);
    u40.Trove:Connect(u1.RequestClientUpdate, function() -- Line: 292
        -- upvalues: u40 (copy)
        task.delay(0.1, function() -- Line: 293
            -- upvalues: u40 (ref)
            u40:Update();
        end);
    end);
    u40.Trove:Connect(u1.NotifyInvite, function(p42) -- Line: 297
        -- upvalues: u40 (copy), u1 (ref)
        u40.UIEngine:Notify("Party Invitation", `{p42.Name} has invited you to join their party`, 6, { "Accept", "Decline" }, function(p43, p44, p45) -- Line: 301
            -- upvalues: u1 (ref)
            if p44 == 1 then
                u1:AcceptInvite();
            end;
        end);
    end);
    u40.UIEngine.BindToClock("RefreshParty", 3, "PreRender", u40.Update, u40);
end;

return u2;