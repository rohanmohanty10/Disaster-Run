 
 

local CollectionService = game:GetService("CollectionService");
local HttpService = game:GetService("HttpService");
local Lighting = game:GetService("Lighting");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("ServerScriptService");
game:GetService("ServerStorage");
local MarketplaceService = game:GetService("MarketplaceService");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local RunService2 = game:GetService("RunService");
local SoundService = game:GetService("SoundService");
local StarterGui = game:GetService("StarterGui");
local TextChatService = game:GetService("TextChatService");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
game:GetService("Teams");
game:GetService("ProximityPromptService");
local GroupService = game:GetService("GroupService");
local PolicyService = game:GetService("PolicyService");
game:GetService("EncodingService");
local UserService = game:GetService("UserService");
local RenderStepped = RunService.RenderStepped;
local query = require(ReplicatedStorage2:WaitForChild("query"));
local Quests = require(ReplicatedStorage.Quests);
local ChatWindowConfiguration = TextChatService.ChatWindowConfiguration;
local workspace_CurrentCamera = workspace.CurrentCamera;
local script_settingFunctions = script.settingFunctions;
local PassClient = require(ReplicatedStorage2.util.PassClient);
local TopbarIcon = require(ReplicatedStorage.TopbarIcon);
local Mode = require(script_settingFunctions.graphicsMode.Mode);
local replication = require(ReplicatedStorage2.client.replication);
local soundUtil = require(ReplicatedStorage2.util.soundUtil);
local actionUtil = require(ReplicatedStorage2.util.actionUtil);
local raycast = require(ReplicatedStorage2.util.raycast);
local Util = require(ReplicatedStorage2.util.Util);
local animationUtil = require(ReplicatedStorage2.util.animationUtil);
local Draw = require(ReplicatedStorage2.util.hitbox.Draw);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local FuzzySearch = require(ReplicatedStorage.forum.FuzzySearch);
local trove = require(ReplicatedStorage2.forum.trove);
local fastSignal = require(ReplicatedStorage2.forum.fastSignal);
local packets = require(ReplicatedStorage2.packets);
local wiki = require(ReplicatedStorage2.wiki);
wiki.init();
local Mastery = require(ReplicatedStorage.Mastery);
local emoteWiki = require(ReplicatedStorage2.emoteWiki);
local script_sensitivityCamera = require(script.sensitivityCamera);
local baseClient = require(script.Parent.baseClient);
require(ReplicatedStorage2:WaitForChild("shiftlockSettings"));
local GamepadContainer = require(ReplicatedStorage2.client.GamepadContainer);
local Observers = require(ReplicatedStorage.forum.Observers);
local CountriesToRegion = require(ReplicatedStorage.CountriesToRegion);
local Ranks = require(ReplicatedStorage.RankedUtil.Ranks);
local script_RankedHelpers = require(script.RankedHelpers);
local Club = require(ReplicatedStorage2.Club);
local script_LimitedPreview = require(script.LimitedPreview);
local script_map_replacings = require(script.map_replacings);
local u1 = os.clock() - 1000;
local u2 = tick() - 2;
local script_Settings = require(script.Settings);
local script_customFlowBars = require(script.customFlowBars);
local script_customHotbars = require(script.customHotbars);
local u3 = {};
u3.__index = u3;
local u4 = {};
local u5 = { "High", "Low", "Potato" };
local u6 = {
    Emotes = 2500,
    Titles = 1000,
    MVPs = 5000,
    Styles = { 125000, 100000, 75000, 25000, 500 },
    GoalEffects = { 75000, 50000, 25000, 10000 }
};
local u7 = 10800;
local u8 = { "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg" };

for _, child in ReplicatedStorage2.Achievements:GetChildren() do
    if child:IsA("ModuleScript") then
        u4[child.Name] = require(child);
    end;
end;

local function getGamepadButtonName(p9) -- Line: 135
    -- upvalues: UserInputService (copy)
    return UserInputService:GetStringForKeyCode(p9):gsub("^Button", "");
end;

local _ = {
    [Enum.KeyCode.ButtonY] = "rbxassetid://80556398884903",
    [Enum.KeyCode.ButtonX] = "rbxassetid://101120336622213",
    [Enum.KeyCode.ButtonB] = "rbxassetid://71989683887881",
    [Enum.KeyCode.DPadUp] = "rbxassetid://117415222124830",
    [Enum.KeyCode.DPadRight] = "rbxassetid://133741850183197",
    [Enum.KeyCode.DPadDown] = "rbxassetid://104918130678523",
    [Enum.KeyCode.DPadLeft] = "rbxassetid://132409386287838",
    [Enum.KeyCode.ButtonL3] = "rbxassetid://102080202293059"
};
shared.AwaitingUnholdForMobile = {};
u3.cachedKeybinds = {
    kick = "MouseButton1",
    dash = "Q",
    drib = "E",
    modetoggle = "E",
    throwGoal = "T",
    givmeBall = "R",
    superDash = "F",
    skill1 = "One",
    skill2 = "Two",
    skill3 = "Three",
    skill4 = "Four",
    skill5 = "Five",
    baseAwaken = "G",
    Emote = "B"
};
local u10 = { "modetoggle" };
local u11 = {};
local u12 = {};
local u20 = {
    kick = {
        Start = function(p13) -- Line: 194, Name: Start
            p13.actived = true;

            while p13.actived and not game:GetService("GuiService").MenuIsOpen do
                p13.baseClient:use("kick");
                task.wait(0.016666666666666666);
            end;
        end,

        End = function(p14) -- Line: 203, Name: End
            p14.actived = false;
        end
    },
    Default = {
        Start = function(p15, p16) -- Line: 208, Name: Start
            -- upvalues: u10 (copy)
            if p15.player:GetAttribute("BeingControlledBy") then
                return;
            end;

            p15.baseClient:use(p16, table.find(u10, p16) ~= nil);
        end
    },
    Emote = {
        Start = function(p17) -- Line: 217, Name: Start
            p17:Emote();
        end
    },
    throwGoal = {
        Start = function(p18) -- Line: 222, Name: Start
            -- upvalues: actionUtil (copy), replication (copy)
            local Role = actionUtil.getRole(p18.character);

            if actionUtil.checkGK(p18.character) or Role == "GK" and p18.character:GetAttribute("RinNoPlay") then
                p18.baseClient:use("throwGoal");

                return;
            end;

            p18.holdingSpecial = replication.isHoldSpecial();
            p18.baseClient:use("Tspecialer", true);
        end,

        End = function(p19) -- Line: 232, Name: End
            if p19.holdingSpecial then
                p19.holdingSpecial = false;
                p19.baseClient:senduse({ "Tspecialer", false });
            end;
        end
    }
};

for _, v in Enum.KeyCode:GetEnumItems() do
    u11[v.Name] = true;
end;

for _, v in Enum.UserInputType:GetEnumItems() do
    u12[v.Name] = true;
end;

local function customkeybinds_updateFromServer(p21) -- Line: 252
    -- upvalues: u3 (copy)
    local Children = p21:GetChildren();
    local cachedKeybinds = u3.cachedKeybinds;

    for _, v in Children do
        cachedKeybinds[v.Name] = v.Value;
    end;
end;

local function deepCopy(p22) -- Line: 261
    -- upvalues: deepCopy (copy)
    if typeof(p22) ~= "table" then
        return p22;
    end;

    local v23 = {};

    for i, v in pairs(p22) do
        v23[i] = deepCopy(v);
    end;

    return v23;
end;

local function PolicyCheck(u24) -- Line: 270
    -- upvalues: PolicyService (copy), Players (copy), replication (copy), ReplicatedStorage2 (copy)
    local success, result = pcall(function() -- Line: 271
        -- upvalues: PolicyService (ref), u24 (copy), Players (ref)
        return PolicyService:GetPolicyInfoForPlayerAsync(u24 or Players.LocalPlayer);
    end);
    local v25 = success and not result.ArePaidRandomItemsRestricted and true or false;

    if not v25 then
        replication.notification("This feature is blacklisted in your region, or this is an error.", Color3.fromRGB(255, 0, 0), ReplicatedStorage2.Resources.notisound);
    end;

    return v25;
end;

local function controller_updateFromServer(p26) -- Line: 286
    -- upvalues: GamepadContainer (copy)
    local v27 = GamepadContainer;

    for _, child in p26:GetChildren() do
        local v28 = tonumber(child.Name);
        local v29 = Enum.KeyCode:FromValue(child.Value);

        if v27[v28] then
            v27[v28].KeyCode = v29;
        end;
    end;
end;

local Random_new_ret = Random.new();

local function random(p30, p31) -- Line: 303
    -- upvalues: Random_new_ret (copy)
    return Random_new_ret:NextNumber(p30, p31);
end;

function countryCodeToEmoji(p32)
    local v33 = p32:upper();
    local v34 = v33:sub(1, 1);
    local v35 = v33:sub(2, 2);

    return utf8.char(127462 + (v34:byte() - 65)) .. utf8.char(127462 + (v35:byte() - 65));
end;

function convertToHMS(p36)
    local v37 = (p36 - p36 % 60) / 60;

    return string.format("%02i", v37 - (v37 - v37 % 60) / 60 * 60) .. ":" .. string.format("%02i", p36 - v37 * 60);
end;

local u38 = {
    Winter25 = {
        skip = 3483662052,
        premium = 3483663288,
        skip_all = 3484451609
    }
};

local function show_odds(p39, p40, p41) -- Line: 338
    -- upvalues: Players (copy)
    if Players.LocalPlayer.PlayerGui:FindFirstChild("Odds") then
        pcall(game.Destroy, Players.LocalPlayer.PlayerGui:FindFirstChild("Odds"));
    end;

    local u42 = script.Odds:Clone();
    local DropTemplate = u42.DropTemplate;
    local v43 = 0;

    for i, v in p39 do
        local v44 = DropTemplate:Clone();
        v44.Parent = u42;
        v44.Name = i;
        v44.title.Text = v.title;
        v44.odds.Text = v.odds;
        v44.Parent = u42.Frame.Product;
        v44.Visible = true;
        v43 = v43 + 1;
    end;

    if v43 == 0 then
        u42.Frame.Product.Nothing.title.Text = string.format(u42.Frame.Product.Nothing.title.Text, p41);
        u42.Frame.Product.Nothing.Visible = true;
    end;

    u42.Frame.title.Text = p40 or u42.Frame.title.Text;
    u42.Parent = Players.LocalPlayer.PlayerGui;
    u42.Frame.CloseButton.Activated:Once(function() -- Line: 368
        -- upvalues: u42 (copy)
        pcall(game.Destroy, u42);
    end);
end;

local function show_odds_grouped(p45, p46, p47) -- Line: 374
    -- upvalues: Players (copy)
    if Players.LocalPlayer.PlayerGui:FindFirstChild("Odds") then
        pcall(game.Destroy, Players.LocalPlayer.PlayerGui:FindFirstChild("Odds"));
    end;

    local u48 = script.Odds:Clone();
    local DropTemplate = u48.DropTemplate;
    local v49 = {};
    local v50 = 0;
    local v51 = 0;

    for i, v in p45 do
        local v52 = DropTemplate:Clone();
        v52.Parent = u48;
        v52.Name = i;
        v52.title.Text = v.title;
        v52.odds.Text = v.odds;

        if v49[v.groups] then
            v52.LayoutOrder = v49[v.groups];
        else
            v51 = v51 + 2;
            v49[v.groups] = v51;
            v52.LayoutOrder = v51;
            local v53 = u48.TierTitle:Clone();
            v53.LayoutOrder = v49[v.groups] - 1;
            v53.title.Text = string.format("%s - %s", v.groups, (tostring(v.group_odds)));
            v53.Parent = u48.Frame.Product;
            v53.Visible = true;
        end;

        v52.Parent = u48.Frame.Product;
        v52.Visible = true;
        v50 = v50 + 1;
    end;

    if v50 == 0 then
        u48.Frame.Product.Nothing.title.Text = string.format(u48.Frame.Product.Nothing.title.Text, p47);
        u48.Frame.Product.Nothing.Visible = true;
    end;

    u48.Frame.title.Text = p46 or u48.Frame.title.Text;
    u48.Parent = Players.LocalPlayer.PlayerGui;
    u48.Frame.CloseButton.Activated:Once(function() -- Line: 421
        -- upvalues: u48 (copy)
        pcall(game.Destroy, u48);
    end);
end;

local function check_type(u54: string) -- Line: 426
    local u55 = nil;
    local u56 = false;
    local u57 = nil;

    return pcall(function() -- Line: 431
        -- upvalues: u54 (copy), u56 (ref), u55 (ref), u57 (ref)
        local buffer_fromstring_ret = buffer.fromstring(u54);
        local success, _ = pcall(function() -- Line: 434
            -- upvalues: buffer_fromstring_ret (ref)
            buffer_fromstring_ret = game:GetService("EncodingService"):Base64Decode(buffer_fromstring_ret);
        end);

        if success then
            local _, _ = pcall(function() -- Line: 439
                -- upvalues: buffer_fromstring_ret (ref)
                buffer_fromstring_ret = game:GetService("EncodingService"):DecompressBuffer(buffer_fromstring_ret, Enum.CompressionAlgorithm.Zstd);
            end);
        end;

        local success2, result = pcall(function() -- Line: 444
            -- upvalues: buffer_fromstring_ret (ref)
            return game:GetService("HttpService"):JSONDecode(buffer.tostring(buffer_fromstring_ret));
        end);

        if success2 then
            u56 = true;
            u55 = u54;
            u57 = result;
        else
            local success3, result2 = pcall(function() -- Line: 453
                -- upvalues: u54 (ref)
                return game:GetService("HttpService"):JSONDecode(u54);
            end);

            if success3 then
                u57 = result2;
                local buffer_fromstring_ret2 = buffer.fromstring(u54);
                local _, _ = pcall(function() -- Line: 462
                    -- upvalues: buffer_fromstring_ret2 (ref)
                    buffer_fromstring_ret2 = game:GetService("EncodingService"):CompressBuffer(buffer_fromstring_ret2, Enum.CompressionAlgorithm.Zstd);
                end);
                local _, _ = pcall(function() -- Line: 466
                    -- upvalues: buffer_fromstring_ret2 (ref)
                    buffer_fromstring_ret2 = game:GetService("EncodingService"):Base64Encode(buffer_fromstring_ret2);
                end);
                u55 = buffer.tostring(buffer_fromstring_ret2);
            end;
        end;

        return u56, u55, u54, u57;
    end);
end;

function u3.new() -- Line: 478
    -- upvalues: Players (copy), u3 (copy), baseClient (ref), ReplicatedStorage2 (copy), vfxUtil (copy), packets (copy), UserInputService (copy), RunService2 (copy), u8 (copy), actionUtil (copy), Lighting (copy), Mode (copy), u5 (copy), RunService (copy), script_settingFunctions (copy), script_map_replacings (copy), ReplicatedStorage (copy), TopbarIcon (copy), replication (copy), TweenService (copy), StarterGui (copy), Quests (copy), wiki (copy), soundUtil (copy), SoundService (copy), query (copy), script_sensitivityCamera (copy), Observers (copy), trove (copy), GroupService (copy), script_RankedHelpers (copy)
    local LocalPlayer = Players.LocalPlayer;
    local u58 = setmetatable({}, u3);
    baseClient = baseClient.new(u58);
    u58.player = LocalPlayer;
    u58.playerGui = LocalPlayer.PlayerGui;
    u58.actived = false;
    u58.inputs = {};
    u3.metatable = u58;
    local Folder = Instance.new("Folder");
    Folder.Name = "Hell";
    Folder.Parent = ReplicatedStorage2;
    workspace.Effects.ChildAdded:Connect(function(p59) -- Line: 493
        -- upvalues: vfxUtil (ref), Players (ref), Folder (copy)
        if not vfxUtil.IsSettingOn(Players.LocalPlayer, "NoVFXAtAll") then
            return;
        end;

        if typeof(p59) ~= "Instance" then
            return;
        end;

        if p59:GetAttribute("IgnoresTheKid") then
            return;
        end;

        p59.Parent = Folder;
    end);
    packets.bytenet_voting.listen(function(p60) -- Line: 502
        -- upvalues: u58 (copy), LocalPlayer (copy)
        if p60 == "END IT" then
            print("destroyed containers");
            u58:destroyContainer();

            return;
        end;

        print("listened to bytenet");

        if not LocalPlayer.Character then
            LocalPlayer.CharacterAdded:Wait();
        end;

        print("character existed and character was waited for");
        u58:votingUI(p60);
        print("went through voting");
    end);
    u58.soccerState = ReplicatedStorage2:WaitForChild("workspace");
    u58.playerModule = require(LocalPlayer.PlayerScripts.PlayerModule);
    u58.isGamepad = UserInputService.GamepadEnabled;
    u58.isTouchEnabled = UserInputService.TouchEnabled;
    u58.isKeyboard = UserInputService.KeyboardEnabled;
    u58.storage = LocalPlayer:WaitForChild("storage");
    u58.emote = LocalPlayer:WaitForChild("emote");
    u58.leaderstats = LocalPlayer:WaitForChild("leaderstats");
    u58.setting = LocalPlayer:WaitForChild("setting");
    local ClockTime = u58.setting:WaitForChild("ClockTime");
    local TableSoccer = u58.setting:WaitForChild("TableSoccer");
    local HurtboxSync = u58.setting:WaitForChild("HurtboxSync");
    local u61 = nil;
    local u62 = nil;

    local function manage_hurtboxsync() -- Line: 534
        -- upvalues: HurtboxSync (copy), u61 (ref), RunService2 (ref), u58 (copy)
        if HurtboxSync.Value then
            u61 = RunService2.PreRender:Connect(function(p63) -- Line: 536
                -- upvalues: u58 (ref)
                for _, child in workspace.characters:GetChildren() do
                    if child ~= u58.player.Character and not child:GetAttribute("frozen") then
                        local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart");
                        local Attribute = child:GetAttribute("HitboxId");

                        if HumanoidRootPart and (Attribute and (workspace:FindFirstChild("Effects") and workspace:FindFirstChild("Effects"):FindFirstChild("HitboxVisuals"))) then
                            local HitboxVisuals = workspace:FindFirstChild("Effects"):FindFirstChild("HitboxVisuals");

                            if HitboxVisuals:FindFirstChild(Attribute) and not HumanoidRootPart.Anchored then
                                local v64 = HitboxVisuals:FindFirstChild(Attribute).CFrame * CFrame.new(0, 0.5, 0);
                                local v65, v66, v67 = v64:ToEulerAnglesYXZ();
                                HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position:Lerp(v64.Position, 55 * p63)) * CFrame.fromEulerAnglesYXZ(v65, v66, v67);
                            end;
                        end;
                    end;
                end;
            end);

            return;
        end;

        if u61 then
            u61:Disconnect();
            u61 = nil;
        end;
    end;

    if HurtboxSync.Value then
        if HurtboxSync.Value then
            u61 = RunService2.PreRender:Connect(function(p68) -- Line: 536
                -- upvalues: u58 (copy)
                for _, child in workspace.characters:GetChildren() do
                    if child ~= u58.player.Character and not child:GetAttribute("frozen") then
                        local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart");
                        local Attribute = child:GetAttribute("HitboxId");

                        if HumanoidRootPart and (Attribute and (workspace:FindFirstChild("Effects") and workspace:FindFirstChild("Effects"):FindFirstChild("HitboxVisuals"))) then
                            local HitboxVisuals = workspace:FindFirstChild("Effects"):FindFirstChild("HitboxVisuals");

                            if HitboxVisuals:FindFirstChild(Attribute) and not HumanoidRootPart.Anchored then
                                local v69 = HitboxVisuals:FindFirstChild(Attribute).CFrame * CFrame.new(0, 0.5, 0);
                                local v70, v71, v72 = v69:ToEulerAnglesYXZ();
                                HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position:Lerp(v69.Position, 55 * p68)) * CFrame.fromEulerAnglesYXZ(v70, v71, v72);
                            end;
                        end;
                    end;
                end;
            end);
        elseif u61 then
            u61:Disconnect();
            u61 = nil;
        end;
    end;

    HurtboxSync.Changed:Connect(manage_hurtboxsync);

    local function fixallsoccerers(p73) -- Line: 570
        -- upvalues: u8 (ref)
        for _, child in workspace.characters:GetChildren() do
            if not table.find(p73, child) then
                local Humanoid = child:FindFirstChild("Humanoid");

                if Humanoid then
                    Humanoid.RequiresNeck = false;

                    if child:FindFirstChild("Torso") then
                        for _, child2 in child:FindFirstChild("Torso"):GetChildren() do
                            if child2:IsA("Weld") and child2.Name == "(tablesoccer)" then
                                pcall(game.Destroy, child2);
                            end;

                            if child2:IsA("Motor6D") and (table.find(u8, child2.Part1.Name) and not child2.Enabled) then
                                child2.Enabled = true;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    if TableSoccer.Value then
        u62 = RunService2.Heartbeat:Connect(function() -- Line: 595
            -- upvalues: actionUtil (ref), u58 (copy), fixallsoccerers (copy), u8 (ref)
            local v74 = actionUtil.checkGK(u58.character) and not actionUtil.checkball(u58.character);

            if v74 then
                fixallsoccerers({ u58.character });

                return;
            end;

            for _, child in workspace.characters:GetChildren() do
                local Humanoid = child:FindFirstChild("Humanoid");

                if Humanoid then
                    Humanoid.RequiresNeck = false;

                    if child:FindFirstChild("Torso") then
                        for _, child2 in child:FindFirstChild("Torso"):GetChildren() do
                            if child2:IsA("Motor6D") and (table.find(u8, child2.Part1.Name) and child2.Enabled) then
                                local Weld = Instance.new("Weld");
                                Weld.C0 = child2.C0;
                                Weld.C1 = child2.C1;
                                Weld.Part0 = child2.Part0;
                                Weld.Part1 = child2.Part1;
                                Weld.Parent = child2.Parent;
                                Weld.Name = "(tablesoccer)";
                                child2.Enabled = false;
                            end;
                        end;
                    end;
                end;
            end;
        end);
    end;

    TableSoccer:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 627
        -- upvalues: TableSoccer (copy), u62 (ref), fixallsoccerers (copy), RunService2 (ref), actionUtil (ref), u58 (copy), u8 (ref)
        if not TableSoccer.Value then
            if u62 then
                u62:Disconnect();
                fixallsoccerers({});
            end;

            return;
        end;

        if u62 then
            u62:Disconnect();
            fixallsoccerers({});
        end;

        u62 = RunService2.Heartbeat:Connect(function() -- Line: 633
            -- upvalues: actionUtil (ref), u58 (ref), fixallsoccerers (ref), u8 (ref)
            local v75 = actionUtil.checkGK(u58.character) and not actionUtil.checkball(u58.character);

            if v75 then
                fixallsoccerers({ u58.character });

                return;
            end;

            for _, child in workspace.characters:GetChildren() do
                local Humanoid = child:FindFirstChild("Humanoid");

                if Humanoid then
                    Humanoid.RequiresNeck = false;

                    if child:FindFirstChild("Torso") then
                        for _, child2 in child:FindFirstChild("Torso"):GetChildren() do
                            if child2:IsA("Motor6D") and (table.find(u8, child2.Part1.Name) and child2.Enabled) then
                                local Weld = Instance.new("Weld");
                                Weld.C0 = child2.C0;
                                Weld.C1 = child2.C1;
                                Weld.Part0 = child2.Part0;
                                Weld.Part1 = child2.Part1;
                                Weld.Parent = child2.Parent;
                                Weld.Name = "(tablesoccer)";
                                child2.Enabled = false;
                            end;
                        end;
                    end;
                end;
            end;
        end);
    end);
    ClockTime:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 671
        -- upvalues: u58 (copy), Lighting (ref), ClockTime (copy)
        if u58.soccerState.overtime.Value then
            return;
        end;

        Lighting.ClockTime = ClockTime.Value;
    end);
    u58.consoleDirection = "Forward";
    u58.baseClient = baseClient;
    u58.holdStartTime = 0;
    u58.fakePlayerParts = {};
    u58.latestCFrame = {};
    u58.currentEmotePage = 1;
    u58.currentOpenEmoteUIPage = u58.emote;
    u58.currentPass = "Winter25";
    u58.passData = {};
    packets.bytenet_getCurrentPassRewards.listen(function(p76) -- Line: 695
        -- upvalues: u58 (copy)
        u58.passData = p76;
    end);
    packets.bytenet_getCurrentPassRewards.send();
    UserInputService.GamepadConnected:Connect(function() -- Line: 701
        -- upvalues: u58 (copy)
        u58.isGamepad = true;
    end);
    UserInputService.GamepadDisconnected:Connect(function() -- Line: 704
        -- upvalues: u58 (copy)
        u58.isGamepad = false;
    end);

    if u58.setting:FindFirstChild("graphicsMode") and u58.setting.graphicsMode.Value ~= 1 then
        Mode[u5[u58.setting.graphicsMode.Value]]();
    end;

    u58.setting:WaitForChild("FPS"):GetPropertyChangedSignal("Value"):Connect(function() -- Line: 712
        -- upvalues: u58 (copy)
        u58:showFPS();
    end);
    u58.setting:WaitForChild("ServerAge"):GetPropertyChangedSignal("Value"):Connect(function() -- Line: 716
        -- upvalues: u58 (copy)
        u58:showServerAge();
    end);
    u58.setting:WaitForChild("ServerLocation"):GetPropertyChangedSignal("Value"):Connect(function() -- Line: 720
        -- upvalues: RunService (ref), u58 (copy)
        if RunService:IsStudio() then
            warn("region not shown");

            return;
        end;

        u58:showServerLocation();
    end);
    u58.setting:WaitForChild("Style&MVP"):GetPropertyChangedSignal("Value"):Connect(function() -- Line: 729
        -- upvalues: u58 (copy)
        u58:showStyleMVP();
    end);
    require(script_settingFunctions.crowdAudio)(u58);
    require(script.muteOtherEmoteSounds)(u58);
    require(script.rolandLobbyTheme)(u58);
    workspace:SetAttribute("PotatoMap", false);
    local u77 = u58.setting:WaitForChild("PotatoMaps") or workspace:GetAttribute("tutorial");
    local PotatoestMaps = u58.setting:WaitForChild("PotatoestMaps");

    if u77.Value then
        coroutine.wrap(script_map_replacings.swap_crowds)(true);
    end;

    if PotatoestMaps.Value and not workspace:GetAttribute("tutorial") then
        coroutine.wrap(script_map_replacings.delete_crowds)(true);
    end;

    u77:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 747
        -- upvalues: PotatoestMaps (copy), script_map_replacings (ref), u77 (copy)
        if not PotatoestMaps.Value then
            coroutine.wrap(script_map_replacings.swap_crowds)(u77.Value);
        end;
    end);
    PotatoestMaps:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 752
        -- upvalues: script_map_replacings (ref), PotatoestMaps (copy)
        coroutine.wrap(script_map_replacings.delete_crowds)(PotatoestMaps.Value);
    end);

    if not workspace:GetAttribute("tutorial") then
        workspace:GetAttributeChangedSignal("tutorial"):Connect(function() -- Line: 757
            -- upvalues: script_map_replacings (ref)
            if workspace:GetAttribute("tutorial") then
                coroutine.wrap(script_map_replacings.swap_crowds)(true);
            end;
        end);
    end;

    local WeakerVFX = u58.setting:WaitForChild("WeakerVFX");

    local function weakvfx(p78) -- Line: 768
        -- upvalues: ReplicatedStorage (ref)
        for _, descendant in ReplicatedStorage:WaitForChild("Resources"):GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                if p78 then
                    local Rate = descendant.Rate;
                    local v79 = descendant:GetAttribute("EmitCount") or 1;

                    if not descendant:GetAttribute("OriginalEmitCount") then
                        descendant:SetAttribute("OriginalEmitCount", v79);
                    end;

                    if not descendant:GetAttribute("OriginalRate") then
                        descendant:SetAttribute("OriginalRate", Rate);
                    end;

                    local v80 = descendant:GetAttribute("OriginalEmitCount") / 4;
                    descendant:SetAttribute("EmitCount", (math.round(v80)));
                    local v81 = descendant:GetAttribute("OriginalRate") / 4;
                    descendant.Rate = math.round(v81);
                else
                    if descendant:GetAttribute("OriginalEmitCount") then
                        descendant:SetAttribute("EmitCount", descendant:GetAttribute("OriginalEmitCount"));
                    end;

                    if descendant:GetAttribute("OriginalRate") then
                        descendant.Rate = descendant:GetAttribute("OriginalRate");
                    end;
                end;
            end;
        end;
    end;

    weakvfx(vfxUtil.IsOptimizationSettingOn(LocalPlayer, "LoweredVFX"));
    WeakerVFX:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 800
        -- upvalues: weakvfx (copy), vfxUtil (ref), LocalPlayer (copy)
        weakvfx(vfxUtil.IsOptimizationSettingOn(LocalPlayer, "LoweredVFX"));
    end);

    if u58.setting:FindFirstChild("AdvancedSettings") then
        u58.setting:FindFirstChild("AdvancedSettings"):WaitForChild("LoweredVFX"):GetPropertyChangedSignal("Value"):Connect(function() -- Line: 805
            -- upvalues: weakvfx (copy), vfxUtil (ref), LocalPlayer (copy)
            weakvfx(vfxUtil.IsOptimizationSettingOn(LocalPlayer, "LoweredVFX"));
        end);
    end;

    local v82 = TopbarIcon.new():setImage("rbxassetid://118685771787843"):bindEvent("deselected", function() -- Line: 813
        -- upvalues: ReplicatedStorage (ref), replication (ref), ReplicatedStorage2 (ref), u58 (copy)
        if ReplicatedStorage.Ranked.Value then
            replication.notification("wyd gng this is a ranked match you cant just swap modes 😭😭😭😭", Color3.fromRGB(255, 0, 0), ReplicatedStorage2.Resources.notisound);

            return;
        end;

        if u58.playerGui:FindFirstChild("GamemodeUI") then
            return;
        end;

        u58:GamemodesUI();
    end):oneClick();
    task.delay(5, function() -- Line: 843
        -- upvalues: ReplicatedStorage (ref), LocalPlayer (copy), u58 (copy), ReplicatedStorage2 (ref), TopbarIcon (ref), TweenService (ref)
        if require(ReplicatedStorage.permissions)(LocalPlayer).highrank then
            u58.hastesterability = true;
            local CmdrClient = require(ReplicatedStorage2:WaitForChild("CmdrClient"));
            TopbarIcon.new():setImage("rbxassetid://78787257278476"):bindEvent("selected", function() -- Line: 851
                -- upvalues: CmdrClient (copy)
                CmdrClient:Show();
            end):bindEvent("deselected", function() -- Line: 854
                -- upvalues: CmdrClient (copy)
                CmdrClient:Hide();
            end);
            TopbarIcon.new():setImage("rbxassetid://9692125126"):bindEvent("deselected", function() -- Line: 860
                -- upvalues: u58 (ref), TweenService (ref)
                if u58.playerGui:FindFirstChild("PS+") then
                    pcall(game.Destroy, u58.playerGui:FindFirstChild("PS+"));

                    return;
                end;

                local v83 = script["PS+"]:Clone();
                v83.Frame.Position = UDim2.fromScale(0.5, 0.3);
                v83.Frame.GroupTransparency = 1;
                TweenService:Create(v83.Frame, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    GroupTransparency = 0,
                    Position = UDim2.fromScale(0.5, 0.5)
                }):Play();
                v83.Parent = u58.playerGui;
                local ModuleScript = require(v83.ModuleScript);
                coroutine.wrap(ModuleScript.new)();
            end):oneClick();
        end;
    end);
    TopbarIcon.highlightKey = "MY COLLAR\'S BLUE BUT MY NECK IS RED";
    v82.highlightKey = TopbarIcon.highlightKey;
    task.spawn(function() -- Line: 883
        -- upvalues: LocalPlayer (copy), StarterGui (ref)
        local Backpack = LocalPlayer.Backpack;
        local Backpack2 = Enum.CoreGuiType.Backpack;
        Backpack.ChildAdded:Connect(function(p84) -- Line: 886
            -- upvalues: StarterGui (ref), Backpack2 (copy)
            if p84:IsA("Tool") and not StarterGui:GetCoreGuiEnabled(Backpack2) then
                StarterGui:SetCoreGuiEnabled(Backpack2, true);
            end;
        end);
        Backpack.ChildRemoved:Connect(function() -- Line: 891
            -- upvalues: Backpack (copy), StarterGui (ref), Backpack2 (copy)
            local v85 = false;

            for _, child in Backpack:GetChildren() do
                if child:IsA("Tool") then
                    v85 = true;
                    break;
                end;
            end;

            if StarterGui:GetCoreGuiEnabled(Backpack2) ~= v85 then
                StarterGui:SetCoreGuiEnabled(Backpack2, v85);
            end;
        end);
        StarterGui:SetCoreGuiEnabled(Backpack2, false);
    end);
    task.spawn(function() -- Line: 906
        -- upvalues: StarterGui (ref)
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.ExperienceShop, false);
    end);

    if LocalPlayer.Character then
        u58:CharacterAdded(LocalPlayer.Character);
    end;

    LocalPlayer.CharacterAdded:connect(function(p86: userdata) -- Line: 914
        -- upvalues: u58 (copy)
        u58:CharacterAdded(p86);
    end);
    Players.PlayerRemoving:connect(function(p87: userdata) -- Line: 918
        -- upvalues: u58 (copy)
        u58.fakePlayerParts[p87] = nil;
        u58.latestCFrame[p87] = nil;
    end);

    local function doNetworkRecieve(p88: userdata, p89) -- Line: 935
        -- upvalues: LocalPlayer (copy), u58 (copy)
        if p88 == LocalPlayer then
            return;
        end;

        if not u58.fakePlayerParts[p88] then
            u58.fakePlayerParts[p88] = p89;
        end;

        u58.latestCFrame[p88] = p89;
    end;

    packets.bytenet_p2pcli.listen(function(p90) -- Line: 948
        -- upvalues: LocalPlayer (copy), u58 (copy)
        local v91 = game.Players:FindFirstChild(p90.playerName);

        if v91 then
            local cframe = p90.cframe;

            if v91 == LocalPlayer then
                return;
            end;

            if not u58.fakePlayerParts[v91] then
                u58.fakePlayerParts[v91] = cframe;
            end;

            u58.latestCFrame[v91] = cframe;
        end;
    end);
    packets.bytenet_quests.listen(function(p92) -- Line: 956
        -- upvalues: u58 (copy), ReplicatedStorage2 (ref), packets (ref), Quests (ref)
        local questContent = p92.questContent;

        if not u58.playerGui:FindFirstChild("Menu") then
            return;
        end;

        local Rewards = u58.playerGui.Menu.Frame.Rewards.Rewards;

        for i, v in questContent do
            local v93 = 0;
            local v94 = 0;

            if Rewards.AchivementContainer:FindFirstChild(i) then
                Rewards.AchivementContainer:FindFirstChild(i):Destroy();
            end;

            local v95 = ReplicatedStorage2.Resources.TemplateQuest:Clone();
            v95.Name = i;
            v95.Holder.Title.Text = i;
            v95.Holder.Skip.Activated:Connect(function(p96: userdata, p97: number) -- Line: 980
                -- upvalues: packets (ref), i (copy)
                packets.bytenet_quests.send({
                    questAction = "skipQuest",
                    questContent = {
                        skipped = i
                    }
                });
            end);
            local u98 = i;

            for i2, v2 in v do
                if i2 ~= "zCreatedManually23567" then
                    v94 = v94 + 1;
                    local u99 = ReplicatedStorage2.Resources.TemplateTask:Clone();
                    task.spawn(function() -- Line: 993
                        -- upvalues: u99 (copy), Quests (ref), i2 (copy), v2 (copy), u98 (copy)
                        u99.Label.Text = Quests.ReturnString(i2) .. ":";
                        u99.Label1.Text = typeof(v2) == "number" and `{v2}/{Quests.Quests[u98][i2].max}` or (v2 == true and "Completed" or "Uncompleted");
                    end);
                    u99.Parent = v95.Holder.ScrollingFrame;

                    if Quests.VerifySingle(i2, u98, v2) then
                        v93 = v93 + 1;
                    end;
                end;
            end;

            v95.Holder.Progress.bar.Size = UDim2.new(v93 / v94, 0, 1, 0);
            v95.Holder.Progress.cout.Text = `{v93}/{v94}`;
            v95.Parent = Rewards.AchivementContainer;
        end;
    end);
    packets.bytenet_refreshDaily.listen(function(p100) -- Line: 1012
        -- upvalues: u58 (copy), wiki (ref), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), query (ref)
        if not u58.playerGui:FindFirstChild("Menu") then
            return;
        end;

        local DailyQuestcontainer = u58.playerGui.Menu.Frame.Rewards.Rewards.DailyQuestcontainer;

        local function RefreshQuest(p101) -- Line: 1019
            -- upvalues: DailyQuestcontainer (copy), wiki (ref), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), u58 (ref)
            for _, child in DailyQuestcontainer:GetChildren() do
                if child.Name ~= "Template" and child:IsA("Frame") then
                    child:Destroy();
                end;
            end;

            for i, v in p101 do
                local v102 = wiki.dailyQuests.list[v.Id];
                local v103 = DailyQuestcontainer.Template:Clone();
                v103.Name = "QUEST";
                v103.Holder.Title.Text = v102.Title;
                v103.Holder.Progress.cout.Text = `{v.Progress[1]}/{v102.Requirements[1].Amount}`;
                v103.Holder.Progress.bar.Size = UDim2.fromScale(v.Progress[1] / v102.Requirements[1].Amount, 1);
                v103.Visible = true;
                v103.Parent = DailyQuestcontainer;

                if v103:FindFirstChild("SkipDaily") then
                    v103.SkipDaily.MouseButton1Up:Connect(function() -- Line: 1037
                        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), u58 (ref), i (copy)
                        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
                        packets.bytenet_SkipDaily.send({ 3436079029, u58.player.UserId, i });
                    end);
                end;
            end;
        end;

        local _ = u58.playerGui.Menu.Frame.Rewards.Rewards;
        local u104 = query.getDailyQuests:Fire();
        pcall(function() -- Line: 1048
            -- upvalues: RefreshQuest (copy), u104 (copy)
            RefreshQuest(u104);
        end);
    end);
    script_sensitivityCamera.new(u58.setting):Bind();
    u58:Controller();
    u58:fakeBall();
    u58:ballHolder();
    u58:title();
    u58:updateCF();
    local u105 = script.checkping:Clone();
    u105.Parent = u58.playerGui;

    local function checkConditions() -- Line: 1104
        -- upvalues: LocalPlayer (copy), u58 (copy), u105 (copy)
        local v106 = LocalPlayer:GetNetworkPing() * 1000;
        local disablePing = u58.setting:FindFirstChild("disablePing");
        u105.Enabled = v106 > 99 and not (disablePing and disablePing.Value) and true or false;
    end;

    local v107 = LocalPlayer:GetNetworkPing() * 1000;
    local disablePing = u58.setting:FindFirstChild("disablePing");
    u105.Enabled = v107 > 99 and not (disablePing and disablePing.Value) and true or false;
    task.spawn(function() -- Line: 1110
        -- upvalues: LocalPlayer (copy), u58 (copy), u105 (copy)
        while task.wait(1) do
            local v108 = LocalPlayer:GetNetworkPing() * 1000;
            local disablePing2 = u58.setting:FindFirstChild("disablePing");
            u105.Enabled = v108 > 99 and not (disablePing2 and disablePing2.Value) and true or false;
        end;
    end);
    local BindableEvent = Instance.new("BindableEvent");
    BindableEvent.Event:Connect(function() -- Line: 1114
        -- upvalues: actionUtil (ref), u58 (copy)
        if actionUtil.statecheck(u58.character) then
            return;
        end;

        u58.human.Health = 0;
    end);
    task.spawn(function() -- Line: 1119
        -- upvalues: StarterGui (ref), BindableEvent (copy)
        local v109 = false;

        while not v109 do
            v109 = pcall(function() -- Line: 1123
                -- upvalues: StarterGui (ref), BindableEvent (ref)
                StarterGui:SetCore("ResetButtonCallback", BindableEvent);
            end);

            if v109 then
                return;
            end;

            print("coregui being slow for ResetButtonCallback");
            wait(0.2);
        end;
    end);
    Observers.observe_tag("DuoEmoteProximity", function(u110: userdata) -- Line: 1135
        -- upvalues: trove (ref), LocalPlayer (copy)
        local u111 = trove.new();
        local u112 = "Participant_" .. LocalPlayer.UserId;

        local function updatePrompt() -- Line: 1139
            -- upvalues: LocalPlayer (ref), u110 (copy), u112 (copy)
            local Character = LocalPlayer.Character;
            local v113;

            if Character == nil then
                v113 = false;
            else
                v113 = not u110:IsDescendantOf(Character);

                if v113 then
                    if u110:GetAttribute("HasSpace") == false then
                        v113 = false;
                    else
                        v113 = not u110:GetAttribute(u112);
                    end;
                end;
            end;

            u110.Enabled = v113;
        end;

        u111:Add(u110.AncestryChanged:Connect(updatePrompt));
        u111:Add(u110:GetAttributeChangedSignal("HasSpace"):Connect(updatePrompt));
        u111:Add(u110:GetAttributeChangedSignal(u112):Connect(updatePrompt));
        u111:Add(LocalPlayer.CharacterAdded:Connect(updatePrompt));
        local Character = LocalPlayer.Character;
        local v114;

        if Character == nil then
            v114 = false;
        else
            v114 = not u110:IsDescendantOf(Character);

            if v114 then
                if u110:GetAttribute("HasSpace") == false then
                    v114 = false;
                else
                    v114 = not u110:GetAttribute(u112);
                end;
            end;
        end;

        u110.Enabled = v114;

        return function() -- Line: 1151
            -- upvalues: u111 (copy)
            u111:Destroy();
        end;
    end, { workspace });
    task.spawn(function() -- Line: 1156
        -- upvalues: LocalPlayer (copy), u58 (copy)
        if LocalPlayer:GetAttribute("seen_bundle") == nil then
            LocalPlayer:GetAttributeChangedSignal("seen_bundle"):Wait();
        end;

        local function u115() -- Line: 1161
            for _, child in script.Bundle:GetChildren() do
                if child.Name == "Disclaimer" then
                    child:Destroy();
                end;
            end;
        end;

        if LocalPlayer:GetAttribute("seen_bundle") == 1 then
            u58:Bundles();
        else
            u115();
        end;

        LocalPlayer:GetAttributeChangedSignal("seen_bundle"):Connect(function() -- Line: 1175
            -- upvalues: u58 (ref), LocalPlayer (ref), u115 (copy)
            if u58.bundle_focused then
                u58:destroyContainer();
            end;

            if LocalPlayer:GetAttribute("seen_bundle") == 2 then
                u115();
            end;
        end);
    end);
    task.spawn(function() -- Line: 1185
        -- upvalues: u58 (copy), packets (ref)
        workspace.map.lobby.FreeReward.FreeReward.Claim.Triggered:Connect(function() -- Line: 1186, Name: openRewardUI
            -- upvalues: u58 (ref), packets (ref)
            local FreeRewards = script:FindFirstChild("FreeRewards");

            if not FreeRewards then
                return;
            end;

            local FreeRewards2 = u58.playerGui:FindFirstChild("FreeRewards");

            if FreeRewards2 then
                FreeRewards2:Destroy();
            end;

            local u116 = FreeRewards:Clone();
            u116.Parent = u58.playerGui;
            local u117 = false;
            u116.Frame.Verify.Claim.Activated:Connect(function() -- Line: 1202
                -- upvalues: u117 (ref), packets (ref), u116 (copy)
                if u117 then
                    return;
                end;

                u117 = true;
                packets.bytenet_freeRewardClaim.send();
                u116:Destroy();
            end);
        end);
    end);
    task.spawn(function() -- Line: 1215
        -- upvalues: GroupService (ref), replication (ref), ReplicatedStorage2 (ref)
        local Anri = workspace.map.lobby.group.Anri;
        Anri.HumanoidRootPart.ProximityPrompt.Triggered:Connect(function() -- Line: 1217
            -- upvalues: GroupService (ref), replication (ref), ReplicatedStorage2 (ref)
            local success, result = pcall(function() -- Line: 1218
                -- upvalues: GroupService (ref)
                return GroupService:PromptJoinAsync(game.CreatorId);
            end);
            local v118 = nil;

            if result == Enum.GroupMembershipStatus.AlreadyMember then
                v118 = "You\'re already in the group!";
            elseif result == Enum.GroupMembershipStatus.JoinRequestPending then
                v118 = "Your join request is now pending.";
            elseif result == Enum.GroupMembershipStatus.Joined then
                v118 = "You\'ve successfully joined the group!";
            elseif not success then
                warn("Failed to join the group:", result);
                v118 = "Failed to join the group.";
            end;

            if v118 then
                replication.notification(v118, Color3.new(1, 1, 1), ReplicatedStorage2.Resources.notisound);
            end;
        end);
        Anri.Humanoid.Animator:LoadAnimation(Anri.Animation):Play();
    end);
    task.spawn(function() -- Line: 1239
        -- upvalues: ReplicatedStorage2 (ref), script_RankedHelpers (ref), u58 (copy)
        local v119 = os.clock() + 30;

        while not ReplicatedStorage2.Ranked.Value and os.clock() < v119 do
            task.wait(0.1);
        end;

        if not ReplicatedStorage2.Ranked.Value then
            return;
        end;

        xpcall(script_RankedHelpers.Ranked, function(p120) -- Line: 1247
            warn((`Ranked failed to load: {p120}`));
        end, u58);
    end);
    task.spawn(function() -- Line: 1252
        -- upvalues: ReplicatedStorage2 (ref), u58 (copy)
        local script_RankedRematch = require(script.RankedRematch);
        local v121 = os.clock() + 30;

        while not ReplicatedStorage2.Ranked.Value and os.clock() < v121 do
            task.wait(0.1);
        end;

        if not ReplicatedStorage2.Ranked.Value then
            return;
        end;

        xpcall(script_RankedRematch.RankedRematch, function(p122) -- Line: 1261
            warn((`Ranked rematch failed to load: {p122}`));
        end, u58);
    end);

    for _, child in script.Extensions:GetChildren() do
        local v123 = require(child);

        if type(v123.Init) == "function" then
            task.spawn(v123.Init, u58);
        end;

        if type(v123.Attachments) == "table" then
            for i, v in v123.Attachments do
                u58[i] = v;
            end;
        end;
    end;

    return u58;
end;

local function dcl(p124) -- Line: 1281
    return math.round(p124 * 100) / 100;
end;

local function OptimizeCframe(p125) -- Line: 1285
    local v126, v127, v128 = p125:ToEulerAnglesYXZ();
    local Position = p125.Position;

    return CFrame.new(math.round(Position.X * 100) / 100, math.round(Position.Y * 100) / 100, math.round(Position.Z * 100) / 100) * CFrame.fromEulerAnglesYXZ(math.round(v126 * 100) / 100, math.round(v127 * 100) / 100, math.round(v128 * 100) / 100);
end;

function u3.updateCF(u129) -- Line: 1291
    -- upvalues: RunService2 (copy), actionUtil (copy), wiki (copy), ReplicatedStorage2 (copy), packets (copy), Draw (copy), u1 (ref), Players (copy), workspace_CurrentCamera (copy), OptimizeCframe (copy)
    RunService2:UnbindFromRenderStep("rootCFUpdate");
    RunService2:BindToRenderStep("rootCFUpdate", Enum.RenderPriority.First.Value, function(p130) -- Line: 1294
        -- upvalues: u129 (copy), RunService2 (ref), actionUtil (ref), wiki (ref), ReplicatedStorage2 (ref), packets (ref), Draw (ref), u1 (ref), Players (ref), workspace_CurrentCamera (ref), OptimizeCframe (ref)
        local humanoidRootPart = u129.humanoidRootPart;
        local Attribute = u129.player:GetAttribute("ControllingUserId");
        local fasterCharacterCoordinateReplication = u129.setting:FindFirstChild("fasterCharacterCoordinateReplication");
        local v131 = fasterCharacterCoordinateReplication and not fasterCharacterCoordinateReplication.Value or shared.nocustomreplication;

        for i, v in u129.fakePlayerParts do
            local v132 = i == u129.player;

            if not (v132 and not RunService2:IsStudio() or (Attribute and i.UserId == Attribute or i.Character and i.Character:GetAttribute("BeingControlled"))) then
                local v133 = u129.latestCFrame[i];

                if v133 then
                    local Rotation = v133.Rotation;
                    local Position = v:Lerp(v133, (math.clamp(p130 * 0.5 * 30, 0, 1))).Position;
                    local v134 = CFrame.new(Position) * Rotation;
                    u129.fakePlayerParts[i] = v134;

                    if not v131 and (i and (i.Character and (i.Character:IsA("Model") and not v132))) then
                        local Character = i.Character;
                        local v135 = Character:FindFirstChildOfClass("Humanoid");
                        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

                        if v135 and (v135.Health > 0 and not (HumanoidRootPart and HumanoidRootPart.Anchored)) then
                            if v135:GetState() ~= Enum.HumanoidStateType.Physics then
                                v135:ChangeState(Enum.HumanoidStateType.Physics);
                            end;

                            if not HumanoidRootPart or HumanoidRootPart.CFrame ~= v134 then
                                Character:PivotTo(v134);
                            end;
                        end;
                    end;
                end;
            end;
        end;

        local v136 = actionUtil.ballHolder();
        local v137 = u129.character and u129.character:GetScale();
        local v138 = u129.character and u129.character:GetAttribute("NoScaleChange") and 1 or v137;
        local v139 = wiki.ball_pickups[actionUtil.checkGK(u129.character) and "gk" or "player"] * (v138 > 1 and v138 or 1);

        if v136 ~= u129.character then
            local CFBall = ReplicatedStorage2:FindFirstChild("CFBall");

            if CFBall and ((humanoidRootPart.Position - CFBall.Value.Position).Magnitude < v139 and not (u129.character:GetAttribute("cantgetball") or u129.character:GetAttribute("InMarble"))) then
                packets.bytenet_findBall.send();
                Draw(humanoidRootPart.CFrame, v139, Color3.new(1, 1, 1));
            end;
        end;

        if u1 + 0.016666666666666666 < os.clock() then
            u1 = os.clock();
            local u140 = nil;
            local v141 = nil;
            local Attribute2 = Players.LocalPlayer:GetAttribute("ControllingUserId");
            local u142;

            if Attribute2 then
                u142 = Players:GetPlayerByUserId(Attribute2);

                if u142 then
                    u142 = u142.Character;
                end;

                if u142 then
                    u142 = u142:FindFirstChild("HumanoidRootPart");
                end;

                if not (u142 and u142:IsA("BasePart")) then
                    u142 = v141;
                end;
            else
                u142 = v141;
            end;

            local _, _ = pcall(function() -- Line: 1376
                -- upvalues: u140 (ref), u142 (ref), humanoidRootPart (copy)
                u140 = (u142 or humanoidRootPart).CFrame;
            end);

            if u140 then
                local LookVector = u140.LookVector;
                local X = LookVector.X;
                local math_clamp_ret = math.clamp(workspace_CurrentCamera.CFrame.LookVector.Y, -1, 1);
                local Vector3_new_ret = Vector3.new(X, math_clamp_ret, LookVector.Z);
                local v143 = OptimizeCframe(workspace_CurrentCamera.CFrame);
                packets.bytenet_clientCFrame.send({
                    adjustedDirection = Vector3_new_ret,
                    camCFrame = v143
                });
            end;
        end;
    end);
end;

function u3.CharacterAdded(u144, u145) -- Line: 1397
    -- upvalues: trove (copy), UserInputService (copy), packets (copy), Util (copy), raycast (copy)
    if u144.charContainer then
        u144.charContainer:Destroy();
        u144.charContainer = nil;
    end;

    local u146 = u145:WaitForChild("HumanoidRootPart") or u145.PrimaryPart;
    local v147 = u145:FindFirstChildOfClass("Humanoid") or u145:WaitForChild("Humanoid");
    local movements = u145:WaitForChild("movements");
    local state = u145:WaitForChild("state");
    u144.character = u145;
    u144.human = v147;
    u144.movementFolder = movements;
    u144.humanoidRootPart = u146;
    u144.state = state;
    local style = state:WaitForChild("style");
    style.Changed:Connect(function(p148) -- Line: 1413
        -- upvalues: u144 (copy)
        u144.style = p148;
        u144:rebuildMindControlHotbar();
    end);
    u144.style = style.Value;
    u144.charContainer = trove.new();
    u144.lastCF = u146.CFrame;
    u144.charContainer:Add(v147.Jumping:connect(function() -- Line: 1423
        -- upvalues: u144 (copy)
        u144.baseClient:use("jump");
    end));
    local u149 = 0;
    u144.charContainer:Add(UserInputService.JumpRequest:Connect(function() -- Line: 1434
        -- upvalues: u144 (copy), UserInputService (ref), u149 (ref), packets (ref)
        local os_clock_ret = os.clock();

        if not (u144.character:GetAttribute("Emoting") and (u144.humanoidRootPart.Anchored and (not UserInputService:GetFocusedTextBox() and os_clock_ret - u149 >= 0.2))) then
            return;
        end;

        u149 = os_clock_ret;
        packets.bytenet_useEmote.send({
            emoteName = "",
            method = "Stop"
        });
    end));

    local function replaceBarriar(p150) -- Line: 1451
        -- upvalues: u144 (copy)
        local gkbarriar = workspace.map.gkbarriar;

        if gkbarriar:FindFirstChild(p150.Name) then
            gkbarriar[p150.Name]:Destroy();
        end;

        local v151 = p150:Clone();
        v151.Parent = gkbarriar;
        u144.charContainer:Add(v151);

        return v151;
    end;

    local u152 = nil;
    local u153 = nil;
    local CollisionGroup = script.Abarriar.CollisionGroup;

    local function ejectFromGkBarrierIfInside() -- Line: 1466
        -- upvalues: u145 (copy), state (copy), u146 (copy), Util (ref), raycast (ref)
        if u145:GetAttribute("IgnorePenaltyBarriar") then
            return;
        end;

        local Value = state.team.Value;

        if not table.find({ "A", "B" }, Value) then
            return;
        end;

        local v154 = u146;

        if not v154 then
            return;
        end;

        local v155 = workspace.map.gkzone:FindFirstChild(Value);

        if not v155 then
            return;
        end;

        local barriar = v155:FindFirstChild("barriar");

        if barriar then
            barriar = Util.IsInZone(barriar, v154.Position);
        end;

        if not barriar then
            return;
        end;

        local v156 = workspace.map.something:FindFirstChild((`barouU20{Value}`));

        if not v156 then
            return;
        end;

        local v157 = v156.CFrame * CFrame.new(-35, 0.069, -60) * CFrame.Angles(0, 3.141592653589793, 0);
        local v158 = raycast(v157.Position, Vector3.new(-0, -50, -0), nil, { workspace.map.map.sanam });

        if v158 then
            v154.CFrame = CFrame.new(v158.Position, v158.Position + v157.LookVector) * CFrame.new(Vector3.new(0, 3, 0));

            return;
        end;

        v154.CFrame = v157;
    end;

    local function updateBarriarCollision(p159) -- Line: 1506
        -- upvalues: u152 (ref), u153 (ref), CollisionGroup (copy), state (copy), u145 (copy)
        if not (u152 and u153) then
            return;
        end;

        u152.CollisionGroup = CollisionGroup;
        u153.CollisionGroup = CollisionGroup;

        if state.role.Value == "GK" then
            if p159 == "A" then
                u152.CollisionGroup = "characterParts";
            elseif p159 == "B" then
                u153.CollisionGroup = "characterParts";
            end;
        end;

        if u145:GetAttribute("IgnorePenaltyBarriar") == true and table.find({ "A", "B" }, p159) then
            if p159 == "A" then
                u152.CollisionGroup = "characterParts";

                return;
            end;

            u153.CollisionGroup = "characterParts";
        end;
    end;

    local function barrier(p160) -- Line: 1532
        -- upvalues: u152 (ref), u144 (copy), u153 (ref), updateBarriarCollision (copy)
        local script_Abarriar = script.Abarriar;
        local gkbarriar = workspace.map.gkbarriar;

        if gkbarriar:FindFirstChild(script_Abarriar.Name) then
            gkbarriar[script_Abarriar.Name]:Destroy();
        end;

        local v161 = script_Abarriar:Clone();
        v161.Parent = gkbarriar;
        u144.charContainer:Add(v161);
        u152 = v161;
        local script_Bbarriar = script.Bbarriar;
        local gkbarriar2 = workspace.map.gkbarriar;

        if gkbarriar2:FindFirstChild(script_Bbarriar.Name) then
            gkbarriar2[script_Bbarriar.Name]:Destroy();
        end;

        local v162 = script_Bbarriar:Clone();
        v162.Parent = gkbarriar2;
        u144.charContainer:Add(v162);
        u153 = v162;
        updateBarriarCollision(p160);
    end;

    u144.charContainer:Add(u145:GetAttributeChangedSignal("IgnorePenaltyBarriar"):Connect(function() -- Line: 1538
        -- upvalues: state (copy), updateBarriarCollision (copy), ejectFromGkBarrierIfInside (copy)
        if table.find({ "A", "B" }, state.team.Value) then
            updateBarriarCollision(state.team.Value);
        end;

        task.defer(ejectFromGkBarrierIfInside);
    end));
    u144.charContainer:Add(state:WaitForChild("team").Changed:Once(function(p163) -- Line: 1545
        -- upvalues: u152 (ref), u144 (copy), u153 (ref), updateBarriarCollision (copy)
        local script_Abarriar = script.Abarriar;
        local gkbarriar = workspace.map.gkbarriar;

        if gkbarriar:FindFirstChild(script_Abarriar.Name) then
            gkbarriar[script_Abarriar.Name]:Destroy();
        end;

        local v164 = script_Abarriar:Clone();
        v164.Parent = gkbarriar;
        u144.charContainer:Add(v164);
        u152 = v164;
        local script_Bbarriar = script.Bbarriar;
        local gkbarriar2 = workspace.map.gkbarriar;

        if gkbarriar2:FindFirstChild(script_Bbarriar.Name) then
            gkbarriar2[script_Bbarriar.Name]:Destroy();
        end;

        local v165 = script_Bbarriar:Clone();
        v165.Parent = gkbarriar2;
        u144.charContainer:Add(v165);
        u153 = v165;
        updateBarriarCollision(p163);
    end));
    u144.charContainer:Add(state:WaitForChild("role").Changed:Once(function(p166) -- Line: 1552
        -- upvalues: state (copy), u152 (ref), u144 (copy), u153 (ref), updateBarriarCollision (copy)
        local Value = state.team.Value;
        local script_Abarriar = script.Abarriar;
        local gkbarriar = workspace.map.gkbarriar;

        if gkbarriar:FindFirstChild(script_Abarriar.Name) then
            gkbarriar[script_Abarriar.Name]:Destroy();
        end;

        local v167 = script_Abarriar:Clone();
        v167.Parent = gkbarriar;
        u144.charContainer:Add(v167);
        u152 = v167;
        local script_Bbarriar = script.Bbarriar;
        local gkbarriar2 = workspace.map.gkbarriar;

        if gkbarriar2:FindFirstChild(script_Bbarriar.Name) then
            gkbarriar2[script_Bbarriar.Name]:Destroy();
        end;

        local v168 = script_Bbarriar:Clone();
        v168.Parent = gkbarriar2;
        u144.charContainer:Add(v168);
        u153 = v168;
        updateBarriarCollision(Value);
    end));

    if table.find({ "A", "B" }, state.team.Value) then
        local Value = state.team.Value;
        local script_Abarriar = script.Abarriar;
        local gkbarriar = workspace.map.gkbarriar;

        if gkbarriar:FindFirstChild(script_Abarriar.Name) then
            gkbarriar[script_Abarriar.Name]:Destroy();
        end;

        local v169 = script_Abarriar:Clone();
        v169.Parent = gkbarriar;
        u144.charContainer:Add(v169);
        u152 = v169;
        local script_Bbarriar = script.Bbarriar;
        local gkbarriar2 = workspace.map.gkbarriar;

        if gkbarriar2:FindFirstChild(script_Bbarriar.Name) then
            gkbarriar2[script_Bbarriar.Name]:Destroy();
        end;

        local v170 = script_Bbarriar:Clone();
        v170.Parent = gkbarriar2;
        u144.charContainer:Add(v170);
        u153 = v170;
        updateBarriarCollision(Value);
    end;

    v147:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
    u144:destroyContainer();
    u144:Lobby();
    u144:movement();
end;

function u3.showServerLocation(p171) -- Line: 1571
    local ExtraHud = p171.playerGui:FindFirstChild("ExtraHud");

    if not ExtraHud then
        return;
    end;

    ExtraHud.ServerLocation.Visible = p171.setting.ServerLocation.Value;
end;

function u3.showFPS(p172) -- Line: 1581
    local ExtraHud = p172.playerGui:FindFirstChild("ExtraHud");

    if not ExtraHud then
        return;
    end;

    ExtraHud.FPSCounter.Visible = p172.setting.FPS.Value;
end;

function u3.showServerAge(p173) -- Line: 1591
    local ExtraHud = p173.playerGui:FindFirstChild("ExtraHud");

    if not ExtraHud then
        return;
    end;

    ExtraHud.ServerAge.Visible = p173.setting.ServerAge.Value;
end;

function u3.showStyleMVP(p174) -- Line: 1601
    local Lobby = p174.playerGui:FindFirstChild("Lobby");

    if not Lobby then
        return;
    end;

    Lobby.Info.Visible = p174.setting["Style&MVP"].Value;
end;

function u3.hasPass(p175, p176) -- Line: 1609
    -- upvalues: PassClient (copy)
    return PassClient.checkPass(p176);
end;

local BundleInfo = require(ReplicatedStorage.BundleInfo);
local Color3_fromRGB_ret = Color3.fromRGB(67, 67, 67);
local TweenInfo_new_ret = TweenInfo.new(2, Enum.EasingStyle.Cubic, Enum.EasingDirection.In);
local u177 = { 1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1 };
local u178 = { "M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I" };

local function toRoman(p179) -- Line: 1625
    -- upvalues: u177 (copy), u178 (copy)
    local v180 = "";

    for i, v in ipairs(u177) do
        local v181 = i;
        local v182 = v;

        while v182 <= p179 do
            v180 = v180 .. u178[v181];
            p179 = p179 - v182;
        end;
    end;

    return v180;
end;

local function addCommas(p183) -- Line: 1636
    local math_floor_ret = math.floor(p183);
    local v184 = tostring(math_floor_ret);
    local v185 = 0;
    local v186 = "";

    for i = #v184, 1, -1 do
        v185 = v185 + 1;
        v186 = v184:sub(i, i) .. v186;
        local v187;

        if v185 % 3 == 0 and i ~= 1 then
            v186 = "," .. v186;
            v187 = i;
        else
            v187 = i;
        end;
    end;

    return v186;
end;

function u3.Bundles(u188) -- Line: 1650
    -- upvalues: vfxUtil (copy), TweenService (copy), TweenInfo_new_ret (copy), soundUtil (copy), BundleInfo (copy), wiki (copy), addCommas (copy), Color3_fromRGB_ret (copy), toRoman (copy), MarketplaceService (copy), packets (copy), replication (copy)
    local u189 = u188:createContainer();

    if not u189 then
        return;
    end;

    local u190 = nil;
    local u191 = nil;
    local u192 = nil;
    local u193 = false;
    local Resources = vfxUtil.getResources();
    local u194 = u189:Clone(script.Bundle);
    u194.Parent = u188.playerGui;
    u188.bundle_focused = true;
    u189:Add(function() -- Line: 1666
        -- upvalues: u188 (copy)
        u188.bundle_focused = nil;
    end);

    local function bundle_warn(p195: string, p196) -- Line: 1670
        -- upvalues: u192 (ref), u189 (copy), u194 (copy), TweenService (ref), TweenInfo_new_ret (ref), soundUtil (ref), Resources (copy)
        if u192 then
            u189:Remove(u192);
        end;

        u192 = u189:Extend();
        u192:AttachToInstance(u194);
        u194.Warning.TextTransparency = 0;
        u194.Warning.TextStrokeTransparency = 0.4;
        u194.Warning.Text = p195;
        u194.Warning.TextColor3 = p196 or Color3.new(1, 0, 0);
        u194.Warning.Position = UDim2.fromScale(0.51, 0.321);
        u194.Warning.Visible = true;
        u192:Add(TweenService:Create(u194.Warning, TweenInfo_new_ret, {
            TextTransparency = 1,
            TextStrokeTransparency = 1,
            Position = UDim2.fromScale(u194.Warning.Position.X.Scale, u194.Warning.Position.Y.Scale + 0.1)
        }), "Pause"):Play();
        u192:Add(task.delay(TweenInfo_new_ret.Time, function() -- Line: 1693
            -- upvalues: u194 (ref)
            u194.Warning.Visible = false;
        end));
        soundUtil:play(Resources.notisound, "default");
    end;

    local function button(u197: function) -- Line: 1700
        -- upvalues: soundUtil (ref), Resources (copy)
        return function() -- Line: 1701
            -- upvalues: soundUtil (ref), Resources (ref), u197 (copy)
            soundUtil:play(Resources.click, "default");
            u197();
        end;
    end;

    local Frame = u194.Items.UIListLayout.Frame;

    local function makeItem(p198: any, p199: any, u200: table?) -- Line: 1709
        -- upvalues: BundleInfo (ref), Frame (copy), u188 (copy), wiki (ref), addCommas (ref), u194 (copy), Color3_fromRGB_ret (ref), u193 (ref), soundUtil (ref), Resources (copy)
        local v201 = BundleInfo.item_types[p199.type];
        local u202 = p198:Clone(Frame);
        u202.Kind.Text = (u200 and "[ PICK %s ]" or "( %s )"):format((v201.name or p199.type):upper());
        u202.ImageLabel.Image = v201.icon or "rbxassetid://113114601887005";
        local v203 = true;
        local v204 = false;

        if p199.type == "mvp" then
            for _, child in u188.storage.mvps:GetChildren() do
                if child.Value == p199.value then
                    v204 = true;
                    break;
                end;
            end;

            local v205 = wiki.mvp_anim[p199.value];

            if not v204 and v205 then
                u202.TextLabel.Text = v205.name or p199.value;
                u202.ImageLabel.Image = v205.icon or "rbxassetid://113114601887005";
                v203 = false;
            end;
        elseif p199.type == "style" then
            for _, child in u188.storage.styles:GetChildren() do
                if child.Value == p199.value then
                    v204 = true;
                    break;
                end;
            end;

            local v206 = wiki.styles[p199.value];

            if not v204 and v206 then
                v203 = false;
                u202.TextLabel.Text = v206.display_name or p199.value;
                u202.ImageLabel.Image = v206.image or (v206.icon or "rbxassetid://113114601887005");
                u202.ImageLabel.ScaleType = Enum.ScaleType.Crop;
                local ImageLabel = u202.ImageLabel;
                local v207;

                if v206.ignorecolor then
                    v207 = Color3.new(1, 1, 1);
                else
                    v207 = v206.color or Color3.new(1, 1, 1);
                end;

                ImageLabel.ImageColor3 = v207;

                if v206.ignorecolor then
                    u202.ImageLabel.ImageTransparency = 0.35;
                end;
            end;
        elseif p199.type == "mastery_complete" then
            local v208 = wiki.styles[p199.value];
            local v209 = wiki.styles[v208.mastery];

            if v209 then
                local BundleReference = v208.mastery_info.BundleReference;

                if BundleReference then
                    for _, child in u188.storage[BundleReference[1]]:GetChildren() do
                        if child.Value == BundleReference[2] then
                            v204 = true;
                            break;
                        end;
                    end;
                end;

                v203 = false;
                u202.TextLabel.Text = string.upper(v209.display_name or p199.value);
                u202.ImageLabel.Image = v209.icon or (v209.image or "rbxassetid://113114601887005");
                u202.ImageLabel.ScaleType = Enum.ScaleType.Crop;
                local ImageLabel = u202.ImageLabel;
                local v210;

                if v209.ignorecolor then
                    v210 = Color3.new(1, 1, 1);
                else
                    v210 = v209.color or Color3.new(1, 1, 1);
                end;

                ImageLabel.ImageColor3 = v210;

                if v209.ignorecolor then
                    u202.ImageLabel.ImageTransparency = 0.35;
                end;
            end;
        elseif p199.type == "title" then
            for _, child in u188.storage.titles:GetChildren() do
                if child.Value == p199.value then
                    v204 = true;
                    break;
                end;
            end;
        elseif p199.type == "emote" then
            for _, child in u188.emote.storage:GetChildren() do
                if child.Value == p199.value then
                    v204 = true;
                    break;
                end;
            end;
        end;

        if v203 then
            local value = p199.value;
            local v211 = tonumber(value);

            if v211 then
                value = addCommas(v211);
            end;

            u202.TextLabel.Text = (v201.format or "%s"):format(value);
        end;

        u202.Parent = u194.Items;

        if u200 then
            u202.Active = true;
            u202.AutoButtonColor = true;
            u202.BackgroundColor3 = Color3_fromRGB_ret;

            local function u213() -- Line: 1812
                -- upvalues: u193 (ref), u200 (copy), u202 (copy), Color3_fromRGB_ret (ref)
                if u193 then
                    return;
                end;

                local table_find_ret = table.find(u200.items, u202);
                u200.picked = table_find_ret;

                for i, v in ipairs(u200.items) do
                    local v212 = i == table_find_ret;
                    v.BackgroundColor3 = v212 and Color3.new(1, 1, 1) or Color3_fromRGB_ret;
                    v.BackgroundTransparency = v212 and 0.1 or 0.5;
                end;
            end;

            p198:Connect(u202.MouseButton1Click, function() -- Line: 1701
                -- upvalues: soundUtil (ref), Resources (ref), u213 (copy)
                soundUtil:play(Resources.click, "default");
                u213();
            end);
        end;

        u202.Visible = not v204;

        return u202;
    end;

    local function renderBundle(p214: number) -- Line: 1829
        -- upvalues: u193 (ref), u190 (ref), u191 (ref), u189 (copy), u194 (copy), bundle_warn (copy), BundleInfo (ref), toRoman (ref), MarketplaceService (ref), addCommas (ref), u188 (copy), packets (ref), soundUtil (ref), Resources (copy), makeItem (copy)
        if u193 then
            return false;
        end;

        u193 = true;

        if p214 then
            u190 = p214;
        end;

        if u191 then
            u189:Remove(u191);
        end;

        u191 = u189:Extend();
        u191:AttachToInstance(u194);
        bundle_warn("Loading...", Color3.new(1, 1, 1));
        local u215 = BundleInfo.bundles[p214];
        local v216 = `Bundle {toRoman(p214)}`;

        if u215.tag then
            v216 = v216 .. ` ({u215.tag})`;
        end;

        u194.BundleName.Text = v216;
        local success, result = pcall(function() -- Line: 1857
            -- upvalues: MarketplaceService (ref), u215 (copy)
            return MarketplaceService:GetProductInfoAsync(u215.id, Enum.InfoType.Product);
        end);

        if not success then
            bundle_warn((`Failed to load Bundle {toRoman(p214)}.`));
            u193 = false;

            return false;
        end;

        u194.Price.Text = `{utf8.char(57346)} {addCommas(result.PriceInRobux)}`;
        local u217 = {};

        local function u224() -- Line: 1885
            -- upvalues: u217 (copy), bundle_warn (ref), u215 (copy), u188 (ref), packets (ref)
            if #u217 > 0 then
                local v218 = 0;
                local v219 = 0;

                for _, v in ipairs(u217) do
                    v218 = v218 + 1;

                    if v.picked then
                        v219 = v219 + 1;
                    else
                        local v220 = false;

                        for _, v2 in ipairs(v.items) do
                            if v2.Visible then
                                v220 = true;
                                break;
                            end;
                        end;

                        if not v220 then
                            v219 = v219 + 1;
                        end;
                    end;
                end;

                if v219 < v218 then
                    bundle_warn("Please pick from the choices given.");

                    return;
                end;
            end;

            local v221 = {};

            for i, v in ipairs(u217) do
                v221[i] = v.picked;
            end;

            local v222 = tostring(u215.id);

            if u215.style_speciality then
                local v223 = false;

                for _, child in u188.storage.styles:GetChildren() do
                    if child.Value == u215.style_speciality then
                        v223 = true;
                        break;
                    end;
                end;

                if v223 then
                    v222 = tostring(u215.id2);
                end;
            end;

            packets.bytenet_marketPromptBundle.send({
                id = v222,
                picks = v221
            });
        end;

        u191:Connect(u194.Purchase.MouseButton1Click, function() -- Line: 1701
            -- upvalues: soundUtil (ref), Resources (ref), u224 (copy)
            soundUtil:play(Resources.click, "default");
            u224();
        end);

        local function return_all_buttons() -- Line: 1939
            -- upvalues: u194 (ref)
            local v225 = 0;

            for _, child in u194.Items:GetChildren() do
                if child:IsA("TextButton") and child.Visible then
                    v225 = v225 + 1;
                end;
            end;

            return v225;
        end;

        local v226 = false;

        for _, v in ipairs(u215.items) do
            if v.type == "pick" then
                local v227 = {
                    picked = nil,
                    items = {}
                };

                for _, v2 in ipairs(v.value) do
                    local v228 = BundleInfo.item_types[v2.type];
                    local v229 = makeItem(u191, v2, v227);
                    table.insert(v227.items, v229);
                    u194.Items.AAAAAAAAA.Visible = return_all_buttons() >= 6;
                    u194.Items.ZZZZZZZZZZ.Visible = return_all_buttons() >= 6;

                    if v228 and (v228.anchor and v229.Visible) then
                        v226 = true;
                    end;
                end;

                table.insert(u217, v227);
            else
                local v230 = BundleInfo.item_types[v.type];
                local v231 = makeItem(u191, v);
                u194.Items.AAAAAAAAA.Visible = return_all_buttons() >= 6;
                u194.Items.ZZZZZZZZZZ.Visible = return_all_buttons() >= 6;

                if v230 and (v230.anchor and v231.Visible) then
                    v226 = true;
                end;
            end;
        end;

        if v226 then
            u193 = false;

            return true;
        end;

        u191:Destroy();
        u193 = false;
        bundle_warn("You already have everything in this bundle.", Color3.new(1, 1, 1));

        return false;
    end;

    local function u232() -- Line: 1989
        -- upvalues: renderBundle (copy), u190 (ref)
        renderBundle((math.max(u190 - 1, 1)));
    end;

    u189:Connect(u194.Previous.MouseButton1Click, function() -- Line: 1701
        -- upvalues: soundUtil (ref), Resources (copy), u232 (copy)
        soundUtil:play(Resources.click, "default");
        u232();
    end);

    local function u233() -- Line: 1993
        -- upvalues: renderBundle (copy), u190 (ref), BundleInfo (ref)
        renderBundle((math.min(u190 + 1, #BundleInfo.bundles)));
    end;

    u189:Connect(u194.Next.MouseButton1Click, function() -- Line: 1701
        -- upvalues: soundUtil (ref), Resources (copy), u233 (copy)
        soundUtil:play(Resources.click, "default");
        u233();
    end);

    local function u234() -- Line: 1997
        -- upvalues: packets (ref), u188 (copy)
        packets.bytenet_seenBundle.send();
        u188:destroyContainer();
    end;

    u189:Connect(u194.Ignore.MouseButton1Click, function() -- Line: 1701
        -- upvalues: soundUtil (ref), Resources (copy), u234 (copy)
        soundUtil:play(Resources.click, "default");
        u234();
    end);
    local v235 = renderBundle(BundleInfo.default_bundle);

    if not v235 then
        for i = 1, #BundleInfo.bundles do
            if i ~= BundleInfo.default_bundle and renderBundle(i) then
                v235 = true;
                break;
            end;

            local _ = i;
        end;

        if not v235 then
            u188:destroyContainer();
            replication.notification("You already own all of the bundle content", Color3.new(1, 1, 1), Resources.notisound);
        end;
    end;
end;

local function formatServerAge(p236) -- Line: 2023
    local math_floor_ret = math.floor(p236);
    local math_max_ret = math.max(math_floor_ret, 0);
    local math_floor_ret2 = math.floor(math_max_ret / 86400);
    local math_floor_ret3 = math.floor(math_max_ret % 86400 / 3600);
    local math_floor_ret4 = math.floor(math_max_ret % 3600 / 60);
    local v237 = math_max_ret % 60;

    if math_floor_ret2 > 0 then
        return `{math_floor_ret2}d {math_floor_ret3}h {math_floor_ret4}m`;
    end;

    if math_floor_ret3 > 0 then
        return `{math_floor_ret3}h {math_floor_ret4}m`;
    end;

    if math_floor_ret4 > 0 then
        return `{math_floor_ret4}m {v237}s`;
    end;

    return `{v237}s`;
end;

function u3.Lobby(u238) -- Line: 2042
    -- upvalues: TopbarIcon (copy), Players (copy), controller_updateFromServer (copy), u3 (copy), TweenService (copy), soundUtil (copy), ReplicatedStorage2 (copy), SoundService (copy), replication (copy), RunService (copy), formatServerAge (copy), actionUtil (copy), RunService2 (copy), Random_new_ret (copy), random (copy)
    TopbarIcon.setTopbarEnabled(true);
    u238:destroyContainer();

    for _, child in Players.LocalPlayer.PlayerGui:GetChildren() do
        if child.Name == "Black" then
            child:Destroy();
        end;
    end;

    controller_updateFromServer(u238.setting.consoleRemapping);
    local Children = u238.setting.customKeybinds:GetChildren();
    local cachedKeybinds = u3.cachedKeybinds;

    for _, v in Children do
        cachedKeybinds[v.Name] = v.Value;
    end;

    local u239 = script.Timer:Clone();
    u239.Parent = u238.playerGui;
    local u240 = script.Lobby:Clone();
    u240.Parent = u238.playerGui;
    u238.lobbyui = u240;
    local Position = u240.Frame.Position;
    local UDim2_new_ret = UDim2.new(0.253, 0, 0.89, 0);
    local TweenInfo_new_ret2 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    u240.Frame.Position = UDim2_new_ret;
    local u241 = TweenService:Create(u240.Frame, TweenInfo_new_ret2, {
        Position = UDim2_new_ret
    });
    local u242 = TweenService:Create(u240.Frame, TweenInfo_new_ret2, {
        Position = Position
    });

    for _, child in ipairs(u240.Frame:GetChildren()) do
        if child:IsA("Frame") then
            local Size = child.Size;
            local UDim2_new_ret2 = UDim2.new(Size.X.Scale * 1.2, 0, Size.Y.Scale * 1.2, 0);
            local TweenInfo_new_ret3 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
            local u243 = TweenService:Create(child, TweenInfo_new_ret3, {
                Size = UDim2_new_ret2
            });
            local u244 = TweenService:Create(child, TweenInfo_new_ret3, {
                Size = Size
            });
            child.Button.MouseEnter:connect(function() -- Line: 2082
                -- upvalues: u242 (copy), u243 (copy)
                u242:Play();
                u243:Play();
            end);
            child.Button.MouseLeave:connect(function() -- Line: 2088
                -- upvalues: u241 (copy), u244 (copy)
                u241:Play();
                u244:Play();
            end);
            child.Button.MouseButton1Up:connect(function() -- Line: 2094
                -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref)
                soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
            end);
        end;
    end;

    local u245 = {};

    local function debounceCheck(u246) -- Line: 2102
        -- upvalues: u245 (copy)
        if u245[u246] then
            return false;
        end;

        u245[u246] = true;
        task.delay(0.5, function() -- Line: 2107
            -- upvalues: u245 (ref), u246 (copy)
            u245[u246] = nil;
        end);

        return true;
    end;

    u240.Frame.Menu.Button.MouseButton1Up:connect(function() -- Line: 2113
        -- upvalues: u245 (copy), u238 (copy), replication (ref), ReplicatedStorage2 (ref)
        local v247;

        if u245.Menu then
            v247 = false;
        else
            u245.Menu = true;
            local u248 = "Menu";
            task.delay(0.5, function() -- Line: 2107
                -- upvalues: u245 (ref), u248 (copy)
                u245[u248] = nil;
            end);
            v247 = true;
        end;

        if not v247 then
            return;
        end;

        if u238:isRematchLobbyLocked() then
            replication.notification("You can\'t access that while voting on a rematch.", Color3.fromRGB(255, 0, 0), ReplicatedStorage2.Resources.notisound);

            return;
        end;

        u238:Menu();
    end);
    u240.Frame.Play.Button.MouseButton1Up:connect(function() -- Line: 2128
        -- upvalues: u245 (copy), u238 (copy), replication (ref), ReplicatedStorage2 (ref)
        local v249;

        if u245.Play then
            v249 = false;
        else
            u245.Play = true;
            local u250 = "Play";
            task.delay(0.5, function() -- Line: 2107
                -- upvalues: u245 (ref), u250 (copy)
                u245[u250] = nil;
            end);
            v249 = true;
        end;

        if not v249 then
            return;
        end;

        if u238:isRematchLobbyLocked() then
            replication.notification("You can\'t access that while voting on a rematch.", Color3.fromRGB(255, 0, 0), ReplicatedStorage2.Resources.notisound);

            return;
        end;

        u238:Select();
    end);
    u240.Frame.Spectate.Button.MouseButton1Up:connect(function() -- Line: 2143
        -- upvalues: u245 (copy), u238 (copy), replication (ref), ReplicatedStorage2 (ref)
        local v251;

        if u245.Spectate then
            v251 = false;
        else
            u245.Spectate = true;
            local u252 = "Spectate";
            task.delay(0.5, function() -- Line: 2107
                -- upvalues: u245 (ref), u252 (copy)
                u245[u252] = nil;
            end);
            v251 = true;
        end;

        if not v251 then
            return;
        end;

        if u238:isRematchLobbyLocked() then
            replication.notification("You can\'t access that while voting on a rematch.", Color3.fromRGB(255, 0, 0), ReplicatedStorage2.Resources.notisound);

            return;
        end;

        u238:Spectate();
    end);
    u240.Frame.achievements.Button.MouseButton1Up:connect(function() -- Line: 2158
        -- upvalues: u245 (copy), u238 (copy)
        local v253;

        if u245.Achievements then
            v253 = false;
        else
            u245.Achievements = true;
            local u254 = "Achievements";
            task.delay(0.5, function() -- Line: 2107
                -- upvalues: u245 (ref), u254 (copy)
                u245[u254] = nil;
            end);
            v253 = true;
        end;

        if not v253 then
            return;
        end;

        u238:AchieveThings();
    end);

    for _, child in u240.Info:GetChildren() do
        if not child:GetAttribute("DefaultText") then
            child:SetAttribute("DefaultText", child.Text);
        end;

        if Players.LocalPlayer:GetAttribute(child.Name) then
            local function update() -- Line: 2173
                -- upvalues: Players (ref), child (copy), u238 (copy)
                local Attribute = Players.LocalPlayer:GetAttribute(child.Name);
                local v255 = child.Name == "mvp_anim" and u238.player:GetAttribute("has_favorite_mvps") and "[random favorited]" or Attribute;
                child.Text = `{child:GetAttribute("DefaultText")} {v255}`;
            end;

            if child.Name == "mvp_anim" then
                u238.charContainer:Add(u238.player:GetAttributeChangedSignal("has_favorite_mvps"):Connect(update));
            end;

            u238.charContainer:Add(Players.LocalPlayer:GetAttributeChangedSignal(child.Name):Connect(update));
            task.defer(update);
        end;
    end;

    local u256 = u238.playerGui:FindFirstChild("ExtraHud") or script.ExtraHud:Clone();
    u256.Parent = u238.playerGui;
    u238:showServerLocation();
    u238:showFPS();
    u238:showServerAge();
    u238:showStyleMVP();
    local ServerLocation = ReplicatedStorage2.ServerLocation;
    u256.ServerLocation.Text = "Server: " .. tostring(ServerLocation.Value);

    if RunService:IsStudio() then
        u256.ServerLocation.Text = "Server: Studio";
    end;

    u238.charContainer:Add(ServerLocation.Changed:Connect(function() -- Line: 2204
        -- upvalues: RunService (ref), u256 (copy), ServerLocation (copy)
        if RunService:IsStudio() then
            return;
        end;

        u256.ServerLocation.Text = "Server: " .. ServerLocation.Value;
    end));
    u238.charContainer:Add(u256.ServerLocation.MouseEnter:Connect(function() -- Line: 2212
        -- upvalues: u256 (copy)
        u256.ServerLocation.Hint.Visible = true;
    end));
    u238.charContainer:Add(u256.ServerLocation.MouseLeave:Connect(function() -- Line: 2215
        -- upvalues: u256 (copy)
        u256.ServerLocation.Hint.Visible = false;
    end));
    local u257 = RunService:IsRunning() and time or os.clock;
    local u258 = u257();
    local u259 = u257();
    local u260 = {};
    local FPSCounter = u256.FPSCounter;
    local u261 = 0;
    local u262 = 0;
    local u263 = nil;
    local u264 = nil;
    local u265 = { ColorSequence.new(Color3.fromRGB(79, 255, 48), Color3.fromRGB(79, 255, 48)), ColorSequence.new(Color3.fromRGB(255, 170, 33), Color3.fromRGB(255, 170, 33)), ColorSequence.new(Color3.fromRGB(255, 37, 37), Color3.fromRGB(255, 37, 37)) };
    local v272 = RunService.Heartbeat:Connect(function() -- Line: 2236
        -- upvalues: u258 (ref), u257 (copy), u260 (copy), u261 (ref), FPSCounter (copy), formatServerAge (ref), u259 (copy), u264 (ref), u263 (ref), u262 (ref), u265 (copy)
        u258 = u257();

        for i = #u260, 1, -1 do
            local v266;

            if u260[i] >= u258 - 1 then
                v266 = u260[i] or nil;
            else
                v266 = nil;
            end;

            u260[i + 1] = v266;
            local _ = i;
        end;

        local Attribute = workspace:GetAttribute("serverage");

        if Attribute then
            local v267 = workspace:GetServerTimeNow() - Attribute;
            local math_floor_ret = math.floor(v267);
            local math_max_ret = math.max(math_floor_ret, 0);

            if math_max_ret ~= u261 then
                u261 = math_max_ret;
                FPSCounter.Parent.ServerAge.Text = formatServerAge(math_max_ret);
            end;
        end;

        u260[1] = u258;
        local v268 = u257() - u259 >= 1 and #u260 or #u260 / (u257() - u259);
        local math_floor_ret = math.floor(v268);
        local v269 = tostring(math_floor_ret);

        if v269 ~= u264 then
            u264 = v269;
            FPSCounter.label.Text = v269;
        end;

        local math_round_ret = math.round((shared.ping or 0) * 1000);
        local v270 = tostring(math_round_ret);

        if v270 ~= u263 then
            u263 = v270;
            FPSCounter.Text = v270;
        end;

        local v271 = math_round_ret < 60 and 1 or (math_round_ret < 100 and 2 or 3);

        if u262 ~= v271 then
            u262 = v271;
            FPSCounter.icon.UIGradient.Color = u265[v271];
        end;
    end);
    u238.charContainer:Add(v272);
    local v273 = actionUtil.checkReleaseStyle(Players.LocalPlayer.Character) == "Release" and "rbxassetid://1841782399" or "rbxassetid://82187586630588";
    local u274 = SoundService:WaitForChild("football-crowd-3-69245");
    u274.SoundId = v273;
    u274.EqualizerSoundEffect.Enabled = true;
    u274:Play();
    local Value = u238.state.ingame.Value;
    u238.state.ingame.Changed:Once(function() -- Line: 2292
        -- upvalues: u238 (copy), Value (copy), u240 (copy), u274 (copy)
        if u238.state.ingame.Value == Value then
            return;
        end;

        u238.rematch_menu_locked = false;
        u240:Destroy();
        u274.EqualizerSoundEffect.Enabled = false;
        u238:InGame();
    end);
    u239.Timer.Text = convertToHMS(u238.soccerState.timer.Value);
    u238.charContainer:Add(u238.soccerState.timer.Changed:connect(function(p275) -- Line: 2306
        -- upvalues: u239 (copy)
        if u239:FindFirstChild("Timer") then
            u239.Timer.Text = convertToHMS(p275);
        end;
    end));
    local Value2 = u238.soccerState.overtime.Value;
    local u276 = 0;
    local Timer = u239.Timer;
    local u277 = false;
    u238.charContainer:Connect(RunService2.Heartbeat, function(p278) -- Line: 2322
        -- upvalues: u238 (copy), Value2 (ref), ReplicatedStorage2 (ref), u277 (ref), Timer (copy), u276 (ref), Random_new_ret (ref), random (ref)
        local Value3 = u238.soccerState.timer.Value;

        if not (Value2 and (Value3 <= 30 and not ReplicatedStorage2.workspace.disabled.Value)) then
            if not u277 then
                u277 = true;
                Timer.Position = UDim2.fromScale(Timer.Position.X.Scale, 0);
                Timer.Rotation = 0;
                Timer.TextColor3 = Color3.new(1, 1, 1);
            end;

            return;
        end;

        u277 = false;
        local v279 = 1 - math.clamp(Value3 / 30, 0, 1);
        local math_lerp_ret = math.lerp(0, 3, v279);
        math.lerp(0, 3, v279);

        if u276 > 0.03333333333333333 then
            u276 = u276 % 0.03333333333333333;
            Timer.Position = UDim2.new(Timer.Position.X.Scale, Random_new_ret:NextNumber(-math_lerp_ret, math_lerp_ret), 0, random(-math_lerp_ret, math_lerp_ret));
            Timer.Rotation = Random_new_ret:NextNumber(-3, 3);
        end;

        Timer.TextColor3 = Color3.new(1, 1, 1):Lerp(Color3.new(1, 0.2, 0.2), v279);
        u276 = u276 + p278;
    end);
    u238.charContainer:Connect(u238.soccerState.overtime.Changed, function(p280) -- Line: 2346
        -- upvalues: Value2 (ref)
        Value2 = p280;
    end);

    if u238.state:WaitForChild("ingame").Value then
        u240:Destroy();
        u274.EqualizerSoundEffect.Enabled = false;
        u238:InGame();
    end;

    if ReplicatedStorage2.Ranked.Value then
        u238:bindRematchLobbyLock();
        u238:applyRematchLobbyLock();
    end;

    for _, descendant in workspace.map.barriar:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = true;
        end;
    end;

    workspace.map.fieldZoneSafe.CanCollide = false;
end;

function u3.InGame(u281) -- Line: 2369
    -- upvalues: controller_updateFromServer (copy), u3 (copy), TopbarIcon (copy), script_customFlowBars (copy), script_customHotbars (copy), wiki (copy), TweenService (copy), soundUtil (copy), ReplicatedStorage2 (copy), SoundService (copy), ReplicatedStorage (copy), GamepadContainer (copy), UserInputService (copy), actionUtil (copy), replication (copy), packets (copy), trove (copy), Players (copy)
    u281:destroyContainer();
    controller_updateFromServer(u281.setting.consoleRemapping);
    local Children = u281.setting.customKeybinds:GetChildren();
    local cachedKeybinds = u3.cachedKeybinds;

    for _, v in Children do
        cachedKeybinds[v.Name] = v.Value;
    end;

    local Value = u281.state:WaitForChild("team").Value;
    local u282 = Value == "A" and "B" or "A";

    if not u281.hastesterability then
        TopbarIcon.setTopbarEnabled(false);
    end;

    local u283 = script.Hotbar:Clone();
    u283:SetAttribute("MovesetReady", false);
    u283.Parent = u281.playerGui;
    u283.MagicHealth.Health.TextLabel.Text = u281.isGamepad and "Press DPad - Up to activate" or (u281.isTouchEnabled and "Click me to activate" or "Press G to activate");
    u283.MagicHealth.Health.flowCharge.Text = "0%";
    local Gamepad = u283.Gamepad;
    local v284 = u281.isGamepad and not (u281.setting:FindFirstChild("disableConsoleUI") and u281.setting.disableConsoleUI.Value);
    Gamepad.Visible = v284;
    u283.MagicHealth.button.Visible = u281.isTouchEnabled;
    local u285 = script_customFlowBars.Mount(u283, u281.style);

    if u285 then
        u283.MagicHealth.Health.Visible = false;
    end;

    script_customHotbars.Mount(u283, u281.style);

    local function updateBarColor() -- Line: 2395
        -- upvalues: wiki (ref), u281 (copy), u283 (ref)
        local v286 = wiki.styles[u281.style];

        if v286 then
            v286 = v286.color_bar;
        end;

        if not v286 then
            return;
        end;

        local v287 = v286[u281.character:GetAttribute("FlowActive") == true and (u281.soccerState.overtime.Value and "overtime_flow" or "flow") or "normal"];

        if v287 == nil then
            return;
        end;

        u283.MagicHealth.Health.Frame.UIGradient.Color = v287;
    end;

    updateBarColor();

    local function updateFlowBars() -- Line: 2423
        -- upvalues: u281 (copy), TweenService (ref), u283 (ref), updateBarColor (copy), u285 (copy)
        local v288 = 0;
        local v289 = false;

        for _, v in ipairs({ { "flow", "Frame" }, { "overflow", "Overflow" } }) do
            local v290 = u281.state:FindFirstChild(v[1]);

            if v290 then
                local Value2 = v290.Value;
                local Hotbar = u281.playerGui:FindFirstChild("Hotbar");
                local TweenInfo_new_ret2 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
                local UDim2_new_ret = UDim2.new(Value2 / 100, 0, 1, 0);
                TweenService:Create(Hotbar.MagicHealth.Health[v[2]], TweenInfo_new_ret2, {
                    Size = UDim2_new_ret
                }):Play();

                if Value2 > 0 then
                    if v[1] == "overflow" then
                        v288 = Value2;
                        v289 = true;
                    else
                        v288 = Value2;
                    end;
                end;
            end;
        end;

        u283.MagicHealth.Health.flowCharge.Text = `{math.floor(v288 / 100 * 100)}%`;
        local v291;

        if v288 >= 100 then
            v291 = not v289 and not u283.MagicHealth.FlowChains.Visible;
        else
            v291 = false;
        end;

        u283.MagicHealth.Health.TextLabel.Visible = v291;
        u283.MagicHealth.Health.flowCharge.Visible = not u283.MagicHealth.Health.TextLabel.Visible;
        updateBarColor();

        if u285 then
            u285:Set(v288 / 100, u281.character:GetAttribute("FlowActive") == true);
        end;
    end;

    local function toggleChains() -- Line: 2458
        -- upvalues: u281 (copy), u283 (ref), updateFlowBars (copy)
        if not (u281.state and u281.state:FindFirstChild("team")) then
            return;
        end;

        if u281.state.team.Value == "" then
            return;
        end;

        local v292 = u281.character:GetAttribute("FlowActive") == true;
        local v293 = u281.character:GetAttribute("FlowLocked") == true;
        local Value2 = u281.state.flow.Value;

        if v293 then
            v293 = not v292;
        end;

        if u283 and u283:FindFirstChild("MagicHealth") then
            u283.MagicHealth.FlowChains.Visible = v293;
            u283.MagicHealth.FlowLock.Visible = v293;
            local v294;

            if Value2 >= 100 then
                v294 = not v293;
            else
                v294 = false;
            end;

            u283.MagicHealth.Health.TextLabel.Visible = v294;
        end;

        updateFlowBars();
    end;

    u281.character:GetAttributeChangedSignal("FlowLocked"):Connect(toggleChains);
    u281.character:GetAttributeChangedSignal("FlowActive"):Connect(toggleChains);
    toggleChains();
    local v295 = wiki.styles[u281.style];

    if v295 and v295.modeInfo then
        local modeInfo = v295.modeInfo;
        u283.MagicHealth.saeText.Visible = true;
        u283.MagicHealth.saeText.UIGradient.Color = modeInfo.color;
        u283.MagicHealth.saeText.Text = modeInfo.text;
    end;

    local u296 = { "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight" };

    local function updateArsenalMarks() -- Line: 2488
        -- upvalues: u283 (ref), u281 (copy), u296 (copy)
        local v297 = u283:FindFirstChild("MagicHealth") and u283.MagicHealth:FindFirstChild("RolandArsenalMarks");

        if not v297 then
            return;
        end;

        v297.Visible = u281.style == "roland";

        for i, v in u296 do
            local v298 = v297:FindFirstChild(v, true);

            if v298 then
                v298 = v298:FindFirstChild("ActiveIndictator");
            end;

            if v298 then
                v298.Visible = u281.character:GetAttribute((`RolandArsenalMark{i}`)) == true;
            end;
        end;
    end;

    u281.character.AttributeChanged:Connect(function(p299) -- Line: 2501
        -- upvalues: updateArsenalMarks (copy)
        if p299:sub(1, 17) == "RolandArsenalMark" then
            updateArsenalMarks();
        end;
    end);
    updateArsenalMarks();

    if u281.isTouchEnabled then
        u281.playerGui:FindFirstChild("Hotbar").MagicHealth.button.MouseButton1Click:connect(function() -- Line: 2518
            -- upvalues: u281 (copy)
            u281.baseClient:use("baseAwaken");
        end);
    end;

    if u281.setting.autoHeader.Value then
        u283.MagicHealth.ModeText.Text = "MODE : TECHNIQUES";
    else
        u283.MagicHealth.ModeText.Text = `MODE : {string.upper(u281.state:WaitForChild("mode").Value)}`;
    end;

    if u281.style == "akashi" then
        u283.MagicHealth.Awakening.Text = "ZONE";
    else
        u283.MagicHealth.Awakening.Text = "FLOW";
    end;

    u281.state:WaitForChild("mode").Changed:connect(function(p300) -- Line: 2535
        -- upvalues: u281 (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref)
        local Hotbar = u281.playerGui:FindFirstChild("Hotbar");
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        Hotbar.MagicHealth.ModeText.Text = `MODE : {string.upper(p300)}`;
    end);
    u281.state:WaitForChild("flow").Changed:connect(updateFlowBars);
    u281.state:WaitForChild("overflow").Changed:connect(updateFlowBars);

    local function scoreChange() -- Line: 2546
        -- upvalues: u281 (copy), Value (copy), u282 (copy)
        local Hotbar = u281.playerGui:FindFirstChild("Hotbar");

        if not (Hotbar and Hotbar:IsDescendantOf(game)) then
            return;
        end;

        pcall(function() -- Line: 2550
            -- upvalues: Hotbar (copy), u281 (ref), Value (ref), u282 (ref)
            Hotbar.Home.Text = `Home : {u281.soccerState[`{Value}score`].Value}`;
            Hotbar.Away.Text = `{u281.soccerState[`{u282}score`].Value} : Away`;
        end);
    end;

    scoreChange();

    local function fixName(p301: string?) -- Line: 2560
        -- upvalues: u281 (copy)
        return p301:gsub("{username}", u281.player.Name):gsub("{displayname}", u281.player.DisplayName);
    end;

    u281.charContainer:Add(u281.soccerState.Ascore.Changed:connect(scoreChange));
    u281.charContainer:Add(u281.soccerState.Bscore.Changed:connect(scoreChange));

    local function forfeitAppeared(u302) -- Line: 2567
        -- upvalues: u281 (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref)
        if not u302 then
            return;
        end;

        local Hotbar = u281.playerGui:FindFirstChild("Hotbar");

        if not Hotbar then
            return;
        end;

        Hotbar.Forfeit.Visible = true;
        local u303 = u281.soccerState[`{u281.player:GetAttribute("team") or "A"}forfeit`];

        if u303.Value > 0 then
            Hotbar.Forfeit.Label.Text = "FORFEIT";
        else
            Hotbar.Forfeit.Label.Text = `FF {u303.Value}/{u303:GetAttribute("max")}`;
        end;

        local u304 = u281.charContainer:Extend();
        u304:Connect(u302.AncestryChanged, function() -- Line: 2585
            -- upvalues: u304 (copy)
            u304:Destroy();
        end);
        u304:Add(function() -- Line: 2588
            -- upvalues: Hotbar (copy)
            Hotbar.Forfeit.Visible = false;
        end);
        u304:Connect(u303.Changed, function(p305) -- Line: 2591
            -- upvalues: Hotbar (copy), u303 (copy)
            Hotbar.Forfeit.Label.Text = `FF {p305}/{u303:GetAttribute("max")}`;
        end);
        u304:Connect(Hotbar.Forfeit.MouseButton1Click, function() -- Line: 2594
            -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u302 (copy)
            soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
            u302:FireServer();
        end);
    end;

    u281.charContainer:Add(ReplicatedStorage.ChildAdded:Connect(function(p306) -- Line: 2599
        -- upvalues: forfeitAppeared (copy)
        if p306:IsA("RemoteEvent") and p306.Name == "ForfeitRemote" then
            forfeitAppeared(p306);
        end;
    end));
    task.spawn(forfeitAppeared, ReplicatedStorage:FindFirstChild("ForfeitRemote"));

    if wiki.styles[u281.style] and wiki.styles[u281.style].AwakeningName then
        u283.MagicHealth.TextLabel.Visible = true;
        u283.MagicHealth.TextLabel.Text = wiki.styles[u281.style].AwakeningName;
    end;

    local u307 = {
        One = 1,
        Two = 2,
        Three = 3,
        Four = 4,
        Five = 5,
        Six = 6,
        Seven = 7,
        Eight = 8,
        Nine = 9,
        Zero = 0
    };

    local function getMoveNumber(p308) -- Line: 2624
        -- upvalues: u281 (copy), GamepadContainer (ref), UserInputService (ref), u307 (copy)
        if typeof(p308) ~= "number" then
            return "";
        end;

        local v309 = u281.isGamepad and UserInputService:GetStringForKeyCode(GamepadContainer[p308].KeyCode):gsub("^Button", "") or (u281.isTouchEnabled and p308 and p308 or u281.setting.customKeybinds[`skill{p308}`].Value);
        local v310 = u307[tostring(v309)] or v309;

        return tostring(v310);
    end;

    local function editButtonForMoveset(p311, p312) -- Line: 2633
        -- upvalues: u281 (copy)
        local v313;

        if type(p312) == "table" then
            v313 = p312[1];
            local v314 = p312[2];

            if v314 then
                p311.Base.Reuse.Visible = true;
                p311.Base.Reuse.Text = v314;
            end;
        else
            p311.Base.Reuse.Visible = false;
            v313 = p312;
        end;

        p311.Base.ToolName.Text = v313:gsub("{username}", u281.player.Name):gsub("{displayname}", u281.player.DisplayName);
        p311.Visible = true;
    end;

    local function createCustomSkillButton(p315, p316, p317) -- Line: 2650
        -- upvalues: getMoveNumber (copy), u281 (copy), u283 (ref)
        local u318 = script.Base:Clone();
        u318.Name = p315;
        local v319 = getMoveNumber(p316);
        local Number = u318.Base.Number;
        Number.Text = v319;
        Number.TextSize = Number.TextSize * (#v319 == 1 and 1.25 or 1);
        u318.LayoutOrder = p316 or 67;
        local v320;

        if type(p317) == "table" then
            v320 = p317[1];
            local v321 = p317[2];

            if v321 then
                u318.Base.Reuse.Visible = true;
                u318.Base.Reuse.Text = v321;
            end;
        else
            u318.Base.Reuse.Visible = false;
            v320 = p317;
        end;

        u318.Base.ToolName.Text = v320:gsub("{username}", u281.player.Name):gsub("{displayname}", u281.player.DisplayName);
        u318.Visible = true;

        if p315 == "Tspecialer" then
            u318.Size = UDim2.new(0, 50, 0, 50);
        end;

        u318.Parent = u283.Backpack.Hotbar;
        u318.Base.MouseButton1Click:connect(function(p322) -- Line: 2667
            -- upvalues: u318 (copy), u281 (ref)
            if not shared.AwaitingUnholdForMobile[u318.Name] then
                u281.baseClient:use(u318.Name);

                return;
            end;

            shared.AwaitingUnholdForMobile[u318.Name] = nil;
            u281.baseClient:senduse({ u318.Name, false });
            print("Button was manually pressed to unhold");
        end);

        return u318;
    end;

    local function createSkillButton(p323, p324, p325) -- Line: 2679
        -- upvalues: u283 (ref), getMoveNumber (copy), u281 (copy)
        local u326 = u283.Base:Clone();
        u326.Name = p323;
        local v327 = getMoveNumber(p324);
        local Number = u326.Base.Number;
        Number.Text = v327;
        Number.TextSize = Number.TextSize * (#v327 == 1 and 1.25 or 1);
        u326.LayoutOrder = p324 or 67;
        local v328;

        if type(p325) == "table" then
            v328 = p325[1];
            local v329 = p325[2];

            if v329 then
                u326.Base.Reuse.Visible = true;
                u326.Base.Reuse.Text = v329;
            end;
        else
            u326.Base.Reuse.Visible = false;
            v328 = p325;
        end;

        u326.Base.ToolName.Text = v328:gsub("{username}", u281.player.Name):gsub("{displayname}", u281.player.DisplayName);
        u326.Visible = true;

        if p323 == "Tspecialer" then
            u326.Size = UDim2.new(0, 50, 0, 50);
        end;

        u326.Parent = u283.Backpack.Hotbar;
        u326.Base.MouseButton1Click:connect(function(p330) -- Line: 2696
            -- upvalues: u326 (copy), u281 (ref)
            if not shared.AwaitingUnholdForMobile[u326.Name] then
                u281.baseClient:use(u326.Name);

                return;
            end;

            shared.AwaitingUnholdForMobile[u326.Name] = nil;
            u281.baseClient:senduse({ u326.Name, false });
            print("Button was manually pressed to unhold");
        end);

        return u326;
    end;

    if wiki.styles[u281.style] then
        for i, v in ipairs(wiki.styles[u281.style].movesets) do
            createSkillButton(`skill{i}`, i, v);
        end;

        if wiki.styles[u281.style].TSpecial and not actionUtil.checkGK(u281.character) then
            createSkillButton("Tspecialer", nil, wiki.styles[u281.style].TSpecial);
        end;
    end;

    u283:SetAttribute("MovesetReady", true);
    replication.applyPendingMoveset();

    if u281.style == "roland" then
        require(ReplicatedStorage2.client.rolandCardsUI)(u281, u283);
    end;

    if u281.style == "custom" and not u281.CustomMovesetConn then
        u281.CustomMovesetConn = packets.bytenet_custommoveset.listen(function(p331) -- Line: 2727
            -- upvalues: u283 (ref), u281 (copy), createCustomSkillButton (copy), actionUtil (ref)
            pcall(game.Destroy, u283);

            for _, child in u281.playerGui:GetChildren() do
                if child.Name == "Hotbar" then
                    pcall(game.Destroy, child);
                end;
            end;

            u283 = script.Hotbar:Clone();
            u283.MagicHealth.button.MouseButton1Click:connect(function() -- Line: 2738
                -- upvalues: u281 (ref)
                u281.baseClient:use("baseAwaken");
            end);
            u283.Parent = u281.playerGui;
            u283.MagicHealth.Health.TextLabel.Text = u281.isGamepad and "Press DPad - Up to activate" or (u281.isTouchEnabled and "Click me to activate" or "Press G to activate");
            u283.MagicHealth.Health.flowCharge.Text = "0%";
            u283.Gamepad.Visible = u281.isGamepad;
            u283.MagicHealth.button.Visible = u281.isTouchEnabled;

            if p331 then
                for i, v in ipairs(p331.moveset) do
                    createCustomSkillButton(`skill{i}`, i, v);
                end;

                if p331.tspecial and not actionUtil.checkGK(u281.character) then
                    createCustomSkillButton("Tspecialer", nil, p331.tspecial);
                end;

                if p331.awaken then
                    u283.MagicHealth.TextLabel.Visible = true;
                    u283.MagicHealth.TextLabel.Text = p331.awaken[1];
                end;
            end;
        end);
    end;

    local v332 = trove.new();
    v332:AttachToInstance(u281.character);
    local RandomizedForPlayer = actionUtil.getRandomizedForPlayer(u281.player);

    if RandomizedForPlayer then
        local function handleRandomized(p333) -- Line: 2771
            -- upvalues: actionUtil (ref), u283 (ref), u281 (copy), createSkillButton (copy)
            local MoveInfoForRandomized = actionUtil.getMoveInfoForRandomized(p333);

            if not MoveInfoForRandomized then
                return;
            end;

            local _, v334, v335 = table.unpack(MoveInfoForRandomized);

            if not (v334 and v335) then
                return;
            end;

            local v336 = u283.Backpack.Hotbar:FindFirstChild(v335);

            if not v336 then
                createSkillButton(v335, tonumber(p333.Name), v334);

                return;
            end;

            if type(v334) == "table" then
                local v337 = v334[1];
                local v338 = v334[2];

                if v338 then
                    v336.Base.Reuse.Visible = true;
                    v336.Base.Reuse.Text = v338;
                    v334 = v337;
                else
                    v334 = v337;
                end;
            else
                v336.Base.Reuse.Visible = false;
            end;

            v336.Base.ToolName.Text = v334:gsub("{username}", u281.player.Name):gsub("{displayname}", u281.player.DisplayName);
            v336.Visible = true;
        end;

        local function handleRemovedRandomized(p339, p340) -- Line: 2783
            -- upvalues: u283 (ref), u281 (copy)
            local v341 = u283.Backpack.Hotbar:FindFirstChild(p339);

            if v341 then
                if p340 then
                    if type(p340) == "table" then
                        local v342 = p340[1];
                        local v343 = p340[2];

                        if v343 then
                            v341.Base.Reuse.Visible = true;
                            v341.Base.Reuse.Text = v343;
                            p340 = v342;
                        else
                            p340 = v342;
                        end;
                    else
                        v341.Base.Reuse.Visible = false;
                    end;

                    v341.Base.ToolName.Text = p340:gsub("{username}", u281.player.Name):gsub("{displayname}", u281.player.DisplayName);
                    v341.Visible = true;

                    return;
                end;

                v341:Destroy();
            end;
        end;

        v332:Add(RandomizedForPlayer.ChildAdded:Connect(handleRandomized));
        v332:Add(RandomizedForPlayer.ChildRemoved:Connect(function(p344) -- Line: 2794
            -- upvalues: wiki (ref), u281 (copy), u283 (ref)
            local v345 = wiki.styles[u281.style];

            if tonumber(p344.Name) then
                local v346 = `skill{p344.Name}`;
                local v347 = v345.movesets[tonumber(p344.Name)];
                local v348 = u283.Backpack.Hotbar:FindFirstChild(v346);

                if v348 then
                    if not v347 then
                        v348:Destroy();

                        return;
                    end;

                    if type(v347) == "table" then
                        local v349 = v347[1];
                        local v350 = v347[2];

                        if v350 then
                            v348.Base.Reuse.Visible = true;
                            v348.Base.Reuse.Text = v350;
                            v347 = v349;
                        else
                            v347 = v349;
                        end;
                    else
                        v348.Base.Reuse.Visible = false;
                    end;

                    v348.Base.ToolName.Text = v347:gsub("{username}", u281.player.Name):gsub("{displayname}", u281.player.DisplayName);
                    v348.Visible = true;
                end;
            elseif p344.Name == "Tspecialer" then
                local TSpecial = v345.TSpecial;
                local v351 = u283.Backpack.Hotbar:FindFirstChild(p344.Name);

                if v351 then
                    if TSpecial then
                        if type(TSpecial) == "table" then
                            local v352 = TSpecial[1];
                            local v353 = TSpecial[2];

                            if v353 then
                                v351.Base.Reuse.Visible = true;
                                v351.Base.Reuse.Text = v353;
                                TSpecial = v352;
                            else
                                TSpecial = v352;
                            end;
                        else
                            v351.Base.Reuse.Visible = false;
                        end;

                        v351.Base.ToolName.Text = TSpecial:gsub("{username}", u281.player.Name):gsub("{displayname}", u281.player.DisplayName);
                        v351.Visible = true;

                        return;
                    end;

                    v351:Destroy();
                end;
            end;
        end));

        for _, child in ipairs(RandomizedForPlayer:GetChildren()) do
            task.spawn(handleRandomized, child);
        end;
    end;

    v332:Add(task.spawn(function() -- Line: 2807
        -- upvalues: Players (ref), u281 (copy)
        local v354 = nil;
        local v355 = nil;
        local v356 = tick();
        local u357 = false;
        local v358 = Players.LocalPlayer.CharacterAdded:Once(function() -- Line: 2814
            -- upvalues: u357 (ref)
            u357 = true;
        end);

        while true do
            task.wait(0.25);
            local character = u281.character;

            if character then
                v354 = character:FindFirstChildWhichIsA("Shirt");
                v355 = character:FindFirstChildWhichIsA("Pants");
            end;

            if v354 and v354:GetAttribute("gp") or (v355 and v355:GetAttribute("gp") or (tick() - v356 >= 90 or u357)) then
                if v358 then
                    v358:Disconnect();
                end;

                if tick() - v356 >= 90 then
                    return;
                end;

                if u281.setting:FindFirstChild("SpecificJersey") and (v354 and (v355 and (v354:GetAttribute("gp") and v355:GetAttribute("gp")))) then
                    print("Found setting");
                    local A = u281.setting:FindFirstChild("SpecificJersey"):FindFirstChild("A");
                    local B = u281.setting:FindFirstChild("SpecificJersey"):FindFirstChild("B");
                    local Value2 = u281.state.team.Value;
                    print("Checking team validation");

                    if Value2 == A.Name and A.Value ~= "none" or Value2 == B.Name and B.Value ~= "none" then
                        print("Current team has a valid option");

                        if Value2 == A.Name then
                            B = A or B;
                        end;

                        v354.ShirtTemplate = v354:GetAttribute("gp") or "rbxassetid://0";
                        v355.PantsTemplate = v355:GetAttribute("gp") or "rbxassetid://0";
                        print("Set");

                        if B.Value == "user" and (u281.character and (u281.character:FindFirstChild("Torso") and u281.character.Torso:FindFirstChild("BackDecal"))) then
                            u281.character.Torso:FindFirstChild("BackDecal"):Destroy();
                        end;
                    end;
                end;

                return;
            end;
        end;
    end));
end;

local function Color3ToRichText(p359, p360: any) -- Line: 2860
    return string.format("<font color=\'#%s\'>%s</font>", p359:ToHex(), p360);
end;

local function stripRichText(u361) -- Line: 2864
    local u362 = {};
    local u363 = {};
    local u364 = 0;
    local u365 = 0;

    local function push(p366: number, p367: number) -- Line: 2870
        -- upvalues: u365 (ref), u361 (copy), u363 (copy), u364 (ref), u362 (copy)
        if p366 <= u365 then
            return;
        end;

        local string_sub_ret = string.sub(u361, p366, p367);
        local v368 = string_sub_ret == "<" and string.find(u361, ">", p366, true);

        if v368 then
            u363[u364] = (u363[u364] or "") .. string.sub(u361, p366, v368);
            u365 = v368;

            return;
        end;

        u364 = u364 + 1;
        u362[u364] = string_sub_ret;
    end;

    if utf8.len(u361) then
        for i, v in utf8.graphemes(u361) do
            if i > u365 then
                local string_sub_ret = string.sub(u361, i, v);
                local v369 = string_sub_ret == "<" and string.find(u361, ">", i, true);

                if v369 then
                    u363[u364] = (u363[u364] or "") .. string.sub(u361, i, v369);
                    u365 = v369;
                else
                    u364 = u364 + 1;
                    u362[u364] = string_sub_ret;
                end;
            end;
        end;
    else
        for i = 1, string.len(u361) do
            local v370;

            if i <= u365 then
                v370 = i;
            else
                local string_sub_ret = string.sub(u361, i, i);
                local v371 = string_sub_ret == "<" and string.find(u361, ">", i, true);

                if v371 then
                    u363[u364] = (u363[u364] or "") .. string.sub(u361, i, v371);
                    u365 = v371;
                    v370 = i;
                else
                    u364 = u364 + 1;
                    u362[u364] = string_sub_ret;
                    v370 = i;
                end;
            end;
        end;
    end;

    return table.concat(u362), u363, u364, u362;
end;

local function ColorSequenceIntoRichText(p372, p373) -- Line: 2902
    -- upvalues: stripRichText (copy)
    local v374 = {};

    for _, v in p372.Color do
        table.insert(v374, v);
    end;

    local _, v375, v376, v377 = stripRichText(p373);
    local v378 = v375[0] or "";

    for i = 1, v376 do
        local v379 = i / v376;
        local v380 = v374[1][2];
        local v381 = v374[#v374][2];
        local v382 = v376;
        local v383 = i;
        local v384 = 0;

        for _, v in v374 do
            if v[1] <= v379 then
                v380 = v[2];
                v384 = v[1];
            end;

            if v379 <= v[1] then
                v381 = v[2];
                v382 = v[1];
                break;
            end;
        end;

        local v385 = v377[v383];
        v378 = v378 .. `<font color='#{v380:Lerp(v381, v382 == v384 and 0 or (v379 - v384) / (v382 - v384)):ToHex()}'>{v385}</font>`;

        if v375[v383] then
            v378 = v378 .. v375[v383];
        end;
    end;

    return v378;
end;

local function resolveChatDisplayPlayer(p386: userdata?) -- Line: 2953
    -- upvalues: Players (copy)
    if not p386 then
        return nil;
    end;

    local Attribute = p386:GetAttribute("ControllingUserId");

    return Attribute and Players:GetPlayerByUserId(Attribute) or p386;
end;

local function getChatDisplayPrefixText(p387: userdata, p388: userdata) -- Line: 2969
    -- upvalues: Players (copy)
    local v389 = p387.TextSource and Players:GetPlayerByUserId(p387.TextSource.UserId);

    if v389 == p388 then
        return p387.PrefixText;
    end;

    return `{p388.DisplayName}:`;
end;

local function ChannelPrefix(p390: any, p391: userdata?) -- Line: 2978
    -- upvalues: Players (copy)
    local TextChannel = p390.TextChannel;

    if not TextChannel then
        return "";
    end;

    local Name = TextChannel.Name;

    if Name:sub(1, 7) == "RBXTeam" then
        return "<font color=\'#FFFFFF\'>[Team]</font> ";
    end;

    if Name:sub(1, 10) == "RBXWhisper" then
        local LocalPlayer = Players.LocalPlayer;

        if not p391 then
            p391 = p390.TextSource and Players:GetPlayerByUserId(p390.TextSource.UserId);
        end;

        if p391 == LocalPlayer then
            local v392, v393 = Name:match("RBXWhisper:(%d+)_(%d+)");

            if tostring(LocalPlayer.UserId) == v392 then
                v392 = v393 or v392;
            end;

            local PlayerByUserId = Players:GetPlayerByUserId((tonumber(v392)));

            return `<font color='#FFFFFF'>[To {PlayerByUserId and PlayerByUserId.DisplayName or "Unknown"}]</font> `;
        end;

        if p391 then
            return `<font color='#FFFFFF'>[From {p391.DisplayName}]</font> `;
        end;
    end;

    return "";
end;

local function getColorSequenceFromTable(p394) -- Line: 3006
    local v395 = {};

    for i, v in ipairs(p394) do
        table.insert(v395, ColorSequenceKeypoint.new((i - 1) / (#p394 - 1), v));
    end;

    if #v395 == 0 then
        return ColorSequence.new(Color3.new(1, 1, 1));
    end;

    if #v395 == 1 then
        return ColorSequence.new(v395[1].Value);
    end;

    return ColorSequence.new(v395);
end;

local u396 = setmetatable({}, {
    __mode = "k"
});

local function getGroupInfo(p397) -- Line: 3022
    -- upvalues: u396 (copy), wiki (copy)
    local v398 = u396[p397];

    if v398 then
        return v398;
    end;

    local v399 = {
        rank = p397:GetRankInGroup(wiki.groupId),
        emperor = p397:GetRoleInGroupAsync(game.CreatorId) == "Emperors / T3"
    };
    u396[p397] = v399;

    return v399;
end;

function u3.title(p400) -- Line: 3033
    -- upvalues: TextChatService (copy), ChatWindowConfiguration (copy), Players (copy), u396 (copy), wiki (copy), getColorSequenceFromTable (copy), ReplicatedStorage2 (copy), Ranks (copy), ColorSequenceIntoRichText (copy), ChannelPrefix (copy), packets (copy)
    function TextChatService.OnChatWindowAdded(p401: userdata) -- Line: 3035
        -- upvalues: ChatWindowConfiguration (ref), Players (ref), u396 (ref), wiki (ref), getColorSequenceFromTable (ref), ReplicatedStorage2 (ref), Ranks (ref), ColorSequenceIntoRichText (ref), ChannelPrefix (ref)
        local v402 = ChatWindowConfiguration:DeriveNewMessageProperties();

        if not p401.TextSource then
            return v402;
        end;

        local PlayerByUserId = Players:GetPlayerByUserId(p401.TextSource.UserId);

        if PlayerByUserId then
            local Attribute = PlayerByUserId:GetAttribute("ControllingUserId");

            if Attribute then
                PlayerByUserId = Players:GetPlayerByUserId(Attribute) or PlayerByUserId;
            end;
        else
            PlayerByUserId = nil;
        end;

        if not PlayerByUserId then
            return v402;
        end;

        local v403 = p401.TextSource and Players:GetPlayerByUserId(p401.TextSource.UserId);
        local v404;

        if v403 == PlayerByUserId then
            v404 = p401.PrefixText;
        else
            v404 = `{PlayerByUserId.DisplayName}:`;
        end;

        local storage = PlayerByUserId:FindFirstChild("storage");
        local v405 = u396[PlayerByUserId];

        if not v405 then
            v405 = {
                rank = PlayerByUserId:GetRankInGroup(wiki.groupId),
                emperor = PlayerByUserId:GetRoleInGroupAsync(game.CreatorId) == "Emperors / T3"
            };
            u396[PlayerByUserId] = v405;
        end;

        local rank = v405.rank;
        local emperor = v405.emperor;
        local v406 = PlayerByUserId:WaitForChild("title").Value or "none";
        local UserId = p401.TextSource.UserId;
        local v407;

        if emperor then
            v407 = v406 ~= "none" and wiki.title[v406] or (wiki.cctitle[UserId] or wiki.highroletitile["7"]);
        else
            v407 = v406 ~= "none" and wiki.title[v406] or (wiki.cctitle[UserId] or wiki.highroletitile[rank]);
        end;

        local special_title = PlayerByUserId:FindFirstChild("special_title");

        if special_title then
            local v408 = {};

            for _, child in ipairs(special_title.colors:GetChildren()) do
                v408[tonumber(child.Name)] = child.Value;
            end;

            v407 = {
                tagText = special_title:GetAttribute("title"),
                tagColor = getColorSequenceFromTable(v408),
                specialer = special_title:GetAttribute("specialer"),
                nameaddition = special_title:GetAttribute("nameaddition")
            };
        end;

        if storage and storage.special_titles:FindFirstChild(v406) then
            local v409 = storage.special_titles:FindFirstChild(v406);
            local ColorSequence_new_ret = ColorSequence.new(Color3.new(255, 255, 255));
            local v410 = v409:FindFirstChild("tagColor") and v409:FindFirstChild("tagColor").Value;

            if v410 then
                local v411 = {};

                for i, v in string.split(v410, " ") do
                    v411[i] = tonumber(v);
                end;

                local v412 = {};

                for i = 1, #v411, 5 do
                    local table_unpack_ret, v413, v414, v415 = table.unpack(v411, i, i + 3);
                    local v416;

                    if table_unpack_ret then
                        table.insert(v412, ColorSequenceKeypoint.new(table_unpack_ret, Color3.new(v413, v414, v415)));
                        v416 = i;
                    else
                        v416 = i;
                    end;
                end;

                ColorSequence_new_ret = ColorSequence.new(v412);
            end;

            if v409:FindFirstChild("tagColor") then
                v407 = {
                    tagText = v409:FindFirstChild("tagText").Value,
                    tagColor = ColorSequence_new_ret
                };
                local v417;

                if v409:FindFirstChild("specialer") then
                    v417 = v409:FindFirstChild("specialer").Value or false;
                else
                    v417 = false;
                end;

                v407.specialer = v417;
                v407.nameaddition = v409:FindFirstChild("nameaddition") and v409:FindFirstChild("nameaddition").Value or false;
            end;
        end;

        if not v407 then
            local v418 = `<font color='#{PlayerByUserId.TeamColor.Color:ToHex()}'>{v404}</font>`;
            v402.Text = `{p401.Text}`;
            v402.PrefixText = ChannelPrefix(p401, PlayerByUserId) .. v418;

            if PlayerByUserId:GetAttribute("MarbleBall") then
                v402.PrefixText = ChannelPrefix(p401, PlayerByUserId) .. "<font color=\'#A0E1FF\'>(Ball)</font> " .. v418;

                return v402;
            end;

            if PlayerByUserId.Character and PlayerByUserId.Character:GetAttribute("role") == "GK" then
                v402.PrefixText = ChannelPrefix(p401, PlayerByUserId) .. "<font color=\'#FFFFFF\'>(GK)</font> " .. v418;
            end;

            return v402;
        end;

        local v419 = `<font color='#{PlayerByUserId.TeamColor.Color:ToHex()}'>{v404}</font>`;

        if ReplicatedStorage2.Ranked.Value then
            local v420 = PlayerByUserId:GetAttribute("elo") or 0;
            local v421 = Ranks.ReturnRank(v420, PlayerByUserId);
            local v422 = math.clamp(v420, v421.MinElo, v421.MaxElo) / v421.MaxElo;
            local math_lerp_ret = math.lerp(1, 5, v422);
            math.floor(math_lerp_ret);
            v419 = string.format("%s ", (ColorSequenceIntoRichText(v421, string.format("[ %s ]", v421.Name)))) .. v419;
        end;

        local tagText = v407.tagText;
        local tagColor = v407.tagColor;
        local v423 = v407.nameaddition or false;
        local v424 = v407.specialer and tagText and tagText or `[ {tagText} ]`;
        local v425 = PlayerByUserId.Character and PlayerByUserId.Character:GetAttribute("role") == "GK";
        local v426 = (v425 and "<font color=\'#FFFFFF\'>(GK)</font> " or "") .. (PlayerByUserId:GetAttribute("MarbleBall") and "<font color=\'#A0E1FF\'>(Ball)</font> " or "");

        if v423 then
            ({}).Color = {
                { 0, Color3.fromRGB(255, 255, 255) },
                { 1, Color3.fromRGB(255, 255, 255) }
            };
            local v427;

            if typeof(tagColor) == "Color3" then
                v427 = {
                    Color = {}
                };
                table.insert(v427.Color, { 0, tagColor });
                table.insert(v427.Color, { 1, tagColor });
            else
                v427 = {
                    Color = {}
                };

                for _, v in pairs(tagColor.Keypoints) do
                    table.insert(v427.Color, { v.Time, v.Value });
                end;
            end;

            local v428 = PlayerByUserId.TeamColor.Color:ToHex();
            Color3.fromRGB(255, 255, 255):ToHex();
            local string_split_ret = string.split(v404, ":");
            local v429 = string_split_ret[1];
            local v430 = string_split_ret[2];
            local v431;

            if string.sub(v424, 1, 1) == "," then
                v431 = `<font color='#{v428}'>{v429 .. ","}</font>`;
                local string_len_ret = string.len(v424);
                v424 = string.sub(v424, 2, string_len_ret);
            else
                v431 = `<font color='#{v428}'>{v429}</font>`;
            end;

            v424 = ColorSequenceIntoRichText(v427, v424);
            v419 = v426 .. v431 .. v424 .. ":" .. v430;
            v402.PrefixText = ChannelPrefix(p401, PlayerByUserId) .. v419;
        end;

        v402.Text = `{p401.Text}`;

        if not v423 then
            if tagColor then
                if typeof(tagColor) == "Color3" then
                    v424 = string.format("<font color=\'#%s\'>%s</font>", tagColor:ToHex(), v424);
                else
                    local v432 = {
                        Color = {}
                    };

                    for _, v in pairs(tagColor.Keypoints) do
                        table.insert(v432.Color, { v.Time, v.Value });
                    end;

                    v424 = ColorSequenceIntoRichText(v432, v424);
                end;
            end;

            v402.PrefixText = ChannelPrefix(p401, PlayerByUserId) .. v424 .. " " .. v426 .. v419;
        end;

        return v402;
    end;

    function TextChatService.OnIncomingMessage(p433: userdata) -- Line: 3213
        -- upvalues: Players (ref)
        local TextSource = p433.TextSource;

        if not TextSource then
            return;
        end;

        local PlayerByUserId = Players:GetPlayerByUserId(TextSource.UserId);

        if PlayerByUserId and PlayerByUserId:GetAttribute("BeingControlledBy") then
            local TextChatMessageProperties = Instance.new("TextChatMessageProperties");
            TextChatMessageProperties.Text = " ";

            return TextChatMessageProperties;
        end;
    end;

    local u434 = {};

    function TextChatService.OnBubbleAdded(p435: userdata) -- Line: 3229
        -- upvalues: Players (ref), u434 (copy), packets (ref)
        local v436 = p435.TextSource and Players:GetPlayerByUserId(p435.TextSource.UserId);

        if not v436 then
            return;
        end;

        local Attribute = v436:GetAttribute("ControllingUserId");

        if Attribute then
            local BubbleChatMessageProperties = Instance.new("BubbleChatMessageProperties");
            BubbleChatMessageProperties.Text = " ";
            BubbleChatMessageProperties.TextSize = 0;
            BubbleChatMessageProperties.TailVisible = false;

            if v436 ~= Players.LocalPlayer then
                return BubbleChatMessageProperties;
            end;

            if p435.Status ~= Enum.TextChatMessageStatus.Success then
                return BubbleChatMessageProperties;
            end;

            local MessageId = p435.MessageId;

            if not MessageId or u434[MessageId] then
                return BubbleChatMessageProperties;
            end;

            u434[MessageId] = true;
            task.delay(10, function() -- Line: 3259
                -- upvalues: u434 (ref), MessageId (copy)
                u434[MessageId] = nil;
            end);
            packets.bytenet_mindControlBubble.send({
                text = p435.Text,
                targetUserId = Attribute,
                messageId = MessageId
            });

            return BubbleChatMessageProperties;
        end;
    end;
end;

function u3.isRematchVoteActive(p437) -- Line: 3274
    -- upvalues: ReplicatedStorage2 (copy)
    local RankedRematchState = ReplicatedStorage2:FindFirstChild("RankedRematchState");

    if not RankedRematchState then
        return false;
    end;

    local Active = RankedRematchState:FindFirstChild("Active");
    local v438;

    if Active == nil then
        v438 = false;
    else
        v438 = Active:IsA("BoolValue") and Active.Value;
    end;

    return v438;
end;

function u3.isRematchLobbyLocked(p439) -- Line: 3283
    -- upvalues: ReplicatedStorage2 (copy)
    return p439.rematch_menu_locked == true and true or (ReplicatedStorage2:GetAttribute("RankedRematchLobbyLocked") == true and true or p439:isRematchVoteActive());
end;

function u3.applyRematchLobbyLock(p440) -- Line: 3289
    local v441 = p440:isRematchLobbyLocked();
    local lobbyui = p440.lobbyui;

    if lobbyui then
        local Frame = lobbyui:FindFirstChild("Frame");

        if Frame then
            for _, v in { "Menu", "Play" } do
                local v442 = Frame:FindFirstChild(v);

                if v442 and v442:IsA("GuiObject") then
                    v442.Visible = not v441;
                end;
            end;
        end;
    end;

    if v441 then
        p440:destroyContainer();
    end;
end;

function u3.bindRematchLobbyLock(u443) -- Line: 3308
    -- upvalues: ReplicatedStorage2 (copy)
    if u443.rematch_lobby_lock_bound then
        u443:applyRematchLobbyLock();

        return;
    end;

    u443.rematch_lobby_lock_bound = true;

    local function bind_state(p444: userdata) -- Line: 3315
        -- upvalues: u443 (copy)
        local Active = p444:WaitForChild("Active", 10);

        if not (Active and Active:IsA("BoolValue")) then
            return;
        end;

        u443:applyRematchLobbyLock();
        Active.Changed:Connect(function() -- Line: 3321
            -- upvalues: u443 (ref)
            u443:applyRematchLobbyLock();
        end);
        p444.Destroying:Connect(function() -- Line: 3324
            -- upvalues: u443 (ref)
            u443:applyRematchLobbyLock();
        end);
    end;

    local RankedRematchState = ReplicatedStorage2:FindFirstChild("RankedRematchState");

    if RankedRematchState then
        bind_state(RankedRematchState);
    end;

    ReplicatedStorage2.ChildAdded:Connect(function(p445) -- Line: 3333
        -- upvalues: bind_state (copy)
        if p445.Name == "RankedRematchState" then
            bind_state(p445);
        end;
    end);
    ReplicatedStorage2:GetAttributeChangedSignal("RankedRematchLobbyLocked"):Connect(function() -- Line: 3338
        -- upvalues: u443 (copy)
        u443:applyRematchLobbyLock();
    end);
end;

function u3.destroyContainer(p446) -- Line: 3343
    if p446.container then
        p446.container:Destroy();
        p446.container = nil;
    end;
end;

function u3.createContainer(p447) -- Line: 3347
    -- upvalues: trove (copy)
    if not p447.container then
        p447.container = trove.new();

        return p447.container;
    end;

    p447:destroyContainer();
end;

function u3.changeSpectate(p448: table, p449: userdata?, p450: any) -- Line: 3355
    -- upvalues: workspace_CurrentCamera (copy)
    if p448.isSpecate then
        if p450 and p448.cam ~= 0 then
            return;
        end;

        if p449 and not p449:IsA("Model") or p448.fakeNeon then
            workspace_CurrentCamera.CameraSubject = p449 or p448.fakeNeon;

            return;
        end;

        if not p449 then
            return;
        end;

        if not p449:FindFirstChildOfClass("Humanoid") then
            return;
        end;

        workspace_CurrentCamera.CameraSubject = p449:FindFirstChildOfClass("Humanoid");
    end;
end;

function u3.AchieveThings(p451) -- Line: 3379
    -- upvalues: soundUtil (copy), ReplicatedStorage2 (copy), SoundService (copy), ReplicatedStorage (copy), replication (copy), u4 (copy), TweenService (copy)
    local u452 = p451:createContainer();

    if not u452 then
        return;
    end;

    soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
    local u453 = script.Achievements:Clone();
    u452:Add(u453.Destroying:Once(function() -- Line: 3391
        -- upvalues: u452 (copy)
        u452:Destroy();
    end));
    u452:Add(u453);
    local Position = u453.Frame.Position;
    u453.Frame.Position = UDim2.fromScale(0.5, 0.4);
    u453.Frame.GroupTransparency = 1;
    local v454 = tick();
    local v455 = ReplicatedStorage.WhereWeAtWithAllThisAchievementStuff:InvokeServer();

    repeat
        task.wait();
    until v455 or tick() - v454 >= 3;

    if tick() - v454 >= 3 then
        replication.notification("Failed to load your achievement data. Please try again later.", nil, ReplicatedStorage2.Resources.notisound);
        u452:Destroy();

        return;
    end;

    local v456 = {};

    for i, v in v455 do
        local string_split_ret = string.split(i, "||");
        local v457 = string_split_ret[1];
        local v458 = string_split_ret[2];

        if not v456[v457] then
            v456[v457] = {};
        end;

        v456[v457][v458] = v;
    end;

    local u459 = "General";

    for i, v in u4 do
        local v460 = u453.Frame.Storage.FrameTemplate:Clone();
        v460.Parent = u453.Frame.Storage;
        v460.Name = i;
        v460.Visible = i == u459;
        local u461 = i;
        local v462 = 0;
        local v463 = 0;

        for _, v2 in v do
            v462 = v462 + 1;
            local v464 = v2.Requirement ~= nil;
            local v465 = u453.Frame.achievement_base:Clone();
            v465.Visible = true;
            v465.Main.Text = v2.Name;
            v465.Description.Text = string.format("\"%s\"", v2.Description);
            v465["Progress Bar"].Visible = v464;
            v465.Parent = v460.list;

            if v464 then
                local v466 = v465["Progress Bar"];
                local v467;

                if v456[u461] and v456[u461][v2.codename] then
                    v467 = tonumber(v456[u461][v2.codename]);

                    if v2.Requirement <= v467 then
                        v465.STATUS.Text = "COMPLETE";
                        v463 = v463 + 1;
                    end;
                else
                    v467 = 0;
                end;

                local Frame = Instance.new("Frame");
                Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                Frame.BackgroundTransparency = 0;
                Frame.Size = UDim2.fromScale(math.min(1, v467 / v2.Requirement), 1);
                Frame.Parent = v466;
                v466.Main.Text = string.format("%s/%s", tostring(v467), (tostring(v2.Requirement)));
            elseif v456[u461] and (v456[u461][v2.codename] and v456[u461][v2.codename]) then
                v465.STATUS.Text = "COMPLETE";
                v463 = v463 + 1;
            end;
        end;

        v460["2"].Text = string.format("%s/%s", tostring(v463), (tostring(v462)));
        local v468 = u453.Frame.TopicFrameHolder:Clone();
        v468.LayoutOrder = u461 == u459 and 0 or 1;
        v468.RealFrame.Main.Text = u461;
        v468.Parent = u453.Frame.Storage.StorageList;
        v468.Visible = true;
        v468.RealFrame.Button.MouseButton1Up:Connect(function() -- Line: 3478
            -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u459 (ref), u461 (copy), u453 (copy)
            soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
            u459 = u461;

            for _, child in u453.Frame.Storage:GetChildren() do
                if child:IsA("Frame") then
                    child.Visible = child.Name == u461;
                end;
            end;
        end);
    end;

    u453.Parent = p451.playerGui;
    TweenService:Create(u453.Frame, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        GroupTransparency = 0,
        Position = Position
    }):Play();
end;

function u3.Spectate(u469) -- Line: 3493
    -- upvalues: actionUtil (copy), packets (copy), Players (copy), TweenService (copy), soundUtil (copy), ReplicatedStorage2 (copy), SoundService (copy), workspace_CurrentCamera (copy)
    if actionUtil.statecheck(u469.character) then
        return;
    end;

    local v470 = u469:createContainer();

    if not v470 then
        return;
    end;

    local u471 = script.Spectate:Clone();
    u471.Parent = u469.playerGui;
    v470:Add(u471);
    u469.isSpecate = true;
    packets.bytenet_changeSpectate.send(true);
    local u472 = {};
    local workspace_characters = workspace.characters;

    local function isIngame(p473: userdata) -- Line: 3515
        local state = p473:FindFirstChild("state");

        if state then
            state = state.ingame;
        end;

        local v474;

        if state == nil then
            v474 = false;
        else
            v474 = state.Value == true;
        end;

        return v474;
    end;

    local function updateSpectateLabel(p475: userdata?) -- Line: 3521
        -- upvalues: u471 (copy), Players (ref)
        if not p475 then
            u471.Frame.scname.TextLabel.Text = "Ball Cam";

            return;
        end;

        local PlayerFromCharacter = Players:GetPlayerFromCharacter(p475);
        u471.Frame.scname.TextLabel.Text = PlayerFromCharacter and (PlayerFromCharacter.DisplayName == PlayerFromCharacter.Name and PlayerFromCharacter.Name or `{PlayerFromCharacter.DisplayName}\n({PlayerFromCharacter.Name})`) or p475.Name;
    end;

    local function goToBallCam() -- Line: 3530
        -- upvalues: u469 (copy), u471 (copy)
        u469.specChar = nil;
        u469.cam = 0;
        u471.Frame.scname.TextLabel.Text = "Ball Cam";
        local Value = u469.soccerState.ballHolder.Value;

        if Value then
            u469:changeSpectate(Value, true);

            return;
        end;

        u469:changeSpectate();
    end;

    local function addCharacter(p476: userdata) -- Line: 3543
        -- upvalues: u472 (copy)
        if table.find(u472, p476) then
            return;
        end;

        table.insert(u472, p476);
    end;

    local function findNearestIngame(p477: number) -- Line: 3548
        -- upvalues: u472 (copy)
        local v478 = #u472;

        if v478 == 0 then
            return nil, nil;
        end;

        for i = 0, v478 - 1 do
            local v479 = p477 - i;

            if v479 < 1 then
                break;
            end;

            local v480 = u472[v479];
            local state = v480:FindFirstChild("state");

            if state then
                state = state.ingame;
            end;

            local v481;

            if state == nil then
                v481 = false;
            else
                v481 = state.Value == true;
            end;

            if v481 then
                return v480, v479;
            end;

            local _ = i;
        end;

        for i = p477 + 1, v478 do
            local v482 = u472[i];
            local state = v482:FindFirstChild("state");

            if state then
                state = state.ingame;
            end;

            local v483;

            if state == nil then
                v483 = false;
            else
                v483 = state.Value == true;
            end;

            if v483 then
                return v482, i;
            end;

            local _ = i;
        end;

        return nil, nil;
    end;

    local function removeCharacter(p484: userdata) -- Line: 3567
        -- upvalues: u472 (copy), u469 (copy), findNearestIngame (copy), updateSpectateLabel (copy), u471 (copy)
        local table_find_ret = table.find(u472, p484);

        if not table_find_ret then
            return;
        end;

        table.remove(u472, table_find_ret);

        if u469.isSpecate and u469.specChar == p484 then
            local v485, v486 = findNearestIngame((math.max(table_find_ret - 1, 1)));

            if v485 then
                u469.specChar = v485;
                u469.cam = v486;
                updateSpectateLabel(v485);
                u469:changeSpectate(v485);

                return;
            end;

            u469.specChar = nil;
            u469.cam = 0;
            u471.Frame.scname.TextLabel.Text = "Ball Cam";
            local Value = u469.soccerState.ballHolder.Value;

            if Value then
                u469:changeSpectate(Value, true);

                return;
            end;

            u469:changeSpectate();
        end;
    end;

    for _, child in ipairs(workspace_characters:GetChildren()) do
        if child:IsA("Model") then
            if not table.find(u472, child) then
                table.insert(u472, child);
            end;
        end;
    end;

    v470:Add(workspace_characters.ChildAdded:Connect(function(p487) -- Line: 3594
        -- upvalues: u472 (copy)
        if p487:IsA("Model") then
            if table.find(u472, p487) then
                return;
            end;

            table.insert(u472, p487);
        end;
    end));
    v470:Add(workspace_characters.ChildRemoved:Connect(function(p488) -- Line: 3600
        -- upvalues: removeCharacter (copy)
        removeCharacter(p488);
    end));
    u469.specChar = nil;
    u469.cam = 0;
    u469.specChar = nil;
    u469.cam = 0;
    u471.Frame.scname.TextLabel.Text = "Ball Cam";
    local Value = u469.soccerState.ballHolder.Value;

    if Value then
        u469:changeSpectate(Value, true);
    else
        u469:changeSpectate();
    end;

    local function changeCam(p489) -- Line: 3609
        -- upvalues: u472 (copy), u469 (copy), u471 (copy), updateSpectateLabel (copy)
        local v490 = #u472;

        if v490 == 0 then
            u469.specChar = nil;
            u469.cam = 0;
            u471.Frame.scname.TextLabel.Text = "Ball Cam";
            local Value2 = u469.soccerState.ballHolder.Value;

            if Value2 then
                u469:changeSpectate(Value2, true);

                return;
            end;

            u469:changeSpectate();

            return;
        end;

        local v491 = u469.specChar and table.find(u472, u469.specChar) or 0 or 0;

        for i = 1, v490 do
            v491 = p489 and v491 + 1 or v491 - 1;

            if v490 < v491 then
                v491 = 0;
            elseif v491 < 0 then
                v491 = v490;
            end;

            if v491 == 0 then
                u469.specChar = nil;
                u469.cam = 0;
                u471.Frame.scname.TextLabel.Text = "Ball Cam";
                local Value2 = u469.soccerState.ballHolder.Value;

                if Value2 then
                    u469:changeSpectate(Value2, true);

                    return;
                end;

                u469:changeSpectate();

                return;
            end;

            local v492 = u472[v491];
            local v493;

            if v492 then
                local state = v492:FindFirstChild("state");

                if state then
                    state = state.ingame;
                end;

                local v494;

                if state == nil then
                    v494 = false;
                else
                    v494 = state.Value == true;
                end;

                if v494 then
                    u469.specChar = v492;
                    u469.cam = v491;
                    updateSpectateLabel(v492);
                    u469:changeSpectate(v492);

                    return;
                end;

                v493 = i;
            else
                v493 = i;
            end;
        end;

        u469.specChar = nil;
        u469.cam = 0;
        u471.Frame.scname.TextLabel.Text = "Ball Cam";
        local Value2 = u469.soccerState.ballHolder.Value;

        if Value2 then
            u469:changeSpectate(Value2, true);

            return;
        end;

        u469:changeSpectate();
    end;

    for _, child in ipairs(u471.Frame:GetChildren()) do
        if child:IsA("Frame") and child:FindFirstChild("Button") then
            local Size = child.Size;
            local UDim2_new_ret = UDim2.new(Size.X.Scale * 1.2, 0, Size.Y.Scale * 1.2, 0);
            local TweenInfo_new_ret2 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
            local u495 = TweenService:Create(child, TweenInfo_new_ret2, {
                Size = UDim2_new_ret
            });
            local u496 = TweenService:Create(child, TweenInfo_new_ret2, {
                Size = Size
            });
            child.Button.MouseEnter:Connect(function() -- Line: 3660
                -- upvalues: u495 (copy)
                u495:Play();
            end);
            child.Button.MouseLeave:Connect(function() -- Line: 3664
                -- upvalues: u496 (copy)
                u496:Play();
            end);
            child.Button.MouseButton1Up:Connect(function() -- Line: 3668
                -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref)
                soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
            end);
        end;
    end;

    u471.Frame.Left.Button.MouseButton1Up:Connect(function() -- Line: 3673
        -- upvalues: changeCam (copy)
        changeCam(false);
    end);
    u471.Frame.Right.Button.MouseButton1Up:Connect(function() -- Line: 3677
        -- upvalues: changeCam (copy)
        changeCam(true);
    end);
    v470:Add(u469.soccerState.ballHolder.Changed:Connect(function(p497) -- Line: 3681
        -- upvalues: u469 (copy)
        u469:changeSpectate(p497, true);
    end));
    v470:Add(function() -- Line: 3688
        -- upvalues: packets (ref), u469 (copy), workspace_CurrentCamera (ref)
        if not workspace.map.fieldZoneSafe.CanCollide then
            packets.bytenet_changeSpectate.send(false);
        end;

        u469.cam = nil;
        u469.specChar = nil;
        u469.isSpecate = false;
        workspace_CurrentCamera.CameraSubject = u469.human;
    end);
end;

function u3.ServerList(p498: table, u499: string) -- Line: 3701
    -- upvalues: Players (copy), CountriesToRegion (copy), ReplicatedStorage (copy), soundUtil (copy), ReplicatedStorage2 (copy), SoundService (copy), packets (copy), TweenService (copy), replication (copy), wiki (copy)
    local u500 = p498:createContainer();

    if not u500 then
        return;
    end;

    local u501 = script.ServerListUI:Clone();
    u501.Parent = p498.playerGui;
    u500:Add(u501);
    local CanvasGroup = u501.CanvasGroup;
    local u502 = "";
    local u503 = true;
    local u504 = tick();
    local u505 = {};
    local u506 = false;
    local u507 = {};
    local u508 = {
        [string.lower(u499)] = true
    };
    local success, result = pcall(function() -- Line: 3723
        -- upvalues: Players (ref)
        return game:GetService("LocalizationService"):GetCountryRegionForPlayerAsync(Players.LocalPlayer);
    end);
    local u509;

    if success then
        u502 = CountriesToRegion.Convert(result);
        CanvasGroup.ServerList.TextLabel.info.Text = string.format("Focus Region: %s", u502 or "idk");
        u509 = u502;
    else
        u509 = u502;
    end;

    local u510 = nil;

    local function call_for_current_list() -- Line: 3734
        -- upvalues: ReplicatedStorage (ref)
        return ReplicatedStorage.requestServer:InvokeServer("List");
    end;

    local function booleansetting(p511: userdata, p512: any) -- Line: 3739
        local Frame = p511:WaitForChild("Frame", 7);

        if not Frame then
            return;
        end;

        local boolean = Frame:WaitForChild("boolean");
        local UDim2_new_ret = UDim2.new(0, 0, 0, 0);
        local UDim2_new_ret2 = UDim2.new(0.5, 0, 0, 0);
        local Color3_fromRGB_ret2 = Color3.fromRGB(123, 255, 0);
        local Color3_fromRGB_ret3 = Color3.fromRGB(178, 255, 169);
        local Color3_fromRGB_ret4 = Color3.fromRGB(171, 0, 0);
        local Color3_fromRGB_ret5 = Color3.fromRGB(255, 107, 107);

        if p512 then
            UDim2_new_ret2 = UDim2_new_ret or UDim2_new_ret2;
        end;

        boolean.Position = UDim2_new_ret2;

        if p512 then
            Color3_fromRGB_ret4 = Color3_fromRGB_ret2 or Color3_fromRGB_ret4;
        end;

        Frame.BackgroundColor3 = Color3_fromRGB_ret4;

        if p512 then
            Color3_fromRGB_ret5 = Color3_fromRGB_ret3 or Color3_fromRGB_ret5;
        end;

        boolean.BackgroundColor3 = Color3_fromRGB_ret5;
    end;

    local function applyVisibility() -- Line: 3759
        -- upvalues: u505 (copy), u508 (copy), u503 (ref)
        for _, v in u505 do
            local v513 = u508[string.lower(v:GetAttribute("mode"))] == true;

            if v513 and (u503 and (v:GetAttribute("playercount") or 0) >= (v:GetAttribute("maxplayercount") or 0)) then
                v513 = false;
            end;

            v.Visible = v513;
        end;
    end;

    u500:Add(CanvasGroup.ServerList.Close.MouseButton1Up:Connect(function() -- Line: 3772
        -- upvalues: u500 (copy)
        u500:Destroy();
    end));
    CanvasGroup.Buttons.quick_join.MouseButton1Up:Connect(function() -- Line: 3776
        -- upvalues: u508 (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), u499 (copy), u502 (ref)
        local v514 = {};

        for i, v in u508 do
            if v then
                v514[i] = true;
            end;
        end;

        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        packets.bytenet_quickjoinRouletteServer.send({
            mode = u499,
            region = u502,
            selected_gamemodes = game:GetService("HttpService"):JSONEncode(v514)
        });
    end);
    CanvasGroup.Buttons.fullserver.MouseButton1Up:Connect(function() -- Line: 3791
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u503 (ref), booleansetting (copy), CanvasGroup (copy), applyVisibility (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        u503 = not u503;
        booleansetting(CanvasGroup.Buttons.fullserver, u503);
        applyVisibility();
    end);
    booleansetting(CanvasGroup.Buttons.fullserver, u503);

    local function refresh(p515) -- Line: 3799
        -- upvalues: u506 (ref), u507 (ref), CanvasGroup (copy), u509 (ref), u504 (ref), TweenService (ref), u510 (ref), ReplicatedStorage (ref), u505 (copy), CountriesToRegion (ref), u500 (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), u499 (copy), applyVisibility (copy)
        if u506 then
            return;
        end;

        for _, v in u507 do
            v();
        end;

        CanvasGroup.ServerList.TextLabel.info.Text = string.format("Focus Region: %s", u509 or "idk");
        u507 = {};
        u506 = true;
        task.delay(4, function() -- Line: 3812
            -- upvalues: u506 (ref)
            u506 = false;
        end);
        u504 = tick();
        TweenService:Create(CanvasGroup.Buttons.refresh.icon, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
            Rotation = CanvasGroup.Buttons.refresh.icon.Rotation + 360
        }):Play();

        if p515 then
            u510 = ReplicatedStorage.requestServer:InvokeServer("List");

            if u510 == "not loaded" then
                CanvasGroup.ServerList.Holder.Servers.info.Visible = true;
            else
                CanvasGroup.ServerList.Holder.Servers.info.Visible = false;
            end;
        end;

        for _, v in u505 do
            pcall(game.Destroy, v);
        end;

        table.clear(u505);
        local u516 = false;
        table.insert(u507, function() -- Line: 3835
            -- upvalues: u516 (ref)
            u516 = true;
        end);

        if u510 and typeof(u510) == "table" then
            for i, v in u510 do
                if i > 750 or u516 then
                    break;
                end;

                local key = v.key;
                local v517 = game:GetService("HttpService"):JSONDecode(v.value);
                local mode = v517.mode;

                if mode and (type(mode) ~= "string" or mode:lower() ~= "chaos") then
                    local v518 = mode == "rankedlobby" and 50 or (mode == "11v11" and 22 or (mode == "6v6" and 12 or 10));
                    local v519 = countryCodeToEmoji(v517.country);
                    local v520 = script.ServerButton:Clone();
                    v520.Visible = false;
                    v520:SetAttribute("mode", v517.mode);
                    v520:SetAttribute("country", v517.country);
                    v520:SetAttribute("playercount", (tonumber(v517.count)));
                    v520:SetAttribute("maxplayercount", (tonumber(v518)));
                    v520.Title.Text = string.format("%s %s: %s, %s (%s)", v519 or "?", v517.country, v517.region or "unknown region", CountriesToRegion.Convert(v517.country), string.upper(mode));
                    v520.Description.Text = string.format("PLAYERS: %s/%s", tostring(v517.count or "?"), v518);
                    v520.LayoutOrder = CountriesToRegion.Convert(v517.country) == u509 and 0 or 2;

                    if ReplicatedStorage:GetAttribute("server_id") and ReplicatedStorage:GetAttribute("server_id") == key then
                        v520.SameServer.Visible = true;
                    end;

                    v520.Parent = CanvasGroup.ServerList.Holder.Servers;
                    table.insert(u505, v520);
                    u500:Add(v520.MouseButton1Up:Connect(function() -- Line: 3890
                        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), u499 (ref), v (copy)
                        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
                        packets.bytenet_joinRouletteServer.send({
                            mode = u499,
                            id = tostring(v.key)
                        });
                    end));

                    if i % 10 == 0 then
                        applyVisibility();
                        task.wait();
                    end;
                end;
            end;

            applyVisibility();
        end;
    end;

    for i, _ in CountriesToRegion.Map do
        local v521 = script.RegionButtonServerList:Clone();
        v521.Text = i;
        v521.Parent = CanvasGroup.Regions.Holder.RegionList;
        v521.MouseButton1Up:Connect(function() -- Line: 3913
            -- upvalues: u505 (copy), CountriesToRegion (ref), i (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u509 (ref), CanvasGroup (copy), replication (ref)
            local v522 = false;

            for _, v in u505 do
                if CountriesToRegion.Convert(v:GetAttribute("country")) == i then
                    v522 = true;
                    break;
                end;
            end;

            print(v522);

            if not v522 then
                replication.notification("There are no visible servers in this region. Quick Joining will either create a server, or put you into a server of your own region.", nil, ReplicatedStorage2.Resources.notisound);

                return;
            end;

            soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
            u509 = i;
            CanvasGroup.ServerList.TextLabel.info.Text = string.format("Focus Region: %s", u509 or "idk");

            for _, v in u505 do
                v.LayoutOrder = CountriesToRegion.Convert(v:GetAttribute("country")) == u509 and 0 or 2;
            end;
        end);
    end;

    for _, v in wiki.gameModes do
        if v and (v[5] and v[5] == "serverList") then
            local string_lower_ret = string.lower(v[4]);
            local u523 = script.GamemodeToggle:Clone();
            u523.TextLabel.Text = v[1];
            u523.Parent = CanvasGroup.Gamemodes.Holder.GamemodeList;

            if not u508[string_lower_ret] then
                u508[string_lower_ret] = false;
            end;

            booleansetting(u523, u508[string_lower_ret]);
            u523.MouseButton1Up:Connect(function() -- Line: 3951
                -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u508 (copy), string_lower_ret (copy), booleansetting (copy), u523 (copy), applyVisibility (copy)
                soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
                u508[string_lower_ret] = not u508[string_lower_ret];
                booleansetting(u523, u508[string_lower_ret]);
                applyVisibility();
            end);
        end;
    end;

    u500:Add(CanvasGroup.Buttons.refresh.MouseButton1Up:Connect(function() -- Line: 3960
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), refresh (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        refresh(true);
    end));
    u504 = u504 - 59.5;
    u500:Add(packets.bytenet_server_list_refresh.listen(function(p524) -- Line: 3969
        -- upvalues: u504 (ref), refresh (copy)
        u504 = tick();
        refresh(true);
    end));
    u500:Add(task.spawn(function() -- Line: 3974
        -- upvalues: u501 (copy), refresh (copy)
        while task.wait(60) and u501.Parent do
            refresh(true);
        end;
    end));
end;

function u3.Regions(p525: table, u526: string) -- Line: 3982
    -- upvalues: wiki (copy), packets (copy)
    local u527 = p525:createContainer();

    if not u527 then
        return;
    end;

    local v528 = script.RankedRegions:Clone();
    v528.Parent = p525.playerGui;
    u527:Add(v528);
    local Frame = v528.Frame;
    u527:Add(Frame.Close.MouseButton1Up:Connect(function() -- Line: 3992
        -- upvalues: u527 (copy)
        u527:Destroy();
    end));

    for _, v in ipairs(wiki.rankedRegions) do
        local v529 = script.RegionButton:Clone();
        v529.Text = v;
        v529.Name = v;
        v529.Parent = Frame.Regions;
        u527:Add(v529);
        u527:Add(v529.MouseButton1Up:Connect(function() -- Line: 4002
            -- upvalues: packets (ref), u526 (copy), v (copy), u527 (copy)
            packets.bytenet_sendRegion.send({
                mode = u526,
                region = v
            });
            u527:Destroy();
        end));
    end;
end;

function u3.GamemodesUI(u530) -- Line: 4009
    -- upvalues: soundUtil (copy), ReplicatedStorage2 (copy), SoundService (copy), TweenService (copy), wiki (copy), packets (copy)
    local u531 = u530:createContainer();

    if not u531 then
        return;
    end;

    local v532 = script.GamemodeUI:Clone();
    v532.Parent = u530.playerGui;
    u531:Add(v532);
    soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
    local Position = v532.CanvasGroup.Position;
    v532.CanvasGroup.Position = UDim2.fromScale(0.5, 0.4);
    v532.CanvasGroup.GroupTransparency = 1;
    TweenService:Create(v532.CanvasGroup, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        GroupTransparency = 0,
        Position = Position
    }):Play();
    local Frame = v532.CanvasGroup.Frame;
    u531:Add(Frame.Close.MouseButton1Up:Connect(function() -- Line: 4029
        -- upvalues: u531 (copy)
        u531:Destroy();
    end));

    for i, v in ipairs(wiki.gameModes) do
        local v533 = script.GamemodeButton:Clone();
        v533.Title.Text = v[1] or "MISSING MODE NAME";
        v533.Description.Text = v[2] or "MISSING MODE DESCRIPTION";
        v533.ImageLabel.Image = v[3] or "rbxassetid://0";
        v533.Name = v[4] or "???YOTHISMODEMISSING";
        v533.New.Visible = table.find(wiki.new_gamemodes, v[1]) ~= nil;
        v533.LayoutOrder = i;
        v533.Parent = Frame.Holder.Gamemodes;
        u531:Add(v533);
        u531:Add(v533.MouseButton1Up:Connect(function() -- Line: 4043
            -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), v (copy), u530 (copy), packets (ref), u531 (copy)
            soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);

            if not v[5] then
                packets.bytenet_teleportGamemode.send(v[4]);
                u531:Destroy();

                return;
            end;

            u530:destroyContainer();
            local v534 = v[5] == "serverList" and "ServerList" or "Regions";
            print(v[4]);
            u530[v534](u530, v[4]);
        end));
    end;

    local Hosted = v532.Hosted;
    Hosted.Visible = true;
    Hosted.Parent = Frame.Holder.Gamemodes;
    u531:Connect(Hosted.Join.MouseButton1Click, function() -- Line: 4061
        -- upvalues: Hosted (copy), packets (ref)
        if Hosted.Code.Text ~= "" then
            packets.bytenet_teleportGamemode.send((`joinPS_{Hosted.Code.Text}`));
        end;
    end);
end;

function u3.PassUI(u535, u536) -- Line: 4070
    -- upvalues: wiki (copy), soundUtil (copy), ReplicatedStorage2 (copy), SoundService (copy), TweenService (copy), replication (copy), packets (copy), u38 (copy)
    local v537 = u535:createContainer();

    if not v537 then
        return;
    end;

    local RewardBase = script.PassTemplate.RewardBase;
    local Attribute = u535.player:GetAttribute((`{u536}Premium`));
    local u538 = wiki.PassInfo[u536];
    local v539 = script.PassTemplate:Clone();
    v539.Parent = u535.playerGui;
    v539.Name = "PassUI";
    v537:Add(v539);
    soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
    local Position = v539.CanvasGroup.Position;
    v539.CanvasGroup.Position = UDim2.fromScale(0.5, 0.4);
    v539.CanvasGroup.GroupTransparency = 1;
    TweenService:Create(v539.CanvasGroup, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        GroupTransparency = 0,
        Position = Position
    }):Play();
    local Main = v539.CanvasGroup.Main;
    Main.RankInfo.TextHolder.TextLabel.Text = u538[1];
    Main.RankInfo.Background.Image = u538[2];
    Main.ExtraUI.TrackBlocker.Visible = not Attribute;

    local function v545(p540, p541, p542) -- Line: 4100
        -- upvalues: RewardBase (copy), Attribute (ref), u535 (copy), Main (copy)
        local v543 = RewardBase:Clone();
        v543.LayoutOrder = p541;
        v543.Icon.Image = p542.icon;
        v543.Item.Text = p542.reward;
        v543.Tier.Text = `Rank {p541}`;
        local Shadow = v543.Shadow;
        local v544 = (Attribute or not p540) and p541 <= u535.player:GetAttribute("EventPassTier");
        Shadow.Visible = v544;
        v543.Visible = true;
        v543.Name = `Reward{p541}`;
        v543.Parent = Main.Rewards[p540 and "Premium" or "Free"];
    end;

    local v546 = u535.passData[u536];
    local u547 = #v546.premium_rewards > #v546.free_rewards and v546.premium_rewards or v546.free_rewards;
    local v548 = u547 == v546.premium_rewards and v546.free_rewards or v546.premium_rewards;

    for i, v in u547 do
        v545(u547 == v546.premium_rewards, i, v);

        if v548[i] then
            v545(u547 ~= v546.premium_rewards, i, v548[i]);
        end;
    end;

    local u549 = u535.player:GetAttribute((`{u536}XP`)) or 0;
    local u550 = u535.player:GetAttribute((`{u536}XPRequirement`)) or 1;
    Main.RankInfo.RankProgress.CurrentRank.Text = `Rank: {u535.player:GetAttribute("EventPassTier")}/{#u547}`;
    Main.RankInfo.RankProgress.Progress.Text = `{u549}/{u550} {u538[3]}`;
    Main.RankInfo.RankProgress.Bar.Size = UDim2.fromScale(math.min(u549 / u550, 1), 1);
    Main.RankInfo.BuyTier.Visible = u550 <= u549;
    v537:Add(Main.RankInfo.SkipAll.MouseButton1Down:Connect(function() -- Line: 4135
        -- upvalues: u535 (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u547 (copy), replication (ref), packets (ref), u38 (ref), u536 (copy)
        local v551 = tonumber(u535.player:GetAttribute("EventPassTier"));
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);

        if #u547 <= v551 then
            replication.notification("your event pass is already complete", nil, ReplicatedStorage2.Resources.notisound);

            return;
        end;

        packets.bytenet_marketPrompt.send({ u38[u536].skip_all });
    end));
    v537:Add(Main.RankInfo.SkipLevel.MouseButton1Down:Connect(function() -- Line: 4142
        -- upvalues: u535 (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u547 (copy), replication (ref), packets (ref), u38 (ref), u536 (copy)
        local v552 = tonumber(u535.player:GetAttribute("EventPassTier"));
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);

        if #u547 <= v552 then
            replication.notification("your event pass is already complete", nil, ReplicatedStorage2.Resources.notisound);

            return;
        end;

        packets.bytenet_marketPrompt.send({ u38[u536].skip });
    end));
    v537:Add(Main.RankInfo.BuyTier.MouseButton1Down:Connect(function() -- Line: 4149
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        packets.bytenet_BuyEventPassTier.send();
    end));
    v537:Add(Main.RankInfo.BuyPass.MouseButton1Down:Connect(function() -- Line: 4154
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), Attribute (ref), replication (ref), u535 (copy), packets (ref), u38 (ref), u536 (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);

        if Attribute then
            replication.notification(`you already have the pass... bad {u535.player.Name}`, nil, ReplicatedStorage2.Resources.notisound);

            return;
        end;

        packets.bytenet_marketPrompt.send({ u38[u536].premium });
    end));
    v537:Add(u535.player:GetAttributeChangedSignal((`{u536}Premium`)):Connect(function() -- Line: 4163
        -- upvalues: Attribute (ref), u535 (copy), u536 (copy), Main (copy)
        Attribute = u535.player:GetAttribute((`{u536}Premium`));
        Main.ExtraUI.TrackBlocker.Visible = not Attribute;

        for _, child in Main.Rewards.Premium:GetChildren() do
            if child:FindFirstChild("Shadow") then
                local v553 = child.Name:split("Reward")[2];
                local v554 = tonumber(v553);

                if v554 and u535.player:GetAttribute("EventPassTier") >= v554 then
                    child.Shadow.Visible = true;
                end;
            end;
        end;
    end));
    v537:Add(u535.player:GetAttributeChangedSignal("EventPassTier"):Connect(function() -- Line: 4176
        -- upvalues: Main (copy), u535 (copy), Attribute (ref)
        for _, child in Main.Rewards.Premium:GetChildren() do
            if child:FindFirstChild("Shadow") then
                local v555 = child.Name:split("Reward")[2];
                local v556 = tonumber(v555);

                if v556 and (u535.player:GetAttribute("EventPassTier") >= v556 and Attribute) then
                    child.Shadow.Visible = true;
                end;
            end;
        end;

        for _, child in Main.Rewards.Free:GetChildren() do
            if child:FindFirstChild("Shadow") then
                local v557 = child.Name:split("Reward")[2];
                local v558 = tonumber(v557);

                if v558 and u535.player:GetAttribute("EventPassTier") >= v558 then
                    child.Shadow.Visible = true;
                end;
            end;
        end;
    end));
    v537:Add(u535.player:GetAttributeChangedSignal((`{u536}XP`)):Connect(function() -- Line: 4194
        -- upvalues: u549 (ref), u535 (copy), u536 (copy), u550 (ref), Main (copy), u547 (copy), u538 (copy)
        u549 = u535.player:GetAttribute((`{u536}XP`)) or 0;
        u550 = u535.player:GetAttribute((`{u536}XPRequirement`)) or 1;
        Main.RankInfo.RankProgress.CurrentRank.Text = `Rank: {u535.player:GetAttribute("EventPassTier")}/{#u547}`;
        Main.RankInfo.RankProgress.Progress.Text = `{u549}/{u550} {u538[3]}`;
        Main.RankInfo.RankProgress.Bar.Size = UDim2.fromScale(math.min(u549 / u550, 1), 1);
        Main.RankInfo.BuyTier.Visible = u550 <= u549;
    end));
end;

function u3.votingUI(p559, p560) -- Line: 4208
    -- upvalues: TweenService (copy), soundUtil (copy), ReplicatedStorage2 (copy), SoundService (copy), packets (copy), ReplicatedStorage (copy)
    p559:destroyContainer();
    print("destroyed container");
    local u561 = p559:createContainer();

    if not u561 then
        print("container was missing");

        return;
    end;

    local v562 = script.VotingUI:Clone();
    v562.Parent = p559.playerGui;
    u561:Add(v562);
    local CanvasGroup = v562.CanvasGroup;
    local Position = CanvasGroup.Position;
    CanvasGroup.Position = UDim2.fromScale(0.5, 0.4);
    CanvasGroup.GroupTransparency = 1;
    TweenService:Create(CanvasGroup, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        GroupTransparency = 0,
        Position = Position
    }):Play();
    local u563 = {};
    local u564 = { 0, 0, 0 };

    for i, v in p560 do
        local u565 = nil;
        local u566 = script.ModeSelection:Clone();
        u566.ModeSelect.Title.Text = v[2];
        u566.Description.Text = v[3];
        u566.ModeSelect.Background.Image = v[4];
        u566.Votes.Text = "VOTES: 0";
        u566.LayoutOrder = i;
        u566.Parent = CanvasGroup.Frame.Holder;
        table.insert(u563, u566);
        local Size = u566.ModeSelect.Size;
        u561:Add(u566);
        u561:Add(u566.ModeSelect.MouseEnter:Connect(function() -- Line: 4244
            -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u565 (ref), TweenService (ref), u566 (copy), Size (ref)
            soundUtil:play(ReplicatedStorage2.Resources.hover, SoundService);

            if u565 then
                u565:Pause();
                u565 = nil;
            end;

            u565 = TweenService:Create(u566.ModeSelect, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
                Size = UDim2.fromScale(Size.X.Scale * 1.1, Size.Y.Scale * 1.1)
            });
            u565:Play();
        end));
        u561:Add(u566.ModeSelect.MouseLeave:Connect(function() -- Line: 4253
            -- upvalues: u565 (ref), TweenService (ref), u566 (copy), Size (ref)
            if u565 then
                u565:Pause();
                u565 = nil;
            end;

            u565 = TweenService:Create(u566.ModeSelect, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
                Size = Size
            });
            u565:Play();
        end));
        u561:Add(u566.ModeSelect.MouseButton1Up:Connect(function() -- Line: 4262
            -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), i (copy)
            soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
            packets.bytenet_voting.send(i);
        end));
    end;

    for _, child in ReplicatedStorage:WaitForChild("modifiers"):WaitForChild("Votes"):GetChildren() do
        if not child:IsA("NumberValue") then
            return;
        end;

        local Value = child.Value;

        if Value ~= 0 then
            u564[Value] = u564[Value] + 1;
            u563[Value].Votes.Text = `VOTES: {u564[Value]}`;
        end;

        u561:Add(child.Changed:Connect(function(p567) -- Line: 4275
            -- upvalues: Value (ref), u564 (copy), u563 (copy)
            if p567 == Value then
                return;
            end;

            local v568 = u564;
            local v569 = Value;
            v568[v569] = v568[v569] - 1;
            local v570 = u564;
            v570[p567] = v570[p567] + 1;
            u563[Value].Votes.Text = `VOTES: {u564[Value]}`;
            u563[p567].Votes.Text = `VOTES: {u564[p567]}`;
            Value = p567;
        end));
    end;

    u561:Add(ReplicatedStorage:WaitForChild("modifiers"):WaitForChild("Votes").ChildAdded:Connect(function(p571) -- Line: 4285
        -- upvalues: u564 (copy), u563 (copy), u561 (copy)
        if not p571:IsA("NumberValue") then
            return;
        end;

        local Value = p571.Value;

        if Value ~= 0 then
            local v572 = u564;
            v572[Value] = v572[Value] + 1;
            u563[Value].Votes.Text = `VOTES: {u564[Value]}`;
        end;

        u561:Add(p571.Changed:Connect(function(p573) -- Line: 4292
            -- upvalues: Value (ref), u564 (ref), u563 (ref)
            if p573 == Value then
                return;
            end;

            local v574 = u564;
            local v575 = Value;
            v574[v575] = v574[v575] - 1;
            local v576 = u564;
            v576[p573] = v576[p573] + 1;
            u563[Value].Votes.Text = `VOTES: {u564[Value]}`;
            u563[p573].Votes.Text = `VOTES: {u564[p573]}`;
            Value = p573;
        end));
    end));
end;

local function u579(p577: userdata, p578: any) -- Line: 4303
    local Frame = p577:WaitForChild("Frame");
    local boolean = Frame:WaitForChild("boolean");
    local UDim2_new_ret = UDim2.new(0, 0, 0, 0);
    local UDim2_new_ret2 = UDim2.new(0.5, 0, 0, 0);
    local Color3_fromRGB_ret2 = Color3.fromRGB(123, 255, 0);
    local Color3_fromRGB_ret3 = Color3.fromRGB(178, 255, 169);
    local Color3_fromRGB_ret4 = Color3.fromRGB(171, 0, 0);
    local Color3_fromRGB_ret5 = Color3.fromRGB(255, 107, 107);

    if p578 then
        UDim2_new_ret2 = UDim2_new_ret or UDim2_new_ret2;
    end;

    boolean.Position = UDim2_new_ret2;

    if p578 then
        Color3_fromRGB_ret4 = Color3_fromRGB_ret2 or Color3_fromRGB_ret4;
    end;

    Frame.BackgroundColor3 = Color3_fromRGB_ret4;

    if p578 then
        Color3_fromRGB_ret5 = Color3_fromRGB_ret3 or Color3_fromRGB_ret5;
    end;

    boolean.BackgroundColor3 = Color3_fromRGB_ret5;
end;

local script_AdvancedSettings = require(script.AdvancedSettings);

function AdvancedMenu(u580)
    -- upvalues: Players (copy), script_AdvancedSettings (copy), u579 (copy), packets (copy), soundUtil (copy), ReplicatedStorage2 (copy), SoundService (copy)
    local success, result = pcall(function() -- Line: 4324
        -- upvalues: u580 (copy), Players (ref), script_AdvancedSettings (ref), u579 (ref), packets (ref), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref)
        u580:destroyContainer();
        local u581 = script["Advanced Settings"]:Clone();

        if Players.LocalPlayer and (Players.LocalPlayer.setting:FindFirstChild("WeakerVFX") and Players.LocalPlayer.setting:FindFirstChild("WeakerVFX").Value) then
            u581.Frame.desc.Visible = true;
        end;

        for _, v in script_AdvancedSettings do
            local u582 = script.SettingAssets.AdvancedSettingToggle:Clone();
            u582.Name = v.datatitle;
            u582.title.Text = v.name;
            u582.desc.Text = v.description;
            u582.Parent = u581.Frame.ScrollingFrame;
            local AdvancedSettings = Players.LocalPlayer.setting:WaitForChild("AdvancedSettings");

            if AdvancedSettings and AdvancedSettings:FindFirstChild(v.datatitle) then
                local Value = AdvancedSettings:FindFirstChild(v.datatitle).Value;
                u579(u582, Value);
                u582.Frame.Button.MouseButton1Click:Connect(function() -- Line: 4346
                    -- upvalues: packets (ref), v (copy), Value (ref), u579 (ref), u582 (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref)
                    packets.bytenet_AdvancedsettingChange.send({
                        name = v.datatitle,
                        value = not Value
                    });
                    Value = not Value;
                    u579(u582, Value);
                    soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
                end);
            end;
        end;

        u581.Frame.LEAVE.MouseButton1Up:Once(function() -- Line: 4357
            -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u581 (copy)
            soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
            pcall(game.Destroy, u581);
        end);
        u581.Parent = Players.LocalPlayer.PlayerGui;
        print(u581.Parent.Name);
        print(u581.Name);
    end);
    print("hi", success, result);
end;

local function round(p583, p584) -- Line: 4368
    local v585 = 10 ^ (p584 or 0);

    return math.round(p583 * v585) / v585;
end;

local function roundTo(p586) -- Line: 4373
    if p586 < 10 then
        return math.round(p586 * 100) / 100;
    end;

    if p586 < 100 then
        return math.round(p586 * 10) / 10;
    end;

    return math.round(p586);
end;

local function formatStat(p587) -- Line: 4383
    if p587 ~= p587 then
        return "NaN";
    end;

    if p587 == (1 / 0) then
        return "inf";
    end;

    if p587 == (-1 / 0) then
        return "-inf";
    end;

    local math_abs_ret = math.abs(p587);
    local v588;

    if math_abs_ret < 10 then
        v588 = math.round(math_abs_ret * 100) / 100;
    elseif math_abs_ret < 100 then
        v588 = math.round(math_abs_ret * 10) / 10;
    else
        v588 = math.round(math_abs_ret);
    end;

    local v589, v590 = tostring(v588):match("^(%d+)(%.?.*)$");
    local v591 = v589:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");

    return (p587 < 0 and "-" or "") .. v591 .. v590;
end;

local function update_textconstraint(p592: any, p593: userdata, p594: number?) -- Line: 4398
    -- upvalues: update_textconstraint (copy)
    if type(p592) == "table" then
        for _, v in p592 do
            update_textconstraint(v, p593, p594);
        end;

        return;
    end;

    p592.MaxTextSize = p593.TextBounds.Y * (p594 or 1);
end;

local u607 = {
    Styles = {
        check = function(p595, p596) -- Line: 4409, Name: check
            for _, child in p595.storage.styles:GetChildren() do
                if child.Value == p596 then
                    return true;
                end;
            end;

            return false;
        end
    },
    GoalEffects = {
        check = function(p597, p598) -- Line: 4417, Name: check
            for _, child in p597.storage.goal_effects:GetChildren() do
                if child.Value == p598 then
                    return true;
                end;
            end;

            return false;
        end
    },
    Titles = {
        check = function(p599, p600) -- Line: 4425, Name: check
            for _, child in p599.storage.titles:GetChildren() do
                if child.Value == p600 then
                    return true;
                end;
            end;

            return false;
        end
    },
    Emotes = {
        check = function(p601, p602) -- Line: 4433, Name: check
            for _, child in p601.emote.storage:GetChildren() do
                if child.Value == p602 then
                    return true;
                end;
            end;

            return false;
        end
    },
    MVPs = {
        check = function(p603, p604) -- Line: 4441, Name: check
            for _, child in p603.storage.mvps:GetChildren() do
                if child.Value == p604 then
                    return true;
                end;
            end;

            return false;
        end
    },
    Commentators = {
        check = function(p605, p606) -- Line: 4449, Name: check
            for _, child in p605.storage.commentators:GetChildren() do
                if child.Value == p606 then
                    return true;
                end;
            end;

            return false;
        end
    }
};

function u3.Menu(u608) -- Line: 4459
    -- upvalues: replication (copy), ReplicatedStorage2 (copy), ReplicatedStorage (copy), u6 (ref), u7 (ref), RunService2 (copy), wiki (copy), soundUtil (copy), vfxUtil (copy), u607 (copy), emoteWiki (copy), packets (copy), Mastery (copy), Ranks (copy), RenderStepped (copy), formatStat (copy), TweenService (copy), script_Settings (copy), SoundService (copy), PolicyCheck (copy), deepCopy (copy), show_odds_grouped (copy), addCommas (copy), show_odds (copy), Players (copy), RunService (copy), MarketplaceService (copy), PassClient (copy), update_textconstraint (copy), UserService (copy), FuzzySearch (copy), query (copy), script_LimitedPreview (copy), fastSignal (copy), script_settingFunctions (copy), HttpService (copy), Club (copy)
    if u608:isRematchLobbyLocked() then
        replication.notification("You can\'t access that while voting on a rematch.", Color3.fromRGB(255, 0, 0), ReplicatedStorage2.Resources.notisound);

        return;
    end;

    local u609 = u608:createContainer();

    if not u609 then
        return;
    end;

    local u610 = {};
    local u611 = {};
    local u612 = nil;
    local u613 = script.Menu:Clone();
    u613.Parent = u608.playerGui;

    if u608.player:GetAttribute("PRI_Restriction") then
        local Shop = u613.Frame.choice.Shop;
        u613.ShopLuck.Visible = false;
        u613.Frame.Shop.Visible = false;
        u613.Frame.RotationFrame.Visible = true;
        Shop.Name = "RotationFrame";
        Shop.Text = "Rotation";
        local v614 = ReplicatedStorage.requestServer:InvokeServer("RequestRotationList");
        print("load list", v614);

        if v614 then
            u6 = v614.RotationData.RotationPricing;
            u7 = v614.RotationData.RotationTime;
            local u615 = v614.SinceLastReset + u7;
            u609:Add(RunService2.Heartbeat:Connect(function() -- Line: 4501
                -- upvalues: u615 (copy), u613 (copy), wiki (ref)
                local v616 = u615 - os.time();
                u613.Frame.RotationFrame.timer.Text = u615 - os.time() < 0 and "Reopen menu to load new rotation" or string.format("Refresh in %s", wiki.dailyQuests.formatTime(v616));
            end));
            local u617 = false;

            for _, child in u613.Frame.RotationFrame.Switch:GetChildren() do
                if child:IsA("TextButton") then
                    u609:Add(child.MouseButton1Click:Connect(function() -- Line: 4510
                        -- upvalues: soundUtil (ref), vfxUtil (ref), child (copy), u617 (ref), u613 (copy)
                        soundUtil:play(vfxUtil.getResources().click, "default");

                        if child.Name == "LimitedShop" then
                            u617 = true;
                            u613.Frame.Shop.Visible = true;
                            u613.Frame.Shop.List.Visible = false;
                            u613.Frame.Shop.Switch.Visible = false;
                            u613.Frame.Shop.rarity.Visible = false;
                            u613.Frame.Shop.LimitedShop.Visible = true;
                            u613.Frame.RotationFrame.List.Visible = false;
                        else
                            u617 = false;
                            u613.Frame.Shop.Visible = false;
                            u613.Frame.Shop.LimitedShop.Visible = false;
                            u613.Frame.Shop.List.Visible = true;
                            u613.Frame.Shop.Switch.Visible = true;
                            u613.Frame.Shop.rarity.Visible = true;
                            u613.Frame.RotationFrame.List.Visible = true;
                        end;

                        for _, child2 in u613.Frame.RotationFrame.Switch:GetChildren() do
                            if child2:IsA("TextButton") then
                                child2.fill.Visible = child == child2;
                            end;
                        end;
                    end));
                end;
            end;

            for i, v in v614.List do
                local v618 = script.SettingAssets.RotationCoreFrame:Clone();
                v618.title.Text = i;
                v618.Parent = u613.Frame.RotationFrame.List;

                if #v == 0 then
                    v618.owned.Visible = true;
                else
                    local u619 = i;

                    for i2, v2 in v do
                        local u620 = script.SettingAssets.RotationObject:Clone();
                        local u621 = u607[u619].check(u608, v2);
                        local v622 = 0;
                        local u623, u624, v625;

                        if u619 == "Styles" then
                            u620.Frame.title.Text = wiki.styles[v2].display_name;
                            u620.Frame.price.UIGradient.Enabled = true;
                            u623 = i2;
                            u624 = v2;

                            for i3, v3 in wiki.style_rarity do
                                if table.find(v3[2], u624) then
                                    v622 = i3;
                                    break;
                                end;
                            end;

                            v625 = u6[u619][v622];

                            if v622 ~= 0 then
                                local v626 = wiki.style_rarity[v622][5] or Color3.new(0, 0, 0);
                                u620.Frame.Rarity.Text = string.format("Rarity: %s", v622 == 5 and "Common" or (v622 == 4 and "Legendary" or (v622 == 3 and "Legendary" or (v622 == 2 and "Mystic" or (v622 == 1 and "World Class" or false)))));
                                u620.Frame.Rarity.TextColor3 = v626;
                                u620.Frame.Rarity.Visible = true;
                                u620.Frame.icon.Image = wiki.styles[u624].icon;
                                u620.Frame.icon.Visible = true;
                            end;
                        else
                            u624 = v2;
                            u623 = i2;
                            v625 = nil;
                        end;

                        if u619 == "GoalEffects" then
                            u620.Frame.title.Text = u624;

                            for i3, v3 in wiki.goal_rarity do
                                if table.find(v3[3], u624) then
                                    v622 = i3;
                                    break;
                                end;
                            end;

                            v625 = u6[u619][v622];

                            if v622 ~= 0 then
                                local v627 = wiki.goal_rarity[v622][2];
                                local v628 = wiki.goal_rarity[v622][6] or Color3.new(0, 0, 0);
                                u620.Frame.Rarity.Text = string.format("Rarity: %s", v627);
                                u620.Frame.Rarity.TextColor3 = v628;
                                u620.Frame.Rarity.Visible = true;
                            end;
                        end;

                        if u619 == "Emotes" then
                            u620.Frame.title.Text = u624;

                            if emoteWiki[u624] and emoteWiki[u624].animation then
                                local animation = emoteWiki[u624].animation;
                                local v629 = vfxUtil.getResources().Rig:Clone();
                                v629.Parent = u620.Frame.icon.ViewportFrame.WorldModel;
                                v629:PivotTo(CFrame.new(0, 0, 5));
                                local Camera = Instance.new("Camera");
                                Camera.CFrame = CFrame.new(0, 0, -15) * CFrame.fromEulerAnglesYXZ(0, 3.141592653589793, 0);
                                Camera.Parent = u620.Frame.icon.ViewportFrame;
                                Camera.FieldOfView = 30;
                                u620.Frame.icon.ViewportFrame.CurrentCamera = Camera;
                                local v630 = v629.Humanoid:LoadAnimation(animation);
                                v630.Looped = true;
                                v630:Play();
                                u620.Frame.icon.Visible = true;
                            end;
                        end;

                        if u619 == "Titles" then
                            local v631 = wiki.title[u624];

                            if typeof(v631) == "table" and typeof(v631.tagText) == "string" then
                                u620.Frame.title.Text = v631.nameaddition and u608.player.DisplayName .. v631.tagText or `[ {v631.tagText} ]`;
                                u620.Frame.title.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal);

                                if v631.tagColor then
                                    local UIGradient = Instance.new("UIGradient");
                                    UIGradient.Color = v631.tagColor;
                                    UIGradient.Parent = u620.Frame.title;
                                    Instance.new("UIStroke").Parent = u620.Frame.title;
                                    u620.Frame.title.TextColor3 = Color3.new(1, 1, 1);
                                end;
                            end;
                        end;

                        if u620.Frame.title.Text == "unchanged" then
                            u620.Frame.title.Text = u624;
                        end;

                        if not v625 and typeof(u6[u619]) == "number" then
                            v625 = u6[u619];
                        end;

                        if v625 then
                            u620.Frame.price.Text = string.format("%s$", v625);
                        end;

                        if u621 then
                            u620.Frame.purchase.Text = "OWNED";
                        end;

                        u620.Frame.purchase.MouseButton1Click:Connect(function() -- Line: 4658
                            -- upvalues: soundUtil (ref), vfxUtil (ref), u621 (ref), packets (ref), u623 (copy), u619 (copy), u607 (ref), u608 (copy), u624 (copy), u620 (copy)
                            soundUtil:play(vfxUtil.getResources().click, "default");

                            if u621 then
                                return;
                            end;

                            packets.bytenet_buyRotationOption.send({
                                index = u623,
                                topic = u619
                            });
                            task.delay(1, function() -- Line: 4662
                                -- upvalues: u621 (ref), u607 (ref), u619 (ref), u608 (ref), u624 (ref), u620 (ref)
                                u621 = u607[u619].check(u608, u624);

                                if u621 then
                                    u620.Frame.purchase.Text = "OWNED";
                                end;
                            end);
                        end);
                        u620.Parent = v618.Options;
                    end;
                end;
            end;
        end;
    end;

    u609:Add(u613);
    local Settings = u613.Frame.Settings;
    local choice = Settings.choice;
    local Stats = Settings.Stats;
    local ViewStyle = Settings.ViewStyle;
    local ViewMastery = Settings.ViewMastery;
    local u632 = {
        [choice.Settings] = Settings.Frame,
        [choice.Stats] = Stats
    };

    local function load_settings_choice(p633: string, p634: boolean?) -- Line: 4693
        -- upvalues: u632 (copy), ViewStyle (copy), ViewMastery (copy), packets (ref)
        for i, v in u632 do
            local v635;

            if i.Name == p633 then
                v635 = not p634;
            else
                v635 = false;
            end;

            v.Visible = v635;

            if i:FindFirstChild("fill") then
                i.fill.Visible = i.Name == p633;
            end;
        end;

        ViewStyle.Visible = false;
        ViewMastery.Visible = false;

        if p633 == "Stats" then
            packets.bytenet_requestPlaytime.send();
        end;
    end;

    local function has_style(p636) -- Line: 4707
        -- upvalues: u608 (copy)
        for _, child in u608.storage.styles:GetChildren() do
            if child.Value == p636 then
                return true;
            end;
        end;

        return false;
    end;

    local u637 = nil;

    local function clean_mastery(p638) -- Line: 4719
        -- upvalues: ViewMastery (copy), Mastery (ref)
        if not p638 then
            for _, child in ViewMastery.TierContainer:GetChildren() do
                if child:IsA("Frame") then
                    child:Destroy();
                end;
            end;

            for i in Mastery.TierSkips do
                ViewMastery[`SkipTier{i}`].Visible = false;
            end;
        end;

        ViewMastery.TierContainer.Visible = true;
        ViewMastery.PlaytimeContainer.Visible = true;
        ViewMastery.DailyContainer.Visible = true;
        ViewMastery.ExamplesContainer.Visible = false;
        ViewMastery.HowXP.Main.Text = "How do you get EXP?";
    end;

    local function open_mastery(p639, p640) -- Line: 4739
        -- upvalues: u637 (ref), clean_mastery (copy), wiki (ref), u613 (copy), ViewMastery (copy), Mastery (ref), ReplicatedStorage2 (ref), load_settings_choice (copy)
        u637 = p639;
        clean_mastery(p640);

        if p640 then
            return;
        end;

        local v641 = wiki.styles[p639];
        local v642 = wiki.styles[v641.mastery];

        for _, child in u613.Frame.choice:GetChildren() do
            if child:IsA("TextButton") then
                local v643 = child.Name == "Settings";
                child.fill.Visible = v643;
                local v644 = u613.Frame:FindFirstChild(child.Name);

                if v644 then
                    v644.Visible = v643;
                end;
            end;
        end;

        ViewMastery.TotalXP.Text = "...";
        ViewMastery.Tier.Text = "...";

        if p639 == "isagi" then
            ViewMastery.Title.Text = `NEL {v641.display_name} Progression`;
        else
            ViewMastery.Title.Text = `Mastery {v641.display_name} Progression`;
        end;

        ViewMastery.Background.Image = v642.image or (v641.image or "");
        ViewMastery.Icon.Image = v642.icon or (v641.icon or "");
        local v645 = v642.color or (v641.color or Color3.new(1, 1, 1));

        if v642.ignorecolor or v641.ignorecolor then
            ViewMastery.Background.ImageColor3 = Color3.new(1, 1, 1);
        else
            ViewMastery.Background.ImageColor3 = Color3.new(v645.R * 0.5, v645.G * 0.5, v645.B * 0.5);
        end;

        for _, child in ViewMastery.ExamplesContainer:GetChildren() do
            if child:IsA("Frame") then
                child:Destroy();
            end;
        end;

        local v646 = {};

        if not Mastery.CanAddXP() then
            table.insert(v646, { "NoXP" });
        end;

        if ReplicatedStorage2.vipserverownerid.Value ~= 0 then
            table.insert(v646, { "PS" });
        end;

        if #v646 > 0 then
            table.insert(v646, { "Divider" });
        end;

        for i, v in v641.mastery_info.XP.Normal do
            local v647 = {
                "Template",
                i,
                `{v[1]} - {v[2]} XP`,
                v642.color or v641.color
            };
            table.insert(v646, v647);
        end;

        if #v646 > 0 then
            table.insert(v646, { "Divider" });
        end;

        for i, v in Mastery.CommonTasks do
            local v648 = { "Template", i, (`{v[1]} - {v[2]} XP`) };
            table.insert(v646, v648);
        end;

        for i, v in ipairs(v646) do
            local v649 = ViewMastery.ExamplesContainer.UIListLayout[v[1]]:Clone();

            if v[2] then
                v649.Name = v[2];
            end;

            v649.LayoutOrder = i;

            if v[3] then
                v649.Label.Text = v[3];
            end;

            if v[4] then
                v649.BackgroundColor3 = v[4];
            end;

            v649.Parent = ViewMastery.ExamplesContainer;
        end;

        task.defer(function() -- Line: 4829
            -- upvalues: ViewMastery (ref)
            ViewMastery.ExamplesContainer.CanvasSize = UDim2.fromOffset(0, ViewMastery.ExamplesContainer.UIListLayout.AbsoluteContentSize.Y);
        end);
        load_settings_choice("Stats", true);
        ViewMastery.Visible = true;
    end;

    local u650 = nil;

    for i, _ in u632 do
        u609:Connect(i.MouseButton1Click, function() -- Line: 4839
            -- upvalues: soundUtil (ref), vfxUtil (ref), load_settings_choice (copy), i (copy)
            soundUtil:play(vfxUtil.getResources().click, "default");
            load_settings_choice(i.Name);
        end);
    end;

    local function updateElo() -- Line: 4845
        -- upvalues: u608 (copy), Ranks (ref), Stats (copy)
        local v651 = u608.player:GetAttribute("elo") or 0;
        local v652 = Ranks.ReturnRank(v651, u608.player);
        Stats.RankName.Text = v652.Name;
        Stats.Elo.Text = `{v651} Elo`;
        Stats.RankIcon.Image = v652.Icon;
        Stats.RankName.UIGradient.Color = v652:GetColor();
    end;

    u609:Connect(u608.player:GetAttributeChangedSignal("elo"), updateElo);
    task.defer(updateElo);
    u609:Connect(ViewStyle.BackOut.Button.MouseButton1Click, function() -- Line: 4858
        -- upvalues: soundUtil (ref), vfxUtil (ref), ViewStyle (copy), ViewMastery (copy), Stats (copy)
        soundUtil:play(vfxUtil.getResources().click, "default");
        ViewStyle.Visible = false;
        ViewMastery.Visible = false;
        Stats.Visible = true;
    end);
    u609:Connect(ViewStyle.Mastery.Button.MouseButton1Click, function() -- Line: 4865
        -- upvalues: soundUtil (ref), vfxUtil (ref), u650 (ref), open_mastery (copy)
        soundUtil:play(vfxUtil.getResources().click, "default");

        if u650 then
            open_mastery(u650);
        end;
    end);
    u609:Connect(ViewMastery.BackOut.Button.MouseButton1Click, function() -- Line: 4872
        -- upvalues: soundUtil (ref), vfxUtil (ref), ViewStyle (copy), ViewMastery (copy), Stats (copy)
        soundUtil:play(vfxUtil.getResources().click, "default");
        ViewStyle.Visible = false;
        ViewMastery.Visible = false;
        Stats.Visible = true;
    end);
    local Main = ViewMastery.HowXP.Main;
    u609:Connect(ViewMastery.HowXP.Button.MouseButton1Click, function() -- Line: 4880
        -- upvalues: soundUtil (ref), vfxUtil (ref), Main (copy), u637 (ref), ViewMastery (copy)
        soundUtil:play(vfxUtil.getResources().click, "default");

        if Main.Text == "Go Back" then
            u637 = u637;
            ViewMastery.TierContainer.Visible = true;
            ViewMastery.PlaytimeContainer.Visible = true;
            ViewMastery.DailyContainer.Visible = true;
            ViewMastery.ExamplesContainer.Visible = false;
            ViewMastery.HowXP.Main.Text = "How do you get EXP?";

            return;
        end;

        ViewMastery.ExamplesContainer.Visible = true;
        ViewMastery.TierContainer.Visible = false;
        ViewMastery.PlaytimeContainer.Visible = false;
        ViewMastery.DailyContainer.Visible = false;
        ViewMastery.Title.Text = "EXP Tasks";
        Main.Text = "Go Back";
    end);

    for i, v in Mastery.TierSkips do
        u609:Connect(ViewMastery[`SkipTier{i}`].Button.MouseButton1Click, function() -- Line: 4896
            -- upvalues: u637 (ref), soundUtil (ref), vfxUtil (ref), packets (ref), v (copy)
            if not u637 then
                return;
            end;

            soundUtil:play(vfxUtil.getResources().click, "default");
            packets.bytenet_marketPromptMasterySkip.send({
                id = tostring(v),
                style = u637
            });
        end);
    end;

    local Color3_new_ret = Color3.new(0, 0, 0);
    local Color3_new_ret2 = Color3.new(1, 1, 1);

    local function doFrameGradientEffect(p653, p654) -- Line: 4912
        -- upvalues: RenderStepped (ref), Color3_new_ret2 (copy), Color3_new_ret (copy)
        local v655 = 0;

        while true do
            local v656 = v655 + RenderStepped:Wait();
            v655 = math.min(v656, p653);
            local v657 = v655 / p653;
            local v658, v659;

            if v657 == 1 then
                v658 = Color3_new_ret2;
                v659 = 0;
            elseif v657 > 0.99 then
                v658 = { ColorSequenceKeypoint.new(0, Color3_new_ret2), ColorSequenceKeypoint.new(v657, Color3_new_ret2), ColorSequenceKeypoint.new(1, Color3_new_ret) };
                v659 = { NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(v657, 0), NumberSequenceKeypoint.new(1, 0.5) };
            else
                v658 = {
                    ColorSequenceKeypoint.new(0, Color3_new_ret2),
                    ColorSequenceKeypoint.new(v657, Color3_new_ret2),
                    ColorSequenceKeypoint.new(v657 + 0.01, Color3_new_ret),
                    ColorSequenceKeypoint.new(1, Color3_new_ret)
                };
                v659 = {
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(v657, 0),
                    NumberSequenceKeypoint.new(v657 + 0.01, 0.5),
                    NumberSequenceKeypoint.new(1, 0.5)
                };
            end;

            p654.Color = ColorSequence.new(v658);
            p654.Transparency = NumberSequence.new(v659);

            if p653 <= v655 then
                return;
            end;
        end;
    end;

    u609:Add(packets.bytenet_playtimeData.listen(function(p660) -- Line: 4957
        -- upvalues: u637 (ref), clean_mastery (copy), wiki (ref), Mastery (ref), ViewMastery (copy), formatStat (ref), u608 (copy), emoteWiki (ref), Color3_new_ret2 (copy), packets (ref), TweenService (ref), doFrameGradientEffect (copy), Stats (copy), u609 (copy), soundUtil (ref), vfxUtil (ref), open_mastery (copy), ViewStyle (copy), u650 (ref)
        if u637 then
            clean_mastery();
            local v661 = wiki.styles[u637];
            local mastery_info = v661.mastery_info;
            local v662 = p660.mastery[u637];
            local v663 = v662.xp or 0;
            local u664 = v662.last_tier or 0;
            local u665 = v662.tier or 0;
            local u666 = select(2, Mastery.GetTierForXP(mastery_info.Tiers, v663));
            ViewMastery.TotalXP.Text = formatStat(v663);
            ViewMastery.Tier.Text = `{u665} / {#mastery_info.Tiers}`;
            local DailyContainer = ViewMastery.DailyContainer;

            for i, v in v662.daily do
                local Daily = Mastery.GetDaily(u637, v.i);
                local v667 = DailyContainer:FindFirstChild((`Daily{i}`));

                if v667 then
                    if Daily then
                        local v668 = Daily[3];
                        local v669 = v.v / v668;

                        if v.f then
                            v667.Progress.Text = "DONE";
                        else
                            v667.Progress.Text = `{v.v}/{v668}`;
                        end;

                        local Y = v667.Bar.AbsoluteSize.Y;
                        local v670;

                        if v667.Bar.AbsoluteSize.X * v669 < Y then
                            v670 = 0;
                        else
                            v670 = v669;
                            Y = 0;
                        end;

                        v667.Bar.Fill.BackgroundColor3 = v661.color;
                        v667.Bar.Fill.Size = UDim2.new(v670, Y, 1, 0);
                        v667.Bar.Fill.Visible = v669 > 0;
                        v667.Label.Text = Daily[1];
                        v667.Visible = true;
                    else
                        v667.Visible = false;
                    end;
                end;
            end;

            local v671 = #mastery_info.Tiers - u665;

            for i in Mastery.TierSkips do
                local v672 = ViewMastery[`SkipTier{i}`];

                if i and i <= v671 then
                    v672.Visible = true;
                else
                    v672.Visible = false;
                end;
            end;

            local TierContainer = ViewMastery.TierContainer;
            local UIListLayout = TierContainer.UIListLayout;
            local v673 = nil;

            for i, v in ipairs(mastery_info.Tiers) do
                local v674 = v[1];
                local v675 = UIListLayout.TierTemplate:Clone();
                v675.LayoutOrder = i;
                v675.MidFrame.Tier.Text = i;
                v675.Name = i;
                v675.Parent = TierContainer;

                if i == 1 then
                    v673 = v675;
                end;

                local v676 = {};

                for _, v2 in ipairs(v) do
                    if v2.currency == "money" then
                        local v677 = `${v2.value}`;
                        table.insert(v676, v677);
                    elseif v2.currency == "style_currency" then
                        local v678 = `<font color="rgb(255,0,255)">${v2.value}</font>`;
                        table.insert(v676, v678);
                    end;
                end;

                if #v676 > 0 then
                    v675.Frame.ExtraLabel.Text = table.concat(v676, "\n");
                    v675.Frame.ExtraLabel.Visible = true;
                end;

                if v674 then
                    if v674.currency then
                        v675.Frame.MoneyLabel.Visible = true;

                        if v674.currency == "style_currency" then
                            v675.Frame.MoneyLabel.TextColor3 = Color3.new(1, 0, 1);
                        end;
                    else
                        local Label = v675.Frame.Label;
                        Label.Visible = true;

                        if v674.title then
                            local v679 = wiki.title[v674.title];

                            if v679 then
                                if v679.tagColor then
                                    Label.UIGradient.Color = v679.tagColor;
                                end;

                                local tagText = v679.tagText;

                                if not v679.specialer then
                                    tagText = `[{tagText}]`;
                                end;

                                if v679.nameaddition then
                                    tagText = `{u608.player.DisplayName}{tagText}`;
                                end;

                                Label.Text = tagText;
                            else
                                Label.Text = `title:\n{v674.title}`;
                            end;
                        elseif v674.emote then
                            local v680 = emoteWiki[v674.emote];
                            local v681;

                            if v680 then
                                v681 = v680.name;
                            else
                                v681 = nil;
                            end;

                            Label.Text = v681 or `emote:\n{v674.emote}`;
                        elseif v674.mvp then
                            local v682 = wiki.mvp_anim[v674.mvp];
                            local v683;

                            if v682 then
                                v683 = v682.name;
                            else
                                v683 = nil;
                            end;

                            Label.Text = v683 or `mvp:\n{v674.mvp}`;
                        elseif v674.style then
                            local v684 = wiki.styles[v674.style];
                            local v685;

                            if v674.is_mastery then
                                v685 = u637 == "isagi" and "NEL" or "Mastery";
                            else
                                v685 = v684 and v684.display_name or v674.style;
                            end;

                            Label.Text = v685;

                            if v684.color then
                                Label.TextColor3 = v684.color;
                            end;
                        end;
                    end;

                    if v674.style then
                        local v686 = wiki.styles[v674.style];

                        if v686.icon then
                            local StyleLabel = v675.Frame.StyleLabel;
                            StyleLabel.Visible = true;
                            StyleLabel.Image = v686.icon;
                        end;
                    end;
                else
                    v675.Frame.Visible = false;
                    v675.MidFrame.Visible = false;
                    v675.ProgressVert1.Visible = false;
                    v675.ProgressVert2.Visible = false;
                end;

                if i <= u664 then
                    v675.Progress.Frame.Size = UDim2.fromScale(1, 1);
                    v675.ProgressVert1.Frame.Size = UDim2.fromScale(1, 1);
                    v675.ProgressVert2.Frame.Size = UDim2.fromScale(1, 1);
                    local ColorSequence_new_ret = ColorSequence.new(Color3_new_ret2);
                    local NumberSequence_new_ret = NumberSequence.new(0);
                    v675.Frame.UIGradient.Color = ColorSequence_new_ret;
                    v675.Frame.UIGradient.Transparency = NumberSequence_new_ret;
                    v675.MidFrame.UIGradient.Color = ColorSequence_new_ret;
                    v675.MidFrame.UIGradient.Transparency = NumberSequence_new_ret;
                    v675.MidFrame.Tier.TextColor3 = Color3.new(0, 0, 0);
                end;
            end;

            if v673 then
                TierContainer.CanvasSize = UDim2.fromOffset(UIListLayout.AbsoluteContentSize.X + v673.Frame.AbsoluteSize.X / 2, 0);
            else
                TierContainer.CanvasSize = UDim2.new();
            end;

            task.spawn(function() -- Line: 5127
                -- upvalues: u665 (copy), u664 (copy), packets (ref), u637 (ref), TierContainer (copy), TweenService (ref), doFrameGradientEffect (ref), u666 (copy), mastery_info (copy)
                if u664 < u665 then
                    packets.bytenet_readMasteryTiers.send(u637);

                    for i = u664 + 1, u665 do
                        local u687 = TierContainer[tostring(i)];
                        TweenService:Create(u687.Progress.Frame, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                            Size = UDim2.fromScale(1, 1)
                        }):Play();
                        task.wait(1);
                        task.spawn(function() -- Line: 5139
                            -- upvalues: u687 (copy), TweenService (ref), doFrameGradientEffect (ref)
                            local Frame = u687.ProgressVert2.Frame;
                            local Frame2 = u687.Frame;
                            local MidFrame = u687.MidFrame;
                            local UIGradient = Frame2.UIGradient;
                            local UIStroke = Frame2.UIStroke;
                            local UIGradient2 = MidFrame.UIGradient;
                            local Tier = MidFrame.Tier;
                            TweenService:Create(u687.ProgressVert1.Frame, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                                Size = UDim2.fromScale(1, 1)
                            }):Play();
                            task.wait(0.3);
                            TweenService:Create(Tier, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                                TextColor3 = Color3.new(0, 0, 0)
                            }):Play();
                            doFrameGradientEffect(0.3, UIGradient2);
                            TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                                Size = UDim2.fromScale(1, 1)
                            }):Play();
                            task.wait(0.3);
                            doFrameGradientEffect(1, UIGradient);
                            TweenService:Create(UIStroke, TweenInfo.new(1), {
                                Thickness = 10,
                                Transparency = 1
                            }):Play();
                        end);
                        local _ = i;
                    end;
                end;

                local v688 = TierContainer:FindFirstChild(u665 + 1);

                if v688 then
                    TweenService:Create(v688.Progress.Frame, TweenInfo.new(1), {
                        Size = UDim2.fromScale(u666 / mastery_info.Tiers[u665 + 1].XP, 1)
                    }):Play();
                end;
            end);
        end;

        local leaderstats = u608.player:FindFirstChild("leaderstats");
        local v689 = leaderstats and (leaderstats.goals:GetAttribute("o") or 0) or 0;
        local v690 = leaderstats and (leaderstats.saves:GetAttribute("o") or 0) or 0;
        local v691 = leaderstats and leaderstats.wins:GetAttribute("o") or 0;
        local v692 = u608.player:GetAttribute("assists") or 0;
        Stats.Goals.Text = formatStat(v689);
        Stats.Saves.Text = formatStat(v690);
        Stats.Wins.Text = formatStat(v691);
        Stats.Assists.Text = formatStat(v692);
        Stats.GW.Text = math.round(v689 / (v691 == 0 and 1 or v691) * 100) / 100;
        Stats.Playtime.Text = `{formatStat(p660.playtime / 3600)} HRS`;
        Stats.Matchtime.Text = `{formatStat(p660.matchtime / 3600)} HRS`;
        local v693 = {};

        for i, v in p660.positions_played do
            if v > 0 then
                table.insert(v693, { i, v });
            end;
        end;

        if #v693 > 0 then
            table.sort(v693, function(p694, p695) -- Line: 5214
                return p694[2] > p695[2];
            end);
            Stats.MPP.Text = v693[1][1];
        else
            Stats.MPP.Text = "N/A";
        end;

        local v696 = {};

        for i, v in p660.mastery do
            if v.playtime > 0 then
                table.insert(v696, { i, v });
            end;
        end;

        table.sort(v696, function(p697, p698) -- Line: 5231
            return p697[2].playtime > p698[2].playtime;
        end);

        if #v696 > 0 then
            local v699 = v696[1];

            if v699 and v699.image then
                Stats.SplashImage.Image = v699.image;
            else
                Stats.SplashImage.Image = "";
            end;
        end;

        local Frame = Stats.Container.UIListLayout.Frame;
        local v700 = {};

        for _, v in ipairs(v696) do
            local u701 = v[2];

            if u701.playtime and u701.playtime > 0 then
                local u702 = wiki.styles[v[1]];

                if u702 then
                    local u703 = Stats.Container:FindFirstChild(v[1]);

                    if not u703 then
                        u703 = Frame:Clone();
                        u703.Name = v[1];
                        u703.Parent = Stats.Container;

                        if type(u701.tier) == "number" and u701.tier < #u702.mastery_info.Tiers then
                            u703.Mastery.Visible = true;

                            if v[1] == "isagi" then
                                u703.Mastery.Main.Text = "Evolution";
                            else
                                u703.Mastery.Main.Text = "Mastery";
                            end;

                            u609:Connect(u703.Mastery.Button.MouseButton1Click, function() -- Line: 5267
                                -- upvalues: soundUtil (ref), vfxUtil (ref), open_mastery (ref), v (copy)
                                soundUtil:play(vfxUtil.getResources().click, "default");
                                open_mastery(v[1]);
                            end);
                        end;

                        u609:Connect(u703.View.Button.MouseButton1Click, function() -- Line: 5272
                            -- upvalues: soundUtil (ref), vfxUtil (ref), Stats (ref), ViewStyle (ref), u702 (copy), formatStat (ref), u701 (copy), u650 (ref), v (copy), u703 (ref)
                            soundUtil:play(vfxUtil.getResources().click, "default");
                            Stats.Visible = false;
                            ViewStyle.Icon.Image = u702.icon or "";
                            ViewStyle.Background.Image = u702.image or "";

                            if u702.ignorecolor then
                                ViewStyle.Background.ImageColor3 = Color3.new(1, 1, 1);
                            else
                                ViewStyle.Background.ImageColor3 = u702.color and Color3.new(u702.color.R * 0.5, u702.color.G * 0.5, u702.color.B * 0.5) or Color3.new(0.5, 0.5, 0.5);
                            end;

                            ViewStyle.Wins.Text = formatStat(u701.wins);
                            ViewStyle.Assists.Text = formatStat(u701.assists);
                            ViewStyle.Goals.Text = formatStat(u701.goals);
                            ViewStyle.Playtime.Text = `{formatStat(u701.playtime / 3600)} HRS`;
                            local v704 = {};
                            local v705 = 0;

                            for i, v2 in u701.positions_played do
                                if v2 > 0 then
                                    table.insert(v704, { i, v2 });
                                    v705 = v705 + v2;
                                end;
                            end;

                            ViewStyle.Matches.Text = formatStat(v705);

                            if #v704 > 0 then
                                table.sort(v704, function(p706, p707) -- Line: 5309
                                    return p706[2] > p707[2];
                                end);
                                ViewStyle.MPP.Text = v704[1][1];
                            else
                                ViewStyle.MPP.Text = "N/A";
                            end;

                            local Frame2 = ViewStyle.Container.UIListLayout.Frame;
                            local v708 = {};

                            for _, child in ViewStyle.Container:GetChildren() do
                                if child.ClassName == Frame2.ClassName then
                                    child:Destroy();
                                end;
                            end;

                            for i, v2 in u701.extras do
                                local v709 = Frame2:Clone();
                                v709.Name = i;
                                v709.NameLabel.Text = i;
                                v709.StatLabel.Text = formatStat(v2);
                                v709.Parent = ViewStyle.Container;
                                table.insert(v708, { i, v2 });
                            end;

                            ViewStyle.Container.Visible = #v708 > 0;
                            ViewStyle.Soon.Visible = not ViewStyle.Container.Visible;
                            u650 = v[1];
                            ViewStyle.Mastery.Visible = u703.Mastery.Visible;

                            if v[1] == "isagi" then
                                ViewStyle.Mastery.Main.Text = "Mastery Obtainment";
                            else
                                ViewStyle.Mastery.Main.Text = "Evolution Obtainment";
                            end;

                            ViewStyle.Visible = true;
                        end);
                    end;

                    u703.MyStyle.Text = u702.display_name or v[1];
                    u703.PlaytimeLabel.Text = `Playtime: {formatStat(u701.playtime / 3600)} HRS`;
                    u703.Playtime.Bar.BackgroundColor3 = u702.color or Color3.new(1, 1, 1);
                    local v710 = ViewMastery.PlaytimeContainer:FindFirstChild(v[1]);

                    if not v710 then
                        v710 = ViewMastery.PlaytimeContainer.UIListLayout.Template:Clone();
                        v710.Name = v[1];
                        v710.Fill.BackgroundColor3 = u702.color or Color3.new(1, 1, 1);
                        v710.Label.Text = u702.display_name or v[1];
                        v710.Parent = ViewMastery.PlaytimeContainer;
                    end;

                    table.insert(v700, {
                        u701.playtime or 0,
                        { u703, v710 }
                    });
                end;
            end;
        end;

        local v711 = #v700 > 0;

        if v711 then
            table.sort(v700, function(p712, p713) -- Line: 5371
                return p712[1] > p713[1];
            end);

            for i, v in ipairs(v700) do
                local v714 = v[1] / v700[1][1];
                local v715 = i;

                for i2, v2 in ipairs(v[2]) do
                    v2.LayoutOrder = v715;

                    if i2 == 1 then
                        v2.Playtime.Bar.Size = UDim2.fromScale(v714, 1);
                    elseif i2 == 2 then
                        v2.Fill.Size = UDim2.fromScale(v714, 1);
                    end;
                end;
            end;
        end;

        Stats.Container.Visible = v711;
        Stats.StyleHint.Visible = not v711;
        Stats.Container.CanvasSize = UDim2.fromOffset(0, Stats.Container.UIListLayout.AbsoluteContentSize.Y);
        ViewMastery.PlaytimeContainer.CanvasSize = UDim2.fromOffset(0, ViewMastery.PlaytimeContainer.UIListLayout.AbsoluteContentSize.Y);
    end));
    packets.bytenet_requestPlaytime.send();
    local BooleanToggle = script.SettingAssets.BooleanToggle;
    local SpecialToggle = script.SettingAssets.SpecialToggle;
    local NumberToggle = script.SettingAssets.NumberToggle;
    local u716 = {};
    local success, result = pcall(function() -- Line: 5405
        -- upvalues: script_Settings (ref), u613 (copy), BooleanToggle (copy), SpecialToggle (copy), NumberToggle (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u608 (copy), u716 (copy)
        for i, v in script_Settings do
            local v717 = script.SettingAssets.Category:Clone();
            v717.Text = v.Name;
            v717.LayoutOrder = i;
            v717.Parent = u613.Frame.Settings.Frame;
            local v718 = i;

            for _, v2 in ipairs(v.Data) do
                local v719;

                if v2.type == "default" then
                    v719 = BooleanToggle:Clone();
                    v719:SetAttribute("type", "default");
                else
                    v719 = nil;
                end;

                if v2.type == "function" then
                    v719 = SpecialToggle:Clone();
                    v719:SetAttribute("type", "function");
                end;

                if v2.type == "number" then
                    v719 = NumberToggle:Clone();
                    v719:SetAttribute("type", "number");
                    v719:SetAttribute("min", v2.min or 0);
                    v719:SetAttribute("max", v2.max or 100);

                    if v2.datatitle == "ClockTime" then
                        v719.Frame.TextBox.PlaceholderText = "0-24";
                    end;
                end;

                if v2.type == "specialsettings" then
                    v719 = script.SettingAssets.AdvancedPageForSettings:Clone();
                    v719:SetAttribute("type", "default");
                end;

                if v719 then
                    if v2.datatitle and script.settingFunctions:FindFirstChild(v2.datatitle) then
                        v719:SetAttribute("type", "function");
                    end;

                    v719.LayoutOrder = v718 + 1;
                    v719.Main.Text = v2.name or v2.datatitle;
                    v719.Name = v2.datatitle;
                    v719.discription.Text = v2.description or "";
                    v719.Parent = u613.Frame.Settings.Frame;

                    if v2.type == "specialsettings" then
                        v719.More.Button.MouseButton1Up:Connect(function() -- Line: 5447
                            -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u608 (ref)
                            soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
                            AdvancedMenu(u608);
                        end);
                    end;

                    table.insert(u716, v719);

                    if v2.spawnfunc then
                        coroutine.wrap(v2.spawnfunc)(v719);
                    end;
                end;
            end;
        end;
    end);
    print(success, result);
    local u720 = { "stylecoin", "candycane" };
    local u721 = "stylecoin";
    local u722 = {
        stylecoin = 5,
        candycane = 3
    };
    local Position = u613.Frame.Position;
    local UDim2_new_ret = UDim2.new(0.5, 0, 0.4, 0);
    local TweenInfo_new_ret2 = TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    coroutine.wrap(function() -- Line: 5477
        -- upvalues: u613 (copy)
        if u613.Frame.Shop.Visible then
            u613.ShopLuck.Visible = true;
            u613.disclaimer.Visible = true;
        end;

        u613.Frame.Shop:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 5482
            -- upvalues: u613 (ref)
            u613.ShopLuck.Visible = u613.Frame.Shop.Visible;
            u613.disclaimer.Visible = u613.Frame.Shop.Visible;
        end);
    end)();
    u613.Frame.Position = UDim2_new_ret;
    u613.Frame.GroupTransparency = 1;
    TweenService:Create(u613.Frame, TweenInfo_new_ret2, {
        GroupTransparency = 0,
        Position = Position
    }):Play();
    local u723 = false;
    u609:Connect(u613.Frame.Shop.List.GoalEffect.Buy.MouseButton1Up, function() -- Line: 5498
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), PolicyCheck (ref), packets (ref)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);

        if PolicyCheck() then
            packets.bytenet_goaleffectSpin.send();
        end;
    end);

    local function find_emote(p724) -- Line: 5505
        -- upvalues: u608 (copy)
        for _, child in ipairs(u608.emote.storage:GetChildren()) do
            if child.Value == p724 then
                return true;
            end;
        end;

        return false;
    end;

    local function find_mvp(p725) -- Line: 5514
        -- upvalues: u608 (copy)
        for _, child in ipairs(u608.storage.mvps:GetChildren()) do
            if child.Value == p725 then
                return true;
            end;
        end;

        return false;
    end;

    local function find_goal_effect(p726) -- Line: 5524
        -- upvalues: u608 (copy)
        for _, child in ipairs(u608.storage.goal_effects:GetChildren()) do
            if child.Value == p726 then
                return true;
            end;
        end;

        return false;
    end;

    u609:Connect(u613.Frame.Shop.List.GoalEffect.Odds.MouseButton1Up, function() -- Line: 5533
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), deepCopy (ref), wiki (ref), u608 (copy), show_odds_grouped (ref)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        local v727 = deepCopy(wiki.goal_rarity);
        table.sort(v727, function(p728, p729) -- Line: 5536
            return p728[1] > p729[1];
        end);
        local _ = u608.storage.goal_effects;
        local v730 = {};

        for i, v in v727 do
            local v731 = v727[i - 1] or { 100 };
            local _ = v727[i + 1];
            local v732 = v[2];
            local v733 = v731[1] - v[1];

            if i == 1 then
                v733 = v733 + 5;
            end;

            if i == 2 then
                v733 = v733 + 10;
            end;

            if i == #v727 then
                v733 = v733 - 10;
            end;

            local v734 = {};
            local v735 = 0;

            for _, v2 in v[3] do
                table.insert(v734, v2);
                v735 = v735 + 1;
            end;

            local v736 = 1 / v735 * 100;

            for _, v2 in v734 do
                local v737;

                if wiki.goal_effects[v2] then
                    v737 = wiki.goal_effects[v2].Name or v2;
                else
                    v737 = v2;
                end;

                table.insert(v730, {
                    name = v737,
                    odds = v736,
                    grouped = v732,
                    group_odds = v733
                });
            end;
        end;

        local v738 = {};

        for _, v in pairs(v730) do
            local odds = v.odds;
            local name = v.name;
            local grouped = v.grouped;
            local v739 = tostring(v.group_odds) .. "%";
            local v740 = {
                title = name,
                odds = string.format("%.2f", (tostring(odds))) .. "%",
                groups = grouped,
                group_odds = v739
            };
            table.insert(v738, v740);
        end;

        show_odds_grouped(v738, "Goal Effect Odds", "Goal Effect");
    end);
    u613.Frame.Shop.List.GoalEffect.Buy.Text = `${wiki.shopprice.goaleffect}`;

    local function get_spin_text() -- Line: 5603
        -- upvalues: u613 (copy), u723 (ref), wiki (ref), u608 (copy), addCommas (ref)
        local _ = u613.Frame.Shop.List.styleSpin.Buy;

        if u723 then
            return `${wiki.shopprice.luckystyle}`;
        end;

        local Attribute = u608.player:GetAttribute("spins");

        if Attribute and Attribute > 0 then
            return `{addCommas(Attribute)} FREE`;
        end;

        return `${wiki.shopprice.style}`;
    end;

    u609:Add(u613.Frame.Shop.List.styleSpin.Buy.MouseButton1Up:connect(function() -- Line: 5617
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u723 (ref), PolicyCheck (ref), packets (ref)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);

        if u723 then
            if PolicyCheck() then
                packets.bytenet_LuckyStyleSpin.send();
            end;
        else
            packets.bytenet_styleSpin.send();
        end;
    end));
    u609:Add(u613.Frame.Shop.List.styleSpin.RobuxPurchase.MouseButton1Up:Connect(function() -- Line: 5629
        -- upvalues: packets (ref), u608 (copy)
        packets.bytenet_luckyStyleSpinPurchase.send({ 3542247039, u608.player.UserId });
    end));
    u609:Add(u613.Frame.Shop.List.styleSpin.Spin.MouseButton1Up:connect(function() -- Line: 5633
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u723 (ref), u613 (copy), get_spin_text (copy), wiki (ref)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        u723 = not u723;
        u613.Frame.Shop.List.styleSpin.Spin.Text = u723 and "Lucky Spin" or "Normal Spin";
        u613.Frame.Shop.List.styleSpin.RobuxPurchase.Visible = u723;
        u613.Frame.Shop.List.styleSpin.Buy.Text = get_spin_text();
        local v741 = u723 and wiki.lucky_style_rarity or wiki.style_rarity;
        local v742 = {};
        local v743 = 0;

        for _, v in pairs(v741) do
            local v744;

            if v742[v[1]] then
                v744 = v;
            else
                v744 = v;
                local v745 = 0;

                for _, _ in v[2] do
                    v745 = v745 + 1;
                end;

                v742[v744[1]] = v745;
            end;

            v743 = v743 + v744[1];
        end;

        local v746 = "";

        for _, v in pairs(v741) do
            local v747 = v[1];
            local v748 = v[2];
            local v749 = v[5];
            local v750 = v747 / (v742[v747] or 1) / v743 * 100;

            if v750 < 100 then
                local string_format_ret = string.format("#%02X%02X%02X", v749.R * 255, v749.G * 255, v749.B * 255);

                for _, v2 in ipairs(v748) do
                    v746 = v746 .. string.format("<font color=\"%s\">%s (%.1f%%)</font>\n", string_format_ret, v2, v750);
                end;
            end;
        end;

        u613.Frame.Shop.rarity.Text = v746;
        u613.Frame.Shop.rarity.RichText = true;
    end));
    u609:Add(u608.playerGui:WaitForChild("Menu").Frame.Rewards.Rewards.RefreshDaily.MouseButton1Up:Connect(function() -- Line: 5679
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), u608 (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        packets.bytenet_refreshDaily.send({ 3436436107, u608.player.UserId });
    end));
    u609:Add(u613.Frame.Shop.List.Mvp.Buy.MouseButton1Up:connect(function() -- Line: 5684
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        packets.bytenet_mvpSpin.send();
    end));
    u609:Add(u613.Frame.Shop.List.Mvp.Odds.MouseButton1Up:connect(function() -- Line: 5691
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), wiki (ref), u608 (copy), show_odds (ref)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        local v751 = {};

        for _, v in wiki.mvp_rarity do
            local v752 = v;
            local v753 = false;

            for _, child in ipairs(u608.storage.mvps:GetChildren()) do
                if child.Value == v752 then
                    v753 = true;
                    break;
                end;
            end;

            if not v753 then
                table.insert(v751, v752);
            end;
        end;

        local v754 = {};

        for _, v in pairs(v751) do
            local v755;

            if wiki.mvp_anim[v] then
                v755 = wiki.mvp_anim[v].name or v;
            else
                v755 = v;
            end;

            local v756 = {
                title = v755,
                odds = string.format("%.1f", (tostring(1 / #v751 * 100))) .. "%"
            };
            table.insert(v754, v756);
        end;

        show_odds(v754, nil, "MVP");
    end));
    u609:Add(u613.Frame.Shop.List.Emote.Buy.MouseButton1Up:connect(function() -- Line: 5715
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), PolicyCheck (ref), packets (ref)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);

        if PolicyCheck() then
            packets.bytenet_emoteSpin.send();
        end;
    end));
    u609:Add(u613.Frame.Shop.List.Emote.Odds.MouseButton1Up:connect(function() -- Line: 5724
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), wiki (ref), u608 (copy), emoteWiki (ref), show_odds (ref)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        local v757 = {};

        for _, v in wiki.emote_rarity do
            local v758 = v;
            local v759 = false;

            for _, child in ipairs(u608.emote.storage:GetChildren()) do
                if child.Value == v758 then
                    v759 = true;
                    break;
                end;
            end;

            if not (v759 or (table.find(wiki["limited&emotes"], v758) or emoteWiki[v758].limited)) then
                table.insert(v757, v758);
            end;
        end;

        local v760 = {};

        for _, v in pairs(v757) do
            local v761 = {
                title = v,
                odds = string.format("%.1f", (tostring(1 / #v757 * 100))) .. "%"
            };
            table.insert(v760, v761);
        end;

        show_odds(v760, "Emote Odds", "Emote");
    end));
    u609:Add(u613.Frame.Shop.List.Dual.Titles.Buy.MouseButton1Up:connect(function() -- Line: 5745
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), PolicyCheck (ref), packets (ref)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);

        if PolicyCheck() then
            packets.bytenet_titleSpin.send();
        end;
    end));
    u609:Add(u613.Frame.Shop.List.Dual.Titles.Odds.MouseButton1Up:connect(function() -- Line: 5753
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), wiki (ref), u608 (copy), Players (ref), show_odds (ref)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        local v762 = {};

        for i, v in wiki.title do
            if not (v.special or u608.storage.titles:FindFirstChild(i)) then
                table.insert(v762, i);
            end;
        end;

        local v763 = {};

        for _, v in pairs(v762) do
            local v764 = wiki.title[v];
            local tagText = v764.tagText;

            if not v764.special then
                tagText = string.format("[ %s ]", tagText);
            end;

            if v764.nameaddition then
                tagText = Players.LocalPlayer.DisplayName .. tagText;
            end;

            local v765 = {
                title = tagText,
                odds = string.format("%.1f", (tostring(1 / #v762 * 100))) .. "%"
            };
            table.insert(v763, v765);
        end;

        show_odds(v763, "Title Odds", "Title");
    end));
    u609:Add(u613.Frame.Shop.List.Dual.Commentators.Buy.MouseButton1Up:connect(function() -- Line: 5800
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        packets.bytenet_commentatorSpin.send();
    end));
    u609:Add(u613.Frame.Shop.List.Dual.Commentators.Odds.MouseButton1Up:connect(function() -- Line: 5806
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), wiki (ref), u608 (copy), show_odds (ref)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        local v766 = {};

        for i, v in wiki.commentators do
            if not (v.Special or u608.storage.commentators:FindFirstChild(i)) then
                table.insert(v766, i);
            end;
        end;

        local v767 = {};

        for _, v in pairs(v766) do
            local v768 = {
                title = v,
                odds = string.format("%.1f", (tostring(1 / #v766 * 100))) .. "%"
            };
            table.insert(v767, v768);
        end;

        show_odds(v767, "Commentator Odds", "Commentator");
    end));
    local u769 = {};

    for _, child in u613.Frame.Shop.Switch:GetChildren() do
        local u770 = u613.Frame.Shop:FindFirstChild(child.Name);

        if u770 then
            u769[child] = u770;
            u609:Connect(child.MouseButton1Click, function() -- Line: 5836
                -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u770 (copy), u613 (copy), child (copy), u769 (copy)
                soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);

                if u770.Visible then
                    return;
                end;

                u613.Frame.Shop.rarity.Visible = child.Name == "List";

                for i, v in u769 do
                    local v771 = i == child;
                    v.Visible = v771;
                    i.fill.Visible = v771;

                    if v771 then
                        i.TextLabel.Position = UDim2.fromScale(0.5, 0.465);
                    else
                        i.TextLabel.Position = UDim2.fromScale(0.5, 0.5);
                    end;
                end;
            end);
        end;
    end;

    u609:Connect(u613.Frame.Shop.LimitedShop.Bundles.MouseButton1Click, function() -- Line: 5853
        -- upvalues: u608 (copy)
        u608:destroyContainer();
        u608:Bundles();
    end);
    u609:Add(u613.Frame.Rewards.Conversion.CurrentConvert.button.MouseButton1Up:connect(function() -- Line: 5858
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u720 (copy), u721 (ref), u613 (copy), u722 (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        local v772 = nil;

        for i, v in u720 do
            if v == u721 then
                v772 = i;
                break;
            end;
        end;

        local v773 = #u720 < v772 + 1 and 1 or v772 + 1;
        u721 = u720[v773];
        u613.Frame.Rewards.Conversion.CurrentConvert.button.Text = "Current Conversion:\n" .. tostring(v773 == 1 and "Cash to Style Coins" or "Candy Canes to Style Coins");
        u613.Frame.Rewards.Conversion.Currency.Label.TextColor3 = v773 == 1 and Color3.fromRGB(85, 0, 127) or Color3.fromRGB(255, 0, 0);
        local v774 = u722[u721];
        local v775 = tonumber(u613.Frame.Rewards.Conversion.Cash.TextBox.Text);

        if v775 and tonumber(v775) then
            u613.Frame.Rewards.Conversion.Currency.Label.Text = string.format("$ %s", (math.floor(v775 / v774)));

            return;
        end;

        u613.Frame.Rewards.Conversion.Currency.Label.Text = "";
    end));
    u609:Add(u613.Frame.Rewards.Conversion.Do.button.MouseButton1Up:connect(function() -- Line: 5884
        -- upvalues: u613 (copy), replication (ref), ReplicatedStorage2 (ref), soundUtil (ref), SoundService (ref), packets (ref), u721 (ref)
        local v776 = tonumber(u613.Frame.Rewards.Conversion.Cash.TextBox.Text);

        if not v776 then
            replication.notification("Please enter an amount of in-game currency.", nil, ReplicatedStorage2.Resources.notisound);
        end;

        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        packets.bytenet_convertCashToStyle.send({
            sum = v776,
            type = u721
        });
    end));
    u609:Add(u613.Frame.Rewards.Conversion.Cash.TextBox:GetPropertyChangedSignal("Text"):connect(function() -- Line: 5896
        -- upvalues: u722 (copy), u721 (ref), u613 (copy)
        local v777 = u722[u721];
        local v778 = tonumber(u613.Frame.Rewards.Conversion.Cash.TextBox.Text);

        if v778 and tonumber(v778) then
            u613.Frame.Rewards.Conversion.Currency.Label.Text = string.format("$ %s", (math.floor(v778 / v777)));

            return;
        end;

        u613.Frame.Rewards.Conversion.Currency.Label.Text = "";
    end));

    local function giftui(u779) -- Line: 5910
        -- upvalues: u613 (copy), Players (ref), RunService (ref), u608 (copy), u609 (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref)
        if u613.Frame.Gift.Visible then
            return;
        end;

        u613.Frame.Gift.Visible = true;

        for _, child in ipairs(u613.Frame.Gift.Storage:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy();
            end;
        end;

        for _, v in Players:GetPlayers() do
            if RunService:IsStudio() or v ~= u608.player then
                local v780 = u613.Frame.Product.base:Clone();
                v780.Main.Text = `{v.DisplayName} @{v.Name}`;
                v780.Visible = true;
                v780.Parent = u613.Frame.Gift.Storage;
                u609:Add(v780.Button.MouseButton1Up:connect(function() -- Line: 5928
                    -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u779 (copy), packets (ref), v (copy)
                    soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);

                    if u779 == 3455902297 then
                        packets.bytenet_marketPromptGift.send({ u779, v.UserId });

                        return;
                    end;

                    packets.bytenet_giftCash.send({ u779, v.UserId });
                end));
            end;
        end;

        u609:Add(u613.Frame.Gift.close.MouseButton1Up:Once(function() -- Line: 5938
            -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u613 (ref)
            soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
            u613.Frame.Gift.Visible = false;
        end));
    end;

    u609:Add(u613.Frame.Product:WaitForChild("s100k").Buy.Button.MouseButton1Up:connect(function() -- Line: 5947
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), u608 (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        packets.bytenet_giftCash.send({ 3467829718, u608.player.UserId });
    end));
    u609:Add(u613.Frame.Product.s100k.Gift.Button.MouseButton1Up:connect(function() -- Line: 5953
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), giftui (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        giftui(3467829718);
    end));
    u609:Add(u613.Frame.Product:WaitForChild("s25k").Buy.Button.MouseButton1Up:connect(function() -- Line: 5961
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), u608 (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        packets.bytenet_giftCash.send({ 3467830465, u608.player.UserId });
    end));
    u609:Add(u613.Frame.Product.s25k.Gift.Button.MouseButton1Up:connect(function() -- Line: 5967
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), giftui (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        giftui(3467830465);
    end));
    u609:Add(u613.Frame.Product:WaitForChild("s10k").Buy.Button.MouseButton1Up:connect(function() -- Line: 5974
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), u608 (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        packets.bytenet_giftCash.send({ 3467830196, u608.player.UserId });
    end));
    u609:Add(u613.Frame.Product.s10k.Gift.Button.MouseButton1Up:connect(function() -- Line: 5980
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), giftui (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        giftui(3467830196);
    end));
    u609:Add(u613.Frame.Product:WaitForChild("s1k").Buy.Button.MouseButton1Up:connect(function() -- Line: 5987
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), u608 (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        packets.bytenet_giftCash.send({ 3467830693, u608.player.UserId });
    end));
    u609:Add(u613.Frame.Product.s1k.Gift.Button.MouseButton1Up:connect(function() -- Line: 5993
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), giftui (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        giftui(3467830693);
    end));
    u609:Add(u613.Frame.Product:WaitForChild("100k").Buy.Button.MouseButton1Up:connect(function() -- Line: 5999
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), u608 (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        packets.bytenet_giftCash.send({ 3237362546, u608.player.UserId });
    end));
    u609:Add(u613.Frame.Product["100k"].Gift.Button.MouseButton1Up:connect(function() -- Line: 6005
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), giftui (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        giftui(3237362546);
    end));
    u609:Add(u613.Frame.Product:WaitForChild("25k").Buy.Button.MouseButton1Up:connect(function() -- Line: 6013
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), u608 (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        packets.bytenet_giftCash.send({ 3237340278, u608.player.UserId });
    end));
    u609:Add(u613.Frame.Product["25k"].Gift.Button.MouseButton1Up:connect(function() -- Line: 6019
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), giftui (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        giftui(3237340278);
    end));
    u609:Add(u613.Frame.Product:WaitForChild("10k").Buy.Button.MouseButton1Up:connect(function() -- Line: 6026
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), u608 (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        packets.bytenet_giftCash.send({ 3237361801, u608.player.UserId });
    end));
    u609:Add(u613.Frame.Product["10k"].Gift.Button.MouseButton1Up:connect(function() -- Line: 6032
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), giftui (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        giftui(3237361801);
    end));
    u609:Add(u613.Frame.Product:WaitForChild("1k").Buy.Button.MouseButton1Up:connect(function() -- Line: 6039
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), u608 (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        packets.bytenet_giftCash.send({ 3237362069, u608.player.UserId });
    end));
    u609:Add(u613.Frame.Product["1k"].Gift.Button.MouseButton1Up:connect(function() -- Line: 6045
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), giftui (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        giftui(3237362069);
    end));
    local Other = u613.Frame.Product:WaitForChild("Other");

    for i, v in wiki.giftedPasses do
        local v781 = u609:Clone(Other.Template);
        v781.Name = v[2];
        v781.Main.Text = v[2];
        v781.Buy.Main.Text = tostring(v[3]);
        v781.Visible = true;
        v781.Parent = Other;
        u609:Connect(v781.Buy.Button.MouseButton1Up, function() -- Line: 6059
            -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), v (copy)
            soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
            packets.bytenet_buyPass.send({ v[1] });
        end);
        u609:Connect(v781.Gift.Button.MouseButton1Up, function() -- Line: 6063
            -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), giftui (copy), i (copy)
            soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
            giftui(i);
        end);
    end;

    local EmperorSlots = ReplicatedStorage2.Subscriptions:FindFirstChild("EmperorSlots");
    local u782 = {};

    for _, child in ipairs(u613.Frame.Product:GetChildren()) do
        local u783 = ReplicatedStorage2.Subscriptions:FindFirstChild(child.Name);

        if u783 then
            local u784 = u783.Value:sub(1, 4) == "EXP-";
            local success2, result2 = pcall(function() -- Line: 6076
                -- upvalues: u784 (copy), MarketplaceService (ref), u783 (copy)
                if u784 then
                    return MarketplaceService:GetSubscriptionProductInfoAsync(u783.Value);
                end;

                return MarketplaceService:GetProductInfoAsync(tonumber(u783.Value), Enum.InfoType.Product);
            end);
            local v785 = { u783, u784 };

            if success2 then
                v785[3] = result2;
            end;

            u609:Connect(child.Buy.Button.MouseButton1Click, function() -- Line: 6087
                -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), u783 (copy)
                soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
                packets.bytenet_gatedPrompt.send(u783.Value);
            end);
            u782[child] = v785;
        end;
    end;

    local function update_tier_buttons() -- Line: 6094
        -- upvalues: u608 (copy), u782 (copy), EmperorSlots (copy), addCommas (ref)
        local Attribute = u608.player:GetAttribute("sub_tier");
        local v786 = type(Attribute) == "string";

        for i, v in u782 do
            local v787 = v[2];
            local v788 = v[3];
            local v789 = i.Name == "Tier3";
            local v790 = v789 and EmperorSlots and EmperorSlots.Value >= EmperorSlots:GetAttribute("cap");

            if v789 and (i:FindFirstChild("Capped") and EmperorSlots) then
                local Attribute2 = EmperorSlots:GetAttribute("cap");
                EmperorSlots.Value = math.min(EmperorSlots.Value, Attribute2);
                i.Capped.Text = `{EmperorSlots.Value}/{Attribute2}`;
            end;

            local v791;

            if v788 then
                v791 = v788.IsForSale and not v790;
            else
                v791 = v788;
            end;

            i.Buy.Button.Visible = v791;

            if v786 and i.Name == Attribute then
                i.Buy.Main.Text = "OWNED";
            elseif v790 then
                i.Buy.Main.Text = "SOLD OUT";
            elseif v788 then
                local v792 = v787 and v788.DisplayPrice or addCommas(v788.PriceInRobux);
                i.Buy.Main.Text = v788.IsForSale and `{v792}/month` or "Not For Sale";
            else
                i.Buy.Main.Text = "Failed to load";
            end;
        end;
    end;

    task.spawn(update_tier_buttons);
    u609:Connect(u608.player:GetAttributeChangedSignal("sub_tier"), update_tier_buttons);

    if EmperorSlots then
        u609:Connect(EmperorSlots.Changed, update_tier_buttons);
    end;

    u609:Add(u613.Frame.Product.Other.Limited1.Gift.Button.MouseButton1Up:connect(function() -- Line: 6132
        -- upvalues: u610 (ref), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), giftui (copy)
        if u610[1] then
            soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
            giftui(u610[1].Id);
        end;
    end));
    u609:Add(u613.Frame.Product.Other.Limited2.Gift.Button.MouseButton1Up:connect(function() -- Line: 6141
        -- upvalues: u610 (ref), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), giftui (copy)
        if u610[2] then
            soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
            giftui(u610[2].Id);
        end;
    end));
    u609:Add(u613.Frame.Product.Other.Limited3.Gift.Button.MouseButton1Up:connect(function() -- Line: 6151
        -- upvalues: u610 (ref), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), giftui (copy)
        if u610[3] then
            soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
            giftui(u610[3].Id);
        end;
    end));
    u609:Add(u613.ShopLuck.LuckBoost.Buy.Button.MouseButton1Up:Connect(function() -- Line: 6159
        -- upvalues: PolicyCheck (ref), packets (ref)
        if PolicyCheck() then
            packets.bytenet_marketPrompt.send({ 3455902297 });
        end;
    end));
    u609:Add(u613.Frame.Product.Other.LuckBoost.Buy.Button.MouseButton1Up:Connect(function() -- Line: 6165
        -- upvalues: PolicyCheck (ref), packets (ref)
        if PolicyCheck() then
            packets.bytenet_marketPrompt.send({ 3455902297 });
        end;
    end));
    u609:Add(u613.ShopLuck.LuckBoost.Gift.Button.MouseButton1Up:Connect(function() -- Line: 6171
        -- upvalues: PolicyCheck (ref), Players (ref), packets (ref), giftui (copy)
        if PolicyCheck() then
            if Players.LocalPlayer.Name == "Stephex_s" then
                packets.bytenet_marketPrompt.send({ 3483662052 });

                return;
            end;

            giftui(3455902297);
        end;
    end));
    u609:Add(u613.Frame.Product.Other.LuckBoost.Gift.Button.MouseButton1Up:Connect(function() -- Line: 6182
        -- upvalues: PolicyCheck (ref), giftui (copy)
        if PolicyCheck() then
            giftui(3455902297);
        end;
    end));
    u609:Add(u613.Frame.Rewards.Rewards.base.Button.MouseButton1Up:connect(function() -- Line: 6188
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), u613 (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        packets.bytenet_useCode.send(u613.Frame.Rewards.Rewards.Search.TextBox.Text);
    end));
    u609:Add(u613.Frame.Rewards.Rewards.checksub.Button.MouseButton1Up:connect(function() -- Line: 6194
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), u613 (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        packets.bytenet_isSubscribed.send(u613.Frame.Rewards.Rewards.channelId.TextBox.Text);
    end));
    local u793 = {};
    local u794 = {};

    for _, child in u613.Frame.Rewards.choice:GetChildren() do
        if child:IsA("TextButton") then
            local v795 = u613.Frame.Rewards:FindFirstChild(child.Name);

            if v795 then
                table.insert(u793, v795);
                table.insert(u794, child);
                u609:Connect(child.MouseButton1Up, function() -- Line: 6209
                    -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u793 (copy), child (copy), u794 (copy)
                    soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);

                    for _, v in u793 do
                        v.Visible = v.Name == child.Name;
                    end;

                    for _, v in u794 do
                        v.fill.Visible = v.Name == child.Name;
                    end;
                end);
            end;
        end;
    end;

    local u796 = {};

    for _, child in u613.Frame.choice:GetChildren() do
        if child:IsA("TextButton") then
            table.insert(u796, child);
            child.MouseButton1Click:Connect(function() -- Line: 6226
                -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u796 (copy), u613 (copy), child (copy), u608 (copy), get_spin_text (copy)
                soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);

                for _, v in ipairs(u796) do
                    v.fill.Visible = false;

                    if u613.Frame:FindFirstChild(v.Name) then
                        u613.Frame[v.Name].Visible = false;
                    end;
                end;

                u613.Frame[child.Name].Visible = true;
                child.fill.Visible = true;

                if u608.player:GetAttribute("PRI_Restriction") then
                    local v797;

                    if child.Name == "RotationFrame" then
                        v797 = u613.Frame.Shop.LimitedShop.Visible;
                    else
                        v797 = false;
                    end;

                    u613.Frame.Shop.Visible = v797;
                end;

                local v798 = child.Name == "Shop";

                if v798 then
                    u613.Frame.Shop.List.styleSpin.Buy.Text = get_spin_text();
                end;

                u613.Frame.Cash.Visible = v798;
                u613.Frame.Currency.Visible = v798;
            end);
        end;
    end;

    u613.Frame.Shop.List.styleSpin.Buy.Text = get_spin_text();
    u613.Frame.Shop.List.Mvp.Buy.Text = `${wiki.shopprice.mvpanimation}`;
    u613.Frame.Shop.List.Emote.Buy.Text = `${wiki.shopprice.emote}`;
    u613.Frame.Shop.List.Dual.Titles.Buy.Text = `${wiki.shopprice.title}`;
    u613.Frame.Shop.List.Dual.Commentators.Buy.Text = `${wiki.shopprice.commentators}`;
    u613.Frame.Cash.Text = `$ {u608.player:GetAttribute("money")}`;
    u613.Frame.Currency.Text = `$ {u608.player:GetAttribute("style_currency")}`;
    u613.ShopLuck.LuckBoost.luckpity.Text = `spin pity: {u608.player:GetAttribute("spinpity")}/100`;
    local style_rarity = wiki.style_rarity;
    local v799 = {};
    local v800 = 0;

    for _, v in pairs(style_rarity) do
        local v801;

        if v799[v[1]] then
            v801 = v;
        else
            v801 = v;
            local v802 = 0;

            for _, _ in v[2] do
                v802 = v802 + 1;
            end;

            v799[v801[1]] = v802;
        end;

        v800 = v800 + v801[1];
    end;

    local v803 = "";

    for _, v in pairs(style_rarity) do
        local v804 = v[1];
        local v805 = v[2];
        local v806 = v[5];
        local v807 = v804 / (v799[v804] or 1) / v800 * 100;
        local string_format_ret = string.format("#%02X%02X%02X", v806.R * 255, v806.G * 255, v806.B * 255);

        for _, v2 in ipairs(v805) do
            v803 = v803 .. string.format("<font color=\"%s\">%s (%.1f%%)</font>\n", string_format_ret, v2, v807);
        end;
    end;

    u613.Frame.Shop.rarity.Text = v803;
    u613.Frame.Shop.rarity.RichText = true;
    u609:Add(u608.player:GetAttributeChangedSignal("money"):connect(function() -- Line: 6303
        -- upvalues: u613 (copy), u608 (copy)
        u613.Frame.Cash.Text = `$ {u608.player:GetAttribute("money")}`;
    end));
    u609:Add(u608.player:GetAttributeChangedSignal("style_currency"):connect(function() -- Line: 6307
        -- upvalues: u613 (copy), u608 (copy)
        u613.Frame.Currency.Text = `$ {u608.player:GetAttribute("style_currency")}`;
    end));
    u609:Add(u608.player:GetAttributeChangedSignal("spinpity"):connect(function() -- Line: 6311
        -- upvalues: u613 (copy), u608 (copy)
        u613.ShopLuck.LuckBoost.luckpity.Text = `spin pity: {u608.player:GetAttribute("spinpity")}/100`;
    end));
    local u808 = {};
    local u809 = {};
    local u810 = {};

    local function addtitle() -- Line: 6319
        -- upvalues: u613 (copy), u608 (copy), wiki (ref), u609 (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref)
        local Titles = u613.Frame.Storage.Titles.Titles;
        local titles = u608.storage.titles;

        for _, child in ipairs(Titles:GetChildren()) do
            if child:IsA("Frame") and (not titles:FindFirstChild(child.Name) and child.Name ~= "Special") then
                child:Destroy();
            end;
        end;

        for _, child in ipairs(titles:GetChildren()) do
            if not Titles:FindFirstChild(child.Name) then
                local u811 = u613.Frame.Storage.base:Clone();
                u811.Visible = true;
                u811.Size = UDim2.fromScale(0.9, 0.9);
                local v812 = wiki.title[child.Value];

                if typeof(v812) == "table" and typeof(v812.tagText) == "string" then
                    u811:SetAttribute("search_tag_1", v812.tagText);
                    u811.Main.Text = v812.nameaddition and u608.player.DisplayName .. v812.tagText or `[ {v812.tagText} ]`;
                    u811.Main.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal);

                    if v812.tagColor then
                        local UIGradient = Instance.new("UIGradient");
                        UIGradient.Color = v812.tagColor;
                        UIGradient.Parent = u811.Main;
                        Instance.new("UIStroke").Parent = u811.Main;
                        u811.Main.TextColor3 = Color3.new(1, 1, 1);
                    end;

                    u811.LayoutOrder = 2;
                else
                    u811.LayoutOrder = 0;
                    u811.Main.Text = child.Value;
                end;

                u811:SetAttribute("search_tag_2", child.Value);
                u811.Name = child.Name;
                u811.Parent = Titles;
                child.Destroying:Once(function() -- Line: 6357
                    -- upvalues: u811 (copy)
                    pcall(game.Destroy, u811);
                end);
                u609:Add(u811.Button.MouseButton1Click:connect(function() -- Line: 6361
                    -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), child (copy)
                    soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
                    packets.bytenet_changeTitle.send(child.Value);
                end));
            end;
        end;
    end;

    local function addcommentator() -- Line: 6371
        -- upvalues: u613 (copy), u608 (copy), u609 (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref)
        local Commentators = u613.Frame.Storage.Commentators.Commentators;
        local commentators = u608.storage.commentators;

        for _, child in ipairs(Commentators:GetChildren()) do
            if child:IsA("Frame") and (not commentators:FindFirstChild(child.Name) and child.Name ~= "Special") then
                child:Destroy();
            end;
        end;

        for _, child in ipairs(commentators:GetChildren()) do
            if not Commentators:FindFirstChild(child.Name) then
                local u813 = u613.Frame.Storage.base:Clone();
                u813.Visible = true;
                u813.Size = UDim2.fromScale(0.9, 0.9);
                u813.Main.Text = child.Value;
                u813.Name = child.Name;
                u813:SetAttribute("search_tag", child.Value);
                u813.Parent = Commentators;
                child.Destroying:Once(function() -- Line: 6391
                    -- upvalues: u813 (copy)
                    pcall(game.Destroy, u813);
                end);
                u609:Add(u813.Button.MouseButton1Click:connect(function() -- Line: 6395
                    -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), child (copy)
                    soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
                    packets.bytenet_changeCommentator.send(child.Value);
                end));
            end;
        end;
    end;

    local function add_stitle() -- Line: 6405
        -- upvalues: u613 (copy), u608 (copy), u609 (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref)
        local Titles = u613.Frame.Storage.Titles.Titles;
        local special_titles = u608.storage.special_titles;

        for _, child in Titles:GetChildren() do
            if child.Name == "Special" then
                pcall(game.Destroy, child);
            end;
        end;

        for _, child in ipairs(special_titles:GetChildren()) do
            local v814 = u613.Frame.Storage.base:Clone();
            v814.Name = "Special";
            v814.Size = UDim2.fromScale(0.9, 0.9);
            v814.LayoutOrder = 1;
            v814.Visible = true;
            v814:SetAttribute("search_tag", child.tagText.Value);
            v814.Parent = Titles;
            v814.Main.Text = child:FindFirstChild("nameaddition") and child:FindFirstChild("nameaddition").Value and u608.player.DisplayName .. child.tagText.Value or `[ {child.tagText.Value} ]`;
            v814.Main.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal);
            local Color3_new_ret3 = Color3.new(255, 255, 255);
            local v815 = child:FindFirstChild("tagColor") and child:FindFirstChild("tagColor").Value;
            local u816;

            if v815 then
                u816 = child;
                local v817 = {};

                for i, v in string.split(v815, " ") do
                    v817[i] = tonumber(v);
                end;

                local v818 = {};

                for i = 1, #v817, 5 do
                    local table_unpack_ret, v819, v820, v821 = table.unpack(v817, i, i + 3);
                    local v822;

                    if table_unpack_ret then
                        table.insert(v818, ColorSequenceKeypoint.new(table_unpack_ret, Color3.new(v819, v820, v821)));
                        v822 = i;
                    else
                        v822 = i;
                    end;
                end;

                Color3_new_ret3 = ColorSequence.new(v818);
            else
                u816 = child;
            end;

            local UIGradient = Instance.new("UIGradient");
            UIGradient.Color = Color3_new_ret3;
            UIGradient.Parent = v814.Main;
            Instance.new("UIStroke").Parent = v814.Main;
            v814.Main.TextColor3 = Color3.new(1, 1, 1);
            u609:Add(v814.Button.MouseButton1Click:connect(function() -- Line: 6456
                -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), u816 (copy)
                soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
                packets.bytenet_changeSpecialTitle.send(u816.Name);
            end));
        end;
    end;

    local u823 = { "🇯🇵", "🇬🇧" };
    local u824 = PassClient.checkPass(u608.player, wiki.gamepassId.dubVoicelines);
    local u825 = {};
    local u826 = {};

    local function update_style_base(u827, u828) -- Line: 6471
        -- upvalues: wiki (ref), u613 (copy), u825 (copy), u609 (copy), soundUtil (ref), vfxUtil (ref), update_style_base (copy), open_mastery (copy), u824 (copy), u608 (copy), u823 (copy), packets (ref), update_textconstraint (ref)
        for _, child in u827.Buttons:GetChildren() do
            if not child:IsA("UIListLayout") then
                child:Destroy();
            end;
        end;

        local u829 = wiki.styles[u828];

        if u829 then
            local display_name = u829.display_name;
            u827:SetAttribute("search_tag_2", display_name);
            u827.Main.Text = display_name or u828;
            u827.Description.Text = u829.description or u827.Description.Text;
            u827.ImageLabel.Image = u829.image or (u829.icon or u827.ImageLabel.Image);

            if u829.ignorecolor then
                u827.ImageLabel.ImageColor3 = Color3.new(1, 1, 1);
            else
                u827.ImageLabel.ImageColor3 = u829.display_color or (u829.color or u827.ImageLabel.ImageColor3);
            end;

            if not u827.ImageLabel:GetAttribute("ImageTransparency") then
                u827.ImageLabel:SetAttribute("ImageTransparency", u827.ImageLabel.ImageTransparency);
            end;

            u827.ImageLabel.ImageTransparency = u829.ignorecolor and 0.35 or u827.ImageLabel:GetAttribute("ImageTransparency") / 1.5;
            local Styles = u613.Frame.Storage.Styles;

            if u829.mastery then
                local v830 = nil;

                if u825[u828] then
                    v830 = Styles.Mastery:Clone();
                    v830.Visible = true;
                    v830.Switch.Visible = true;
                    v830.Parent = u827.Buttons;
                    local v831 = u609:Extend();
                    v831:AttachToInstance(v830);
                    v831:Connect(v830.MouseButton1Click, function() -- Line: 6505
                        -- upvalues: soundUtil (ref), vfxUtil (ref), update_style_base (ref), u827 (copy), u829 (copy)
                        soundUtil:play(vfxUtil.getResources().click, "default");
                        update_style_base(u827, u829.mastery);
                    end);
                elseif u829.mastery_info then
                    v830 = Styles.Mastery:Clone();
                    v830.Visible = true;
                    v830.View.Visible = true;
                    v830.Parent = u827.Buttons;
                    local v832 = u609:Extend();
                    v832:AttachToInstance(v830);
                    v832:Connect(v830.MouseButton1Click, function() -- Line: 6516
                        -- upvalues: soundUtil (ref), vfxUtil (ref), open_mastery (ref), u828 (copy)
                        soundUtil:play(vfxUtil.getResources().click, "default");
                        open_mastery(u828);
                    end);
                end;

                if v830 and string.match(tostring(u828), "isagi") then
                    v830.Text = "Evolution";
                end;
            elseif u829.mastery_of then
                local v833 = Styles.Mastery:Clone();
                v833.Visible = true;
                v833.Switch.Visible = true;
                v833.Parent = u827.Buttons;
                local v834 = u609:Extend();
                v834:AttachToInstance(v833);
                v834:Connect(v833.MouseButton1Click, function() -- Line: 6531
                    -- upvalues: soundUtil (ref), vfxUtil (ref), update_style_base (ref), u827 (copy), u829 (copy)
                    soundUtil:play(vfxUtil.getResources().click, "default");
                    update_style_base(u827, u829.mastery_of);
                end);

                if string.match(tostring(u828), "isagi") then
                    v833.Text = "Evolution";
                end;
            end;

            xpcall(function() -- Line: 6539
                -- upvalues: u829 (copy), u824 (ref), u608 (ref), u828 (copy), Styles (copy), u823 (ref), u827 (copy), u609 (ref), soundUtil (ref), vfxUtil (ref), packets (ref)
                local v835 = u829.dub and (u824 and u608.setting:FindFirstChild((`dub_{u828}`)));

                if v835 then
                    local u836 = Styles.Dub:Clone();
                    u836.Visible = true;
                    u836.Text = u823[v835.Value and 2 or 1];
                    u836.Parent = u827.Buttons;
                    local v837 = u609:Extend();
                    v837:AttachToInstance(u836);
                    v837:Connect(u836.MouseButton1Click, function() -- Line: 6549
                        -- upvalues: soundUtil (ref), vfxUtil (ref), packets (ref), u828 (ref)
                        soundUtil:play(vfxUtil.getResources().click, "default");
                        packets.bytenet_settingChange.send({
                            name = "dub",
                            value = u828
                        });
                    end);
                    v837:Connect(v835.Changed, function(p838) -- Line: 6556
                        -- upvalues: u836 (copy), u823 (ref)
                        u836.Text = u823[p838 and 2 or 1];
                    end);
                end;
            end, warn);

            if u829.wiki and not u829.wiki_inaccessible then
                local v839 = Styles.View:Clone();
                v839.Visible = true;
                v839.Parent = u827.Buttons;
                local u840 = u609:Extend();
                u840:AttachToInstance(v839);
                u840:Connect(v839.MouseButton1Click, function() -- Line: 6568
                    -- upvalues: soundUtil (ref), vfxUtil (ref), u613 (ref), u829 (copy), u828 (copy), u840 (copy), update_textconstraint (ref), wiki (ref)
                    soundUtil:play(vfxUtil.getResources().click, "default");
                    u613.Frame.Storage.Styles.Visible = false;
                    local StyleInfo = u613.Frame.Storage.StyleInfo;

                    for _, child in ipairs(StyleInfo.list:GetChildren()) do
                        if child:IsA("Frame") then
                            child:Destroy();
                        end;
                    end;

                    StyleInfo.Visible = true;
                    StyleInfo["1"].Text = u829.display_name or u828;
                    local icon = StyleInfo.icon;

                    if u829.icon then
                        icon.Image = u829.icon;
                        icon.Visible = true;
                    else
                        icon.Visible = false;
                    end;

                    StyleInfo["1"].TextXAlignment = Enum.TextXAlignment[u829.icon and "Left" or "Center"];

                    for _, v in ipairs(u829.wiki) do
                        local u841 = StyleInfo.base:Clone();
                        u841.Name = v.name;

                        if v.num then
                            u841.MoveName.Text = `[{v.num}] {v.name}`;
                        else
                            u841.MoveName.Text = v.name;
                        end;

                        u841.Description.Text = v.description;
                        u841.Parent = StyleInfo.list;
                        local u842 = u840:Extend();
                        u842:AttachToInstance(u841);
                        u842:Connect(u841.MoveName:GetPropertyChangedSignal("TextBounds"), function() -- Line: 6599
                            -- upvalues: update_textconstraint (ref), u841 (copy)
                            update_textconstraint(u841.Description.UITextSizeConstraint, u841.MoveName, 0.9);
                        end);
                        u842:Connect(StyleInfo:GetPropertyChangedSignal("Visible"), function() -- Line: 6602
                            -- upvalues: u840 (ref), u842 (copy)
                            u840:Remove(u842);
                        end);
                        local v843;

                        if v.tags then
                            v843 = v;

                            for _, v2 in ipairs(v.tags) do
                                local v844 = StyleInfo.tag:Clone();
                                v844.TextLabel.Text = wiki.move_tags[v2] or v2;
                                v844.Visible = true;
                                v844.Parent = u841.Tags;
                            end;
                        else
                            v843 = v;
                        end;

                        if v843.stats then
                            local v845 = {};

                            for i in v843.stats do
                                table.insert(v845, i);
                            end;

                            table.sort(v845);

                            for _, v2 in ipairs(v845) do
                                local v846 = v843.stats[v2];

                                if typeof(v846) == "table" then
                                    v846 = table.concat(v846, "/");
                                end;

                                local v847 = StyleInfo.stat:Clone();
                                local v848 = v2;
                                local v849 = false;

                                for i, v3 in wiki.move_stats do
                                    if v848:sub(1, i:len()) == i then
                                        if v848 == i then
                                            v847.Text = `{v3}: {v846}`;
                                        else
                                            v847.Text = `{v3} ({v848:sub(i:len() + 1)}): {v846}`;
                                        end;

                                        v849 = true;
                                    end;
                                end;

                                if not v849 then
                                    v847.Text = `{v848}: {v846}`;
                                end;

                                if #v845 > 3 then
                                    local Size = v847.Size;
                                    v847.Size = UDim2.new(Size.X.Scale / 1.5, Size.X.Offset / 1.5, Size.Y.Scale / 1.5, Size.Y.Offset / 1.5);
                                end;

                                v847.Visible = true;
                                v847.Parent = u841.Stats;
                            end;
                        end;

                        u841.Visible = true;
                    end;
                end);
            end;
        else
            u827.Main.Text = u828;
        end;

        u827:SetAttribute("search_tag_1", u828);
        u827.Name = u828;
    end;

    local function addstyle() -- Line: 6659
        -- upvalues: u613 (copy), u826 (copy), u825 (copy), u608 (copy), wiki (ref), update_style_base (copy), u609 (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref)
        local StylesS = u613.Frame.Storage.Styles.StylesS;
        table.clear(u826);
        table.clear(u825);
        local v850 = {};

        for _, child in ipairs(u608.storage.styles:GetChildren()) do
            local Value = child.Value;
            local v851 = wiki.styles[Value];

            if v851 and v851.mastery_of then
                u825[v851.mastery_of] = Value;
                table.insert(u826, Value);
            else
                table.insert(v850, Value);
            end;
        end;

        for i, v in ipairs(v850) do
            if not StylesS:FindFirstChild(v) then
                xpcall(function() -- Line: 6685
                    -- upvalues: u613 (ref), i (copy), wiki (ref), v (copy), StylesS (copy), update_style_base (ref), u609 (ref), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref)
                    local u852 = u613.Frame.Storage.style_base:Clone();
                    u852.Visible = true;
                    u852.LayoutOrder = i;
                    local table_find_ret = table.find(wiki.style_new, v);
                    local table_find_ret2 = table.find(wiki.style_updated, v);

                    if table_find_ret or table_find_ret2 then
                        u852.New.Visible = true;
                        u852.LayoutOrder = -(table_find_ret2 and 1 or 2);

                        if table_find_ret2 then
                            u852.New.TextLabel.Text = "UPDATED!";
                        end;
                    end;

                    u852.Parent = StylesS;
                    update_style_base(u852, v);
                    u609:Add(u852.MouseButton1Click:Connect(function() -- Line: 6704
                        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), u852 (copy)
                        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
                        packets.bytenet_changeStyle.send(u852.Name);
                    end));
                end, function(p853) -- Line: 6710
                    -- upvalues: v (copy)
                    warn((`[{v}]: {p853}`));
                end);
            end;
        end;

        for _, child in ipairs(StylesS:GetChildren()) do
            if child:IsA("TextButton") and not (table.find(v850, child.Name) or table.find(u826, child.Name)) then
                child:Destroy();
            end;
        end;
    end;

    local function addcustomstyle(u854: number, u855: number, u856: string) -- Line: 6722
        -- upvalues: u613 (copy), u609 (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), UserService (ref)
        local u857 = nil;
        local u858 = false;
        local u859 = nil;
        local v860, _, _, _, v861 = pcall(function() -- Line: 431
            -- upvalues: u856 (copy), u858 (ref), u857 (ref), u859 (ref)
            local buffer_fromstring_ret = buffer.fromstring(u856);
            local success2, _ = pcall(function() -- Line: 434
                -- upvalues: buffer_fromstring_ret (ref)
                buffer_fromstring_ret = game:GetService("EncodingService"):Base64Decode(buffer_fromstring_ret);
            end);

            if success2 then
                local _, _ = pcall(function() -- Line: 439
                    -- upvalues: buffer_fromstring_ret (ref)
                    buffer_fromstring_ret = game:GetService("EncodingService"):DecompressBuffer(buffer_fromstring_ret, Enum.CompressionAlgorithm.Zstd);
                end);
            end;

            local success3, result2 = pcall(function() -- Line: 444
                -- upvalues: buffer_fromstring_ret (ref)
                return game:GetService("HttpService"):JSONDecode(buffer.tostring(buffer_fromstring_ret));
            end);

            if success3 then
                u858 = true;
                u857 = u856;
                u859 = result2;
            else
                local success4, result3 = pcall(function() -- Line: 453
                    -- upvalues: u856 (ref)
                    return game:GetService("HttpService"):JSONDecode(u856);
                end);

                if success4 then
                    u859 = result3;
                    local buffer_fromstring_ret2 = buffer.fromstring(u856);
                    local _, _ = pcall(function() -- Line: 462
                        -- upvalues: buffer_fromstring_ret2 (ref)
                        buffer_fromstring_ret2 = game:GetService("EncodingService"):CompressBuffer(buffer_fromstring_ret2, Enum.CompressionAlgorithm.Zstd);
                    end);
                    local _, _ = pcall(function() -- Line: 466
                        -- upvalues: buffer_fromstring_ret2 (ref)
                        buffer_fromstring_ret2 = game:GetService("EncodingService"):Base64Encode(buffer_fromstring_ret2);
                    end);
                    u857 = buffer.tostring(buffer_fromstring_ret2);
                end;
            end;

            return u858, u857, u856, u859;
        end);
        local StylesS = u613.Frame.Storage.Styles.StylesS;

        if v860 then
            print(v861 ~= nil);

            if v861 then
                local u862 = u613.Frame.Storage.style_base:Clone();
                u862.stephex.Visible = true;
                u862.Visible = true;
                u862.LayoutOrder = u855 + 999;
                u862.Parent = StylesS;
                u862.Main.Text = v861.StyleName or "IDK THE NAME OF THIS ONE";

                if v861.BannerIcon then
                    u862.ImageLabel.Image = "rbxassetid://" .. v861.BannerIcon;
                end;

                u609:Add(u862.MouseButton1Click:Connect(function() -- Line: 6745
                    -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), u854 (copy), u855 (copy)
                    soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
                    packets.bytenet_playserverstyle.send({ tonumber(u854), u855 });
                end));
                task.spawn(function() -- Line: 6752
                    -- upvalues: u862 (copy), u854 (copy), UserService (ref)
                    u862.Description.Text = "(Skill Builder Style) added to server by " .. tostring(u854);
                    local success2, result2 = pcall(function() -- Line: 6755
                        -- upvalues: UserService (ref), u854 (ref)
                        return UserService:GetUserInfosByUserIdsAsync({ (tonumber(u854)) });
                    end);

                    if not success2 then
                        for i = 1, 3 do
                            task.wait(2);
                            local success3, result3 = pcall(function() -- Line: 6762
                                -- upvalues: UserService (ref), u854 (ref)
                                return UserService:GetUserInfosByUserIdsAsync({ (tonumber(u854)) });
                            end);

                            if success3 then
                                result2 = result3;
                                success2 = success3;
                                break;
                            end;

                            local _ = i;
                        end;
                    end;

                    if success2 and result2 then
                        print(result2, result2[1]);
                        u862.Description.Text = string.format("(Skill Builder Style) Added to the server by %s (@%s)", result2[1].DisplayName, result2[1].Username);
                    end;
                end);
            end;
        end;
    end;

    local function addstyle_temps(p863) -- Line: 6783
        -- upvalues: u613 (copy), u609 (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref)
        local StylesS = u613.Frame.Storage.Styles.StylesS;

        for _, child in ipairs(p863:GetChildren()) do
            if not StylesS:FindFirstChild(child.Value .. "temp") then
                local u864 = u613.Frame.Storage.base:Clone();
                u864.Visible = true;
                u864.Main.Text = child.Value;
                u864.Name = child.Value .. "temp";
                u864.Main.TextColor3 = child:GetAttribute("Color") or Color3.fromRGB(255, 0, 0);
                u864:SetAttribute("search_tag", child.Value);
                u864.Parent = StylesS;
                u864.LayoutOrder = 9999;
                child.Destroying:Once(function() -- Line: 6801
                    -- upvalues: u864 (copy)
                    pcall(game.Destroy, u864);
                end);
                u609:Add(u864.Button.MouseButton1Click:Connect(function() -- Line: 6805
                    -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), child (copy)
                    soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
                    packets.bytenet_changeStyle.send(child.Value);
                end));
            end;
        end;
    end;

    local function addmvp() -- Line: 6814
        -- upvalues: u809 (copy), u613 (copy), u608 (copy), wiki (ref), u609 (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), replication (ref)
        table.clear(u809);
        local MvpAnims = u613.Frame.Storage.Mvps.MvpAnims;

        for _, child in ipairs(u608.storage.mvps:GetChildren()) do
            table.insert(u809, child.Value);

            if not MvpAnims:FindFirstChild(child.Value) then
                local v865 = wiki.mvp_anim[child.Value];
                local u866 = u613.Frame.Storage.mvp_base:Clone();
                u866.Visible = true;
                u866:SetAttribute("search_tag_1", child.Value);

                if typeof(v865) == "table" and v865.name then
                    u866.Main.Text = v865.name;
                    u866:SetAttribute("search_tag_2", v865.name);
                else
                    u866.Main.Text = child.Value;
                end;

                u866.Name = child.Value;
                u866:SetAttribute("favorite", u608.player.FavMVPs:FindFirstChild(child.Value) ~= nil);
                u866.Parent = MvpAnims;

                local function u867() -- Line: 6841
                    -- upvalues: u866 (copy)
                    if u866:GetAttribute("favorite") then
                        u866.Favorite.ImageTransparency = 0;
                        u866.Favorite.ImageColor3 = Color3.new(1, 1, 0);

                        return;
                    end;

                    u866.Favorite.ImageTransparency = 0.5;
                    u866.Favorite.ImageColor3 = Color3.new(1, 1, 1);
                end;

                u609:Add(u866.Button.MouseButton1Click:connect(function() -- Line: 6851
                    -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), child (copy)
                    soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
                    packets.bytenet_changeMvp.send(child.Value);
                end));
                u609:Add(u866.Favorite.MouseButton1Click:Connect(function() -- Line: 6858
                    -- upvalues: wiki (ref), child (copy), replication (ref), u866 (copy), packets (ref), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u867 (copy)
                    if table.find(wiki.vaultedMvps, child.Value) then
                        replication.notification((`Unable to favorite {child.Value} (vaulted)`));

                        return;
                    end;

                    local v868 = not u866:GetAttribute("favorite");
                    u866:SetAttribute("favorite", v868);
                    packets.bytenet_favoriteMvp.send({
                        index = child.Value,
                        value = v868
                    });
                    soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
                    u867();
                end));
                u867();
            end;
        end;

        for _, child in ipairs(MvpAnims:GetChildren()) do
            if child:IsA("Frame") and not table.find(u809, child.Name) then
                child:Destroy();
            end;
        end;
    end;

    local function addemote() -- Line: 6883
        -- upvalues: u808 (copy), u608 (copy), u613 (copy), emoteWiki (ref), u609 (copy), u612 (ref)
        table.clear(u808);

        for _, child in ipairs(u608.emote.storage:GetChildren()) do
            local Value = child.Value;
            table.insert(u808, Value);

            if not u613.Frame.Storage.Emotes.Emote.Storage:FindFirstChild(Value) then
                local v869 = emoteWiki[child.Value];
                local v870 = u613.Frame.Storage.Emotes.Emote.base:Clone();
                v870.Visible = true;
                v870:SetAttribute("search_tag_1", child.Value);

                if typeof(v869) == "table" and v869.name then
                    v870.Main.Text = v869.name;
                    v870:SetAttribute("search_tag_2", v869.name);
                else
                    v870.Main.Text = child.Value;
                end;

                v870.Name = Value;
                v870.Parent = u613.Frame.Storage.Emotes.Emote.Storage;
                u609:Add(v870.Button.MouseButton1Click:Connect(function() -- Line: 6911
                    -- upvalues: u612 (ref), Value (copy)
                    if u612 then
                        u612:Fire(Value);
                    end;
                end));
            end;
        end;

        for _, child in ipairs(u613.Frame.Storage.Emotes.Emote.Storage:GetChildren()) do
            if child:IsA("Frame") and not table.find(u808, child.Name) then
                child:Destroy();
            end;
        end;
    end;

    local function getGoalEffectName(p871) -- Line: 6925
        -- upvalues: wiki (ref), u608 (copy)
        local v872 = wiki.goal_effects[p871];
        local v873;

        if v872 then
            v873 = v872.Name or p871;
        else
            v873 = p871;
        end;

        if p871 == "default" then
            v873 = v873 .. " (default)";
        end;

        return v873, u608.player:GetAttribute("goal_effect") == p871 and true or false;
    end;

    local function addgoaleffect() -- Line: 6941
        -- upvalues: u810 (copy), u613 (copy), u608 (copy), wiki (ref), u609 (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref)
        table.clear(u810);
        local FX = u613.Frame.Storage.GoalEffects.FX;

        for _, child in ipairs(u608.storage.goal_effects:GetChildren()) do
            local Value = child.Value;
            table.insert(u810, Value);

            if not FX:FindFirstChild(Value) then
                local v874 = u613.Frame.Storage.base:Clone();
                v874.Visible = true;
                local v875 = nil;

                for _, v in wiki.goal_rarity do
                    if table.find(v[3], Value) then
                        v875 = v;
                        break;
                    end;
                end;

                local v876 = wiki.goal_effects[Value];
                local v877;

                if v876 then
                    v877 = v876.Name or Value;
                else
                    v877 = Value;
                end;

                if Value == "default" then
                    v877 = v877 .. " (default)";
                end;

                local v878 = u608.player:GetAttribute("goal_effect") == Value and true or false;
                local v879 = v875 and v875[6] or Color3.new(1, 0.333333, 0);
                local UIGradient = Instance.new("UIGradient");

                if v878 then
                    UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v879), ColorSequenceKeypoint.new(0.667, v879), ColorSequenceKeypoint.new(1, Color3.new(0, 1, 0)) });
                else
                    UIGradient.Color = ColorSequence.new(v879);
                end;

                UIGradient.Parent = v874;
                v874:SetAttribute("search_tag_1", v877);
                v874:SetAttribute("search_tag_2", Value);
                v874.BackgroundColor3 = v879;
                v874.Main.Text = v877;
                v874.Name = Value;
                v874.Parent = FX;
                u609:Add(v874.Button.MouseButton1Click:connect(function() -- Line: 6987
                    -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), Value (copy)
                    soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
                    packets.bytenet_changeGoalEffect.send(Value);
                end));
            end;
        end;

        u609:Connect(u608.player:GetAttributeChangedSignal("goal_effect"), function() -- Line: 6993
            -- upvalues: FX (copy), wiki (ref), u608 (ref)
            for _, child in ipairs(FX:GetChildren()) do
                if child:IsA("Frame") then
                    local Name = child.Name;
                    local v880 = wiki.goal_effects[Name];
                    local v881;

                    if v880 then
                        v881 = v880.Name or Name;
                    else
                        v881 = Name;
                    end;

                    if Name == "default" then
                        v881 = v881 .. " (default)";
                    end;

                    local v882 = u608.player:GetAttribute("goal_effect") == Name and true or false;
                    local UIGradient = child:FindFirstChild("UIGradient");

                    if UIGradient then
                        local Value = UIGradient.Color.Keypoints[1].Value;

                        if v882 then
                            UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Value), ColorSequenceKeypoint.new(0.667, Value), ColorSequenceKeypoint.new(1, Color3.new(0, 1, 0)) });
                        else
                            UIGradient.Color = ColorSequence.new(Value);
                        end;
                    end;

                    child.Main.Text = v881;
                end;
            end;
        end);

        for _, child in ipairs(FX:GetChildren()) do
            if child:IsA("Frame") and not table.find(u810, child.Name) then
                child:Destroy();
            end;
        end;
    end;

    addemote();
    addstyle();
    addmvp();
    addtitle();
    add_stitle();
    addcommentator();
    addgoaleffect();

    for _, child in u613.Frame.Storage:GetChildren() do
        local Search = child:FindFirstChild("Search");

        if Search and Search:IsA("TextBox") then
            local v883 = child:FindFirstChildWhichIsA("ScrollingFrame");

            if v883 then
                local u884 = {};
                local u885 = {};

                local function new_addition(u886: userdata) -- Line: 7041
                    -- upvalues: u885 (copy), u884 (copy)
                    if not u886:IsA("GuiObject") or table.find(u885, u886) then
                        return;
                    end;

                    local v887 = {};

                    for i, v in u886:GetAttributes() do
                        if i:sub(1, 10) == "search_tag" then
                            table.insert(v887, v);
                        end;
                    end;

                    if #v887 == 0 then
                        return;
                    end;

                    local u888 = {
                        instance = u886,
                        attributes = v887
                    };
                    table.insert(u885, u886);
                    table.insert(u884, u888);
                    u886.Destroying:Once(function() -- Line: 7060
                        -- upvalues: u885 (ref), u886 (copy), u884 (ref), u888 (copy)
                        table.remove(u885, table.find(u885, u886));
                        table.remove(u884, table.find(u884, u888));
                    end);
                end;

                for _, child2 in ipairs(v883:GetChildren()) do
                    new_addition(child2);
                end;

                u609:Connect(v883.ChildAdded, new_addition);
                local u889 = FuzzySearch.new(u884, {
                    threshold = 0.3,
                    keys = { "attributes.*" }
                });
                u609:Connect(Search:GetPropertyChangedSignal("Text"), function() -- Line: 7070
                    -- upvalues: Search (copy), u889 (copy), u884 (copy)
                    local Text = Search.Text;
                    local v890 = Text == "";
                    local v891 = u889:search(Text);
                    local v892 = {};

                    for _, v in ipairs(v891) do
                        table.insert(v892, v.item.instance);
                    end;

                    for _, v in ipairs(u884) do
                        local v893 = table.find(v892, v.instance) ~= nil;
                        local v894 = false;

                        for _, v2 in v.attributes do
                            if string.find(string.lower(v2), string.lower(Text), 1, true) then
                                v894 = true;
                                break;
                            end;
                        end;

                        v.instance.Visible = v893 or (v890 or v894);
                    end;
                end);
            end;
        end;
    end;

    if workspace:GetAttribute("SkillBuilderActive") then
        for i, v in ReplicatedStorage.requestServer:InvokeServer("SkillBuilderList") do
            local v895 = i;

            for i2, v2 in v do
                task.spawn(addcustomstyle, v895, i2, v2);
            end;
        end;
    end;

    u609:Add(u608.storage.special_titles.ChildAdded:connect(add_stitle));
    u609:Add(u608.storage.titles.ChildAdded:connect(addtitle));
    u609:Add(u608.storage.styles.ChildAdded:connect(addstyle));
    u609:Add(u608.storage.commentators.ChildAdded:connect(addcommentator));
    u609:Add(u608.storage.mvps.ChildAdded:connect(addmvp));
    u609:Add(u608.storage.goal_effects.ChildAdded:connect(addgoaleffect));
    u609:Add(u608.emote.storage.ChildAdded:connect(addemote));
    local u896 = {};

    for _, child in ipairs(u613.Frame.Storage.StorageList:GetChildren()) do
        if child:IsA("Frame") and child:FindFirstChild("Button") then
            table.insert(u896, child);
            u609:Add(child.Button.MouseButton1Click:Connect(function() -- Line: 7121
                -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u896 (copy), child (copy), u613 (copy)
                soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);

                for _, v in ipairs(u896) do
                    if v.Name == child.Name then
                        v.fill.Visible = true;
                    else
                        v.fill.Visible = false;
                    end;
                end;

                for _, child2 in u613.Frame.Storage:GetChildren() do
                    if child2:GetAttribute("Page") then
                        if child2.Name == child.Name then
                            child2.Visible = true;
                        else
                            child2.Visible = false;
                        end;
                    end;
                end;
            end));
        end;
    end;

    task.spawn(function() -- Line: 7143
        -- upvalues: addstyle_temps (copy), u609 (copy), u608 (copy)
        local u897 = false;

        local function process(u898) -- Line: 7148
            -- upvalues: u897 (ref), addstyle_temps (ref), u609 (ref)
            if not (u897 or (not u898:IsA("Folder") or u898.Name ~= "tempstyles")) then
                print("recieved");
                u897 = true;
                local u899 = u898.ChildAdded:Connect(function() -- Line: 7152
                    -- upvalues: addstyle_temps (ref), u898 (copy)
                    addstyle_temps(u898);
                end);
                u609:Add(u899);
                u609:Add(u898.Destroying:Once(function() -- Line: 7156
                    -- upvalues: u897 (ref), u899 (ref)
                    u897 = false;

                    if u899 then
                        u899:Disconnect();
                        u899 = nil;
                    end;
                end));
                addstyle_temps(u898);
            end;
        end;

        local v900 = u608.player.ChildAdded:Connect(process);

        if u608.player:FindFirstChild("tempstyles") then
            process(u608.player:FindFirstChild("tempstyles"));
        end;

        u609:Add(v900);
    end);
    local u901 = nil;
    local u902 = nil;
    local u903 = nil;
    local u904 = nil;
    local u905 = nil;
    local u906 = nil;
    local u907 = nil;
    local u908 = false;
    local u909 = "";

    local function reload() -- Line: 7180
        -- upvalues: u901 (ref), query (ref), u613 (copy), u909 (ref), u908 (ref), u610 (ref), u902 (ref), emoteWiki (ref), u903 (ref), wiki (ref), u904 (ref), u905 (ref), u808 (copy), u906 (ref), u809 (copy), u907 (ref), MarketplaceService (ref), u611 (copy)
        u901 = query.getCurrentLimited:Fire();

        if not u613.Parent then
            return;
        end;

        if not u901 then
            return;
        end;

        local v910 = u901.Emote.Name .. u901.Mvp.Name .. u901.Mvp2.Name;

        if v910 == u909 then
            return;
        end;

        u909 = v910;
        u908 = false;

        for _, v in u901 do
            v.Id = tonumber(v.Id);
        end;

        u610 = { u901.Emote, u901.Mvp, u901.Mvp2 };
        u902 = emoteWiki[u901.Emote.Name];
        u903 = wiki.mvp_anim[u901.Mvp.Name];
        u904 = wiki.mvp_anim[u901.Mvp2.Name];
        coroutine.wrap(function() -- Line: 7204
            -- upvalues: u902 (ref), u903 (ref), u904 (ref), u613 (ref), u901 (ref)
            local v911 = { u902, u903, u904 };

            for i = 1, 3 do
                local v912 = u613.Frame.Product.Other:FindFirstChild("Limited" .. tostring(i));
                local v913;

                if v912 then
                    local Image = v912:FindFirstChild("Image");

                    if not Image then
                        Image = Instance.new("ImageLabel");
                        Image.Size = UDim2.fromScale(1, 1);
                        Image.BackgroundTransparency = 1;
                        Image.ZIndex = 0;
                        Image.Name = "Image";
                        Image.Parent = v912;
                        Image.ImageTransparency = 0.5;
                        Image.ScaleType = Enum.ScaleType.Fit;
                    end;

                    if v911[i].icon and Image.Image ~= v911[i].icon then
                        Image.Image = v911[i].icon;
                        v913 = i;
                    else
                        v913 = i;
                    end;
                else
                    v913 = i;
                end;
            end;

            u613.Frame.Product.Other.Limited1.Main.Text = u901.Emote.Name .. " (Limited Emote)";
            u613.Frame.Product.Other.Limited2.Main.Text = (u903 and u903.name) .. " (Limited MVP)" or "Limited MVP";
            u613.Frame.Product.Other.Limited3.Main.Text = (u904 and u904.name) .. " (Limited MVP 2)" or "Limited MVP 2";
        end)();
        u613.Frame.Shop.LimitedShop.Slot1.Icon.Image = u902.icon;
        u613.Frame.Shop.LimitedShop.Slot2.Icon.Image = u903.icon;
        u613.Frame.Shop.LimitedShop.Slot3.Icon.Image = u904.icon;
        u905 = table.find(u808, u901.Emote.Name);
        u906 = table.find(u809, u901.Mvp.Name);
        u907 = table.find(u809, u901.Mvp2.Name);

        if u905 then
            u613.Frame.Shop.LimitedShop.Slot1.Cost.TextColor3 = Color3.fromRGB(93, 179, 255);
            u613.Frame.Shop.LimitedShop.Slot1.Cost.Text = "OWNED";
        end;

        if u906 then
            u613.Frame.Shop.LimitedShop.Slot2.Cost.TextColor3 = Color3.fromRGB(93, 179, 255);
            u613.Frame.Shop.LimitedShop.Slot2.Cost.Text = "OWNED";
        end;

        if u907 then
            u613.Frame.Shop.LimitedShop.Slot3.Cost.TextColor3 = Color3.fromRGB(93, 179, 255);
            u613.Frame.Shop.LimitedShop.Slot3.Cost.Text = "OWNED";
        end;

        if not u908 then
            u908 = true;
            coroutine.wrap(function() -- Line: 7258
                -- upvalues: u610 (ref), MarketplaceService (ref), u611 (ref)
                for i = 1, 3 do
                    local u914 = u610[i] and u610[i].Id;
                    local v915;

                    if u914 then
                        local success2, result2 = pcall(function() -- Line: 7262
                            -- upvalues: MarketplaceService (ref), u914 (copy)
                            return MarketplaceService:GetProductInfo(u914, Enum.InfoType.Product);
                        end);

                        if success2 then
                            u611[u914] = result2.PriceInRobux;
                            v915 = i;
                        else
                            v915 = i;
                        end;
                    else
                        v915 = i;
                    end;
                end;
            end)();
        end;
    end;

    local function formatAdaptive(p916) -- Line: 7278
        if p916 >= 86400 then
            return p916 // 86400 .. " days";
        end;

        if p916 >= 3600 then
            return p916 // 3600 .. " hours";
        end;

        if p916 >= 60 then
            return p916 // 60 .. " mins";
        end;

        return math.ceil(p916) .. " secs";
    end;

    local u917 = 0;
    u609:Add(task.spawn(function() -- Line: 7296
        -- upvalues: u613 (copy), u917 (ref), reload (copy), u608 (copy)
        while task.wait(0.1) and u613.Parent do
            local v918 = 1;
            u917 = u917 + 1;

            if u917 % 10 == 1 then
                task.spawn(reload);
            end;

            local v919 = (u608.player:GetAttribute("spinluck") or os.time()) - os.time();
            local os_date_ret = os.date(v919 >= 3600 and "%X" or "%M:%S", v919);

            if u608.player:GetAttribute("spinpity") == 99 then
                u613.ShopLuck.LuckBoost.luckpity.TextColor3 = Color3.fromHSV(tick() * 60 % 360 / 360, 1, 1);
                v918 = 2;
            else
                u613.ShopLuck.LuckBoost.luckpity.TextColor3 = Color3.new();
            end;

            u613.ShopLuck.LuckBoost.lucktime.Text = ("luck time: %s"):format(os_date_ret or os.date("%M:%S", 0));

            if v919 >= 1 then
                u613.ShopLuck.LuckBoost.lucktime.TextColor3 = Color3.fromHSV(tick() * 60 % 360 / 360, 1, 1);
                v918 = 2;
            else
                u613.ShopLuck.LuckBoost.lucktime.TextColor3 = Color3.new();
            end;

            u613.ShopLuck.LuckBoost.luck.Text = ("current luck: %sx"):format((tostring(v918)));
            u613.ShopLuck.LuckBoost.luck.TextColor3 = v918 >= 2 and Color3.fromHSV(tick() * 60 % 360 / 360, 1, 1) or Color3.new();
        end;
    end));
    u609:Connect(u613.Frame.Shop.LimitedShop.LeftContainer.MoreBtn.MouseButton1Click, function() -- Line: 7329
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u613 (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        u613.Frame.Shop.Visible = false;
        u613.Frame.choice.Shop.fill.Visible = false;
        u613.Frame.Product.Visible = true;
        u613.Frame.Product.CanvasPosition = Vector2.zero;
        u613.Frame.choice.Product.fill.Visible = true;
    end);
    u609:Add(u613.Frame.Shop.LimitedShop.Slot1.InputBegan:Connect(function(p920: userdata) -- Line: 7339
        -- upvalues: u905 (ref), RunService2 (ref), u610 (ref), packets (ref), u608 (copy)
        if not ((not u905 or RunService2:IsStudio()) and u610[1]) then
            return;
        end;

        if p920.UserInputType == Enum.UserInputType.Touch or p920.UserInputType == Enum.UserInputType.MouseButton1 then
            packets.bytenet_giftCash.send({ u610[1].Id, u608.player.UserId });
        end;
    end));
    u609:Add(u613.Frame.Shop.LimitedShop.Slot2.InputBegan:Connect(function(p921: userdata) -- Line: 7346
        -- upvalues: u906 (ref), RunService2 (ref), u610 (ref), packets (ref), u608 (copy)
        if not ((not u906 or RunService2:IsStudio()) and u610[2]) then
            return;
        end;

        if p921.UserInputType == Enum.UserInputType.Touch or p921.UserInputType == Enum.UserInputType.MouseButton1 then
            packets.bytenet_giftCash.send({ u610[2].Id, u608.player.UserId });
        end;
    end));
    u609:Add(u613.Frame.Shop.LimitedShop.Slot3.InputBegan:Connect(function(p922: userdata) -- Line: 7353
        -- upvalues: u907 (ref), RunService2 (ref), u610 (ref), packets (ref), u608 (copy)
        if not ((not u907 or RunService2:IsStudio()) and u610[3]) then
            return;
        end;

        if p922.UserInputType == Enum.UserInputType.Touch or p922.UserInputType == Enum.UserInputType.MouseButton1 then
            packets.bytenet_giftCash.send({ u610[3].Id, u608.player.UserId });
        end;
    end));
    u609:Add(u613.Frame.Shop.LimitedShop.Slot1.Cost.MouseButton1Up:Connect(function() -- Line: 7360
        -- upvalues: emoteWiki (ref), u610 (ref), replication (ref), ReplicatedStorage2 (ref), script_LimitedPreview (ref)
        local v923 = emoteWiki[u610[1].Name];

        if not v923 then
            return;
        end;

        if workspace:GetAttribute("Preview") then
            replication.notification("There is a preview currently active.", Color3.fromRGB(255, 255, 255), ReplicatedStorage2.Resources.notisound);

            return;
        end;

        workspace:SetAttribute("Preview", true);
        script_LimitedPreview.Preview_EMOTE(v923, u610[1].Name);
        task.delay(5, function() -- Line: 7373
            workspace:SetAttribute("Preview", false);
        end);
    end));
    u609:Add(u613.Frame.Shop.LimitedShop.Slot2.Cost.MouseButton1Up:Connect(function() -- Line: 7379
        -- upvalues: wiki (ref), u610 (ref), replication (ref), ReplicatedStorage2 (ref), script_LimitedPreview (ref)
        local v924 = wiki.mvp_anim[u610[2].Name];

        if not v924 then
            return;
        end;

        if workspace:GetAttribute("Preview") then
            replication.notification("There is a preview currently active.", Color3.fromRGB(255, 255, 255), ReplicatedStorage2.Resources.notisound);

            return;
        end;

        workspace:SetAttribute("Preview", true);
        script_LimitedPreview.Preview_MVP(v924, u610[2].Name);
        task.delay(v924.length + 1 or 5, function() -- Line: 7392
            workspace:SetAttribute("Preview", false);
        end);
    end));
    u609:Add(u613.Frame.Shop.LimitedShop.Slot3.Cost.MouseButton1Up:Connect(function() -- Line: 7397
        -- upvalues: wiki (ref), u610 (ref), replication (ref), ReplicatedStorage2 (ref), script_LimitedPreview (ref)
        local v925 = wiki.mvp_anim[u610[3].Name];

        if not v925 then
            return;
        end;

        if workspace:GetAttribute("Preview") then
            replication.notification("There is a preview currently active.", Color3.fromRGB(255, 255, 255), ReplicatedStorage2.Resources.notisound);

            return;
        end;

        workspace:SetAttribute("Preview", true);
        script_LimitedPreview.Preview_MVP(v925, u610[3].Name);
        task.delay(v925.length + 1 or 5, function() -- Line: 7410
            workspace:SetAttribute("Preview", false);
        end);
    end));
    u609:Add(u613.Frame.Shop.LimitedShop.Slot1.MouseEnter:Connect(function() -- Line: 7416
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u905 (ref), u613 (copy), u611 (copy), u610 (ref)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);

        if u905 then
            u613.Frame.Shop.LimitedShop.Slot1.Cost.TextColor3 = Color3.fromRGB(93, 179, 255);
            u613.Frame.Shop.LimitedShop.Slot1.Cost.Text = "OWNED";

            return;
        end;

        u613.Frame.Shop.LimitedShop.Slot1.Cost.TextColor3 = Color3.fromRGB(78, 255, 90);
        u613.Frame.Shop.LimitedShop.Slot1.Cost.Text = (u611[u610[1] and u610[1].Id] or "149") .. "R$";
        u613.Frame.Shop.LimitedShop.Slot1.MouseLeave:Wait();
        u613.Frame.Shop.LimitedShop.Slot1.Cost.TextColor3 = Color3.fromRGB(255, 255, 255);
        u613.Frame.Shop.LimitedShop.Slot1.Cost.Text = "EMOTE";
    end));
    u609:Add(u613.Frame.Shop.LimitedShop.Slot2.MouseEnter:Connect(function() -- Line: 7430
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u906 (ref), u613 (copy), u611 (copy), u610 (ref)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);

        if u906 then
            u613.Frame.Shop.LimitedShop.Slot2.Cost.TextColor3 = Color3.fromRGB(93, 179, 255);
            u613.Frame.Shop.LimitedShop.Slot2.Cost.Text = "OWNED";

            return;
        end;

        u613.Frame.Shop.LimitedShop.Slot2.Cost.TextColor3 = Color3.fromRGB(78, 255, 90);
        u613.Frame.Shop.LimitedShop.Slot2.Cost.Text = (u611[u610[2] and u610[2].Id] or "499") .. "R$";
        u613.Frame.Shop.LimitedShop.Slot2.MouseLeave:Wait();
        u613.Frame.Shop.LimitedShop.Slot2.Cost.TextColor3 = Color3.fromRGB(255, 255, 255);
        u613.Frame.Shop.LimitedShop.Slot2.Cost.Text = "MVP";
    end));
    u609:Add(u613.Frame.Shop.LimitedShop.Slot3.MouseEnter:Connect(function() -- Line: 7445
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u907 (ref), u613 (copy), u611 (copy), u610 (ref)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);

        if u907 then
            u613.Frame.Shop.LimitedShop.Slot3.Cost.TextColor3 = Color3.fromRGB(93, 179, 255);
            u613.Frame.Shop.LimitedShop.Slot3.Cost.Text = "OWNED";

            return;
        end;

        u613.Frame.Shop.LimitedShop.Slot3.Cost.TextColor3 = Color3.fromRGB(78, 255, 90);
        u613.Frame.Shop.LimitedShop.Slot3.Cost.Text = (u611[u610[3] and u610[3].Id] or "499") .. "R$";
        u613.Frame.Shop.LimitedShop.Slot3.MouseLeave:Wait();
        u613.Frame.Shop.LimitedShop.Slot3.Cost.TextColor3 = Color3.fromRGB(255, 255, 255);
        u613.Frame.Shop.LimitedShop.Slot3.Cost.Text = "MVP";
    end));
    local u926 = {};

    local function updateEmoteSlots() -- Line: 7462
        -- upvalues: u608 (copy), u613 (copy), emoteWiki (ref), u926 (copy), u609 (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u612 (ref), fastSignal (ref), packets (ref)
        for i = 1, 8 do
            local v927;

            if u608.currentOpenEmoteUIPage:FindFirstChild(i) then
                task.spawn(pcall, function() -- Line: 7465
                    -- upvalues: u608 (ref), i (copy), u613 (ref), emoteWiki (ref), u926 (ref), u609 (ref), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u612 (ref), fastSignal (ref), packets (ref)
                    local u928 = u608:hasPass(1168206289);
                    local Value = u608.currentOpenEmoteUIPage[i].Value;
                    local u929 = u613.Frame.Storage.Emotes.Emote.Slots[i];
                    local _ = emoteWiki[Value];
                    u929.Visible = i <= 4 and true or u928;
                    local v930 = emoteWiki[Value];

                    if v930 then
                        Value = v930.name or Value;
                    end;

                    u929.Main.Text = Value;
                    local Button = u929.Button;

                    if u926[`changeSlot{i}`] then
                        u926[`changeSlot{i}`]:Disconnect();
                    end;

                    u926[`changeSlot{i}`] = u609:Add(Button.MouseButton1Click:Connect(function() -- Line: 7485
                        -- upvalues: i (ref), u928 (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u612 (ref), u929 (copy), fastSignal (ref), emoteWiki (ref), packets (ref), u608 (ref), u609 (ref)
                        if i > 4 and not u928 then
                            return;
                        end;

                        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);

                        if u612 then
                            return;
                        end;

                        u929.BackgroundColor3 = Color3.fromRGB(136, 112, 112);
                        u612 = fastSignal.new();
                        u612:Once(function(p931) -- Line: 7497
                            -- upvalues: u612 (ref), emoteWiki (ref), u929 (ref), packets (ref), i (ref), u608 (ref)
                            u612:Destroy();
                            u612 = nil;
                            local v932 = emoteWiki[p931];
                            local v933;

                            if v932 then
                                v933 = v932.name or p931;
                            else
                                v933 = p931;
                            end;

                            u929.Main.Text = v933;
                            u929.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                            packets.bytenet_changeEmote.send({
                                emoteName = p931,
                                emoteIndex = i,
                                emotePage = u608.currentEmotePage
                            });
                        end);
                        u609:Add(u612);
                    end));
                end);
                v927 = i;
            else
                v927 = i;
            end;
        end;
    end;

    local function updatePage() -- Line: 7530
        -- upvalues: u608 (copy), u613 (copy), wiki (ref), updateEmoteSlots (copy)
        local v934;

        if u608.currentEmotePage == 1 then
            v934 = u608.emote;
        else
            v934 = u608.emote.extraPages[u608.currentEmotePage - 1];
        end;

        u608.currentOpenEmoteUIPage = v934;
        u613.Frame.Storage.Emotes.Emote.Previous.Visible = u608.currentEmotePage > 1;
        u613.Frame.Storage.Emotes.Emote.Next.Visible = u608.currentEmotePage < wiki.maxEmotePages;
        u613.Frame.Storage.Emotes.Emote.PageNumber.Main.Text = `{u608.currentEmotePage}/{wiki.maxEmotePages}`;
        task.spawn(updateEmoteSlots);
    end;

    packets.bytenet_quests.send({
        questAction = "giveme",
        questContent = {}
    });

    local function changePage(p935: string) -- Line: 7547
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u608 (copy), replication (ref), wiki (ref), MarketplaceService (ref), updatePage (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);

        if u608.emotePageDebounce then
            replication.notification("Try page switching again in a second", nil, ReplicatedStorage2.Resources.notisound);

            return;
        end;

        u608.emotePageDebounce = true;
        task.delay(0.1, function() -- Line: 7557
            -- upvalues: u608 (ref)
            u608.emotePageDebounce = nil;
        end);
        local table_find_ret = table.find({ "Next", "Previous" }, p935);
        assert(table_find_ret, "direction must be \'Next\' or \'Previous\'");

        if not u608:hasPass(wiki.gamepassId.extraPages) then
            MarketplaceService:PromptGamePassPurchase(u608.player, wiki.gamepassId.extraPages);

            return;
        end;

        local v936 = u608.currentEmotePage + (p935 == "Next" and 1 or -1);

        if wiki.maxEmotePages < v936 then
            replication.notification("There is no next page", Color3.fromRGB(255, 100, 100), ReplicatedStorage2.Resources.notisound);

            return;
        end;

        if v936 < 1 then
            replication.notification("There is no previous page", Color3.fromRGB(255, 100, 100), ReplicatedStorage2.Resources.notisound);

            return;
        end;

        u608.currentEmotePage = v936;
        updatePage();
    end;

    updateEmoteSlots();
    updatePage();
    u609:Connect(u613.Frame.Storage.Emotes.Emote.Next.Button.MouseButton1Click, function() -- Line: 7583
        -- upvalues: changePage (copy)
        changePage("Next");
    end);
    u609:Connect(u613.Frame.Storage.Emotes.Emote.Previous.Button.MouseButton1Click, function() -- Line: 7587
        -- upvalues: changePage (copy)
        changePage("Previous");
    end);
    u609:Add(u613.Frame.Storage.Emotes.Emote.Search.TextBox:GetPropertyChangedSignal("Text"):connect(function() -- Line: 7591
        -- upvalues: u613 (copy)
        for _, child in u613.Frame.Storage.Emotes.Emote.Storage:GetChildren() do
            if child:IsA("Frame") then
                child.Visible = string.find(child.Main.Text:lower(), u613.Frame.Storage.Emotes.Emote.Search.TextBox.Text:lower()) and true or false;
            end;
        end;
    end));

    local function u939(p937: userdata, p938: any) -- Line: 7599
        local Frame = p937:WaitForChild("Frame");
        local boolean = Frame:WaitForChild("boolean");
        local UDim2_new_ret2 = UDim2.new(0, 0, 0, 0);
        local UDim2_new_ret3 = UDim2.new(0.5, 0, 0, 0);
        local Color3_fromRGB_ret2 = Color3.fromRGB(123, 255, 0);
        local Color3_fromRGB_ret3 = Color3.fromRGB(178, 255, 169);
        local Color3_fromRGB_ret4 = Color3.fromRGB(171, 0, 0);
        local Color3_fromRGB_ret5 = Color3.fromRGB(255, 107, 107);

        if p938 then
            UDim2_new_ret3 = UDim2_new_ret2 or UDim2_new_ret3;
        end;

        boolean.Position = UDim2_new_ret3;

        if p938 then
            Color3_fromRGB_ret4 = Color3_fromRGB_ret2 or Color3_fromRGB_ret4;
        end;

        Frame.BackgroundColor3 = Color3_fromRGB_ret4;

        if p938 then
            Color3_fromRGB_ret5 = Color3_fromRGB_ret3 or Color3_fromRGB_ret5;
        end;

        boolean.BackgroundColor3 = Color3_fromRGB_ret5;
    end;

    local function functionsetting(p940, p941, p942) -- Line: 7618
        -- upvalues: script_settingFunctions (ref), u608 (copy)
        require(script_settingFunctions[p940])(u608, p941, p942);
    end;

    local function checkGamepass(p943) -- Line: 7625
        -- upvalues: wiki (ref), PassClient (ref), MarketplaceService (ref), u608 (copy)
        local v944 = wiki.gamepassId[p943];

        if not v944 or PassClient.checkPass(v944) then
            return true;
        end;

        MarketplaceService:PromptGamePassPurchase(u608.player, v944);

        return false;
    end;

    local success2, result2 = pcall(function() -- Line: 7639
        -- upvalues: u716 (copy), u608 (copy), u939 (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), u609 (copy), functionsetting (copy), wiki (ref), PassClient (ref), MarketplaceService (ref)
        for _, v in u716 do
            local u945 = u608.setting:FindFirstChild(v.Name);

            if u945 then
                local Attribute = v:GetAttribute("type");

                if Attribute == "default" then
                    local Value = u945.Value;
                    u939(v, u945.Value);
                    (v:FindFirstChild("Button") or v.Frame:FindFirstChild("Button")).MouseButton1Up:Connect(function() -- Line: 7654
                        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), u945 (copy), Value (ref)
                        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
                        packets.bytenet_settingChange.send({
                            name = u945.Name,
                            value = not Value
                        });
                    end);
                    u609:Connect(u945.Changed, function(p946) -- Line: 7663
                        -- upvalues: Value (ref), u939 (ref), v (copy)
                        Value = p946;
                        u939(v, p946);
                    end);
                elseif Attribute == "function" then
                    local u947 = v.Frame:FindFirstChild("Button") or v:FindFirstChild("Button");
                    local v948;

                    if table.find({ "graphicsMode", "teamHighlight", "crowdAudio", "Style&MVP", "ServerLocation", "FPS", "CurrencyUI" }, v.Name) then
                        local _, _ = pcall(function() -- Line: 7676
                            -- upvalues: functionsetting (ref), v (copy), u947 (copy), u945 (copy)
                            return functionsetting(v.Name, u947, u945 and (u945.ClassName ~= "Folder" and u945.Value or u945));
                        end);
                        v948 = true;
                    else
                        v948 = false;
                    end;

                    if v948 then
                        u947.MouseButton1Up:Connect(function() -- Line: 7697
                            -- upvalues: v (copy), functionsetting (ref), u947 (copy)
                            if v.Name == "graphicsMode" then
                                return functionsetting(v.Name, u947, nil);
                            end;
                        end);
                    else
                        u947.MouseButton1Up:Connect(function() -- Line: 7683
                            -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), v (copy), wiki (ref), PassClient (ref), MarketplaceService (ref), u608 (ref), functionsetting (ref), u947 (copy), u945 (copy)
                            soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
                            local v949 = wiki.gamepassId[v.Name];
                            local v950;

                            if v949 and not PassClient.checkPass(v949) then
                                MarketplaceService:PromptGamePassPurchase(u608.player, v949);
                                v950 = false;
                            else
                                v950 = true;
                            end;

                            if not v950 then
                                return;
                            end;

                            local _, _ = pcall(function() -- Line: 7690
                                -- upvalues: functionsetting (ref), v (ref), u947 (ref), u945 (ref)
                                return functionsetting(v.Name, u947, u945 and (u945.ClassName ~= "Folder" and u945.Value or u945));
                            end);
                        end);
                    end;
                else
                    local TextBox = v:WaitForChild("Frame"):WaitForChild("TextBox");
                    local Value = u945.Value;
                    TextBox.FocusLost:connect(function() -- Line: 7708
                        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), TextBox (copy), v (copy), Value (ref), packets (ref), u945 (copy)
                        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
                        local v951 = tonumber(TextBox.Text);

                        if typeof(v951) ~= "number" or (v951 < (v:GetAttribute("min") or 0) or (v:GetAttribute("max") or 100) < v951) then
                            TextBox.Text = Value;

                            return;
                        end;

                        Value = v951;
                        TextBox.Text = Value;

                        if typeof(Value) ~= "number" and typeof(Value) ~= "string" then
                            return warn("invaild setting behavior");
                        end;

                        packets.bytenet_settingChange.send({
                            name = u945.Name,
                            value = Value
                        });
                    end);
                    TextBox.Text = Value;
                end;
            else
                print("?");
            end;
        end;
    end);
    print(success2, result2);
    local Rewards = u613.Frame.Rewards.Rewards;
    local DailyQuestcontainer = Rewards.DailyQuestcontainer;

    local function u955(p952) -- Line: 7739
        -- upvalues: DailyQuestcontainer (copy), wiki (ref), u609 (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), u608 (copy)
        for _, child in DailyQuestcontainer:GetChildren() do
            if child.Name ~= "Template" and child:IsA("Frame") then
                child:Destroy();
            end;
        end;

        for i, v in p952 do
            local v953 = wiki.dailyQuests.list[v.Id];
            local v954 = DailyQuestcontainer.Template:Clone();
            v954.Name = "QUEST";
            v954.Holder.Title.Text = v953.Title;
            v954.Holder.Progress.cout.Text = `{v.Progress[1]}/{v953.Requirements[1].Amount}`;
            v954.Holder.Progress.bar.Size = UDim2.fromScale(v.Progress[1] / v953.Requirements[1].Amount, 1);
            v954.Visible = true;
            v954.Parent = DailyQuestcontainer;

            if v954:FindFirstChild("SkipDaily") then
                u609:Add(v954.SkipDaily.MouseButton1Up:Connect(function() -- Line: 7757
                    -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), u608 (ref), i (copy)
                    soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
                    packets.bytenet_SkipDaily.send({ 3436079029, u608.player.UserId, i });
                end));
            end;
        end;
    end;

    local u956 = nil;
    u609:Add(task.defer(function() -- Line: 7768
        -- upvalues: u613 (copy), wiki (ref), Rewards (copy), query (ref), HttpService (ref), u956 (ref), u955 (copy)
        while task.wait(1) and u613.Parent do
            local v957 = wiki.dailyQuests.getNextCycleTime() - os.time();
            Rewards.DailyQuestRefresh.Text = `Daily Quests refresh in {wiki.dailyQuests.formatTime(v957)}`;
            local u958 = query.getDailyQuests:Fire();
            local success3, result3 = pcall(HttpService.JSONEncode, HttpService, u958);

            if not success3 or result3 ~= u956 then
                u956 = result3;
                pcall(function() -- Line: 7781
                    -- upvalues: u955 (ref), u958 (copy)
                    u955(u958);
                end);
            end;
        end;
    end));
    local u959 = nil;
    local u960 = {};

    local function view_product(u961, u962, u963, p964, p965) -- Line: 7792
        -- upvalues: u809 (copy), u808 (copy), u960 (ref), u613 (copy), TweenService (ref), packets (ref), u608 (copy), replication (ref), ReplicatedStorage2 (ref), giftui (copy), script_LimitedPreview (ref), u959 (ref)
        local u966 = u963 == "MVP" and table.find(u809, u961.Name);

        if not u966 then
            if u963 == "EMOTE" then
                u966 = table.find(u808, u961.Name);
            else
                u966 = false;
            end;
        end;

        for _, v in u960 do
            v:Disconnect();
        end;

        u960 = {};
        local RightContainer = u613.Frame.Shop.LimitedShop.RightContainer;
        RightContainer.Visible = true;
        local Showcase = RightContainer.Showcase;
        Showcase.ItemName.Text = u962.name or u961.Name;
        Showcase.ItemType.Text = u963;
        local Position2 = RightContainer.Position;
        RightContainer.Position = UDim2.fromScale(0.465, 0.4);
        RightContainer.GroupTransparency = 1;
        TweenService:Create(RightContainer, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            GroupTransparency = 0,
            Position = Position2
        }):Play();

        if u962.icon then
            Showcase.ItemImage.Image = u962.icon;
        end;

        if u966 then
            Showcase.ButtonContainer.BuyBtn.Main.Text = "OWNED";
        elseif p964 then
            Showcase.ButtonContainer.BuyBtn.Main.Text = p965.Text;
        else
            Showcase.ButtonContainer.BuyBtn.Main.Text = "BUY";
        end;

        table.insert(u960, Showcase.ButtonContainer.BuyBtn.MouseButton1Up:Connect(function() -- Line: 7830
            -- upvalues: u966 (copy), packets (ref), u961 (copy), u608 (ref), replication (ref), ReplicatedStorage2 (ref)
            if u966 then
                replication.notification("You already own this item!", Color3.fromRGB(255, 170, 0), ReplicatedStorage2.Resources.notisound);

                return;
            end;

            packets.bytenet_giftCash.send({ u961.Id, u608.player.UserId });
        end));
        table.insert(u960, Showcase.ButtonContainer.GiftBtn.MouseButton1Up:Connect(function() -- Line: 7837
            -- upvalues: giftui (ref), u961 (copy)
            giftui(u961.Id);
        end));
        table.insert(u960, Showcase.ButtonContainer.PreviewBtn.MouseButton1Up:Connect(function() -- Line: 7840
            -- upvalues: script_LimitedPreview (ref), u963 (copy), replication (ref), ReplicatedStorage2 (ref), u962 (copy), u961 (copy)
            if not script_LimitedPreview["Preview_" .. u963] then
                replication.notification("There is no preview method for this type of cosmetic.", Color3.fromRGB(255, 255, 255), ReplicatedStorage2.Resources.notisound);

                return;
            end;

            if workspace:GetAttribute("Preview") then
                replication.notification("There is a preview currently active.", Color3.fromRGB(255, 255, 255), ReplicatedStorage2.Resources.notisound);

                return;
            end;

            workspace:SetAttribute("Preview", true);
            script_LimitedPreview["Preview_" .. u963](u962, u961.Name);
            task.delay(u963 == "MVP" and (u962.length + 1 or 5) or 5, function() -- Line: 7849
                workspace:SetAttribute("Preview", false);
            end);
        end));
        u959 = u961.Id;
    end;

    local function createLimitedItemFrame(u967, u968, u969, p970, p971) -- Line: 7859
        -- upvalues: u613 (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), TweenService (ref), MarketplaceService (ref), view_product (copy)
        local u972 = {};
        local u973 = u613.Frame.Shop.LimitedShop.LeftContainer.SampleItem:Clone();
        local Size = u973.Size;
        u973.Name = u967.Name;
        u973.Visible = true;
        u973.LayoutOrder = p970;
        u973.MouseEnter:Connect(function() -- Line: 7869
            -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u972 (copy), TweenService (ref), u973 (copy), Size (copy)
            soundUtil:play(ReplicatedStorage2.Resources.hover, SoundService);

            for _, v in u972 do
                v:Pause();
            end;

            table.clear(u972);
            local TweenInfo_new_ret3 = TweenInfo.new(0.25);
            local v974 = {
                Size = UDim2.fromScale(Size.X.Scale * 1.05, Size.Y.Scale * 1.05)
            };
            table.insert(u972, TweenService:Create(u973, TweenInfo_new_ret3, v974));
            local Glow = u973.Glow;
            local TweenInfo_new_ret4 = TweenInfo.new(0.25);
            table.insert(u972, TweenService:Create(Glow, TweenInfo_new_ret4, {
                ImageTransparency = 0
            }));

            for _, v in u972 do
                v:Play();
            end;
        end);
        u973.MouseLeave:Connect(function() -- Line: 7882
            -- upvalues: u972 (copy), TweenService (ref), u973 (copy), Size (copy)
            for _, v in u972 do
                v:Pause();
            end;

            table.clear(u972);
            local TweenInfo_new_ret3 = TweenInfo.new(0.25);
            table.insert(u972, TweenService:Create(u973, TweenInfo_new_ret3, {
                Size = Size
            }));
            local Glow = u973.Glow;
            local TweenInfo_new_ret4 = TweenInfo.new(0.25);
            table.insert(u972, TweenService:Create(Glow, TweenInfo_new_ret4, {
                ImageTransparency = 1
            }));

            for _, v in u972 do
                v:Play();
            end;
        end);
        local title = u973:FindFirstChild("title");

        if title then
            title.Text = u968.name or u967.Name .. " (" .. u969 .. ")";
        end;

        if u968.icon then
            u973.Icon.Image = u968.icon;
        end;

        local price = u973:FindFirstChild("price");
        local u975 = nil;
        task.spawn(function() -- Line: 7906
            -- upvalues: MarketplaceService (ref), u967 (copy), price (copy), u975 (ref)
            local success3, result3 = pcall(function() -- Line: 7907
                -- upvalues: MarketplaceService (ref), u967 (ref)
                return MarketplaceService:GetProductInfo(u967.Id, Enum.InfoType.Product);
            end);

            if success3 and (result3 and price) then
                price.Text = `{result3.PriceInRobux}`;
                u975 = result3.PriceInRobux;
            end;
        end);
        u973.MouseButton1Up:Connect(function() -- Line: 7926
            -- upvalues: view_product (ref), u967 (copy), u968 (copy), u969 (copy), u975 (ref), price (copy)
            view_product(u967, u968, u969, u975, price);
        end);

        return u973;
    end;

    local u976 = "EMOTE";

    local function createLimitedShop(p977) -- Line: 7957
        -- upvalues: u976 (ref), u613 (copy), query (ref), wiki (ref), createLimitedItemFrame (copy), u809 (copy), emoteWiki (ref), u808 (copy)
        local v978 = 0;

        while true do
            if v978 == 0 then
                v978 = -1;
                u976 = p977 or u976;
                local LimitedShop = u613.Frame.Shop.LimitedShop;
                local v979 = LimitedShop.LeftContainer:FindFirstChild("LeftScroll") or LimitedShop;

                for _, child in v979:GetChildren() do
                    if (child:IsA("Frame") or child:IsA("ImageButton")) and child.Name ~= "Template" then
                        child:Destroy();
                    end;
                end;

                local v980 = query.getLimitedShopItems:Fire();

                if not v980 then
                    warn("Failed to fetch limited shop data");

                    return;
                end;

                if u976 ~= "MVP" then
                    if u976 == "EMOTE" then
                        local v981 = v980.numEmotes or 3;

                        if v980.emotes then
                            for i, v in ipairs(v980.emotes) do
                                if v981 < i then
                                    break;
                                end;

                                local v982 = emoteWiki[v.Name];

                                if v982 then
                                    createLimitedItemFrame(v, v982, "EMOTE", i, table.find(u808, v.Name) ~= nil).Parent = v979;
                                end;
                            end;
                        end;
                    end;

                    v978 = 1;
                    continue;
                end;

                local v983 = v980.numMvps or 5;

                if v980.mvps then
                    for i, v in ipairs(v980.mvps) do
                        if v983 < i then
                            v978 = 1;
                            break;
                        end;

                        local v984 = wiki.mvp_anim[v.Name];

                        if v984 then
                            createLimitedItemFrame(v, v984, "MVP", i, table.find(u809, v.Name) ~= nil).Parent = v979;
                        end;
                    end;

                    if v978 ~= -1 then
                        continue;
                    end;

                    return;
                end;

                v978 = 1;
                continue;
            elseif v978 == 1 then
                v978 = -1;
                break;
            else
                break;
            end;
        end;
    end;

    task.spawn(function() -- Line: 8023
        -- upvalues: createLimitedShop (copy), u976 (ref)
        createLimitedShop(u976);
    end);
    local MVPsTab = u613.Frame.Shop.LimitedShop.LeftContainer.TabBar:FindFirstChild("MVPsTab");
    local EmotesTab = u613.Frame.Shop.LimitedShop.LeftContainer.TabBar:FindFirstChild("EmotesTab");

    if MVPsTab then
        u609:Add(MVPsTab.MouseButton1Click:Connect(function() -- Line: 8031
            -- upvalues: u960 (ref), u959 (ref), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), MVPsTab (copy), EmotesTab (copy), createLimitedShop (copy)
            for _, v in u960 do
                v:Disconnect();
            end;

            u960 = {};
            u959 = nil;
            soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
            MVPsTab.fill.Visible = true;
            EmotesTab.fill.Visible = false;
            createLimitedShop("MVP");
        end));
    end;

    if EmotesTab then
        u609:Add(EmotesTab.MouseButton1Click:Connect(function() -- Line: 8050
            -- upvalues: u960 (ref), u959 (ref), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), createLimitedShop (copy), MVPsTab (copy), EmotesTab (copy)
            for _, v in u960 do
                v:Disconnect();
            end;

            u960 = {};
            u959 = nil;
            soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
            createLimitedShop("EMOTE");
            MVPsTab.fill.Visible = false;
            EmotesTab.fill.Visible = true;
        end));
    end;

    local Club2 = u613.Frame.Club;
    local u985 = {};
    u609:Add(function() -- Line: 8072
        -- upvalues: u985 (copy)
        for _, v in u985 do
            v:Cancel();
            v:Destroy();
        end;

        table.clear(u985);
    end);

    local function doTween(p986: userdata, p987: userdata, p988: table) -- Line: 8080
        -- upvalues: u985 (copy), TweenService (ref)
        if u985[p986] then
            u985[p986]:Pause();
        end;

        local v989 = TweenService:Create(p986, p987, p988);
        v989:Play();
        u985[p986] = v989;
    end;

    local function isInClub(p990) -- Line: 8089
        -- upvalues: u608 (copy)
        local club = (p990 or u608.player):FindFirstChild("club");

        if club then
            club = club.Value ~= "";
        end;

        return club;
    end;

    u609:Connect(Club2.ActiveClub.Leave.Button.MouseButton1Click, function() -- Line: 8094
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), Club (ref)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        Club.Leave();
    end);
    local TweenInfo_new_ret3 = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
    local u991 = nil;
    local MemberInfo = Club.GetMemberInfo(u608.player);

    local function addToMembers(u992) -- Line: 8104
        -- upvalues: Club2 (copy), u608 (copy), MemberInfo (ref), Club (ref), u609 (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref)
        local ScrollingFrame = Club2.ActiveClub.ScrollingFrame;
        local UIListLayout = ScrollingFrame.UIListLayout;

        if ScrollingFrame:FindFirstChild(u992.Name) then
            return;
        end;

        local v993 = UIListLayout.Template:Clone();
        v993.MVPs.Text = `MVPs: {u992:GetAttribute("MVPs")}`;
        v993.Placement.Text = `#{u992:GetAttribute("Placement")}`;
        v993.Username.Text = u992:GetAttribute("Username");
        v993.LayoutOrder = tonumber(u992:GetAttribute("Placement")) or 10000;
        v993.Name = u992.Name;
        v993.Parent = ScrollingFrame;
        ScrollingFrame.CanvasSize = UDim2.fromOffset(0, ScrollingFrame.UIListLayout.AbsoluteContentSize.Y);
        local v994 = u992.Value == "Chairman";

        if v994 then
            v993.Chairman.Visible = true;
        end;

        if tonumber(u992.Name) == u608.player.UserId then
            Club2.ActiveClub.Leave.Button.Text = v994 and "Disband" or "Leave";
            MemberInfo = u992;
        end;

        if Club.IsRankAbove(MemberInfo or u608.player, u992) then
            local v995 = UIListLayout.Kick:Clone();
            v995.Parent = v993.Buttons;
            u609:Connect(v995.Button.MouseButton1Click, function() -- Line: 8136
                -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), Club (ref), u992 (copy)
                soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
                Club.Kick((tonumber(u992.Name)));
            end);
        end;
    end;

    local function updateClubFrame() -- Line: 8143
        -- upvalues: u991 (ref), u608 (copy), Club2 (copy), TweenInfo_new_ret3 (copy), u985 (copy), TweenService (ref), ReplicatedStorage2 (ref), u609 (copy), addToMembers (copy)
        if u991 then
            u991:Disconnect();
            u991 = nil;
        end;

        local club = u608.player:FindFirstChild("club");
        local club2 = u608.player:FindFirstChild("club");

        if club2 then
            club2 = club2.Value ~= "";
        end;

        if not club2 then
            local Creation = Club2.Creation;
            local v996 = {
                AnchorPoint = Vector2.new(0, 0)
            };

            if u985[Creation] then
                u985[Creation]:Pause();
            end;

            local v997 = TweenService:Create(Creation, TweenInfo_new_ret3, v996);
            v997:Play();
            u985[Creation] = v997;
            local Invites = Club2.Invites;
            local v998 = {
                AnchorPoint = Vector2.new(1, 0)
            };

            if u985[Invites] then
                u985[Invites]:Pause();
            end;

            local v999 = TweenService:Create(Invites, TweenInfo_new_ret3, v998);
            v999:Play();
            u985[Invites] = v999;
            local ActiveClub = Club2.ActiveClub;
            local v1000 = {
                GroupTransparency = 1
            };

            if u985[ActiveClub] then
                u985[ActiveClub]:Pause();
            end;

            local v1001 = TweenService:Create(ActiveClub, TweenInfo_new_ret3, v1000);
            v1001:Play();
            u985[ActiveClub] = v1001;

            return club;
        end;

        local Creation = Club2.Creation;
        local v1002 = {
            AnchorPoint = Vector2.new(1, 0)
        };

        if u985[Creation] then
            u985[Creation]:Pause();
        end;

        local v1003 = TweenService:Create(Creation, TweenInfo_new_ret3, v1002);
        v1003:Play();
        u985[Creation] = v1003;
        local Invites = Club2.Invites;
        local v1004 = {
            AnchorPoint = Vector2.new(0, 0)
        };

        if u985[Invites] then
            u985[Invites]:Pause();
        end;

        local v1005 = TweenService:Create(Invites, TweenInfo_new_ret3, v1004);
        v1005:Play();
        u985[Invites] = v1005;
        local ActiveClub = Club2.ActiveClub;
        local v1006 = {
            GroupTransparency = 0
        };

        if u985[ActiveClub] then
            u985[ActiveClub]:Pause();
        end;

        local v1007 = TweenService:Create(ActiveClub, TweenInfo_new_ret3, v1006);
        v1007:Play();
        u985[ActiveClub] = v1007;
        local ActiveClub2 = Club2.ActiveClub;
        ActiveClub2.ClubName.Text = club.name.Value;
        ActiveClub2.ImageLabel.Image = `rbxassetid://{club.icon.Value}`;
        local v1008 = ReplicatedStorage2.Club.Cache[club.Value];
        local Members = v1008.Members;
        ActiveClub2.ClubStreak.Text = v1008.streak.Value;
        u991 = u609:Connect(Members.ChildAdded, addToMembers);

        for _, child in Members:GetChildren() do
            task.defer(addToMembers, child);
        end;

        return club;
    end;

    local Invites = Club2.ActiveClub.Invites;
    local u1009 = nil;

    local function addInvitable(u1010: userdata) -- Line: 8180
        -- upvalues: u608 (copy), Invites (copy), u609 (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u1009 (ref)
        if u1010 == u608.player then
            return;
        end;

        local club = (u1010 or u608.player):FindFirstChild("club");

        if club then
            club = club.Value ~= "";
        end;

        if club then
            return;
        end;

        if Invites:FindFirstChild(u1010.Name) then
            return;
        end;

        local u1011 = Invites.UIListLayout.Template:Clone();
        u1011.Name = u1010.Name;
        u1011.Username.Text = u1010.DisplayName;
        u1011.Parent = Invites;
        Invites.CanvasSize = UDim2.fromOffset(0, Invites.UIListLayout.AbsoluteContentSize.Y);
        u609:Connect(u1011.MouseButton1Click, function() -- Line: 8194
            -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u1009 (ref), u1010 (copy), Invites (ref)
            soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
            u1009 = u1010;

            for _, child in Invites:GetChildren() do
                if child:IsA("TextButton") then
                    if child.Name == u1010.Name then
                        child.BackgroundColor3 = Color3.new(1, 1, 0);
                    else
                        child.BackgroundColor3 = Color3.new(1, 1, 1);
                    end;
                end;
            end;
        end);
        u609:Connect(u1010.AncestryChanged, function() -- Line: 8207
            -- upvalues: u1010 (copy), u1011 (copy)
            if not u1010:IsDescendantOf(game) then
                u1011:Destroy();
            end;
        end);
    end;

    for _, v in Players:GetPlayers() do
        task.defer(addInvitable, v);
    end;

    u609:Connect(Players.PlayerAdded, addInvitable);
    u609:Connect(Club2.ActiveClub.Invite.Button.MouseButton1Click, function() -- Line: 8220
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u1009 (ref), Club (ref)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);

        if u1009 then
            Club.Invite.Send(u1009);
        end;
    end);
    local u1012 = updateClubFrame();

    if u1012 then
        u609:Connect(u1012.Changed, updateClubFrame);
    else
        u609:Connect(u608.player.ChildAdded, function(p1013) -- Line: 8230
            -- upvalues: u1012 (ref), u609 (copy), updateClubFrame (copy)
            if p1013.Name == "club" then
                u1012 = p1013;
                u609:Connect(u1012.Changed, updateClubFrame);
                updateClubFrame();
            end;
        end);
    end;

    local Creation = Club2.Creation;
    local Container = Creation.Container;
    local ImageLabel = Container.IconExample.ImageLabel;
    u609:Connect(Container.Texture.FocusLost, function() -- Line: 8245
        -- upvalues: Container (copy), ImageLabel (copy), MarketplaceService (ref)
        local u1014 = tonumber(Container.Texture.Text);

        if not u1014 then
            ImageLabel.Image = "";

            return;
        end;

        local success3, result3 = pcall(function() -- Line: 8248
            -- upvalues: MarketplaceService (ref), u1014 (ref)
            return MarketplaceService:GetProductInfoAsync(u1014, Enum.InfoType.Asset);
        end);

        if not success3 then
            ImageLabel.Image = "";

            return;
        end;

        if result3.AssetTypeId == Enum.AssetType.Image.Value then
            u1014 = `rbxassetid://{result3.AssetId}`;
        else
            if result3.AssetTypeId ~= Enum.AssetType.Decal.Value then
                ImageLabel.Image = "";

                return;
            end;

            u1014 = `rbxthumb://type=Asset&id={result3.AssetId}&w=420&h=420`;
        end;

        ImageLabel.Image = u1014;
    end);
    u609:Connect(Creation.Create.Button.MouseButton1Click, function() -- Line: 8265
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), Club (ref), Container (copy), u608 (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        Club.Create(Container.ClubName.Text, u608.player, {
            icon = tonumber(Container.Texture.Text)
        });
    end);
    local ScrollingFrame = Club2.Invites.ScrollingFrame;

    local function add_invite(u1015: userdata) -- Line: 8275
        -- upvalues: ScrollingFrame (copy), u609 (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), Club (ref), u608 (copy)
        local club = u1015.Value.club;

        if ScrollingFrame:FindFirstChild(u1015.Name) then
            return;
        end;

        local u1016 = ScrollingFrame.UIListLayout.Frame:Clone();
        u1016.Name = club.Value;
        u1016.TextLabel.Text = club.name.Value;
        u1016.ImageLabel.Image = `rbxassetid://{club.icon.Value}`;
        u1016.Parent = ScrollingFrame;
        ScrollingFrame.CanvasSize = UDim2.fromOffset(0, ScrollingFrame.UIListLayout.AbsoluteContentSize.Y);
        u609:Connect(u1016.Accept.Button.MouseButton1Click, function() -- Line: 8290
            -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), Club (ref), u1015 (copy)
            soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
            Club.Invite.Accept(u1015);
        end);
        u609:Connect(u1016.Decline.Button.MouseButton1Click, function() -- Line: 8295
            -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), Club (ref), u1015 (copy)
            soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
            Club.Invite.Decline(u1015);
        end);
        u609:Connect(u1015.AncestryChanged, function() -- Line: 8300
            -- upvalues: u1015 (copy), u608 (ref), u1016 (copy)
            if not u1015:IsDescendantOf(u608.player) then
                u1016:Destroy();
            end;
        end);
    end;

    for _, child in u608.player.ClubInvites:GetChildren() do
        task.defer(add_invite, child);
    end;

    u609:Connect(u608.player.ClubInvites.ChildAdded, add_invite);

    return u613;
end;

function u3.Select(u1017) -- Line: 8316
    -- upvalues: replication (copy), ReplicatedStorage2 (copy), TweenService (copy), Players (copy), ReplicatedStorage (copy), soundUtil (copy), SoundService (copy), packets (copy), wiki (copy)
    if u1017:isRematchLobbyLocked() then
        replication.notification("nice bro.", Color3.fromRGB(255, 0, 0), ReplicatedStorage2.Resources.notisound);

        return;
    end;

    local v1018 = u1017:createContainer();

    if not v1018 then
        return;
    end;

    local u1019 = script.Select:Clone();
    u1019.Parent = u1017.playerGui;
    v1018:Add(u1019);
    v1018:Add(ReplicatedStorage2.workspace.disabled.Changed:Connect(function(p1020) -- Line: 8335
        -- upvalues: u1019 (copy)
        u1019.Frame.Frozen.Visible = p1020;
    end));
    u1019.Frame.Frozen.Visible = ReplicatedStorage2.workspace.disabled.Value;
    local Position = u1019.Frame.Position;
    local UDim2_new_ret = UDim2.new(0, 0, 1, 0);
    local TweenInfo_new_ret2 = TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    u1019.Frame.Position = UDim2_new_ret;
    TweenService:Create(u1019.Frame, TweenInfo_new_ret2, {
        Position = Position
    }):Play();

    local function getImage(p1021, p1022) -- Line: 8351
        -- upvalues: Players (ref)
        if p1022 and p1022:GetAttribute("AIGK") then
            return;
        end;

        local profile = p1021.profile;
        local v1023 = p1022 and Players:GetPlayerFromCharacter(p1022);

        if v1023 then
            local UserThumbnailAsync, _ = Players:GetUserThumbnailAsync(v1023.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420);
            profile.Image = UserThumbnailAsync;
        end;

        profile.Visible = p1022;
        local UIGradient = p1021:FindFirstChild("UIGradient");

        if UIGradient then
            UIGradient.Enabled = p1022;
        end;
    end;

    for _, child in ipairs(u1019.Frame.A:GetChildren()) do
        if child:IsA("Frame") then
            if ReplicatedStorage.Ranked.Value and (u1017.player.Team and u1017.player.Team.Name ~= "A") then
                child.Visible = false;
            else
                if u1017.soccerState.ownerRole.A[child.Name].Value then
                    getImage(child, u1017.soccerState.ownerRole.A[child.Name].Value);
                end;

                v1018:Add(u1017.soccerState.ownerRole.A[child.Name].Changed:connect(function(p1024) -- Line: 8387
                    -- upvalues: getImage (copy), child (copy)
                    getImage(child, p1024);
                end));
                v1018:Add(child.Button.MouseButton1Up:connect(function() -- Line: 8391
                    -- upvalues: u1017 (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), wiki (ref), child (copy)
                    if u1017.human and u1017.human.Health <= 0 then
                        return;
                    end;

                    soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
                    packets.bytenet_selectRole.send({
                        t = "A",
                        index = table.find(wiki.teamroles, child.Name)
                    });
                    u1017:destroyContainer();
                end));
            end;
        end;
    end;

    for _, child in ipairs(u1019.Frame.B:GetChildren()) do
        if ReplicatedStorage.Ranked.Value and (u1017.player.Team and u1017.player.Team.Name ~= "B") then
            child.Visible = false;
        elseif child:IsA("Frame") then
            if u1017.soccerState.ownerRole.B[child.Name].Value then
                getImage(child, u1017.soccerState.ownerRole.B[child.Name].Value);
            end;

            v1018:Add(u1017.soccerState.ownerRole.B[child.Name].Changed:connect(function(p1025) -- Line: 8416
                -- upvalues: getImage (copy), child (copy)
                getImage(child, p1025);
            end));
            v1018:Add(child.Button.MouseButton1Up:connect(function() -- Line: 8420
                -- upvalues: u1017 (copy), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), wiki (ref), child (copy)
                if u1017.human and u1017.human.Health <= 0 then
                    return;
                end;

                soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
                packets.bytenet_selectRole.send({
                    t = "B",
                    index = table.find(wiki.teamroles, child.Name)
                });
                u1017:destroyContainer();
            end));
        end;
    end;

    soundUtil:play(ReplicatedStorage2.Resources.year, SoundService);
end;

function u3.Emote(u1026) -- Line: 8439
    -- upvalues: soundUtil (copy), ReplicatedStorage2 (copy), SoundService (copy), emoteWiki (copy), animationUtil (copy), Players (copy), u2 (ref), replication (copy), packets (copy), wiki (copy), MarketplaceService (copy), HttpService (copy)
    local v1027 = u1026:createContainer();

    if not v1027 then
        return;
    end;

    soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);

    if u1026.commsWasOpen then
        u1026:Comms();

        return;
    end;

    local u1028 = script.Emotes:Clone();
    u1028.Parent = u1026.playerGui;
    local Next = u1028.ImageLabel.Next;
    local Previous = u1028.ImageLabel.Previous;
    local u1029 = {};

    local function openUI(p1030) -- Line: 8458
        -- upvalues: u1026 (copy), u1028 (copy), emoteWiki (ref), animationUtil (ref), u1029 (copy), Players (ref), u2 (ref), replication (ref), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref)
        if not u1026.currentOpenEmoteUIPage:FindFirstChild(p1030) then
            return;
        end;

        local Value = u1026.currentOpenEmoteUIPage[p1030].Value;
        local v1031 = u1028:WaitForChild("ImageLabel")[p1030];
        local v1032 = emoteWiki[Value];

        if not v1032 then
            return;
        end;

        local Button = v1031.Button;
        v1031.Visible = true;
        v1031.EmoteName.Text = v1032.name or Value;
        local v1033 = v1032.animation or v1032.equipanimation;

        if v1033 then
            local v1034 = animationUtil:loadAnimation(v1031.ViewportFrame.WorldModel.Preview, v1033);
            v1034.Looped = true;
            v1034:Play(0);
        end;

        if u1029[`triggerEmote{p1030}`] then
            u1029[`triggerEmote{p1030}`]:Disconnect();
        end;

        u1029[`triggerEmote{p1030}`] = Button.MouseButton1Click:Connect(function() -- Line: 8483
            -- upvalues: Players (ref), u2 (ref), replication (ref), u1026 (ref), soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), packets (ref), Value (copy)
            if Players.LocalPlayer.UserId ~= 1549164509 and tick() - u2 < 2 then
                replication.notification("Please wait a few seconds and try again!");

                return;
            end;

            u2 = tick();
            u1026:destroyContainer();
            soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
            packets.bytenet_useEmote.send({
                emoteName = Value
            });
        end);
    end;

    local function u1036() -- Line: 8499
        -- upvalues: u1026 (copy), Previous (copy), Next (copy), wiki (ref), openUI (copy)
        local v1035;

        if u1026.currentEmotePage == 1 then
            v1035 = u1026.emote;
        else
            v1035 = u1026.emote.extraPages[u1026.currentEmotePage - 1];
        end;

        u1026.currentOpenEmoteUIPage = v1035;
        Previous.Visible = u1026.currentEmotePage > 1;
        Next.Visible = u1026.currentEmotePage < wiki.maxEmotePages;
        task.spawn(function() -- Line: 8507
            -- upvalues: u1026 (ref), openUI (ref)
            for i = 1, 8 do
                if i > 4 and not u1026:hasPass(1168206289) then
                    break;
                end;

                openUI(i);
                local _ = i;
            end;
        end);
    end;

    local function u1039(p1037: string) -- Line: 8518
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u1026 (copy), replication (ref), wiki (ref), MarketplaceService (ref), u1036 (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);

        if u1026.emotePageDebounce then
            replication.notification("Try page switching again in a second", nil, ReplicatedStorage2.Resources.notisound);

            return;
        end;

        u1026.emotePageDebounce = true;
        task.delay(0.1, function() -- Line: 8528
            -- upvalues: u1026 (ref)
            u1026.emotePageDebounce = nil;
        end);
        local table_find_ret = table.find({ "Next", "Previous" }, p1037);
        assert(table_find_ret, "direction must be \'Next\' or \'Previous\'");

        if not u1026:hasPass(wiki.gamepassId.extraPages) then
            MarketplaceService:PromptGamePassPurchase(u1026.player, wiki.gamepassId.extraPages);

            return;
        end;

        local v1038 = u1026.currentEmotePage + (p1037 == "Next" and 1 or -1);

        if wiki.maxEmotePages < v1038 then
            replication.notification("There is no next page", Color3.fromRGB(255, 100, 100), ReplicatedStorage2.Resources.notisound);

            return;
        end;

        if v1038 < 1 then
            replication.notification("There is no previous page", Color3.fromRGB(255, 100, 100), ReplicatedStorage2.Resources.notisound);

            return;
        end;

        u1026.currentEmotePage = v1038;
        u1036();
    end;

    v1027:Connect(Next.Button.MouseButton1Click, function() -- Line: 8551
        -- upvalues: u1039 (copy)
        u1039("Next");
    end);
    v1027:Connect(Previous.Button.MouseButton1Click, function() -- Line: 8555
        -- upvalues: u1039 (copy)
        u1039("Previous");
    end);
    v1027:Connect(u1028.ImageLabel.Comms.Button.MouseButton1Click, function() -- Line: 8559
        -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref), u1026 (copy)
        soundUtil:play(ReplicatedStorage2.Resources.click, SoundService);
        u1026:Comms();
    end);
    u1028.ImageLabel.Comms.Visible = u1026.soccerState.roundstart.Value and u1026.state and u1026.state.ingame.Value;
    local special_emote = u1026.player:FindFirstChild("special_emote");
    local v1040 = special_emote and {
        name = "[ SPECIAL ]",
        image = special_emote:GetAttribute("icon"),
        animated_data = special_emote:GetAttribute("animated_data")
    } or nil or wiki.special_emotes[u1026.player.UserId];

    if v1040 then
        local Special = u1028.ImageLabel.Special;
        Special.Visible = v1040 ~= nil;
        Special.EmoteName.Text = v1040.name or "";
        Special.ImageLabel.Image = `rbxassetid://{v1040.image}`;
        Special.ImageLabel.ImageRectSize = Vector2.zero;
        Special.ImageLabel.ImageRectOffset = Vector2.zero;
        local animated_data = v1040.animated_data;

        if type(animated_data) == "string" then
            local success, result = pcall(HttpService.JSONDecode, HttpService, animated_data);
            animated_data = success and result and result or nil;
        end;

        if type(animated_data) == "table" and (type(animated_data.FrameWidth) == "number" and type(animated_data.FrameHeight) == "number") then
            Special.ImageLabel.ImageRectSize = Vector2.new(animated_data.FrameWidth, animated_data.FrameHeight);
        end;

        v1027:Connect(Special.Button.MouseButton1Click, function() -- Line: 8599
            -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), packets (ref), u1026 (copy)
            soundUtil:play(ReplicatedStorage2.Resources.click, "default");
            packets.bytenet_useEmote.send({
                emoteName = "super_special_emote"
            });
            u1026:destroyContainer();
        end);
    end;

    openUI(1);
    openUI(2);
    openUI(3);
    openUI(4);
    task.spawn(function() -- Line: 8631
        -- upvalues: u1026 (copy), openUI (copy)
        if not u1026:hasPass(1168206289) then
            return;
        end;

        openUI(4);
        openUI(5);
        openUI(6);
        openUI(7);
        openUI(8);
    end);
    u1036();
    v1027:Add(u1028);
end;

function u3.ballHolder(u1041) -- Line: 8672
    -- upvalues: ReplicatedStorage2 (copy), CollectionService (copy), RunService (copy), ReplicatedStorage (copy), replication (copy), actionUtil (copy), vfxUtil (copy), wiki (copy), TweenService (copy)
    local u1042 = {};

    local function destroyassets() -- Line: 8676
        -- upvalues: u1042 (copy)
        for _, v in u1042 do
            if typeof(v) == "Instance" then
                v:Destroy();
            else
                v:Disconnect();
            end;
        end;

        table.clear(u1042);
    end;

    local function add(u1043) -- Line: 8687
        -- upvalues: destroyassets (copy), ReplicatedStorage2 (ref), u1042 (copy), CollectionService (ref), RunService (ref), ReplicatedStorage (ref), replication (ref), actionUtil (ref), u1041 (copy), vfxUtil (ref), wiki (ref), TweenService (ref)
        destroyassets();
        local u1044 = u1043.HumanoidRootPart or u1043.PrimaryPart;
        local u1045 = ReplicatedStorage2.Resources.Ball:Clone();
        u1045.Parent = u1043;

        if u1043:GetAttribute("style") == "akashi" then
            local ball = u1045.ball;
            ball.C0 = ball.C0 * CFrame.Angles(0, 3.141592653589793, 0);
        end;

        u1045.ball.Part0 = u1044;
        u1045.CanCollide = false;
        u1045.Attachment:Destroy();
        u1045.position:Destroy();
        table.insert(u1042, u1045);
        local u1046 = ReplicatedStorage2.Resources.VISUALRADAR0:Clone();
        u1046.Anchored = true;
        u1046.Parent = u1043;
        table.insert(u1042, u1046);
        local u1047 = nil;
        local u1048 = nil;
        local _ = CollectionService:GetTagged("MapFloor")[1];
        local u1049 = false;
        local v1055 = RunService.PreRender:Connect(function() -- Line: 8721
            -- upvalues: u1043 (copy), u1049 (ref), ReplicatedStorage2 (ref), u1046 (copy), u1044 (copy), u1048 (ref), ReplicatedStorage (ref), u1042 (ref), u1047 (ref), u1045 (copy)
            local v1050;

            if u1043 == nil then
                v1050 = false;
            else
                v1050 = u1043:GetAttribute("hide_radar") == true;
            end;

            if v1050 or u1049 then
                local v1051 = not v1050 and not ReplicatedStorage2.workspace.disabled.Value;

                for _, descendant in u1046:GetDescendants() do
                    if descendant:IsA("CylinderHandleAdornment") then
                        descendant.Visible = v1051;
                    end;
                end;

                u1049 = v1050;
            end;

            local v1052 = u1043 and u1043:GetAttribute("torso_radar") and true or false;
            local v1053;

            if u1043 and u1043:GetAttribute("InMarble") then
                v1053 = CFrame.identity;
            else
                v1053 = u1044.CFrame.Rotation;
            end;

            if v1052 then
                if u1043 and u1043:FindFirstChild("Torso") then
                    local Torso = u1043:FindFirstChild("Torso");
                    u1046.CFrame = v1053 + vector.create(Torso.Position.X, 3.1, Torso.Position.Z);
                else
                    u1046.CFrame = v1053 + vector.create(u1044.Position.X, 3.1, u1044.Position.Z);
                end;
            else
                u1046.CFrame = v1053 + vector.create(u1044.Position.X, 3.1, u1044.Position.Z);
            end;

            local Attribute = u1043:GetAttribute("ball_transparency");

            if u1043:GetAttribute("AlternateBallRig") then
                Attribute = 1;

                if not u1048 then
                    u1048 = ReplicatedStorage.Resources.AlternateBallRig:Clone();
                    u1048.Weld.Part0 = u1044;
                    local Weld = u1048.Weld;
                    local CFrame_Angles = CFrame.Angles;
                    local v1054 = tonumber(u1043:GetAttribute("AlternateBallRig")) or 0;
                    Weld.C1 = CFrame_Angles(0, math.rad(v1054), 0);
                    u1048.Parent = u1043;
                    table.insert(u1042, u1048);
                end;
            elseif u1048 then
                local table_find_ret = table.find(u1042, u1048);

                if table_find_ret then
                    table.remove(u1042, table_find_ret);
                end;

                u1048:Destroy();
                u1048 = nil;
            end;

            if Attribute ~= u1047 then
                u1047 = Attribute;
                u1045.Transparency = Attribute or 0;
            end;
        end);
        table.insert(u1042, v1055);
        replication.highlight(u1043, Color3.fromRGB(255, 255, 255), 0.3);
        local u1056 = actionUtil.checkGK(u1041.character) and not actionUtil.checkball(u1041.character);
        local u1057 = { u1046.Beam };
        local u1058 = nil;
        local Position = u1046.Beam.Attachment0.Position;
        local Position2 = u1046.Beam.Attachment1.Position;

        if u1056 then
            if vfxUtil.IsSettingOn(u1041.player, "GKColoredLine") then
                local v1059 = wiki.styles[actionUtil.checkStyle(u1043)];

                if v1059 and v1059.gkLineColor then
                    local Keypoints = v1059.gkLineColor.Keypoints;
                    local v1060 = u1046.Beam.Attachment0:Clone();
                    local v1061 = u1046.Beam.Attachment1:Clone();
                    local v1062 = u1046.Beam:Clone();
                    local v1063 = u1046.Beam.Width0 / 4;
                    v1060.Parent = u1046;
                    v1061.Parent = u1046;
                    print("custom line");
                    v1062.Attachment0 = v1060;
                    v1062.Attachment1 = v1061;
                    v1062.Parent = u1046;
                    u1046.Beam.Color = ColorSequence.new(Keypoints[1].Value);
                    v1062.Color = ColorSequence.new(Keypoints[#Keypoints].Value);
                    u1046.Beam.Attachment0.Position = Position - Vector3.new(1, 0, 0) * v1063;
                    u1046.Beam.Attachment1.Position = Position2 - Vector3.new(1, 0, 0) * v1063;
                    v1060.Position = Position + Vector3.new(1, 0, 0) * v1063;
                    v1061.Position = Position2 + Vector3.new(1, 0, 0) * v1063;
                    local Beam = u1046.Beam;
                    Beam.Width0 = Beam.Width0 / 2;
                    local Beam2 = u1046.Beam;
                    Beam2.Width1 = Beam2.Width1 / 2;
                    v1062.Width0 = u1046.Beam.Width0;
                    v1062.Width1 = u1046.Beam.Width1;
                    table.insert(u1057, v1062);
                    u1058 = {
                        u1046.Beam.Attachment0,
                        u1046.Beam.Attachment1,
                        v1060,
                        v1061
                    };
                elseif v1059 and v1059.color then
                    u1046.Beam.Color = ColorSequence.new(v1059.color);
                end;
            end;

            for _, v in u1057 do
                v.LightEmission = 0;
                v.Brightness = 1;
            end;
        else
            u1046.Beam.Enabled = false;
        end;

        if ReplicatedStorage2.workspace.disabled.Value then
            for _, descendant in ipairs(u1046:GetDescendants()) do
                if descendant:IsA("CylinderHandleAdornment") then
                    descendant.Visible = false;
                end;
            end;

            if u1056 then
                for _, v in u1057 do
                    v.Width0 = 0;
                    v.Width1 = 0;
                end;
            end;
        end;

        for _, descendant in ipairs(u1046:GetDescendants()) do
            if descendant:IsA("CylinderHandleAdornment") then
                local InnerRadius = descendant.InnerRadius;
                local Radius = descendant.Radius;
                descendant.InnerRadius = 0;
                descendant.Radius = 0;
                TweenService:Create(descendant, TweenInfo.new(Random.new():NextNumber(0.1, 1), Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    InnerRadius = InnerRadius,
                    Radius = Radius
                }):Play();
            end;
        end;

        local v1065 = ReplicatedStorage2.workspace.disabled.Changed:connect(function(p1064) -- Line: 8911
            -- upvalues: u1043 (copy), u1046 (copy), u1056 (copy), u1057 (copy), TweenService (ref), u1058 (ref), Position (copy), Position2 (copy)
            if p1064 then
                if u1043 and not u1043:GetAttribute("KeepRadar") then
                    for _, descendant in ipairs(u1046:GetDescendants()) do
                        if descendant:IsA("CylinderHandleAdornment") then
                            descendant.Visible = false;
                        end;
                    end;

                    if u1056 then
                        for _, v in u1057 do
                            TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                                Width0 = 0,
                                Width1 = 0
                            }):Play();
                        end;
                    end;
                end;
            else
                for _, descendant in ipairs(u1046:GetDescendants()) do
                    if descendant:IsA("CylinderHandleAdornment") then
                        descendant.Visible = true;
                    end;
                end;

                if u1056 then
                    if u1058 then
                        u1058[1].Position = Position - Vector3.new(0.075, 0, 0);
                        u1058[2].Position = Position2 - Vector3.new(0.075, 0, 0);
                        u1058[3].Position = Position + Vector3.new(0.075, 0, 0);
                        u1058[4].Position = Position2 + Vector3.new(0.075, 0, 0);
                    end;

                    for _, v in u1057 do
                        v.Width0 = 0.3 / #u1057;
                        v.Width1 = 0.3 / #u1057;
                    end;
                end;
            end;
        end);
        table.insert(u1042, v1065);
    end;

    if u1041.soccerState.ballHolder.Value ~= nil then
        add(u1041.soccerState.ballHolder.Value);
    end;

    u1041.soccerState.ballHolder:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 8971
        -- upvalues: u1041 (copy), destroyassets (copy), add (copy)
        local Value = u1041.soccerState.ballHolder.Value;

        if Value then
            add(Value);

            return;
        end;

        destroyassets();
    end);
end;

local u1066 = false;

function u3.fakeBall(u1067) -- Line: 8985
    -- upvalues: actionUtil (copy), ReplicatedStorage2 (copy), TweenService (copy), u1066 (ref), raycast (copy), RunService2 (copy), wiki (copy)
    local u1068 = {};

    for _, v in u1068 do
        v:Destroy();
    end;

    table.clear(u1068);

    local function FakeBall(u1069) -- Line: 8990
        -- upvalues: u1067 (copy), actionUtil (ref), ReplicatedStorage2 (ref), TweenService (ref), u1068 (copy), u1066 (ref), raycast (ref), RunService2 (ref), wiki (ref)
        if not u1069 then
            print("wh");

            return;
        end;

        if not u1069:WaitForChild("velocity", 1) then
            print("ball not created bc no velocity");

            return;
        end;

        if not u1069:IsDescendantOf(game) then
            warn("ball not created bc not exist");

            return;
        end;

        if u1067.fakeNeon then
            u1067.fakeNeon = nil;
        end;

        local _ = u1067.character and actionUtil.checkGK(u1067.character);
        local u1070 = nil;
        local _ = time() + 0.05;
        local u1071 = ReplicatedStorage2.Resources.Ball:Clone();
        u1071.Anchored = true;
        u1071.CFrame = u1069.Value;
        u1071.Parent = workspace.Terrain;
        u1071.position.BillboardGui.ImageLabel.ImageTransparency = 1;
        TweenService:Create(u1071.position.BillboardGui.ImageLabel, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            ImageTransparency = 0.8
        }):Play();
        table.insert(u1068, u1071);
        u1067:changeSpectate(u1071, true);
        u1067.fakeNeon = u1071;
        local Value = u1069.velocity.Value;
        local Position = u1069.Value.Position;
        tick();
        local speed = u1069:FindFirstChild("speed");
        local TimeScale = ReplicatedStorage2:FindFirstChild("TimeScale");
        local os_clock_ret = os.clock();
        local u1072 = u1069:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 9031
            -- upvalues: os_clock_ret (ref)
            os_clock_ret = os.clock();
        end);

        local function v1077(p1073) -- Line: 9035
            -- upvalues: u1069 (copy), speed (copy), os_clock_ret (ref), TimeScale (copy), u1071 (copy), Value (ref), Position (ref), u1066 (ref), raycast (ref), u1070 (ref), ReplicatedStorage2 (ref)
            if not u1069:IsDescendantOf(game) then
                return;
            end;

            if not u1069:FindFirstChild("velocity") then
                return;
            end;

            local v1074 = speed and speed.Value or 0;
            local v1075 = os.clock() - os_clock_ret;
            local math_min_ret = math.min(v1075, 0.035);

            if v1074 > 0 then
                math_min_ret = math_min_ret * (TimeScale and TimeScale.Value or 1) / v1074;
            end;

            u1071.CFrame = u1071.CFrame:Lerp(u1069.Value + u1069.velocity.Value * math_min_ret, 1 - math.exp(-52 * p1073));
            Value = u1069.velocity.Value;
            Position = u1069.Value.Position;
            u1071:SetAttribute("velocity", Value);
            u1071:SetAttribute("position", Position);

            if Value.Magnitude > 300 then
                if not u1066 then
                    u1066 = true;
                    local Sound = Instance.new("Sound");
                    Sound.SoundId = "rbxassetid://110763917843304";
                    Sound.Volume = 0.5;
                    Sound.PlaybackSpeed = math.random(100, 110) / 100;
                    Sound.Parent = u1071;
                    Sound:Play();
                    game:GetService("Debris"):AddItem(Sound, 5);
                end;
            else
                u1066 = false;
            end;

            if u1069 and (u1069:FindFirstChild("highlight") and (u1069.highlight.Value and u1071:FindFirstChild("Highlight"))) then
                u1071.Highlight.Enabled = true;
            end;

            if not workspace:FindFirstChild("map") then
                return;
            end;

            local v1076 = raycast(u1069.Value.Position, Vector3.new(-0, -1000, -0), nil, { workspace.map.map.sanam.main });

            if v1076 then
                if not u1070 then
                    u1070 = ReplicatedStorage2.Resources.ballshadow:Clone();
                    u1070.Parent = u1071;
                    u1070.CFrame = CFrame.new(v1076.Position) * CFrame.Angles(0, 0, 1.5707963267948966);
                end;

                local Magnitude = (v1076.Position - u1069.Value.Position).Magnitude;
                u1070.CFrame = u1070.CFrame:Lerp(CFrame.new(v1076.Position) * CFrame.Angles(0, 0, 1.5707963267948966), 1 - math.exp(-24 * p1073));
                local math_clamp_ret = math.clamp(Magnitude, 0, 100);
                u1070.Size = Vector3.new(0.01, math_clamp_ret, math_clamp_ret);
            end;
        end;

        local u1078 = RunService2.PreRender:Connect(v1077);
        v1077(0.01);
        local u1079 = nil;
        u1079 = u1069.AncestryChanged:Once(function() -- Line: 9095
            -- upvalues: u1078 (ref), u1079 (ref), u1072 (copy), u1071 (copy), u1067 (ref), wiki (ref)
            if u1078 then
                u1078:Disconnect();
            end;

            if u1079 then
                u1079:Disconnect();
            end;

            u1072:Disconnect();

            if u1071 then
                u1071:Destroy();
            end;

            if u1067.fakeNeon then
                u1067.fakeNeon = nil;
            end;

            if wiki.isTestGame() then
                print("old ball destroyed");
            end;
        end);
    end;

    if ReplicatedStorage2:FindFirstChild("CFBall") then
        task.spawn(FakeBall, ReplicatedStorage2:FindFirstChild("CFBall"));
    end;

    ReplicatedStorage2.ChildAdded:Connect(function(p1080) -- Line: 9114
        -- upvalues: FakeBall (copy)
        if p1080.Name == "CFBall" and p1080:IsA("CFrameValue") then
            FakeBall(p1080);
        end;
    end);
end;

function u3.movement(u1081) -- Line: 9121
    -- upvalues: actionUtil (copy)
    game.Players:GetPlayerFromCharacter(u1081.character);

    local function create() -- Line: 9123
        -- upvalues: actionUtil (ref), u1081 (copy)
        local _walkjump, v1082 = actionUtil.get_walkjump(u1081.character);
        u1081.human.WalkSpeed = _walkjump;
        u1081.human.JumpPower = v1082;
    end;

    u1081.human.Running:connect(create);
    u1081.human:GetPropertyChangedSignal("MoveDirection"):connect(create);
    u1081.movementFolder.ChildAdded:connect(function(p1083: userdata) -- Line: 9133
        -- upvalues: create (copy), actionUtil (ref), u1081 (copy)
        p1083.AttributeChanged:Connect(create);
        local _walkjump, v1084 = actionUtil.get_walkjump(u1081.character);
        u1081.human.WalkSpeed = _walkjump;
        u1081.human.JumpPower = v1084;
    end);
    u1081.movementFolder.ChildRemoved:connect(create);
    u1081.character:GetAttributeChangedSignal("frozen"):Connect(create);
    u1081.player:GetAttributeChangedSignal("BeingControlledBy"):Connect(create);
end;

function u3.refreshMovement(p1085) -- Line: 9142
    -- upvalues: actionUtil (copy)
    if not (p1085.character and p1085.human) then
        return;
    end;

    local _walkjump, v1086 = actionUtil.get_walkjump(p1085.character);
    p1085.human.WalkSpeed = _walkjump;
    p1085.human.JumpPower = v1086;
end;

function u3.setControlsEnabled(u1087: table, p1088: boolean) -- Line: 9152
    local success, result = pcall(function() -- Line: 9153
        -- upvalues: u1087 (copy)
        return u1087.playerModule:GetControls();
    end);

    if not (success and result) then
        return;
    end;

    if p1088 then
        result:Enable();

        return;
    end;

    result:Disable();
end;

local function fixMindControlMoveName(p1089: string?, p1090: userdata) -- Line: 9168
    return not p1089 and "" or p1089:gsub("{username}", p1090.Name):gsub("{displayname}", p1090.DisplayName);
end;

function u3.applyMindControlPuppet(u1091: table, p1092: userdata) -- Line: 9176
    local Character = p1092.Character;

    if not Character then
        return false;
    end;

    local v1093 = Character:FindFirstChildOfClass("Humanoid");
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local movements = Character:FindFirstChild("movements");
    local state = Character:FindFirstChild("state");

    if not (v1093 and (HumanoidRootPart and (movements and state))) then
        return false;
    end;

    if u1091.mindControlSnapshot then
        u1091:clearMindControlPuppet();
    end;

    local style = state:FindFirstChild("style");
    local v1094;

    if style and style:IsA("StringValue") then
        v1094 = style.Value;
    else
        v1094 = u1091.style;
    end;

    u1091.mindControlSnapshot = {
        character = u1091.character,
        human = u1091.human,
        humanoidRootPart = u1091.humanoidRootPart,
        movementFolder = u1091.movementFolder,
        state = u1091.state,
        style = u1091.style,
        baseClient = {
            player = u1091.baseClient.player,
            character = u1091.baseClient.character,
            human = u1091.baseClient.human,
            humanoidRootPart = u1091.baseClient.humanoidRootPart,
            movementFolder = u1091.baseClient.movementFolder,
            style = u1091.baseClient.style
        }
    };
    u1091.character = Character;
    u1091.human = v1093;
    u1091.humanoidRootPart = HumanoidRootPart;
    u1091.movementFolder = movements;
    u1091.state = state;
    u1091.style = v1094;
    u1091.baseClient.player = p1092;
    u1091.baseClient.character = Character;
    u1091.baseClient.human = v1093;
    u1091.baseClient.humanoidRootPart = HumanoidRootPart;
    u1091.baseClient.movementFolder = movements;
    u1091.baseClient.style = v1094;

    if u1091.lobbyui and u1091.lobbyui.Parent then
        u1091.lobbyui.Enabled = false;
    end;

    if u1091.playerGui:FindFirstChild("Hotbar") then
        u1091:rebuildMindControlHotbar();
    else
        u1091.mindControlCreatedHotbar = true;
        local success, result = pcall(function() -- Line: 9234
            -- upvalues: u1091 (copy)
            u1091:InGame();
        end);

        if not success then
            warn("mind control failed to build in-game UI:", result);
        end;
    end;

    return true;
end;

function u3.clearMindControlPuppet(p1095) -- Line: 9247
    if p1095.mindControlUiTrove then
        p1095.mindControlUiTrove:Destroy();
        p1095.mindControlUiTrove = nil;
    end;

    local mindControlSnapshot = p1095.mindControlSnapshot;

    if not mindControlSnapshot then
        return;
    end;

    p1095.character = mindControlSnapshot.character;
    p1095.human = mindControlSnapshot.human;
    p1095.humanoidRootPart = mindControlSnapshot.humanoidRootPart;
    p1095.movementFolder = mindControlSnapshot.movementFolder;
    p1095.state = mindControlSnapshot.state;
    p1095.style = mindControlSnapshot.style;

    for i, v in mindControlSnapshot.baseClient do
        p1095.baseClient[i] = v;
    end;

    p1095.mindControlSnapshot = nil;

    if p1095.mindControlCreatedHotbar then
        local Hotbar = p1095.playerGui:FindFirstChild("Hotbar");

        if Hotbar then
            Hotbar:Destroy();
        end;

        p1095.mindControlCreatedHotbar = nil;
    else
        p1095:rebuildMindControlHotbar();
    end;

    if p1095.lobbyui and p1095.lobbyui.Parent then
        p1095.lobbyui.Enabled = true;
    end;

    p1095:refreshMovement();
end;

function u3.rebuildMindControlHotbar(u1096) -- Line: 9288
    -- upvalues: wiki (copy), GamepadContainer (copy), UserInputService (copy), actionUtil (copy), replication (copy), trove (copy)
    local Hotbar = u1096.playerGui:FindFirstChild("Hotbar");

    if not Hotbar then
        return;
    end;

    local Backpack = Hotbar:FindFirstChild("Backpack");

    if Backpack then
        Backpack = Backpack:FindFirstChild("Hotbar");
    end;

    if not Backpack then
        return;
    end;

    for _, child in Backpack:GetChildren() do
        if child:IsA("GuiObject") then
            child:Destroy();
        end;
    end;

    local v1097 = wiki.styles[u1096.style];

    if not v1097 then
        return;
    end;

    local u1098 = u1096.mindControlSnapshot and u1096.baseClient.player or u1096.player;
    local u1099 = Hotbar:FindFirstChild("Base") or script:FindFirstChild("Base");

    if not u1099 then
        return;
    end;

    local u1100 = {
        One = 1,
        Two = 2,
        Three = 3,
        Four = 4,
        Five = 5,
        Six = 6,
        Seven = 7,
        Eight = 8,
        Nine = 9,
        Zero = 0
    };

    local function u1104(p1101) -- Line: 9331
        -- upvalues: u1096 (copy), GamepadContainer (ref), UserInputService (ref), u1100 (copy)
        if typeof(p1101) ~= "number" then
            return "";
        end;

        local v1102 = u1096.isGamepad and UserInputService:GetStringForKeyCode(GamepadContainer[p1101].KeyCode):gsub("^Button", "") or (u1096.isTouchEnabled and p1101 and p1101 or u1096.setting.customKeybinds[`skill{p1101}`].Value);
        local v1103 = u1100[tostring(v1102)] or v1102;

        return tostring(v1103);
    end;

    local function _(p1105, p1106) -- Line: 9342
        -- upvalues: u1098 (copy)
        local v1107;

        if type(p1106) == "table" then
            v1107 = p1106[1];
            local v1108 = p1106[2];

            if v1108 then
                p1105.Base.Reuse.Visible = true;
                p1105.Base.Reuse.Text = v1108;
            end;
        else
            p1105.Base.Reuse.Visible = false;
            v1107 = p1106;
        end;

        local v1109 = u1098;
        p1105.Base.ToolName.Text = not v1107 and "" or v1107:gsub("{username}", v1109.Name):gsub("{displayname}", v1109.DisplayName);
        p1105.Visible = true;
    end;

    local function v1118(p1110, p1111, p1112) -- Line: 9359
        -- upvalues: u1099 (copy), u1104 (copy), u1098 (copy), Backpack (copy), u1096 (copy)
        local u1113 = u1099:Clone();
        u1113.Name = p1110;
        local v1114 = u1104(p1111);
        local Number = u1113.Base.Number;
        Number.Text = v1114;
        Number.TextSize = Number.TextSize * (#v1114 == 1 and 1.25 or 1);
        u1113.LayoutOrder = p1111 or 67;
        local v1115;

        if type(p1112) == "table" then
            v1115 = p1112[1];
            local v1116 = p1112[2];

            if v1116 then
                u1113.Base.Reuse.Visible = true;
                u1113.Base.Reuse.Text = v1116;
            end;
        else
            u1113.Base.Reuse.Visible = false;
            v1115 = p1112;
        end;

        local v1117 = u1098;
        u1113.Base.ToolName.Text = not v1115 and "" or v1115:gsub("{username}", v1117.Name):gsub("{displayname}", v1117.DisplayName);
        u1113.Visible = true;

        if p1110 == "Tspecialer" then
            u1113.Size = UDim2.new(0, 50, 0, 50);
        end;

        u1113.Parent = Backpack;
        u1113.Base.MouseButton1Click:connect(function() -- Line: 9374
            -- upvalues: u1113 (copy), u1096 (ref)
            if not shared.AwaitingUnholdForMobile[u1113.Name] then
                u1096.baseClient:use(u1113.Name);

                return;
            end;

            shared.AwaitingUnholdForMobile[u1113.Name] = nil;
            u1096.baseClient:senduse({ u1113.Name, false });
        end);
    end;

    for i, v in ipairs(v1097.movesets or {}) do
        v1118(`skill{i}`, i, v);
    end;

    if v1097.TSpecial and not actionUtil.checkGK(u1096.character) then
        v1118("Tspecialer", nil, v1097.TSpecial);
    end;

    if Hotbar:FindFirstChild("MagicHealth") then
        if v1097.AwakeningName then
            Hotbar.MagicHealth.TextLabel.Visible = true;
            Hotbar.MagicHealth.TextLabel.Text = v1097.AwakeningName;
        end;

        if v1097.modeInfo then
            Hotbar.MagicHealth.saeText.Visible = true;
            Hotbar.MagicHealth.saeText.UIGradient.Color = v1097.modeInfo.color;
            Hotbar.MagicHealth.saeText.Text = v1097.modeInfo.text;
        else
            Hotbar.MagicHealth.saeText.Visible = false;
        end;

        local RolandArsenalMarks = Hotbar.MagicHealth:FindFirstChild("RolandArsenalMarks");

        if RolandArsenalMarks then
            RolandArsenalMarks.Visible = u1096.style == "roland";
        end;

        if u1096.state and u1096.state:FindFirstChild("mode") then
            Hotbar.MagicHealth.ModeText.Text = `MODE : {string.upper(u1096.state.mode.Value)}`;
        end;
    end;

    replication.applyPendingMoveset();

    if u1096.mindControlSnapshot and u1096.state then
        if u1096.mindControlUiTrove then
            u1096.mindControlUiTrove:Destroy();
        end;

        u1096.mindControlUiTrove = trove.new();
        local flow = u1096.state:FindFirstChild("flow");

        if flow then
            local function updateFlow(p1119: number) -- Line: 9427
                -- upvalues: u1096 (copy)
                local Hotbar2 = u1096.playerGui:FindFirstChild("Hotbar");

                if not (Hotbar2 and Hotbar2:FindFirstChild("MagicHealth")) then
                    return;
                end;

                Hotbar2.MagicHealth.Health.Frame.Size = UDim2.new(p1119 / 100, 0, 1, 0);
                Hotbar2.MagicHealth.Health.flowCharge.Text = `{math.floor(p1119)}%`;
            end;

            u1096.mindControlUiTrove:Connect(flow.Changed, updateFlow);
            updateFlow(flow.Value);
        end;

        local mode = u1096.state:FindFirstChild("mode");

        if mode then
            u1096.mindControlUiTrove:Connect(mode.Changed, function(p1120) -- Line: 9443
                -- upvalues: u1096 (copy)
                local Hotbar2 = u1096.playerGui:FindFirstChild("Hotbar");

                if Hotbar2 and Hotbar2:FindFirstChild("MagicHealth") then
                    Hotbar2.MagicHealth.ModeText.Text = `MODE : {string.upper(p1120)}`;
                end;
            end);
        end;
    end;
end;

function u3.ButtonFunction(u1121) -- Line: 9453
    -- upvalues: u20 (copy), actionUtil (copy)
    return {
        DashButton = function() -- Line: 9456, Name: DashButton
            -- upvalues: u20 (ref), u1121 (copy)
            u20.Default.Start(u1121, "dash");
        end,

        VolleyButton = function() -- Line: 9460, Name: VolleyButton
            -- upvalues: u20 (ref), u1121 (copy)
            u20.Default.Start(u1121, "Volley");
        end,

        KickButton = function() -- Line: 9464, Name: KickButton
            -- upvalues: u1121 (copy)
            while u1121.inputs.KickButton and not game:GetService("GuiService").MenuIsOpen do
                u1121.baseClient:use("kick");
                task.wait(0.008333333333333333);
            end;
        end,

        BallButton = function() -- Line: 9471, Name: BallButton
            -- upvalues: u20 (ref), u1121 (copy)
            u20.Default.Start(u1121, "givmeBall");
        end,

        SuperRunButton = function() -- Line: 9475, Name: SuperRunButton
            -- upvalues: u20 (ref), u1121 (copy)
            u20.Default.Start(u1121, "superDash");
        end,

        ShiftlockButton = function() -- Line: 9479, Name: ShiftlockButton
            -- upvalues: u1121 (copy)
            u1121.playerModule:GetCameras().activeMouseLockController:ToggleShiftLock(not u1121.playerModule:GetCameras().activeMouseLockController.isMouseLocked);

            if u1121.mobileButtons then
                u1121.mobileButtons.Crosshair.Visible = u1121.playerModule:GetCameras().activeMouseLockController.isMouseLocked;
            end;
        end,

        ThrowButton = function() -- Line: 9486, Name: ThrowButton
            -- upvalues: u20 (ref), u1121 (copy)
            u20.throwGoal.Start(u1121);
        end,

        DribbleButton = function() -- Line: 9490, Name: DribbleButton
            -- upvalues: actionUtil (ref), u1121 (copy), u20 (ref)
            if actionUtil.checkball(u1121.character) then
                u1121.baseClient:use("drib");

                return;
            end;

            u20.Default.Start(u1121, "modetoggle");
        end,

        EmoteButton = function() -- Line: 9498, Name: EmoteButton
            -- upvalues: u1121 (copy)
            u1121:Emote();
        end
    }, {
        ThrowButton = function() -- Line: 9502, Name: ThrowButton
            -- upvalues: u20 (ref), u1121 (copy)
            u20.throwGoal.End(u1121);
        end
    };
end;

function u3.Controller(u1122) -- Line: 9512
    -- upvalues: UserInputService (copy), u20 (copy), RunService (copy), workspace_CurrentCamera (copy), TweenService (copy), GuiService (copy), u11 (copy), u12 (copy), GamepadContainer (copy), actionUtil (copy), replication (copy)
    UserInputService.WindowFocusReleased:Connect(function() -- Line: 9513
        -- upvalues: u20 (ref), u1122 (copy)
        u20.throwGoal.End(u1122);
    end);

    if u1122.isTouchEnabled then
        local v1123 = script.Mobile:Clone();
        v1123.Parent = u1122.playerGui;
        u1122.mobileButtons = v1123;
        RunService.RenderStepped:Wait();
        local ViewportSize = workspace_CurrentCamera.ViewportSize;
        local v1124 = math.min(ViewportSize.X, ViewportSize.Y) <= 500;
        local v1125 = v1124 and 70 or 120;
        local v1126 = {
            SuperRunButton = UDim2.new(1, -(v1125 * 2.6 - 10), 1, -v1125 * 3.95),
            BallButton = UDim2.new(1, -(v1125 * 2.6 - 10), 1, -v1125 * 5.05),
            KickButton = UDim2.new(1, -(v1125 * 1.5 - 10), 1, -v1125 * 3.95),
            DashButton = UDim2.new(1, -(v1125 * 1.5 - 10), 1, -v1125 * 2.85),
            DribbleButton = UDim2.new(1, -(v1125 * 1.5 - 10), 1, -v1125 * 5.05),
            VolleyButton = UDim2.new(1, -(v1125 * 3.7 - 10), 1, -v1125 * 5.6),
            ShiftlockButton = UDim2.new(1, -(v1125 * 1.5 - 10), 1, -v1125 * 6.15),
            EmoteButton = UDim2.new(1, -(v1125 * 2.6 - 10), 1, -v1125 * 6.15),
            ThrowButton = UDim2.new(1, -(v1125 * 2.6 - 10), 1, -v1125 * 2.85)
        };
        local v1127 = {
            SuperRunButton = UDim2.new(1, -175, 1, -240),
            BallButton = UDim2.new(1, -175, 1, -315),
            VolleyButton = UDim2.new(1, -240, 1, -360),
            KickButton = UDim2.new(1, -95, 1, -240),
            DashButton = UDim2.new(1, -95, 1, -165),
            DribbleButton = UDim2.new(1, -95, 1, -315),
            ShiftlockButton = UDim2.new(1, -95, 1, -390),
            EmoteButton = UDim2.new(1, -175, 1, -390),
            ThrowButton = UDim2.new(1, -175, 1, -165)
        };
        local v1128 = v1124 and v1127 and v1127 or v1126;

        for i, v in v1128 do
            local v1129 = v1123.Frame:FindFirstChild(i);

            if v1129 then
                v1129.Position = v;
                v1129.Size = UDim2.fromOffset(v1125, v1125);
            end;
        end;

        u1122.isSmallScreen = v1124;
        u1122.originalPosition = v1126;
        u1122.originalSmallPosition = v1127;
        local u1130, u1131 = u1122:ButtonFunction();

        for _, child in ipairs(v1123.Frame:GetChildren()) do
            child.Size = UDim2.fromOffset(v1125, v1125);

            if u1122.setting.mobilebuttonPositions:FindFirstChild(child.Name) then
                child.Position = u1122.setting.mobilebuttonPositions[child.Name].Position;
                local Attribute = u1122.setting.mobilebuttonPositions[child.Name]:GetAttribute("Size");
                local Attribute2 = u1122.setting.mobilebuttonPositions[child.Name]:GetAttribute("Transparency");

                if Attribute then
                    child.Size = UDim2.fromOffset(v1125 * Attribute, v1125 * Attribute);
                    child:SetAttribute("Size", Attribute);
                end;

                if Attribute2 then
                    child.ImageTransparency = Attribute2;
                    child:SetAttribute("Transparency", Attribute2);
                end;
            else
                child.Position = v1128[child.Name];
            end;

            local u1132 = nil;
            child.InputBegan:Connect(function(p1133) -- Line: 9611
                -- upvalues: u1132 (ref), u1131 (copy), child (copy), TweenService (ref), u1122 (copy), u1130 (copy)
                if p1133.UserInputState ~= Enum.UserInputState.Begin then
                    return;
                end;

                if p1133.UserInputType ~= Enum.UserInputType.Touch then
                    return;
                end;

                if u1132 and u1131[child.Name] then
                    return;
                end;

                u1132 = p1133;
                TweenService:Create(child, TweenInfo.new(0.2), {
                    ImageColor3 = Color3.fromRGB(84, 84, 84)
                }):Play();
                u1122.inputs[child.Name] = true;

                if u1130[child.Name] then
                    task.spawn(u1130[child.Name]);
                end;
            end);
            child.InputEnded:Connect(function(p1134) -- Line: 9631
                -- upvalues: u1132 (ref), TweenService (ref), child (copy), u1122 (copy), u1131 (copy)
                if u1132 and (p1134 == u1132 and p1134.UserInputType == Enum.UserInputType.Touch) then
                    u1132 = nil;
                    TweenService:Create(child, TweenInfo.new(0.2), {
                        ImageColor3 = Color3.fromRGB(255, 255, 255)
                    }):Play();
                    u1122.inputs[child.Name] = nil;

                    if u1131[child.Name] then
                        task.spawn(u1131[child.Name]);
                    end;
                end;
            end);
        end;

        if not (u1122.isKeyboard or u1122.isGamepad) then
            return;
        end;
    end;

    UserInputService.InputBegan:connect(function(p1135: userdata, p1136: any) -- Line: 9654
        -- upvalues: UserInputService (ref), GuiService (ref), u1122 (copy), u11 (ref), u12 (ref), u20 (ref), GamepadContainer (ref), actionUtil (ref), replication (ref)
        if p1136 then
            return;
        end;

        if UserInputService:GetFocusedTextBox() then
            return;
        end;

        if GuiService.MenuIsOpen then
            return;
        end;

        for _, child in u1122.setting.customKeybinds:GetChildren() do
            if u11[child.Value] ~= nil or u12[child.Value] ~= nil then
                local v1137 = u11[child.Value] ~= nil and Enum.KeyCode[child.Value] or u12[child.Value] and Enum.UserInputType[child.Value];

                if p1135.KeyCode == v1137 or p1135.UserInputType == v1137 then
                    if u20[child.Name] ~= nil and u20[child.Name].Start ~= nil then
                        u20[child.Name].Start(u1122);

                        return;
                    end;

                    u20.Default.Start(u1122, child.Name);
                end;
            end;
        end;

        if p1135.KeyCode == GamepadContainer[6].KeyCode then
            u20.kick.Start(u1122);

            return;
        end;

        if p1135.KeyCode == GamepadContainer[7].KeyCode then
            u20.Default.Start(u1122, "dash");

            return;
        end;

        if p1135.KeyCode == GamepadContainer[8].KeyCode then
            if actionUtil.checkball(u1122.character) then
                u1122.baseClient:use("drib");

                return;
            end;

            u20.Default.Start(u1122, "modetoggle");

            return;
        end;

        if p1135.KeyCode ~= GamepadContainer[9].KeyCode then
            if p1135.KeyCode == GamepadContainer[12].KeyCode then
                if not (u1122.playerModule:GetCameras().activeMouseLockController.isMouseLocked and (u1122.baseClient.kickactived and not actionUtil.checkball(u1122.character))) then
                    u20.Default.Start(u1122, "superDash");

                    return;
                end;
            else
                if p1135.KeyCode == GamepadContainer[1].KeyCode then
                    u20.Default.Start(u1122, "skill1");

                    return;
                end;

                if p1135.KeyCode == GamepadContainer[2].KeyCode then
                    u20.Default.Start(u1122, "skill2");

                    return;
                end;

                if p1135.KeyCode == GamepadContainer[3].KeyCode then
                    u20.Default.Start(u1122, "skill3");

                    return;
                end;

                if p1135.KeyCode == GamepadContainer[4].KeyCode then
                    u20.Default.Start(u1122, "skill4");

                    return;
                end;

                if p1135.KeyCode == GamepadContainer[5].KeyCode then
                    u20.Default.Start(u1122, "skill5");

                    return;
                end;

                if p1135.KeyCode == GamepadContainer[10].KeyCode then
                    u20.Default.Start(u1122, "baseAwaken");

                    return;
                end;

                if p1135.KeyCode == GamepadContainer[11].KeyCode and u1122.isGamepad then
                    u1122.holdStartTime = tick();
                end;
            end;

            return;
        end;

        if replication.isHoldSpecial() then
            u20.throwGoal.Start(u1122);

            return;
        end;

        local KeyCode = GamepadContainer[9].KeyCode;
        local v1138 = tick();
        local v1139;

        while true do
            v1139 = tick() - v1138 > 0.2;

            if not v1139 then
                if not UserInputService:IsGamepadButtonDown(p1135.UserInputType, KeyCode) then
                    break;
                end;

                task.wait();
            end;

            if v1139 then
                break;
            end;
        end;

        if v1139 then
            u20.Default.Start(u1122, "givmeBall");

            return;
        end;

        u20.throwGoal.Start(u1122);
    end);
    UserInputService.InputEnded:connect(function(p1140: userdata) -- Line: 9781
        -- upvalues: u1122 (copy), u11 (ref), u12 (ref), u20 (ref), GamepadContainer (ref), UserInputService (ref)
        for _, child in u1122.setting.customKeybinds:GetChildren() do
            if u11[child.Value] ~= nil or u12[child.Value] ~= nil then
                local v1141 = u11[child.Value] ~= nil and Enum.KeyCode[child.Value] or u12[child.Value] and Enum.UserInputType[child.Value];

                if not (p1140.KeyCode ~= v1141 and p1140.UserInputType ~= v1141 or (u20[child.Name] == nil or u20[child.Name].End == nil)) then
                    u20[child.Name].End(u1122);

                    return;
                end;
            end;
        end;

        if p1140.KeyCode == GamepadContainer[6].KeyCode then
            u20.kick.End(u1122);

            return;
        end;

        if p1140.KeyCode == GamepadContainer[9].KeyCode then
            u20.throwGoal.End(u1122);

            return;
        end;

        if p1140.KeyCode == GamepadContainer[11].KeyCode and u1122.isGamepad then
            if tick() - u1122.holdStartTime >= 0.5 then
                u20.Emote.Start(u1122);

                return;
            end;

            u1122.playerModule:GetCameras().activeMouseLockController:ToggleShiftLock(not u1122.playerModule:GetCameras().activeMouseLockController.isMouseLocked);

            if u1122.playerGui:FindFirstChild("Crosshair") then
                u1122.playerGui:FindFirstChild("Crosshair").Enabled = u1122.playerModule:GetCameras().activeMouseLockController.isMouseLocked;
            else
                local v1142 = script.Crosshair:Clone();
                v1142.Parent = u1122.playerGui;
                v1142.Enabled = u1122.playerModule:GetCameras().activeMouseLockController.isMouseLocked;
            end;

            UserInputService.MouseIconEnabled = not u1122.playerModule:GetCameras().activeMouseLockController.isMouseLocked;
        end;
    end);
end;

return u3;