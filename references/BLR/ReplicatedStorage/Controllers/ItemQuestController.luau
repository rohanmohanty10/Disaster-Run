  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
game:GetService("MarketplaceService");
local CollectionService = game:GetService("CollectionService");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.LimitedCrateData);
require(ReplicatedStorage.Packages.Janitor);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.utils.makePlayerModel);
require(ReplicatedStorage.Shared.FormatNumber);
local VfxManager = require(ReplicatedStorage2.Shared.VfxManager);
local ItemQuestData = require(ReplicatedStorage.Shared.Configs.ItemQuestData);
local EgoEventCutscene = require(ReplicatedStorage.Effects.EgoEventCutscene);
local EgoEventCutsceneEntrance = require(ReplicatedStorage.Effects.EgoEventCutsceneEntrance);
local v1 = Knit.CreateController({
    Name = "ItemQuestController"
});
local PlayerData = require(ReplicatedStorage.ClientModules.ClientGlobals).PlayerData;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local Quest = ReplicatedStorage.Assets.UI.ItemQuest.Quest;

local function fireworkVisuals(p2, p3) -- Line: 30
    -- upvalues: ItemQuestData (copy), CollectionService (copy), VfxManager (copy)
    local v4 = ItemQuestData.Quests[p2];

    for _, v in CollectionService:GetTagged("QuestActivated") do
        if v:GetAttribute("Colour") == v4.Colour then
            if p3.Progress < p3.Goal then
                VfxManager.Enable(v, false);
            else
                VfxManager.Enable(v, true);
            end;
        end;
    end;
end;

local function questVisual(p5, p6) -- Line: 49
    -- upvalues: ItemQuestData (copy), Quest (copy)
    local v7 = ItemQuestData.Quests[p5];
    local v8 = storage:FindFirstChild(p5);

    if not v8 then
        v8 = Quest:Clone();
        v8.Name = p5;
        v8.Questname.Text = string.gsub(v7.Display, "X", p6.Goal);
        v8.Bar.BackgroundColor3 = ItemQuestData.QuestColours[v7.Colour].BG;
        v8.Bar.UIStroke.Color = ItemQuestData.QuestColours[v7.Colour].Outline;
        v8.Parent = storage;
    end;

    v8.Progress.ProgressText.Text = `{p6.Progress}/{p6.Goal}`;

    if p6.Progress >= p6.Goal then
        v8.LayoutOrder = v8.LayoutOrder + ItemQuestData.QuestAmount;
    end;
end;

function v1.KnitStart(p9) -- Line: 69
    -- upvalues: ItemQuestData (copy), Knit (copy), PlayerData (copy), PlayerGui (copy), questVisual (copy), fireworkVisuals (copy), ReplicatedStorage2 (copy), EgoEventCutscene (copy), LocalPlayer (copy), Popup (copy), RunService (copy), EgoEventCutsceneEntrance (copy)
    if not ItemQuestData.Enabled then
        return;
    end;

    local Service = Knit.GetService("ItemQuestsEventService");
    PlayerData:WaitForLoaded();
    local Fireworks = PlayerGui.Fireworks;
    local Frame = Fireworks.Frame;
    storage = Frame.Contents.ScrollingFrame;

    local function checkQuestsCompleted() -- Line: 79
        -- upvalues: ItemQuestData (ref), PlayerData (ref)
        local v10 = 0;

        for i, _ in ItemQuestData.Quests do
            local v11 = PlayerData.Data.ItemQuest[ItemQuestData.EVENT].Quests[i];

            if v11.Progress >= v11.Goal then
                v10 = v10 + 1;
            end;
        end;

        return v10;
    end;

    local function checkChristmasTree() -- Line: 92
        return workspace.TreeFirework:FindFirstChild("ChristmasTree");
    end;

    local function destroyChristmasTree() -- Line: 97
        local ChristmasTree = workspace.TreeFirework:FindFirstChild("ChristmasTree");

        if not ChristmasTree then
            return;
        end;

        ChristmasTree:Destroy();
    end;

    for i, _ in ItemQuestData.Quests do
        PlayerData:Observe({
            "ItemQuest",
            ItemQuestData.EVENT,
            "Quests",
            i
        }, function(p12) -- Line: 104
            -- upvalues: questVisual (ref), i (copy), fireworkVisuals (ref), PlayerData (ref), ItemQuestData (ref), checkQuestsCompleted (copy), Frame (copy)
            if not p12 then
                print(p12);

                return;
            end;

            questVisual(i, p12);
            fireworkVisuals(i, p12);

            if PlayerData.Data.ItemQuest[ItemQuestData.EVENT].Claimed then
                return;
            end;

            local v13 = checkQuestsCompleted();

            if v13 >= ItemQuestData.QuestAmount then
                Frame.Claim.Visible = true;
                Frame.QuestsCompleted.Visible = false;

                return;
            end;

            Frame.QuestsCompleted.Text = `{v13}/{ItemQuestData.QuestAmount}`;
            Frame.Claim.Visible = false;
            Frame.QuestsCompleted.Visible = true;
        end);
    end;

    local v14 = PlayerData.Data.ItemQuest[ItemQuestData.EVENT].Claimed and workspace.TreeFirework:FindFirstChild("ChristmasTree");

    if v14 then
        v14:Destroy();
    end;

    PlayerData:Observe({ "ItemQuest", ItemQuestData.EVENT, "Claimed" }, function(p15) -- Line: 129
        -- upvalues: Frame (copy)
        if p15 then
            Frame.QuestsCompleted.Text = "REWARD CLAIMED";
            Frame.Claim.Visible = false;
            Frame.QuestsCompleted.Visible = true;
        end;
    end);
    workspace.Ego.Prox.Triggered:Connect(function() -- Line: 139
        -- upvalues: Fireworks (copy)
        Fireworks.Enabled = true;
    end);
    workspace.Ego.Humanoid:LoadAnimation(ReplicatedStorage2.Assets.Emotes["Liberty Cat Dance"]):Play();
    Frame.Prize.Label.Text = ItemQuestData.ITEM_REWARD;

    local function claimPrize() -- Line: 149
        -- upvalues: Service (copy), EgoEventCutscene (ref), LocalPlayer (ref), Popup (ref), ItemQuestData (ref)
        if not Service:ClaimReward() then
            return;
        end;

        if not workspace.TreeFirework:FindFirstChild("ChristmasTree") then
            return;
        end;

        print("Claiming here");
        EgoEventCutscene({
            Char = LocalPlayer.Character
        });
        local ChristmasTree = workspace.TreeFirework:FindFirstChild("ChristmasTree");

        if ChristmasTree then
            ChristmasTree:Destroy();
        end;

        Popup.Popup(nil, (`Recieved "{ItemQuestData.ITEM_REWARD}"`));
    end;

    Frame.Claim.Activated:Connect(function() -- Line: 160
        -- upvalues: claimPrize (copy)
        claimPrize();
    end);
    Frame.Prize.Activated:Connect(function() -- Line: 165
        -- upvalues: checkQuestsCompleted (copy), ItemQuestData (ref), claimPrize (copy)
        if checkQuestsCompleted() < ItemQuestData.QuestAmount then
            return;
        end;

        claimPrize();
    end);
    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.FilterType = Enum.RaycastFilterType.Include;

    if not PlayerData.Data.ItemQuest[ItemQuestData.EVENT].StartAnimation then
        local u16 = nil;
        local u17 = nil;
        u16 = RunService.Heartbeat:Connect(function() -- Line: 178
            -- upvalues: OverlapParams_new_ret (copy), LocalPlayer (ref), u17 (ref), Service (copy), u16 (ref), EgoEventCutsceneEntrance (ref)
            OverlapParams_new_ret.FilterDescendantsInstances = { LocalPlayer.Character };

            if #workspace:GetPartsInPart(workspace.TreeFirework.StartAnimationPad, OverlapParams_new_ret) == 0 then
                return;
            end;

            u17 = true;

            if not Service:StartAnimation() then
                u17 = false;

                return;
            end;

            u16:Disconnect();
            print("Playing start animation");
            EgoEventCutsceneEntrance({
                Char = LocalPlayer.Character
            });
            u17 = false;
        end);
    end;
end;

return v1;