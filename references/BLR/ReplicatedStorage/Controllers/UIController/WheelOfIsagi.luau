  

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local MarketplaceService = game:GetService("MarketplaceService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local KnitClient = require(ReplicatedStorage.Packages.Knit.KnitClient);
local RngUtil = require(ReplicatedStorage.Shared.RngUtil);
local SpinWheelData = require(ReplicatedStorage.Shared.Configs.SpinWheelData);
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local FormatNumber = require(ReplicatedStorage.Shared.FormatNumber);
local PlayerData = ClientGlobals.PlayerData;
local LocalPlayer = Players.LocalPlayer;
local Random_new_ret = Random.new();
local u1 = KnitClient.CreateController({
    Name = "WheelOfIsagi"
});
local u2 = false;
local u3 = false;
local u4 = { 300, 0, 60, 120, 180, 240 };

local function GetTargetRotation(p5) -- Line: 35
    -- upvalues: u4 (copy)
    return -(u4[p5] or 0);
end;

local function GetCurrentSegment(p6) -- Line: 44
    -- upvalues: u4 (copy)
    local v7 = (1 / 0);
    local v8 = 1;

    for i, v in u4 do
        local v9 = (p6 + v) % 360;

        if v9 > 180 then
            v9 = 360 - v9;
        end;

        if v9 < v7 then
            v8 = i;
            v7 = v9;
        end;
    end;

    return v8;
end;

local function Lerp(p10, p11, p12) -- Line: 60
    return p10 + (p11 - p10) * p12;
end;

function u1.Spin(p13, p14, p15) -- Line: 64
    -- upvalues: u2 (ref), Random_new_ret (copy), u4 (copy), TweenService (copy), GetCurrentSegment (copy)
    local bg = p13.bg;
    u2 = true;
    local v16 = Random_new_ret:NextInteger(7, 10) * 360;
    local Rotation = bg.Rotation;
    local v17 = Random_new_ret:NextNumber(-25, 25);
    local v18 = -(u4[p14] or 0) + v17 + v16;

    local function ease(p19) -- Line: 73
        -- upvalues: TweenService (ref)
        return TweenService:GetValue(p19, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    end;

    local v20 = GetCurrentSegment(Rotation);
    local v21 = 0;

    while true do
        v21 = v21 + task.wait();
        local v22 = v21 / p15;
        local Value = TweenService:GetValue(v22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);

        if v22 >= 1 then
            break;
        end;

        local v23 = Rotation + (v18 - Rotation) * Value;
        bg.Rotation = v23 % 360;
        local v24 = GetCurrentSegment(v23);

        if v24 == v20 then
            v24 = v20;
        end;

        v20 = v24;
    end;

    bg.Rotation = v18 % 360;
    task.wait(0.3);
    u2 = false;
end;

function u1.KnitStart(u25) -- Line: 103
    -- upvalues: KnitClient (copy), RunService (copy), LocalPlayer (copy), RngUtil (copy), SpinWheelData (copy), u2 (ref), u3 (ref), MarketplaceService (copy), PlayerData (copy), u1 (copy), FormatNumber (copy)
    local Service = KnitClient.GetService("WheelOfIsagiService");
    local SpinWheel = workspace:FindFirstChild("SpinWheel");
    local u26 = SpinWheel and SpinWheel:FindFirstChild("SpinPart");

    if u26 then
        RunService.Heartbeat:Connect(function(p27) -- Line: 111
            -- upvalues: u26 (copy)
            u26.CFrame = u26.CFrame * CFrame.Angles(0, 0, 0.5235987755982988 * p27);
        end);
    end;

    local WheelOfIsagi = LocalPlayer.PlayerGui:WaitForChild("WheelOfIsagi");
    local HUD = LocalPlayer.PlayerGui:WaitForChild("HUD");
    local Main = WheelOfIsagi.WheelFrame.Main;
    u25.bg = Main.Wheel.BG;
    local Main2 = Main.SpinButtons.FreeSpin.Main;
    local Main3 = Main.SpinButtons.Spin3.Main;
    local Main4 = Main.SpinButtons.Spin10.Main;
    local FastSpin = Main.FastSpin;
    local Close = Main.Close;
    local _ = WheelOfIsagi.BlackBG;
    RngUtil.ConvertToWeightMap(SpinWheelData.Rewards, function(p28, p29) -- Line: 132
        return p28, p29[2];
    end);
    Main2.Activated:Connect(function() -- Line: 137
        -- upvalues: u2 (ref), Service (copy), u3 (ref)
        if u2 then
            return;
        end;

        Service:Spin(u3);
    end);
    Main3.Activated:Connect(function() -- Line: 143
        -- upvalues: u2 (ref), Main3 (copy), MarketplaceService (ref), LocalPlayer (ref)
        if u2 then
            return;
        end;

        local Attribute = Main3:GetAttribute("ID");

        if Attribute then
            MarketplaceService:PromptProductPurchase(LocalPlayer, Attribute);
        end;
    end);
    Main4.Activated:Connect(function() -- Line: 151
        -- upvalues: u2 (ref), Main4 (copy), MarketplaceService (ref), LocalPlayer (ref)
        if u2 then
            return;
        end;

        local Attribute = Main4:GetAttribute("ID");

        if Attribute then
            MarketplaceService:PromptProductPurchase(LocalPlayer, Attribute);
        end;
    end);
    local Enabled1 = FastSpin:FindFirstChild("Enabled1");
    local Disabled1 = FastSpin:FindFirstChild("Disabled1");

    local function updateFastSpinUI() -- Line: 163
        -- upvalues: u3 (ref), Enabled1 (copy), Disabled1 (copy)
        if u3 then
            Enabled1.Enabled = true;
            Disabled1.Enabled = false;

            return;
        end;

        Enabled1.Enabled = false;
        Disabled1.Enabled = true;
    end;

    FastSpin.Activated:Connect(function() -- Line: 173
        -- upvalues: PlayerData (ref), SpinWheelData (ref), u3 (ref), Enabled1 (copy), Disabled1 (copy), FastSpin (copy), MarketplaceService (ref), LocalPlayer (ref)
        if not PlayerData:TryIndex({ "WheelOfFortune", SpinWheelData.WheelName, "FastSpin" }) then
            local Attribute = FastSpin:GetAttribute("ID");

            if Attribute then
                MarketplaceService:PromptProductPurchase(LocalPlayer, Attribute);
            end;

            return;
        end;

        u3 = not u3;

        if u3 then
            Enabled1.Enabled = true;
            Disabled1.Enabled = false;

            return;
        end;

        Enabled1.Enabled = false;
        Disabled1.Enabled = true;
    end);
    PlayerData:Observe({ "WheelOfFortune", SpinWheelData.WheelName, "FastSpin" }, function(p30) -- Line: 186
        -- upvalues: u3 (ref), Enabled1 (copy), Disabled1 (copy)
        if p30 then
            u3 = true;
        else
            u3 = false;
        end;

        if u3 then
            Enabled1.Enabled = true;
            Disabled1.Enabled = false;

            return;
        end;

        Enabled1.Enabled = false;
        Disabled1.Enabled = true;
    end);
    Close.Activated:Connect(function() -- Line: 196
        -- upvalues: WheelOfIsagi (copy), HUD (copy)
        WheelOfIsagi.Enabled = false;
        HUD.Enabled = true;
    end);
    Service.SpinResults:Connect(function(p31) -- Line: 202
        -- upvalues: u3 (ref), u1 (ref)
        u1:Spin(p31.prize, u3 and 2 or 6);
    end);
    task.spawn(function() -- Line: 208
        -- upvalues: WheelOfIsagi (copy), HUD (copy)
        workspace:WaitForChild("GameObjects"):WaitForChild("LobbyNPCs"):WaitForChild("WheelOfIsagi").Rig.HumanoidRootPart.ProximityPrompt.Triggered:Connect(function() -- Line: 211
            -- upvalues: WheelOfIsagi (ref), HUD (ref)
            WheelOfIsagi.Enabled = true;
            HUD.Enabled = false;
        end);
    end);
    local WheelName = SpinWheelData.WheelName;
    PlayerData:Observe({ "WheelOfFortune", WheelName, "Tokens" }, function(p32) -- Line: 219
        -- upvalues: Main2 (copy)
        Main2.Title.Text = "Spin (" .. (p32 or 0) .. ")";
    end);
    task.spawn(function() -- Line: 225
        -- upvalues: u2 (ref), u25 (copy)
        while true do
            local v33;

            repeat
                v33 = task.wait();
            until not u2;

            u25.bg.Rotation = (u25.bg.Rotation + v33 * 20) % 360;
        end;
    end);
    local Service2 = KnitClient.GetService("WheelOfIsagiQuestsService");
    local WheelQuest = LocalPlayer.PlayerGui:WaitForChild("WheelQuest");
    local Frame = WheelQuest.Frame;
    local Options = Frame.Options;
    local Template = Options.Template;
    local Refresh = Options.Refresh;
    local Exit = Frame.Exit;
    local Main5 = Main.Parent.Quests.Main;
    Template.Visible = false;
    Refresh.Visible = false;
    local u34 = {};
    local u35 = "";
    local ImageColor3 = Template.Claim.ImageColor3;
    local Color3_fromRGB_ret = Color3.fromRGB(130, 130, 130);

    local function clearQuestFrames() -- Line: 253
        -- upvalues: u34 (copy)
        for _, v in u34 do
            if v.instance then
                v.instance:Destroy();
            end;

            if v.timerConnection then
                v.timerConnection:Disconnect();
            end;
        end;

        table.clear(u34);
    end;

    local function getQuestDisplayText(p36, p37) -- Line: 265
        -- upvalues: SpinWheelData (ref), FormatNumber (ref)
        local v38 = SpinWheelData.Quests[p36];

        if not v38 then
            return "";
        end;

        if p36 == "Playtime" then
            return string.gsub(v38.Display, "X", FormatNumber.AdaptiveClockString(p37));
        end;

        return string.gsub(v38.Display, "X", (tostring(p37)));
    end;

    local function getQuestProgressText(p39, p40, p41) -- Line: 275
        -- upvalues: FormatNumber (ref)
        if p39 == "Playtime" then
            return FormatNumber.AdaptiveClockString(p40) .. "/" .. FormatNumber.AdaptiveClockString(p41);
        end;

        return p40 .. "/" .. p41;
    end;

    local function getQuestStructureKey(p42) -- Line: 283
        if not p42 then
            return "";
        end;

        local v43 = {};

        for i, v in p42 do
            local v44 = i .. ":" .. tostring(v.Claimed);
            table.insert(v43, v44);
        end;

        table.sort(v43);

        return table.concat(v43, ",");
    end;

    local function updateQuestProgress() -- Line: 293
        -- upvalues: PlayerData (ref), WheelName (copy), u34 (copy), FormatNumber (ref), ImageColor3 (copy)
        local v45 = PlayerData:TryIndex({ "WheelOfFortune", WheelName, "Quests" });

        if not v45 then
            return;
        end;

        for i, v in v45 do
            local v46 = u34[i];

            if v46 and (v46.instance and not v.Claimed) then
                local instance = v46.instance;
                local math_min_ret = math.min(v.Progress, v.Goal);
                local TextLabel = instance.ExpBar.TextLabel;
                local Goal = v.Goal;
                local v47;

                if i == "Playtime" then
                    v47 = FormatNumber.AdaptiveClockString(math_min_ret) .. "/" .. FormatNumber.AdaptiveClockString(Goal);
                else
                    v47 = math_min_ret .. "/" .. Goal;
                end;

                TextLabel.Text = v47;
                instance.ExpBar.Frame.Size = UDim2.new(math.clamp(math_min_ret / v.Goal, 0, 1), 0, 1, 0);

                if v.Goal <= math_min_ret then
                    instance.Claim.Label.Text = "CLAIM";
                    instance.Claim.ImageColor3 = ImageColor3;
                end;
            end;
        end;
    end;

    local function createActiveQuest(u48, u49) -- Line: 315
        -- upvalues: Template (copy), getQuestDisplayText (copy), SpinWheelData (ref), FormatNumber (ref), Color3_fromRGB_ret (copy), Service2 (copy), Options (copy)
        local v50 = Template:Clone();
        v50.Name = u48;
        v50.Visible = true;
        v50.QuestName.Text = getQuestDisplayText(u48, u49.Goal);
        v50["100XP"].Text = SpinWheelData.TokensPerQuest .. " SPIN";
        local math_min_ret = math.min(u49.Progress, u49.Goal);
        local TextLabel = v50.ExpBar.TextLabel;
        local Goal = u49.Goal;
        local v51;

        if u48 == "Playtime" then
            v51 = FormatNumber.AdaptiveClockString(math_min_ret) .. "/" .. FormatNumber.AdaptiveClockString(Goal);
        else
            v51 = math_min_ret .. "/" .. Goal;
        end;

        TextLabel.Text = v51;
        v50.ExpBar.Frame.Size = UDim2.new(math.clamp(math_min_ret / u49.Goal, 0, 1), 0, 1, 0);
        local v52;

        if u49.Goal <= math_min_ret then
            v52 = not u49.Claimed;
        else
            v52 = false;
        end;

        if v52 then
            v50.Claim.Label.Text = "CLAIM";
        else
            v50.Claim.Label.Text = "IN PROGRESS";
            v50.Claim.ImageColor3 = Color3_fromRGB_ret;
        end;

        v50.Claim.Activated:Connect(function() -- Line: 335
            -- upvalues: u49 (copy), Service2 (ref), u48 (copy)
            if u49.Progress < u49.Goal then
                return;
            end;

            if u49.Claimed then
                return;
            end;

            Service2:ClaimQuest(u48);
        end);
        v50.Parent = Options;

        return v50;
    end;

    local function createRefreshQuest(u53, u54) -- Line: 345
        -- upvalues: Refresh (copy), Service2 (copy), MarketplaceService (ref), LocalPlayer (ref), Options (copy), RunService (ref), SpinWheelData (ref), FormatNumber (ref)
        local u55 = Refresh:Clone();
        u55.Name = u53;
        u55.Visible = true;

        for _, child in u55:GetChildren() do
            if child:IsA("TextLabel") and child.Name == "QuestName" then
                if child.Position.Y.Scale < 0.3 then
                    child.Text = "REFRESHES IN...";
                else
                    child.Text = "...";
                end;
            end;
        end;

        u55.RefreshNow.Activated:Connect(function() -- Line: 360
            -- upvalues: Service2 (ref), u53 (copy), MarketplaceService (ref), LocalPlayer (ref)
            Service2:SetPendingRefresh(u53);
            MarketplaceService:PromptProductPurchase(LocalPlayer, 3551508238);
        end);
        u55.Parent = Options;

        return u55, RunService.Heartbeat:Connect(function() -- Line: 366
            -- upvalues: u54 (copy), SpinWheelData (ref), u55 (copy), FormatNumber (ref)
            if not u54.RefreshTimer then
                return;
            end;

            local v56 = u54.RefreshTimer + SpinWheelData.QuestResetTime - DateTime.now().UnixTimestamp;
            local math_max_ret = math.max(0, v56);

            for _, child in u55:GetChildren() do
                if child:IsA("TextLabel") and (child.Name == "QuestName" and child.Position.Y.Scale > 0.3) then
                    child.Text = FormatNumber.AdaptiveClockString(math_max_ret);
                end;
            end;
        end);
    end;

    local function buildQuests() -- Line: 379
        -- upvalues: clearQuestFrames (copy), PlayerData (ref), WheelName (copy), createRefreshQuest (copy), u34 (copy), createActiveQuest (copy), u35 (ref), getQuestStructureKey (copy)
        clearQuestFrames();
        local v57 = PlayerData:TryIndex({ "WheelOfFortune", WheelName, "Quests" });

        if not v57 then
            return;
        end;

        for i, v in v57 do
            if v.Claimed then
                local v58, v59 = createRefreshQuest(i, v);
                u34[i] = {
                    instance = v58,
                    timerConnection = v59
                };
            else
                u34[i] = {
                    instance = createActiveQuest(i, v)
                };
            end;
        end;

        u35 = getQuestStructureKey(v57);
    end;

    buildQuests();
    PlayerData:Observe({ "WheelOfFortune", WheelName, "Quests" }, function(p60) -- Line: 399
        -- upvalues: getQuestStructureKey (copy), u35 (ref), updateQuestProgress (copy), buildQuests (copy)
        if getQuestStructureKey(p60) == u35 then
            updateQuestProgress();

            return;
        end;

        buildQuests();
    end);
    Main5.Activated:Connect(function() -- Line: 408
        -- upvalues: WheelOfIsagi (copy), WheelQuest (copy)
        WheelOfIsagi.Enabled = false;
        WheelQuest.Enabled = true;
    end);
    Exit.Activated:Connect(function() -- Line: 413
        -- upvalues: WheelQuest (copy), WheelOfIsagi (copy), HUD (copy)
        WheelQuest.Enabled = false;
        WheelOfIsagi.Enabled = true;
        HUD.Enabled = false;
    end);
    LocalPlayer.PlayerGui.InGameUI:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 419
        -- upvalues: LocalPlayer (ref), WheelOfIsagi (copy), WheelQuest (copy)
        if not LocalPlayer.PlayerGui.InGameUI.Enabled then
            return;
        end;

        WheelOfIsagi.Enabled = false;
        WheelQuest.Enabled = false;
    end);
end;

return u1;