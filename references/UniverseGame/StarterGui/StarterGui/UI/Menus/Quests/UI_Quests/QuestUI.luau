  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local u1 = {};
u1.__index = u1;
local _ = print;

function print(...)
end;

function u1.new(p2, p3) -- Line: 18
    -- upvalues: u1 (copy)
    local v4 = setmetatable({}, u1);
    v4.UI = p2;
    v4.UIEngine = p3;
    v4.Assets = p2.Assets;
    v4.Cache = {};
    v4.Selection = nil;
    v4.QuestlineEntry = v4.Assets.QuestlineEntry;
    v4.QuestEntry = v4.Assets.QuestEntry;
    v4.ObjectiveEntry = v4.Assets.ObjectiveEntry;
    v4.RewardEntry = v4.Assets.RewardEntry;
    v4.QuestlineList = v4.UI.Questlines;
    v4.QuestList = v4.UI.Quests;
    v4.QuestlinePage = v4.QuestlineList.QuestlinePage;
    v4.QuestPage = v4.QuestList.QuestPage;

    return v4;
end;

function u1.AddQuestlineEntry(u5, u6) -- Line: 41
    -- upvalues: Trove (copy)
    if u5.Cache[u6] then
        return;
    end;

    local u7 = Trove.new();
    local u8 = u7:Clone(u5.QuestlineEntry);
    u8.NameFrame.Text = u6.Name;
    u8.Parent = u5.QuestlinePage;
    u8.Visible = #u6:GetChildren() >= 1;
    u7:Connect(u8.MouseButton1Click, function() -- Line: 53
        -- upvalues: u5 (copy), u6 (copy)
        u5.UIEngine:PlaySound("Click");
        u5:ChangeSelection(u6);
    end);
    local u9 = {};

    local function AddQuest(u10) -- Line: 60
        -- upvalues: u7 (copy), u5 (copy), u6 (copy), u8 (copy), u9 (copy)
        local u11 = u7:Clone(u5.QuestEntry);
        u11.Name = u10.Name;
        u11.NameFrame.Text = u10.Name;
        u11.Visible = u5.Selection == u6;
        u11.Parent = u5.QuestPage;
        local u12 = {};
        local u13 = {};

        local function AddReward(p14) -- Line: 70
            -- upvalues: u5 (ref), u11 (copy), u13 (copy), u8 (ref)
            local v15 = u5.RewardEntry:Clone();
            local v16 = u5.UIEngine:AbbreviateNumber(p14.Value);
            v15.NameFrame.Text = `{p14.Name} : {v16}`;
            v15.Parent = u11.RewardPage;
            v15.Visible = true;
            u11.RewardPage.CanvasSize = UDim2.fromOffset(0, u11.RewardPage.UIListLayout.AbsoluteContentSize.Y + 10);
            u13[p14] = {
                Entry = v15
            };
            u8.Visible = true;

            if u11:GetAttribute("Pinned") then
                u5.UIEngine:UpdatePinnedRewards(u13);
            end;
        end;

        local function AddObjective(u17) -- Line: 91
            -- upvalues: AddReward (copy), u5 (ref), u11 (copy), u12 (copy), u8 (ref)
            if u17:GetAttribute("Reward") then
                AddReward(u17);

                return;
            end;

            local u18 = u5.ObjectiveEntry:Clone();
            u18.NameFrame.Text = u17.Name;
            u18.Parent = u11.ObjectivePage;
            u18.Visible = true;
            local ProgressFrame = u18.ProgressFrame;

            local function UpdateProgress(p19) -- Line: 103
                -- upvalues: u17 (copy), ProgressFrame (copy), u18 (copy), u11 (ref), u5 (ref), u12 (ref)
                local v20 = u17:GetAttribute("MaxValue");
                local v21 = p19 / v20;

                if not ProgressFrame:FindFirstChild("ProgressText") then
                    return;
                end;

                if not ProgressFrame:FindFirstChild("Progress") then
                    return;
                end;

                ProgressFrame.ProgressText.Text = tostring(p19) .. " / " .. tostring(v20);
                ProgressFrame.Progress.Size = UDim2.new(v21, 0, 1, 0);

                if v21 == 1 then
                    u18.BackgroundTransparency = 0.2;
                end;

                if u11:GetAttribute("Pinned") then
                    u5.UIEngine:UpdatePinnedQuestTasks(u12);
                end;
            end;

            UpdateProgress(u17.Value);
            u17.Changed:Connect(UpdateProgress);
            u17:GetAttributeChangedSignal("MaxValue"):Connect(function() -- Line: 124
                -- upvalues: UpdateProgress (copy), u17 (copy)
                UpdateProgress(u17.Value);
            end);
            u11.ObjectivePage.CanvasSize = UDim2.fromOffset(0, u11.ObjectivePage.UIListLayout.AbsoluteContentSize.Y + 10);
            u12[u17] = {
                Entry = u18
            };
            u8.Visible = true;

            if u11:GetAttribute("Pinned") then
                u5.UIEngine:UpdatePinnedQuestTasks(u12);
            end;
        end;

        local function PinQuest() -- Line: 140
            -- upvalues: u11 (copy), u5 (ref), u10 (copy), u12 (copy), u13 (copy)
            print("PINQUEST CALLED: ", u11.Name);

            if u11:GetAttribute("Pinned") then
                print("UNPINNING ", u11.Name);
                u5.UIEngine:SetLastUnpinnedQuestName(u10.Name);
                u5.UIEngine:SetCurrentPinnedQuestNameInternal("None");
                u5.UIEngine:HidePinnedQuestOverlay();

                return;
            end;

            print("PINNING", u11.Name);

            for _, child in u5.QuestPage:GetChildren() do
                if child then
                    child:SetAttribute("Pinned", nil);
                end;
            end;

            u5.UIEngine:AddPinnedQuest(u10.Name, u12, u13);
            u11:SetAttribute("Pinned", true);
        end;

        for _, child in ipairs(u10:GetChildren()) do
            AddObjective(child);
        end;

        u7:Connect(u10.ChildAdded, AddObjective);
        u7:Connect(u11.Pin.MouseButton1Click, PinQuest);
        local v22 = u5.UIEngine:GetPinnedQuestName();

        if u10.Name == v22 then
            PinQuest();
        elseif v22 == "None" then
            local v23 = true;

            for _, child in u5.QuestPage:GetChildren() do
                print("ENTRY QUERYING: ", child);

                if child and child:GetAttribute("Pinned") then
                    v23 = false;
                    break;
                end;
            end;

            print("NO PINS? : ", v23);
            local v24 = u5.UIEngine:GetLastUnpinnedQuestName();
            print("LAST UNPINNED: ", v24);
            print("QUEST NAME: ", u10.Name);

            if v23 and u10.Name ~= v24 then
                task.wait();
                PinQuest();
            end;
        end;

        u9[u10] = {
            Entry = u11,
            ObjectiveEntries = u12,
            RewardEntries = u13
        };
        u8.Visible = true;
    end;

    local function RemoveQuest(p25) -- Line: 213
        -- upvalues: u9 (copy), u5 (copy), u6 (copy), u8 (copy)
        local v26 = u9[p25];

        if v26 then
            if v26.Entry:GetAttribute("Pinned") then
                u5.UIEngine:HidePinnedQuestOverlay();
                v26.Entry:SetAttribute("Pinned", nil);
            end;

            v26.Entry.Visible = false;
            v26.Entry:Destroy();
            u9[p25] = nil;
        end;

        if #u6:GetChildren() < 1 then
            u8.Visible = false;
        end;
    end;

    for _, child in ipairs(u6:GetChildren()) do
        AddQuest(child);
    end;

    u7:Connect(u6.ChildAdded, AddQuest);
    u7:Connect(u6.ChildRemoved, RemoveQuest);
    u5.Cache[u6] = {
        Entry = u8,
        Trove = u7,

        ToggleQuests = function(p27) -- Line: 237, Name: ToggleQuests
            -- upvalues: u9 (copy)
            for _, v in pairs(u9) do
                v.Entry.Visible = p27;
            end;
        end,

        QuestEntries = u9
    };
end;

function u1.AutoUpdate_PinnedQuest(p28, p29, p30) -- Line: 252
    if not p29 then
        for i, _ in p28.Cache do
            p29 = i;
            break;
        end;
    end;

    print("Questline: ", p29);
    local v31 = p28.Cache[p29];

    if not v31 then
        return;
    end;

    if not p30 then
        for i, _ in v31.QuestEntries do
            p30 = i;
            break;
        end;
    end;

    print("Quest To Show: ", p30);
    local v32 = v31.QuestEntries[p30];

    if v32 then
        print("CACHE FOUND");
        local Entry = v32.Entry;
        local ObjectiveEntries = v32.ObjectiveEntries;
        local RewardEntries = v32.RewardEntries;

        for _, child in p28.QuestPage:GetChildren() do
            if child then
                child:SetAttribute("Pinned", nil);
            end;
        end;

        p28.UIEngine:AddPinnedQuest(p30.Name, ObjectiveEntries, RewardEntries);
        Entry:SetAttribute("Pinned", true);
    end;
end;

function u1.RemoveQuestlineEntry(p33, p34) -- Line: 291
    if not p33.Cache[p34] then
        return;
    end;

    if p33.Cache[p34].Trove then
        p33.Cache[p34].Trove:Destroy();
    end;

    p33.Cache[p34] = nil;
end;

function u1.ChangeSelection(p35, p36) -- Line: 299
    local Selection = p35.Selection;
    p35.Selection = p36;
    local v37 = p35.Cache[Selection];
    local v38 = p35.Cache[p35.Selection];

    if v37 then
        v37.Entry.BackgroundTransparency = 0.6;
        v37.ToggleQuests(false);
    end;

    if v38 then
        v38.Entry.BackgroundTransparency = 0.15;
        v38.ToggleQuests(true);
    end;

    p35.UI.Discard.Visible = p36:GetAttribute("Discardable");
    p35.DiscardCache = p36;
end;

function u1.DiscardQuestline(u39) -- Line: 320
    local u40 = u39.UIEngine.Knit.GetService("QuestLineService");
    local DiscardCache = u39.DiscardCache;
    u39.UIEngine.NewPrompt({
        Title = "Discard Questline",
        Delay = 1,
        Text = `Are you sure you want to discard {DiscardCache.Name}? Doing so will reset the questline.`,
        Options = { "Yes", "No" },

        Callback = function(p41) -- Line: 331, Name: Callback
            -- upvalues: u40 (copy), DiscardCache (copy), u39 (copy)
            if p41.Choice ~= 1 then
                return;
            end;

            if u40:DiscardQuestline(DiscardCache:GetAttribute("InternalName")):expect() then
                u39.UIEngine.NewPrompt({
                    Title = "Discard Success",
                    Text = `{DiscardCache.Name} has been successfully discarded`
                });
            else
                u39.UIEngine.NewPrompt({
                    Title = "Discard Fail",
                    Text = `{DiscardCache.Name} could not be discarded`
                });
            end;

            u39.UI.Discard.Visible = false;
        end
    });
end;

return u1;