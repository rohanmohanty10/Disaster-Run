  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Popup = require(ReplicatedStorage.Shared.Popup);
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
require(ReplicatedStorage.Shared.environment);
local RankedData = require(ReplicatedStorage.Shared.Ranked.RankedData);
local u1 = {};

local function getModeConfig(p2: string) -- Line: 14
    -- upvalues: u1 (copy), ReplicatedStorage (copy)
    if u1[p2] then
        return u1[p2];
    end;

    local v3 = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("environment").Configs:FindFirstChild(p2);

    if not v3 and p2:find("Ranked") then
        v3 = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("environment").Configs:FindFirstChild("Ranked");
    end;

    if v3 then
        u1[p2] = require(v3);
    end;

    return u1[p2];
end;

local u4 = {
    Normal = "Normal",
    Normal3v3 = "Normal3v3",
    Normal8v8 = "Normal8v8",
    Pro = "Pro",
    AfkWorld = "AfkWorld"
};
local u5 = {
    ["2v2"] = "Ranked2v2",
    ["5v5"] = "Ranked5v5"
};
local v6 = Knit.CreateController({
    Name = "ModesController"
});
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = {};

local function getPlayerLevel() -- Line: 52
    -- upvalues: LocalPlayer (copy)
    local ProfileStats = LocalPlayer:FindFirstChild("ProfileStats");
    local v14 = ProfileStats and ProfileStats:FindFirstChild("Level");

    return not v14 and 1 or v14.Value;
end;

local function updateLockStates() -- Line: 63
    -- upvalues: u7 (ref), LocalPlayer (copy), u13 (copy), getModeConfig (copy)
    local Size = u7:GetSize();
    local ProfileStats = LocalPlayer:FindFirstChild("ProfileStats");
    local v15 = ProfileStats and ProfileStats:FindFirstChild("Level");
    local v16 = not v15 and 1 or v15.Value;

    for i, v in u13 do
        local v17 = getModeConfig(v);
        local v18 = v17 and (v17.MaxParty or 5) or 5;
        local v19 = v17 and v17.LevelReq or 0;
        local Locked = i:FindFirstChild("Locked");

        if Locked then
            local Frame = Locked:FindFirstChild("Frame");

            if Frame then
                Frame = Frame:FindFirstChild("lockedtext");
            end;

            local v20 = v == "Ranked2v2" and "DisableRanked2v2" or (v == "Ranked5v5" and "DisableRanked5v5" or nil);

            if v20 and workspace:GetAttribute(v20) == true then
                Locked.Visible = true;

                if Frame then
                    Frame.Text = "CURRENTLY DISABLED";
                end;
            elseif v16 < v19 then
                Locked.Visible = true;

                if Frame then
                    Frame.Text = "UNLOCKS AT LEVEL " .. v19;
                end;
            elseif v18 < Size then
                Locked.Visible = true;

                if Frame then
                    Frame.Text = "MAX PARTY SIZE: " .. v18;
                end;
            else
                Locked.Visible = false;
            end;
        end;
    end;
end;

function v6.KnitStart(p21) -- Line: 100
    -- upvalues: u7 (ref), Knit (copy), u8 (ref), u9 (ref), u10 (ref), u11 (ref), ReplicatedStorage (copy), PlayerGui (copy), u12 (ref), u5 (copy), u4 (copy), u13 (copy), Popup (copy), LocalPlayer (copy), updateLockStates (copy)
    p21:SetupHowTo();
    u7 = Knit.GetController("PartyController");
    u8 = Knit.GetService("PartyService");
    u9 = Knit.GetService("RankedService");
    u10 = Knit.GetService("ModesService");
    u11 = require(ReplicatedStorage.ClientModules.ClientGlobals);
    u12 = PlayerGui:WaitForChild("Modes").Frame:WaitForChild("Modes");
    local WorldTournament = u12:FindFirstChild("WorldTournament", true);

    if WorldTournament then
        WorldTournament:Destroy();
    end;

    task.spawn(function() -- Line: 119
        -- upvalues: ReplicatedStorage (ref), u10 (ref)
        local GameObjects = workspace:WaitForChild("GameObjects", 60);

        if GameObjects then
            GameObjects = GameObjects:WaitForChild("LobbyNPCs", 60);
        end;

        if GameObjects then
            GameObjects = GameObjects:WaitForChild("GamemodeTeleport", 60);
        end;

        if GameObjects then
            GameObjects = GameObjects:FindFirstChild("HumanoidRootPart");
        end;

        if GameObjects then
            GameObjects = GameObjects:FindFirstChildOfClass("ProximityPrompt");
        end;

        if not GameObjects then
            return;
        end;

        local BlueLockCupEventData = require(ReplicatedStorage.Shared.Configs.BlueLockCupEventData);

        local function eventLive() -- Line: 128
            -- upvalues: BlueLockCupEventData (copy)
            return not BlueLockCupEventData.IsFinalStageOver("F");
        end;

        GameObjects.Enabled = not BlueLockCupEventData.IsFinalStageOver("F");
        GameObjects.Triggered:Connect(function() -- Line: 133
            -- upvalues: BlueLockCupEventData (copy), u10 (ref)
            if BlueLockCupEventData.IsFinalStageOver("F") then
                return;
            end;

            u10:Teleport("WorldTournament");
        end);

        while GameObjects.Parent do
            task.wait(30);
            GameObjects.Enabled = not BlueLockCupEventData.IsFinalStageOver("F");
        end;
    end);
    local u22 = 0;
    local u23 = nil;
    local u24 = false;
    local u25 = nil;
    local u26 = {};

    for _, child in u12:GetChildren() do
        if child:IsA("Frame") then
            for _, child2 in child:GetChildren() do
                if child2:IsA("ImageButton") then
                    local u27 = u5[child2.Name];
                    local u28 = u4[child2.Name];
                    local u29 = u27 or u28;

                    if u29 then
                        u13[child2] = u29;
                        child2.Activated:Connect(function() -- Line: 163
                            -- upvalues: child2 (copy), u27 (copy), u28 (copy), u24 (ref), u25 (ref), u9 (ref), u22 (ref), Popup (ref), LocalPlayer (ref), Knit (ref), u23 (ref), u10 (ref), u29 (copy)
                            local Locked = child2:FindFirstChild("Locked");

                            if Locked and Locked.Visible then
                                return;
                            end;

                            print("[Modes] Button clicked:", child2.Name, "rankedMode:", tostring(u27), "normalMode:", (tostring(u28)));

                            if not u27 then
                                u10:Teleport(u29);

                                return;
                            end;

                            if u24 then
                                return;
                            end;

                            if u25 == child2 then
                                u24 = true;
                                u9:LeaveQueue();

                                return;
                            end;

                            if u25 then
                                return;
                            end;

                            if tick() < u22 then
                                local v30 = u22 - tick();
                                local math_ceil_ret = math.ceil(v30);
                                Popup.Popup(LocalPlayer, "Please wait before queueing again (" .. math_ceil_ret .. "s)");

                                return;
                            end;

                            local Controller = Knit.GetController("RankedController");
                            u24 = true;
                            u23 = child2;
                            u9:Queue(child2.Name, Controller:GetRegion());
                            u22 = tick() + 3;
                        end);
                    end;
                end;
            end;
        end;
    end;

    for i in u13 do
        local title = i:FindFirstChild("title", true);

        if title then
            u26[i] = title.Text;
        end;
    end;

    updateLockStates();
    u9.QueueStatus:Connect(function(p31, p32) -- Line: 205
        -- upvalues: u24 (ref), u25 (ref), u23 (ref), u13 (ref), u26 (copy)
        u24 = false;

        if p31 == "Queued" then
            u25 = u23;
            u23 = nil;

            if not u25 and p32 then
                for i, _ in u13 do
                    if i.Name == p32 then
                        u25 = i;
                        break;
                    end;
                end;
            end;

            local v33 = u25 and u25:FindFirstChild("title", true);

            if v33 then
                v33.Text = "IN QUEUE";
            end;
        elseif p31 == "Cancelled" then
            if u25 then
                local title = u25:FindFirstChild("title", true);

                if title then
                    title.Text = u26[u25] or title.Text;
                end;

                u25 = nil;
            end;
        elseif p31 == "MatchFound" then
            local v34 = u25 and u25:FindFirstChild("title", true);

            if v34 then
                v34.Text = "MATCH FOUND";
            end;
        elseif p31 == "Failed" then
            u23 = nil;

            if u25 then
                local title = u25:FindFirstChild("title", true);

                if title then
                    title.Text = u26[u25] or title.Text;
                end;

                u25 = nil;
            end;
        end;
    end);
    u8.PartyUpdate:Connect(function() -- Line: 252
        -- upvalues: updateLockStates (ref)
        task.defer(updateLockStates);
    end);
    workspace.AttributeChanged:Connect(function(p35) -- Line: 256
        -- upvalues: updateLockStates (ref)
        if p35 == "DisableRanked2v2" or p35 == "DisableRanked5v5" then
            task.defer(updateLockStates);
        end;
    end);
end;

function v6.UpdateLockStates(p36) -- Line: 264
    -- upvalues: updateLockStates (copy)
    updateLockStates();
end;

function v6.UpdateRankLabels(p37) -- Line: 268
    -- upvalues: LocalPlayer (copy), u9 (ref), RankedData (copy)
    local Modes = LocalPlayer.PlayerGui:FindFirstChild("Modes");

    if not Modes then
        return;
    end;

    local v38 = Modes:FindFirstChild("Frame") and Modes.Frame:FindFirstChild("Modes") and Modes.Frame.Modes:FindFirstChild("Ranked");

    if not v38 then
        return;
    end;

    for _, v in { "2v2", "5v5" } do
        local v39 = v38:FindFirstChild(v);

        if v39 then
            local rank = v39:FindFirstChild("rank");

            if rank then
                task.spawn(function() -- Line: 284
                    -- upvalues: u9 (ref), v (copy), RankedData (ref), rank (copy)
                    local success, result = pcall(function() -- Line: 285
                        -- upvalues: u9 (ref), v (ref)
                        return u9:GetSeasonData(v);
                    end);

                    if success and (result and result.Elo) then
                        local Rank, v40 = RankedData.GetRank(result.Elo);
                        rank.Text = Rank .. " " .. tostring(v40);

                        return;
                    end;

                    warn("[ModesController] GetSeasonData failed for", v, "success:", success, "data:", result);
                    rank.Text = "Unranked";
                end);
            end;
        end;
    end;
end;

function v6.SetupHowTo(p41) -- Line: 300
    -- upvalues: PlayerGui (copy)
    local Frame = PlayerGui:WaitForChild("Modes").Frame;
    local Howto = Frame.Howto;
    local Modes = Frame.Modes;
    local v42 = Modes:FindFirstChild("RankedTitle") and Modes.RankedTitle:FindFirstChild("Info");
    local Return = Howto:FindFirstChild("Return");

    if v42 then
        v42.Activated:Connect(function() -- Line: 309
            -- upvalues: Modes (copy), Frame (copy), Howto (copy)
            Modes.Visible = false;
            Frame.Party.Visible = false;
            Howto.Visible = true;
        end);
    end;

    if Return then
        Return.ZIndex = 5;
        Return.Activated:Connect(function() -- Line: 318
            -- upvalues: Howto (copy), Modes (copy), Frame (copy)
            Howto.Visible = false;
            Modes.Visible = true;
            Frame.Party.Visible = true;
        end);
    end;
end;

return v6;