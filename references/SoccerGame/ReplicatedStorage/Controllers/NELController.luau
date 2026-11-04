  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local KnitClient = require(ReplicatedStorage.Packages.Knit.KnitClient);
local SalaryConfig = require(ReplicatedStorage.Shared.Configs.SalaryConfig);
local NELConfig = require(ReplicatedStorage.Shared.Configs.NELConfig);
local Popup = require(ReplicatedStorage.Shared.Popup);
local u1 = nil;
pcall(function() -- Line: 9
    -- upvalues: u1 (ref), ReplicatedStorage (copy)
    u1 = require(ReplicatedStorage.Shared.TopbarPlus.Icon);
end);
local RunService = game:GetService("RunService");
local MarketplaceService = game:GetService("MarketplaceService");
local ProductIds = require(ReplicatedStorage.Shared.Configs.ProductIds);
game:GetService("ContentProvider");
local LocalPlayer = Players.LocalPlayer;
local v2 = KnitClient.CreateController({
    Name = "NELController"
});

local function comma(p3) -- Line: 19
    local v4 = tonumber(p3) or 0;
    local math_floor_ret = math.floor(v4);
    local v5 = tostring(math_floor_ret);
    local v6;

    repeat
        v5, v6 = string.gsub(v5, "^(-?%d+)(%d%d%d)", "%1,%2");
    until v6 == 0;

    return v5;
end;

local function shortYen(p7) -- Line: 29
    -- upvalues: comma (copy)
    local v8 = tonumber(p7) or 0;

    if v8 >= 1000000000 then
        return string.format("%.1fB", v8 / 1000000000);
    end;

    if v8 >= 1000000 then
        return string.format("%.0fM", v8 / 1000000);
    end;

    return comma(v8);
end;

local function teamIcon(p9) -- Line: 36
    -- upvalues: SalaryConfig (copy)
    return p9 and SalaryConfig.TeamIcons[p9] or "";
end;

local function textLabels(p10) -- Line: 40
    local v11 = {};

    for _, child in ipairs(p10:GetChildren()) do
        if child:IsA("TextLabel") then
            table.insert(v11, child);
        end;
    end;

    return v11;
end;

local function classify(p12) -- Line: 48
    local v13 = {};

    for _, child in ipairs(p12:GetChildren()) do
        if child:IsA("TextLabel") then
            local Text = child.Text;

            if string.find(Text, "Rewards", 1, true) then
                v13.rewards = child;
            elseif string.find(Text, "MAX", 1, true) or (string.find(Text, "MIN", 1, true) or string.find(Text, "¥", 1, true)) then
                v13.band = child;
            elseif string.find(Text, "Games", 1, true) or string.find(Text, "RW", 1, true) then
                v13.games = child;
            else
                v13.team = child;
            end;
        end;
    end;

    return v13;
end;

local function captainDesc(p14) -- Line: 62
    -- upvalues: NELConfig (copy)
    for _, v in NELConfig.CaptainQuests do
        if v.Key == p14 then
            return NELConfig.QuestTrackDesc[v.Track] or "";
        end;
    end;

    return "";
end;

local u15 = {
    StyleSpins = "rbxassetid://125339871021518",
    LuckyStyleSpins = "rbxassetid://125339871021518",
    FlowSpins = "rbxassetid://133558083095603",
    LuckyFlowSpins = "rbxassetid://133558083095603"
};
local u16 = {
    ["Ego\'s Portal"] = "rbxassetid://119107219489603"
};
local ColorSequence_new_ret = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 64, 64)),
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 170, 0)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 240, 0)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 220, 90)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 160, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 80, 255))
});

local function rewardIcons(p17) -- Line: 86
    -- upvalues: NELConfig (copy), u16 (copy), u15 (copy)
    local v18 = {};

    for _, v in NELConfig.MainQuests do
        if v.Key == p17 and v.Reward then
            for _, v3 in v.Reward do
                local v19 = v3.Name and u16[v3.Name] or u15[v3.Type];

                if v19 then
                    table.insert(v18, v19);
                end;
            end;
        end;
    end;

    return v18;
end;

local u20 = nil;

local function rewardText(p21) -- Line: 100
    -- upvalues: u20 (ref), NELConfig (copy)
    if not u20 then
        u20 = {};

        for _, v in NELConfig.CaptainQuests do
            u20[v.Key] = v.Reward;
        end;

        for _, v in NELConfig.MainQuests do
            u20[v.Key] = v.Reward;
        end;

        for _, v in NELConfig.TeamQuests do
            u20[v.Key] = v.Reward;
        end;
    end;

    local v22 = u20[p21];

    if not v22 then
        return "";
    end;

    local v23 = {
        StyleSpins = "Style Spin",
        FlowSpins = "Flow Spin",
        LuckyStyleSpins = "Lucky Style Spin",
        LuckyFlowSpins = "Lucky Flow Spin",
        GachaSpins = "Crate Spin"
    };
    local v24 = {};

    for _, v in v22 do
        if v.Type == "Money" then
            local v25 = v.Amount or 0;
            local v26;

            if v25 >= 1000 then
                local v27 = v25 / 1000;
                v26 = v27 == math.floor(v27) and string.format("%dk", v27) or string.format("%.1fk", v27);
            else
                v26 = tostring(v25);
            end;

            table.insert(v24, v26 .. " Cash");
        elseif v23[v.Type] then
            local v28 = v.Amount or 1;
            table.insert(v24, string.format("%d %s%s", v28, v23[v.Type], v28 == 1 and "" or "s"));
        elseif v.Name then
            table.insert(v24, v.Name);
        end;
    end;

    return table.concat(v24, " + ");
end;

function v2.Tab(u29, p30) -- Line: 132
    for i, v in u29.Views do
        v.Visible = i == p30;
    end;

    local Frames = u29.MainGui.Frames;
    local v31 = p30 ~= "NelLeaderboard";

    if Frames:FindFirstChild("FriendLeaderboard") then
        Frames.FriendLeaderboard.Visible = v31;
    end;

    if Frames:FindFirstChild("TeamProgressBar") then
        Frames.TeamProgressBar.Visible = v31;
    end;

    if v31 and u29.MainGui.Visible then
        u29:BindFriendLeaderboard();
    end;

    for i, v in u29.TabButtons do
        v.ImageTransparency = i == p30 and 0 or 0.45;
    end;

    if p30 == "NelLeaderboard" then
        u29:BindNelLeaderboard(u29._state);
    end;

    if p30 == "SeasonMatchups" then
        u29:RenderSeasonPage();
        task.spawn(function() -- Line: 147
            -- upvalues: u29 (copy)
            local NELState = u29.Service:GetNELState();

            if NELState then
                u29._state = NELState;
                u29:RenderSeasonPage();
            end;
        end);
    end;
end;

function v2.ApplyAcademyKit(p32, p33) -- Line: 158
    -- upvalues: LocalPlayer (copy), SalaryConfig (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    if not p32._savedClothing then
        p32._savedClothing = {};

        for _, child in Character:GetChildren() do
            if child:IsA("Shirt") then
                p32._savedClothing.Shirt = child.ShirtTemplate;
            elseif child:IsA("Pants") then
                p32._savedClothing.Pants = child.PantsTemplate;
            end;
        end;
    end;

    for _, child in Character:GetChildren() do
        if child:IsA("Shirt") or (child:IsA("Pants") or child:IsA("ShirtGraphic")) then
            child:Destroy();
        end;
    end;

    local v34 = SalaryConfig.TeamKits and SalaryConfig.TeamKits[p33] or SalaryConfig.DefaultKit;

    if v34 then
        if v34.Shirt and v34.Shirt ~= "" then
            local Shirt = Instance.new("Shirt");
            Shirt.ShirtTemplate = v34.Shirt;
            Shirt.Parent = Character;
        end;

        if v34.Pants and v34.Pants ~= "" then
            local Pants = Instance.new("Pants");
            Pants.PantsTemplate = v34.Pants;
            Pants.Parent = Character;
        end;
    end;
end;

function v2.RestoreClothing(p35) -- Line: 189
    -- upvalues: LocalPlayer (copy)
    if not p35._savedClothing then
        return;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        for _, child in Character:GetChildren() do
            if child:IsA("Shirt") or child:IsA("Pants") then
                child:Destroy();
            end;
        end;

        if p35._savedClothing.Shirt then
            local Shirt = Instance.new("Shirt");
            Shirt.ShirtTemplate = p35._savedClothing.Shirt;
            Shirt.Parent = Character;
        end;

        if p35._savedClothing.Pants then
            local Pants = Instance.new("Pants");
            Pants.PantsTemplate = p35._savedClothing.Pants;
            Pants.Parent = Character;
        end;
    end;

    p35._savedClothing = nil;
end;

local CFrame_new_ret = CFrame.new(
    -0.079102,
    2.400002,
    -13.160133,
    -1,
    0,
    0,
    0,
    0.992511034,
    0.122155085,
    0,
    0.122155085,
    -0.992511034
);
local CFrame_new_ret2 = CFrame.new(0, 0, 0);

function v2.SetRigAuraEnabled(p36, p37, p38) -- Line: 214
    if p37 then
        p37 = p37:FindFirstChild("ClubAura");
    end;

    if not p37 then
        return;
    end;

    for _, descendant in p37:GetDescendants() do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("PointLight") then
            descendant.Enabled = p38;
        end;
    end;
end;

function v2.AttachAcademyAura(p39, p40, p41) -- Line: 224
    -- upvalues: NELConfig (copy), ReplicatedStorage (copy), CFrame_new_ret2 (copy)
    if not p40 or p40:FindFirstChild("ClubAura") then
        return;
    end;

    local v42 = NELConfig.AcademyAuras and NELConfig.AcademyAuras[p41];

    if not v42 then
        return;
    end;

    local ClubAuras = ReplicatedStorage.Assets:FindFirstChild("ClubAuras");

    if ClubAuras then
        ClubAuras = ClubAuras:FindFirstChild(v42);
    end;

    if not ClubAuras then
        warn("[NEL] club aura missing for", p41, v42);

        return;
    end;

    local Torso = p40:FindFirstChild("Torso");

    if not Torso then
        return;
    end;

    local v43 = ClubAuras:Clone();
    v43.Name = "ClubAura";
    v43.Anchored = false;
    v43.CanCollide = false;
    v43.CanQuery = false;
    v43.CanTouch = false;
    v43.Massless = true;

    for _, descendant in v43:GetDescendants() do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("PointLight") then
            descendant.Enabled = false;
        end;
    end;

    v43.CFrame = Torso.CFrame * CFrame_new_ret2;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = Torso;
    WeldConstraint.Part1 = v43;
    WeldConstraint.Parent = v43;
    v43.Parent = p40;
end;

function v2.SetupAcademyCharacters(p44) -- Line: 256
    -- upvalues: NELConfig (copy), ReplicatedStorage (copy)
    local AcademyStageAnimations = NELConfig.AcademyStageAnimations;
    local AcademyCharacters = NELConfig.AcademyCharacters;

    if not (AcademyStageAnimations and AcademyCharacters) then
        return;
    end;

    local v45 = workspace:FindFirstChild("NEL Academy Selection");

    if not v45 then
        return;
    end;

    local AcademyCharacters2 = ReplicatedStorage.Assets:FindFirstChild("AcademyCharacters");

    if not AcademyCharacters2 then
        return;
    end;

    local Character1 = v45:FindFirstChild("Character1");

    if Character1 then
        Character1 = Character1:FindFirstChild("HumanoidRootPart");
    end;

    if not Character1 then
        return;
    end;

    p44._acadAnchorCF = Character1.CFrame;

    for _, v in { "Character1", "Character2" } do
        local v46 = v45:FindFirstChild(v);

        if v46 then
            for _, descendant in v46:GetDescendants() do
                if descendant:IsA("BasePart") then
                    descendant.Transparency = 1;
                end;

                if descendant:IsA("Decal") then
                    descendant.Transparency = 1;
                end;
            end;
        end;
    end;

    local AcademyCharsRuntime = v45:FindFirstChild("AcademyCharsRuntime");

    if AcademyCharsRuntime then
        AcademyCharsRuntime:Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "AcademyCharsRuntime";
    Folder.Parent = v45;
    p44._acadCharRigs = {};
    p44._acadTrackCache = {};

    for i, v in AcademyCharacters do
        p44._acadCharRigs[i] = {};
        p44._acadTrackCache[i] = {};
        local v47 = AcademyStageAnimations[i];
        local v48 = i;
        local v49 = v;

        for _, v3 in { "Character1", "Character2" } do
            local v50 = v49[v3];

            if v50 then
                v50 = AcademyCharacters2:FindFirstChild(v50);
            end;

            if v50 and v47 then
                local v51 = v50:Clone();
                v51.Name = v48 .. "_" .. v3;
                local HumanoidRootPart = v51:FindFirstChild("HumanoidRootPart");
                local v52;

                if HumanoidRootPart then
                    v52 = v3;

                    for _, descendant in v51:GetDescendants() do
                        if descendant:IsA("BasePart") then
                            descendant.Anchored = descendant == HumanoidRootPart;
                        end;
                    end;

                    v51.PrimaryPart = HumanoidRootPart;
                else
                    v52 = v3;
                end;

                v51.Parent = Folder;

                if HumanoidRootPart then
                    v51:PivotTo(p44._acadAnchorCF);
                end;

                local v53 = v51:FindFirstChildOfClass("Humanoid");
                local v54;

                if v53 then
                    v54 = v53:FindFirstChildOfClass("Animator");
                else
                    v54 = v53;
                end;

                if not v54 and v53 then
                    v54 = Instance.new("Animator");
                    v54.Parent = v53;
                end;

                local v55 = v47[v52];

                if v54 and v55 then
                    local Animation = Instance.new("Animation");
                    Animation.AnimationId = v55;
                    local v56 = v54:LoadAnimation(Animation);
                    v56.Looped = true;
                    p44._acadTrackCache[v48][v52] = v56;
                    v56:Play(0);
                end;

                p44._acadCharRigs[v48][v52] = v51;
                p44:AttachAcademyAura(v51, v48);
            end;

            task.wait();
        end;
    end;

    task.wait(0.4);

    for i, v in p44._acadCharRigs do
        local v57 = i;

        for i2, v3 in v do
            local v58 = p44._acadTrackCache[v57] and p44._acadTrackCache[v57][i2];

            if v58 then
                v58:Stop(0);
            end;

            if v3.PrimaryPart then
                v3:PivotTo(p44._acadAnchorCF * CFrame.new(0, -300, 0));
            end;
        end;
    end;
end;

function v2.PlayAcademyStageAnims(p59, p60) -- Line: 331
    if not p59._acadCharRigs then
        p59:SetupAcademyCharacters();
    end;

    if not p59._acadCharRigs then
        return;
    end;

    local _acadAnchorCF = p59._acadAnchorCF;
    local v61;

    if _acadAnchorCF then
        v61 = _acadAnchorCF * CFrame.new(0, -300, 0);
    else
        v61 = _acadAnchorCF;
    end;

    for i, v in p59._acadCharRigs do
        local v62 = i == p60;
        local v63 = i;

        for i2, v3 in v do
            local v64 = p59._acadTrackCache[v63] and p59._acadTrackCache[v63][i2];
            p59:SetRigAuraEnabled(v3, v62);

            if v62 then
                if v3.PrimaryPart and _acadAnchorCF then
                    v3:PivotTo(_acadAnchorCF);
                end;

                if v64 and not v64.IsPlaying then
                    v64:Play(0);
                end;
            else
                if v64 and v64.IsPlaying then
                    v64:Stop(0);
                end;

                if v3.PrimaryPart and v61 then
                    v3:PivotTo(v61);
                end;
            end;
        end;
    end;
end;

function v2.StopAcademyStageAnims(p65) -- Line: 352
    if not p65._acadCharRigs then
        return;
    end;

    local v66 = p65._acadAnchorCF and p65._acadAnchorCF * CFrame.new(0, -300, 0);

    for i, v in p65._acadCharRigs do
        local v67 = i;

        for i2, v3 in v do
            local v68 = p65._acadTrackCache[v67] and p65._acadTrackCache[v67][i2];

            if v68 and v68.IsPlaying then
                v68:Stop(0);
            end;

            if v3.PrimaryPart and v66 then
                v3:PivotTo(v66);
            end;

            p65:SetRigAuraEnabled(v3, false);
        end;
    end;
end;

function v2.StartAcademyCamera(p69) -- Line: 365
    -- upvalues: CFrame_new_ret (copy), RunService (copy), LocalPlayer (copy)
    if p69._acadCamActive then
        return;
    end;

    local u70 = workspace:FindFirstChild("NEL Academy Selection");

    if u70 then
        u70 = u70:FindFirstChild("Character1");
    end;

    if u70 then
        u70 = u70:FindFirstChild("HumanoidRootPart");
    end;

    if not u70 then
        warn("[NEL] Academy stage/Character1 missing; skipping stage camera");

        return;
    end;

    p69._acadCamActive = true;
    pcall(function() -- Line: 375
        game:GetService("StarterGui"):SetCore("ResetButtonCallback", false);
    end);
    local workspace_CurrentCamera = workspace.CurrentCamera;
    p69._savedCamType = workspace_CurrentCamera.CameraType;
    p69._savedFOV = workspace_CurrentCamera.FieldOfView;
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    workspace_CurrentCamera.FieldOfView = 70;
    local Blur = game.Lighting:FindFirstChild("Blur");

    if Blur then
        p69._savedBlur = Blur.Size;
        game:GetService("TweenService"):Create(Blur, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 3
        }):Play();
    end;

    workspace_CurrentCamera.CFrame = u70.CFrame * CFrame_new_ret;
    p69._acadCamConn = RunService.RenderStepped:Connect(function() -- Line: 387
        -- upvalues: u70 (copy), workspace_CurrentCamera (copy), CFrame_new_ret (ref), LocalPlayer (ref)
        if u70 and u70.Parent then
            workspace_CurrentCamera.CFrame = u70.CFrame * CFrame_new_ret;
        end;

        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChildOfClass("Humanoid");
        end;

        if Character then
            Character.WalkSpeed = 0;
            Character.JumpPower = 0;
            Character.JumpHeight = 0;
        end;
    end);
end;

function v2.StopAcademyCamera(p71) -- Line: 399
    p71:StopAcademyStageAnims();

    if not p71._acadCamActive then
        return;
    end;

    p71._acadCamActive = false;
    pcall(function() -- Line: 403
        game:GetService("StarterGui"):SetCore("ResetButtonCallback", true);
    end);

    if p71._acadCamConn then
        p71._acadCamConn:Disconnect();
        p71._acadCamConn = nil;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;

    if p71._savedFOV then
        workspace_CurrentCamera.FieldOfView = p71._savedFOV;
    end;

    local Blur = game.Lighting:FindFirstChild("Blur");

    if Blur and p71._savedBlur then
        game:GetService("TweenService"):Create(Blur, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = p71._savedBlur
        }):Play();
    end;
end;

function v2.RecolorTheme(p72, p73, p74) -- Line: 412
    -- upvalues: SalaryConfig (copy)
    if p74 then
        p74 = SalaryConfig.TeamColors[p74];
    end;

    if not (p73 and p74) then
        return;
    end;

    local Color3_fromRGB_ret = Color3.fromRGB(0, 170, 127);
    local Color3_fromRGB_ret2 = Color3.fromRGB(0, 85, 255);

    local function near(p75, p76) -- Line: 416
        local v77;

        if math.abs(p75.R - p76.R) < 0.12 and math.abs(p75.G - p76.G) < 0.12 then
            v77 = math.abs(p75.B - p76.B) < 0.12;
        else
            v77 = false;
        end;

        return v77;
    end;

    local ColorSequence_new_ret2 = ColorSequence.new(p74[1], p74[2]);

    for _, descendant in p73:GetDescendants() do
        if descendant:IsA("UIGradient") then
            if descendant:GetAttribute("_NELTheme") == nil then
                local Value = descendant.Color.Keypoints[1].Value;
                local v78;

                if math.abs(Value.R - Color3_fromRGB_ret.R) < 0.12 and math.abs(Value.G - Color3_fromRGB_ret.G) < 0.12 then
                    v78 = math.abs(Value.B - Color3_fromRGB_ret.B) < 0.12;
                else
                    v78 = false;
                end;

                if not v78 then
                    if math.abs(Value.R - Color3_fromRGB_ret2.R) < 0.12 and math.abs(Value.G - Color3_fromRGB_ret2.G) < 0.12 then
                        v78 = math.abs(Value.B - Color3_fromRGB_ret2.B) < 0.12;
                    else
                        v78 = false;
                    end;
                end;

                descendant:SetAttribute("_NELTheme", v78);
            end;

            if descendant:GetAttribute("_NELTheme") == true then
                descendant.Color = ColorSequence_new_ret2;
            end;
        end;
    end;
end;

function v2.BindTeamHub(p79, p80) -- Line: 433
    -- upvalues: SalaryConfig (copy), textLabels (copy), Players (copy), LocalPlayer (copy), NELConfig (copy), rewardText (copy), comma (copy), shortYen (copy)
    local TeamHub = p79.Views.TeamHub;

    if not TeamHub then
        return;
    end;

    if p79._hubTheme ~= p80.CurrentTeam then
        p79._hubTheme = p80.CurrentTeam;
        p79:RecolorTheme(p79.MainGui, p80.CurrentTeam);
    end;

    local Header = p79.MainGui:FindFirstChild("Header");
    local v81;

    if Header then
        v81 = Header:FindFirstChild("Country", true);
    else
        v81 = Header;
    end;

    if v81 then
        v81.Text = "Country: " .. (SalaryConfig.TeamCountries[p80.CurrentTeam] or "");
    end;

    if Header then
        Header = Header:FindFirstChild("TeamLogo", true);
    end;

    if Header and Header:IsA("ImageLabel") then
        local CurrentTeam = p80.CurrentTeam;
        Header.Image = CurrentTeam and SalaryConfig.TeamIcons[CurrentTeam] or "";
    end;

    local v82 = p80.Perks or {};
    local v83 = {};

    for _, child in ipairs(TeamHub.TeamPerks.List:GetChildren()) do
        if child:IsA("Frame") then
            table.insert(v83, child);
        end;
    end;

    for i, v in v83 do
        local v84 = v82[i];
        v.Visible = v84 ~= nil;

        if v84 then
            local v85 = textLabels(v);

            if v85[1] then
                v85[1].Text = v84.Name;
            end;

            if v85[2] then
                v85[2].Text = v84.Desc;
            end;

            local Icon = v:FindFirstChild("Icon");

            if Icon and (v84.Icon and v84.Icon ~= "") then
                Icon.Image = v84.Icon;
                Icon.ImageColor3 = Color3.new(1, 1, 1);
                local v86 = Icon:FindFirstChildOfClass("UIGradient");

                if v86 then
                    v86.Enabled = false;
                end;

                local Icon2 = Icon:FindFirstChild("Icon");

                if Icon2 then
                    Icon2.Visible = false;
                end;
            end;
        end;
    end;

    local Children = TeamHub.Stats.StatsIMG:GetChildren();
    local v87 = {
        Speed = "Speed",
        Defense = "Defense",
        Pass = "Passing",
        Dribble = "Dribble",
        Shoot = "Shooting",
        Offense = "Offense"
    };

    for i = 1, #Children do
        local v88 = Children[i];
        local v89;

        if v88:IsA("TextLabel") and v88.Name ~= "Grade" then
            local v90 = v87[v88.Text];
            local v91 = Children[i + 1];

            if v90 and (p80.Grades and (p80.Grades[v90] and (v91 and (v91:IsA("TextLabel") and v91.Name == "Grade")))) then
                v91.Text = p80.Grades[v90].letter;
                v89 = i;
            else
                v89 = i;
            end;
        else
            v89 = i;
        end;
    end;

    if TeamHub.Stats:FindFirstChild("TotalScore") then
        TeamHub.Stats.TotalScore.TotalScore.Text = "Total: " .. tostring(p80.Total or 0);
    end;

    if TeamHub.Stats:FindFirstChild("RankGrade") then
        TeamHub.Stats.RankGrade.Rank.Text = "Rank: " .. tostring(p80.Rank or "D");
    end;

    local Profile = TeamHub.Stats:FindFirstChild("Profile");
    local u92 = Profile and Profile:FindFirstChild("BG") and Profile.BG:FindFirstChild("PlayerID");

    if u92 and u92:IsA("ImageLabel") then
        task.spawn(function() -- Line: 498
            -- upvalues: Players (ref), LocalPlayer (ref), u92 (copy)
            local success, result = pcall(function() -- Line: 499
                -- upvalues: Players (ref), LocalPlayer (ref)
                return Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size420x420);
            end);

            if success and result then
                u92.Image = result;
            end;
        end);
    end;

    local v93 = p80.CaptainQuests or {};
    local v94 = {};

    for _, child in ipairs(TeamHub.TeamQuests.List:GetChildren()) do
        if child:IsA("Frame") then
            table.insert(v94, child);
        end;
    end;

    table.sort(v94, function(p95, p96) -- Line: 511
        return p95.Name < p96.Name;
    end);
    local v97 = nil;

    for _, v in NELConfig.TeamQuests do
        if v.Team == p80.CurrentTeam then
            v97 = v;
            break;
        end;
    end;

    p79._questTimers = {};

    for i, v in v94 do
        local v98 = v93[i];

        if v98 then
            v.Visible = true;
            local v99 = (v98.CooldownRemaining or 0) > 0;
            local v100 = textLabels(v);

            if v100[1] then
                v100[1].Text = v98.Display;
            end;

            local v101;

            if v100[2] then
                if v99 then
                    local CooldownRemaining = v98.CooldownRemaining;
                    v100[2].Text = string.format("Ready in %d:%02d", math.floor(CooldownRemaining / 60), CooldownRemaining % 60);
                    local _questTimers = p79._questTimers;
                    local v102 = {
                        label = v100[2],
                        readyTime = os.time() + CooldownRemaining
                    };
                    table.insert(_questTimers, v102);
                    v101 = v;
                else
                    local Key = v98.Key;
                    v101 = v;
                    local v103 = "";

                    for _, v3 in NELConfig.CaptainQuests do
                        if v3.Key == Key then
                            v103 = NELConfig.QuestTrackDesc[v3.Track] or "";
                            break;
                        end;
                    end;

                    v100[2].Text = string.format("%s (%d/%d)  |  Reward: %s", v103, v98.Progress or 0, v98.Goal or 0, rewardText(v98.Key));
                end;
            else
                v101 = v;
            end;

            for _, v3 in v100 do
                v3.TextTransparency = v99 and 0.55 or 0;
            end;

            if v99 and v100[2] then
                v100[2].TextTransparency = 0;
            end;

            local Icon = v101:FindFirstChild("Icon");

            if Icon then
                Icon.ImageTransparency = v99 and 0.55 or 0;
            end;
        elseif v97 and i == #v93 + 1 then
            v.Visible = true;
            local v104 = textLabels(v);

            if v104[1] then
                v104[1].Text = v97.Display;
            end;

            if v104[2] then
                local v105 = p80.TeamLifetime or 0;
                local v106;

                if v97.Threshold <= v105 then
                    v106 = "Complete";
                else
                    local string_format = string.format;
                    local v107 = tonumber(v105) or 0;
                    local v108;

                    if v107 >= 1000000000 then
                        v108 = string.format("%.1fB", v107 / 1000000000);
                    elseif v107 >= 1000000 then
                        v108 = string.format("%.0fM", v107 / 1000000);
                    else
                        v108 = comma(v107);
                    end;

                    v106 = string_format("%s / %s", v108, shortYen(v97.Threshold));
                end;

                v104[2].Text = string.format("%s  |  Reward: %s", v106, rewardText(v97.Key));
            end;

            for _, v3 in v104 do
                v3.TextTransparency = 0;
            end;

            local Icon = v:FindFirstChild("Icon");

            if Icon then
                Icon.ImageTransparency = 0;
            end;
        else
            v.Visible = false;
        end;
    end;

    local v109 = {};

    for _, child in ipairs(TeamHub.Achievements.List:GetChildren()) do
        if child:IsA("ImageLabel") then
            table.insert(v109, child);
        end;
    end;

    local v110 = { p80.LifetimeWins or 0, p80.LifetimeMvps or 0 };

    for i, v in v109 do
        local v111 = textLabels(v);
        local v112 = v111[2] or v111[1];

        if v112 then
            v112.Text = comma(v110[i] or 0);
        end;
    end;
end;

function v2.BindOverallQuests(u113, p114) -- Line: 568
    -- upvalues: rewardText (copy), rewardIcons (copy), ColorSequence_new_ret (copy), NELConfig (copy)
    local TeamQuests = u113.Views.TeamQuests;

    if not TeamQuests then
        return;
    end;

    local ScrollingFrame = TeamQuests.ScrollingFrame;
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
    ScrollingFrame.CanvasSize = UDim2.new();

    if not u113._readyTemplate then
        local RewardReady = ScrollingFrame:FindFirstChild("RewardReady");
        local NotClaimed = ScrollingFrame:FindFirstChild("NotClaimed");

        if RewardReady then
            u113._readyTemplate = RewardReady:Clone();
        end;

        if NotClaimed then
            u113._notTemplate = NotClaimed:Clone();
        end;
    end;

    if not (u113._readyTemplate and u113._notTemplate) then
        return;
    end;

    for _, child in ipairs(ScrollingFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy();
        end;
    end;

    for _, v in p114.MainQuests or {} do
        local v115 = (v.CooldownRemaining or 0) > 0;
        local v116, v117;

        if v.Ready and not v.Claimed then
            v116 = u113._readyTemplate:Clone();
            local ClaimReward = v116:FindFirstChild("ClaimReward");

            if ClaimReward then
                ClaimReward.Activated:Connect(function() -- Line: 595
                    -- upvalues: u113 (copy), v (copy)
                    u113.Service:ClaimMainQuest(v.Key);
                end);
                v117 = v;
            else
                v117 = v;
            end;
        else
            v116 = u113._notTemplate:Clone();

            if v116:FindFirstChild("Reward") then
                v116.Reward.Text = v115 and "On Cooldown" or (v.Claimed and "Claimed" or rewardText(v.Key));
            end;

            local PrizeReward = v116:FindFirstChild("PrizeReward");
            local v118 = rewardIcons(v.Key);

            if PrizeReward and #v118 > 0 then
                local Claimed = v.Claimed;
                local v119 = { PrizeReward };

                if #v118 >= 2 then
                    local Scale = PrizeReward.Position.X.Scale;
                    local v120 = PrizeReward:Clone();
                    v120.Name = "PrizeReward2";
                    v120.Parent = PrizeReward.Parent;
                    PrizeReward.Position = UDim2.new(Scale - 0.033, 0, PrizeReward.Position.Y.Scale, 0);
                    v120.Position = UDim2.new(Scale + 0.033, 0, PrizeReward.Position.Y.Scale, 0);
                    v119[2] = v120;
                end;

                v117 = v;

                for i, v3 in v119 do
                    v3.Image = v118[i];
                    local v121 = v3:FindFirstChildOfClass("UIGradient");

                    if not v121 then
                        v121 = Instance.new("UIGradient");
                        v121.Rotation = 45;
                        v121.Parent = v3;
                    end;

                    v121.Color = ColorSequence_new_ret;
                    v3.ImageColor3 = Claimed and Color3.fromRGB(120, 120, 120) or Color3.new(1, 1, 1);
                    v121.Enabled = not Claimed;
                end;
            else
                v117 = v;
            end;
        end;

        if v116:FindFirstChild("QuestInfo") then
            v116.QuestInfo.Text = v117.Display;
        end;

        if v116:FindFirstChild("Progress") then
            if v115 then
                local CooldownRemaining = v117.CooldownRemaining;
                v116.Progress.Text = string.format("Ready in %d:%02d:%02d", math.floor(CooldownRemaining / 3600), math.floor(CooldownRemaining % 3600 / 60), CooldownRemaining % 60);
                u113._questTimers = u113._questTimers or {};
                local _questTimers = u113._questTimers;
                local v122 = {
                    hours = true,
                    label = v116.Progress,
                    readyTime = os.time() + CooldownRemaining
                };
                table.insert(_questTimers, v122);
            else
                v116.Progress.Text = string.format("%s (%d/%d)  |  Reward: %s", NELConfig.MainQuestDesc[v117.Key] or "", v117.Progress or 0, v117.Goal or 0, rewardText(v117.Key));
            end;
        end;

        if v115 then
            for _, descendant in v116:GetDescendants() do
                if descendant:IsA("TextLabel") then
                    descendant.TextTransparency = 0.55;
                end;
            end;

            if v116:FindFirstChild("Progress") then
                v116.Progress.TextTransparency = 0;
            end;
        end;

        v116.Visible = true;
        v116.Parent = ScrollingFrame;
    end;

    local TeamProgressBar = u113.MainGui.Frames:FindFirstChild("TeamProgressBar");

    if TeamProgressBar and (TeamProgressBar:FindFirstChild("Bar") and TeamProgressBar.Bar:FindFirstChild("Fill")) then
        local v123 = p114.TeamLifetime or 0;
        local Fill = TeamProgressBar.Bar.Fill;
        Fill.AnchorPoint = Vector2.new(0.5, 1);
        Fill.Position = UDim2.new(0.5, 0, 1, 0);
        local v124 = { { 0, 0 }, { 500000000, 0.111 }, { 1500000000, 0.469 }, { 3000000000, 1 } };
        local v125 = v124[#v124][2];

        if v123 <= 0 then
            v125 = 0;
        else
            for i = 2, #v124 do
                if v123 <= v124[i][1] then
                    local v126 = v124[i - 1];
                    local v127 = v124[i];
                    v125 = v126[2] + (v127[2] - v126[2]) * ((v123 - v126[1]) / (v127[1] - v126[1]));
                    break;
                end;

                local _ = i;
            end;
        end;

        Fill.Size = UDim2.new(1, 0, v125, 0);
        local v128 = p114.CurrentTeam or "";

        for i, v in {
            ThirdPrize = {
                earned = "500 Mil Earned",
                reward = "Chat Tag",
                threshold = 500000000
            },
            SecondPrize = {
                earned = "1,5 Bil Earned",
                reward = "Playercard",
                threshold = 1500000000
            },
            GrandPrize = {
                earned = "3 Bil Earned",
                reward = "Goal Effect",
                threshold = 3000000000
            }
        } do
            local v129 = TeamProgressBar:FindFirstChild(i);

            if v129 and v129:IsA("TextLabel") then
                v129.Text = v.earned .. "\r" .. v128 .. " " .. v.reward;
                v129.TextTransparency = v.threshold <= v123 and 0 or 0.5;
            end;
        end;
    end;
end;

function v2.BindFriendLeaderboard(u130) -- Line: 689
    -- upvalues: LocalPlayer (copy), comma (copy), SalaryConfig (copy), Players (copy)
    local FriendLeaderboard = u130.MainGui.Frames:FindFirstChild("FriendLeaderboard");

    if not FriendLeaderboard then
        return;
    end;

    local ScrollingFrame = FriendLeaderboard.ScrollingFrame;

    if not u130._lbTemplate then
        for _, child in ipairs(ScrollingFrame:GetChildren()) do
            if child:IsA("Frame") then
                u130._lbTemplate = child:Clone();
                break;
            end;
        end;
    end;

    if not u130._lbTemplate then
        return;
    end;

    for _, child in ipairs(ScrollingFrame:GetChildren()) do
        if child:IsA("Frame") then
            child.Visible = false;
        end;
    end;

    u130._friendLbGen = (u130._friendLbGen or 0) + 1;
    local _friendLbGen = u130._friendLbGen;
    task.spawn(function() -- Line: 704
        -- upvalues: u130 (copy), _friendLbGen (copy), FriendLeaderboard (copy), ScrollingFrame (copy), LocalPlayer (ref), comma (ref), SalaryConfig (ref), Players (ref)
        local FriendLeaderboard2 = u130.Service:GetFriendLeaderboard();

        if _friendLbGen ~= u130._friendLbGen or not (u130.MainGui.Visible and FriendLeaderboard.Visible) then
            return;
        end;

        for _, child in ipairs(ScrollingFrame:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy();
            end;
        end;

        for i, v in FriendLeaderboard2 or {} do
            local v131 = u130._lbTemplate:Clone();
            local v132 = v.UserId == LocalPlayer.UserId;

            if v131:FindFirstChild("QuestInfo") then
                v131.QuestInfo.Text = string.format("#%d  %s", i, v.Name);

                if v132 then
                    v131.QuestInfo.TextColor3 = Color3.fromRGB(255, 221, 51);
                end;
            end;

            if v131:FindFirstChild("Cash") then
                v131.Cash.Text = "$" .. comma(v.Earnings or 0);
            end;

            if v131:FindFirstChild("TeamLogo") then
                local Team = v.Team;
                v131.TeamLogo.Image = Team and SalaryConfig.TeamIcons[Team] or "";
            end;

            if v131:FindFirstChild("ProfileIMG") and v131.ProfileIMG:FindFirstChild("PlayerID") then
                local success, result = pcall(function() -- Line: 720
                    -- upvalues: Players (ref), v (copy)
                    return Players:GetUserThumbnailAsync(v.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150);
                end);

                if success then
                    v131.ProfileIMG.PlayerID.Image = result;
                end;
            end;

            v131.Visible = true;
            v131.Parent = ScrollingFrame;
        end;
    end);
end;

function v2.BindNelLeaderboard(p133, p134) -- Line: 730
    -- upvalues: comma (copy), LocalPlayer (copy), Players (copy), SalaryConfig (copy)
    if not p134 then
        return;
    end;

    local NelLeaderboard = p133.Views.NelLeaderboard;

    if not NelLeaderboard then
        return;
    end;

    local v135 = p134.StatMultipliers or {};

    local function mult(p136) -- Line: 736
        return string.format("%gx", p136 or 1);
    end;

    local StatMultipliers = NelLeaderboard:FindFirstChild("StatMultipliers");

    if StatMultipliers then
        if StatMultipliers:FindFirstChild("GoalsMultiplier") then
            StatMultipliers.GoalsMultiplier.Text = string.format("%gx", v135.Goal or 1);
        end;

        if StatMultipliers:FindFirstChild("AssistsMultiplier") then
            StatMultipliers.AssistsMultiplier.Text = string.format("%gx", v135.Assist or 1);
        end;

        if StatMultipliers:FindFirstChild("SavesMultiplier") then
            StatMultipliers.SavesMultiplier.Text = string.format("%gx", v135.Save or 1);
        end;

        if StatMultipliers:FindFirstChild("StealsMultiplier") then
            StatMultipliers.StealsMultiplier.Text = string.format("%gx", v135.Steal or 1);
        end;
    end;

    local RightSide = NelLeaderboard:FindFirstChild("RightSide");

    if RightSide and RightSide:FindFirstChild("ScrollingFrame") then
        local v137 = {};

        for _, child in RightSide.ScrollingFrame:GetChildren() do
            if child.Name == "detail" then
                table.insert(v137, child);
            end;
        end;

        local v138 = p134.SalaryBreakdown or {};

        for i, v in v137 do
            local v139 = v138[i];
            v.Visible = v139 ~= nil;

            if v139 then
                local Title = v:FindFirstChild("Title");

                if Title then
                    if Title:FindFirstChild("name") then
                        Title.name.Text = v139.Stat;
                    end;

                    if Title:FindFirstChild("amount") then
                        Title.amount.Text = string.format("[x%d]", v139.Count or 0);
                    end;
                end;

                if v:FindFirstChild("Amount") then
                    v.Amount.Text = "¥ " .. comma(v139.Yen or 0);
                end;
            end;
        end;

        local Total = RightSide:FindFirstChild("Total");

        if Total then
            Total = Total:FindFirstChild("detail");
        end;

        if Total and Total:FindFirstChild("Amount") then
            Total.Amount.Text = "¥ " .. comma(p134.SalaryTotal or 0);
        end;
    end;

    local LeftSide = NelLeaderboard:FindFirstChild("LeftSide");

    if LeftSide and LeftSide:FindFirstChild("ScrollingFrame") then
        local ScrollingFrame = LeftSide.ScrollingFrame;
        ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
        ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
        ScrollingFrame.CanvasSize = UDim2.new();
        local v140 = not p133._npcRowTemplate and ScrollingFrame:FindFirstChild("1");

        if v140 then
            p133._npcRowTemplate = v140:Clone();
        end;

        if p133._npcRowTemplate then
            for _, child in ScrollingFrame:GetChildren() do
                if child:IsA("ImageLabel") or child:IsA("Frame") then
                    child:Destroy();
                end;
            end;

            for i, v in p134.SalaryLeaderboard or {} do
                local v141 = p133._npcRowTemplate:Clone();
                v141.LayoutOrder = i;

                if v141:FindFirstChild("Num") then
                    v141.Num.Text = "#" .. i;
                end;

                local Name = v141:FindFirstChild("Name");

                if Name then
                    Name.Text = v.IsPlayer and LocalPlayer.Name or v.Name;
                end;

                if v141:FindFirstChild("Amount") then
                    v141.Amount.Text = "¥ " .. comma(v.Salary or 0);
                end;

                local Icon = v141:FindFirstChild("Icon");

                if Icon then
                    if v.IsPlayer then
                        task.spawn(function() -- Line: 792
                            -- upvalues: Players (ref), LocalPlayer (ref), Icon (copy)
                            local success, result = pcall(function() -- Line: 793
                                -- upvalues: Players (ref), LocalPlayer (ref)
                                return Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150);
                            end);

                            if success then
                                Icon.Image = result;
                            end;
                        end);
                    elseif v.Icon and v.Icon ~= "" then
                        Icon.Image = v.Icon;
                    end;
                end;

                v141.Visible = true;
                v141.Parent = ScrollingFrame;
            end;
        end;
    end;

    local v142 = LeftSide and LeftSide:FindFirstChild("Total") and LeftSide.Total:FindFirstChild("Player");

    if v142 then
        if v142:FindFirstChild("Num") then
            v142.Num.Text = "#" .. tostring(p134.SalaryRank or 0);
        end;

        local Name = v142:FindFirstChild("Name");

        if Name then
            Name.Text = LocalPlayer.Name;
        end;

        if v142:FindFirstChild("Amount") then
            v142.Amount.Text = "¥ " .. comma(p134.SalaryTotal or 0);
        end;

        local Icon = v142:FindFirstChild("Icon");

        if Icon then
            task.spawn(function() -- Line: 811
                -- upvalues: Players (ref), LocalPlayer (ref), Icon (copy)
                local success, result = pcall(function() -- Line: 812
                    -- upvalues: Players (ref), LocalPlayer (ref)
                    return Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150);
                end);

                if success then
                    Icon.Image = result;
                end;
            end);
        end;
    end;

    local button = NelLeaderboard:FindFirstChild("button");

    if button and (button:FindFirstChild("Round") and button.Round:FindFirstChild("TextLabel")) then
        button.Round.TextLabel.Text = string.format("Round %d/%d", p134.GamesPlayed or 0, p134.CareerLength or SalaryConfig.GamesPerOffer);
    end;
end;

function v2.BindContract(u143, p144) -- Line: 823
    -- upvalues: classify (copy), comma (copy), shortYen (copy), SalaryConfig (copy)
    local ContractGui = u143.ContractGui;

    if not ContractGui then
        return;
    end;

    for _, v in u143._contractConns do
        v:Disconnect();
    end;

    u143._contractConns = {};

    if not p144 then
        ContractGui.Visible = false;
        u143:RefreshEnabled();

        return;
    end;

    local v145 = {};

    for _, child in ipairs(ContractGui.Frame.ContractList:GetChildren()) do
        if child:IsA("ImageLabel") then
            table.insert(v145, child);
        end;
    end;

    table.sort(v145, function(p146, p147) -- Line: 838
        return p146.Name < p147.Name;
    end);

    local function fill(p148, u149) -- Line: 840
        -- upvalues: classify (ref), comma (ref), shortYen (ref), SalaryConfig (ref), u143 (copy), ContractGui (copy)
        if not p148 then
            return;
        end;

        p148.Visible = u149 ~= nil;

        if not u149 then
            return;
        end;

        local v150 = classify(p148);

        if v150.team then
            v150.team.Text = u149.Team;
        end;

        if v150.games then
            v150.games.Text = string.format("RW - %d Games", u149.Length or 0);
        end;

        if v150.band then
            local band = v150.band;
            local string_format = string.format;
            local v151 = tonumber(u149.Max) or 0;
            local v152;

            if v151 >= 1000000000 then
                v152 = string.format("%.1fB", v151 / 1000000000);
            elseif v151 >= 1000000 then
                v152 = string.format("%.0fM", v151 / 1000000);
            else
                v152 = comma(v151);
            end;

            band.Text = string_format("MAX: %s ¥\nMIN: %s ¥", v152, shortYen(u149.Min));
        end;

        if v150.rewards then
            v150.rewards.Text = "Rewards: " .. (u149.Rewards or "");
        end;

        local Logo = p148:FindFirstChild("Logo");

        if Logo and Logo:FindFirstChild("lOGO") then
            local Team = u149.Team;
            Logo.lOGO.Image = Team and SalaryConfig.TeamIcons[Team] or "";
        end;

        local v153 = p148:FindFirstChild("RenewContract") or p148:FindFirstChild("SelectContract");

        if v153 then
            table.insert(u143._contractConns, v153.Activated:Connect(function() -- Line: 853
                -- upvalues: ContractGui (ref), u143 (ref), u149 (copy)
                ContractGui.Visible = false;
                u143.Darkness.Visible = false;
                u143:RefreshEnabled();

                if not u143:OpenPositionPicker(function(p154) -- Line: 857
                    -- upvalues: u143 (ref), u149 (ref)
                    u143.Service:AcceptTeamOffer(u149.Team, u149.Length, p154);
                    u143:Refresh();
                end) then
                    u143.Service:AcceptTeamOffer(u149.Team, u149.Length);
                    u143:Refresh();
                end;
            end));
        end;
    end;

    local v155 = p144.cards or {};
    fill(v145[1], v155[1]);
    fill(v145[2], v155[2]);
    fill(v145[3], v155[3]);
    ContractGui.Visible = true;
    u143:RefreshEnabled();
end;

function v2.OpenAcademy(u156) -- Line: 878
    -- upvalues: SalaryConfig (copy), NELConfig (copy), textLabels (copy), Popup (copy)
    local AcademyGui = u156.AcademyGui;

    if not AcademyGui then
        return;
    end;

    local u157 = {};

    for _, v in SalaryConfig.Teams do
        table.insert(u157, v.Name);
    end;

    if #u157 == 0 then
        return;
    end;

    local function show() -- Line: 885
        -- upvalues: u157 (copy), u156 (copy), AcademyGui (copy), SalaryConfig (ref), NELConfig (ref), textLabels (ref)
        local v158 = u157[u156._academyIdx];

        if AcademyGui:FindFirstChild("TeamSelect") and AcademyGui.TeamSelect:FindFirstChild("TeamLogo") then
            AcademyGui.TeamSelect.TeamLogo.Image = v158 and (SalaryConfig.TeamIcons[v158] or "") or "";
        end;

        local v159 = NELConfig.TeamPerks[v158] or {};
        local v160 = {};

        for _, child in ipairs(AcademyGui.TeamPerks.List:GetChildren()) do
            if child:IsA("Frame") then
                table.insert(v160, child);
            end;
        end;

        for i, v in v160 do
            local v161 = v159[i];
            v.Visible = v161 ~= nil;

            if v161 then
                local v162 = textLabels(v);

                if v162[1] then
                    v162[1].Text = v161.Name;
                end;

                if v162[2] then
                    v162[2].Text = NELConfig.PerkDescriptions[v161.Key] or "";
                end;
            end;
        end;

        local Country = AcademyGui.TeamPerks:FindFirstChild("Country", true);

        if Country then
            Country.Text = "Country: " .. (SalaryConfig.TeamCountries[v158] or "");
        end;

        u156:PlayAcademyStageAnims(v158);

        if u156._acadTheme ~= v158 then
            u156._acadTheme = v158;
            u156:RecolorTheme(AcademyGui, v158);
        end;
    end;

    if not u156._academyBound then
        u156._academyBound = true;
        u156._academyIdx = 1;

        if AcademyGui.TeamSelect:FindFirstChild("Left") then
            AcademyGui.TeamSelect.Left.Activated:Connect(function() -- Line: 919
                -- upvalues: u156 (copy), u157 (copy), show (copy)
                u156._academyIdx = (u156._academyIdx - 2) % #u157 + 1;
                show();
            end);
        end;

        if AcademyGui.TeamSelect:FindFirstChild("Right") then
            AcademyGui.TeamSelect.Right.Activated:Connect(function() -- Line: 925
                -- upvalues: u156 (copy), u157 (copy), show (copy)
                u156._academyIdx = u156._academyIdx % #u157 + 1;
                show();
            end);
        end;

        if AcademyGui:FindFirstChild("SelectAcademyButton") then
            AcademyGui.SelectAcademyButton.Activated:Connect(function() -- Line: 931
                -- upvalues: u157 (copy), u156 (copy), Popup (ref), AcademyGui (copy)
                local v163 = u157[u156._academyIdx];
                local v164 = u156._state and u156._state.PendingTeamSwap;
                local v165;

                if v164 then
                    local v166;
                    v165, v166 = u156.Service:SwapAcademy(v163);

                    if not v165 then
                        Popup.Popup(nil, v166 == "already on this team" and ("You are already signed with " .. v163 or "Could not swap team") or "Could not swap team");
                    end;
                else
                    v165 = u156.Service:ChooseAcademy(v163);
                end;

                if v165 then
                    AcademyGui.Visible = false;
                    u156.Darkness.Visible = false;
                    u156.MainGui.Visible = true;
                    u156:Tab("TeamHub");
                    u156:RefreshEnabled();
                    u156:Refresh();

                    if not v164 then
                        u156:OpenPositionPicker(function(p167) -- Line: 952
                            -- upvalues: u156 (ref)
                            u156.Service:SetSeasonPosition(p167);
                        end);
                    end;
                end;
            end);
        end;
    end;

    show();
    AcademyGui.Visible = true;
    u156:RefreshEnabled();
end;

function v2.SwapPriceText(u168) -- Line: 966
    -- upvalues: MarketplaceService (copy), ProductIds (copy)
    if not u168._swapPrice then
        u168._swapPrice = 100;
        task.spawn(function() -- Line: 969
            -- upvalues: MarketplaceService (ref), ProductIds (ref), u168 (copy)
            local success, success = pcall(function() -- Line: 970
                -- upvalues: MarketplaceService (ref), ProductIds (ref)
                return MarketplaceService:GetProductInfo(ProductIds.NEL.SwapTeam, Enum.InfoType.Product);
            end);

            if success then
                if success then
                    success = tonumber(success.PriceInRobux);
                end;
            end;

            if success then
                u168._swapPrice = success;
                u168:RefreshSwapButton();
            end;
        end);
    end;

    return `Swap Team {u168._swapPrice}`;
end;

function v2.SwapCooldownText(p169, p170) -- Line: 983
    local v171 = tonumber(p170) or 0;
    local math_floor_ret = math.floor(v171);
    local math_max_ret = math.max(0, math_floor_ret);
    local math_floor_ret2 = math.floor(math_max_ret / 3600);
    local math_floor_ret3 = math.floor(math_max_ret % 3600 / 60);

    if math_floor_ret2 > 0 then
        return string.format("Available in %dh %dm", math_floor_ret2, math_floor_ret3);
    end;

    if math_floor_ret3 > 0 then
        return string.format("Available in %dm", math_floor_ret3);
    end;

    return string.format("Available in %ds", math_max_ret);
end;

function v2.RefreshSwapButton(p172) -- Line: 996
    local SwapButton = p172.SwapButton;

    if not SwapButton then
        return;
    end;

    local _state = p172._state;
    local v173 = SwapButton:FindFirstChildWhichIsA("TextLabel", true);

    if not (_state and _state.AcademyChosen) then
        SwapButton.Visible = false;

        return;
    end;

    SwapButton.Visible = true;
    local v174 = tonumber(_state.SwapAvailableIn) or 0;

    if _state.PendingTeamSwap then
        if v173 then
            v173.Text = "Choose your team";
        end;
    elseif v174 > 0 then
        if v173 then
            v173.Text = p172:SwapCooldownText(v174);
        end;
    elseif v173 then
        v173.Text = p172:SwapPriceText();
    end;
end;

function v2.OnSwapPressed(p175) -- Line: 1016
    -- upvalues: Popup (copy), MarketplaceService (copy), LocalPlayer (copy), ProductIds (copy)
    local _state = p175._state;

    if not (_state and _state.AcademyChosen) then
        return;
    end;

    if _state.PendingTeamSwap then
        p175.MainGui.Visible = false;
        p175:OpenAcademy();

        return;
    end;

    if (tonumber(_state.SwapAvailableIn) or 0) > 0 then
        Popup.Popup(nil, p175:SwapCooldownText(_state.SwapAvailableIn));

        return;
    end;

    MarketplaceService:PromptProductPurchase(LocalPlayer, ProductIds.NEL.SwapTeam);
end;

function v2.UpdateQuestTimers(p176) -- Line: 1031
    if p176._state and p176.MainGui.Visible then
        local v177 = tonumber(p176._state.SwapAvailableIn) or 0;

        if v177 > 0 then
            p176._state.SwapAvailableIn = math.max(0, v177 - 1);
            p176:RefreshSwapButton();
        end;
    end;

    if not p176._questTimers then
        return;
    end;

    if not p176.MainGui.Visible then
        return;
    end;

    local v178 = false;

    for _, v in p176._questTimers do
        if v.label and v.label.Parent then
            local v179 = v.readyTime - os.time();

            if v179 <= 0 then
                v178 = true;
            else
                v.label.Text = v.hours and string.format("Ready in %d:%02d:%02d", math.floor(v179 / 3600), math.floor(v179 % 3600 / 60), v179 % 60) or string.format("Ready in %d:%02d", math.floor(v179 / 60), v179 % 60);
            end;
        end;
    end;

    if v178 then
        p176._questTimers = nil;
        p176:Refresh();
    end;
end;

function v2.RefreshEnabled(p180) -- Line: 1058
    -- upvalues: u1 (ref), LocalPlayer (copy)
    local Visible = p180.AcademyGui.Visible;

    if not (p180.MainGui.Visible or Visible) then
        p180.ContractGui.Visible = false;
    end;

    local v181 = (p180.PositionFrame and p180.PositionFrame.Visible) == true;
    local u182 = p180.MainGui.Visible or (p180.ContractGui.Visible or (Visible or v181));
    p180.Gui.Enabled = u182;
    p180.Darkness.Visible = p180.MainGui.Visible or (p180.ContractGui.Visible or v181);

    if u1 then
        pcall(function() -- Line: 1067
            -- upvalues: u1 (ref), u182 (copy)
            u1.setTopbarEnabled(not u182);
        end);
    end;

    local HUD = LocalPlayer.PlayerGui:FindFirstChild("HUD");

    if HUD then
        if u182 then
            HUD.Enabled = false;
            p180._hudHidden = true;
        elseif p180._hudHidden then
            p180._hudHidden = false;
            local v183 = LocalPlayer.Team ~= game:GetService("Teams").Visitor;

            if not v183 and (p180._uiController and p180._uiController.Frames) then
                for _, v in p180._uiController.Frames do
                    if v.Enabled then
                        v183 = true;
                        break;
                    end;
                end;
            end;

            if not v183 then
                local PickTeam = LocalPlayer.PlayerGui:FindFirstChild("PickTeam");
                local InGameUI = LocalPlayer.PlayerGui:FindFirstChild("InGameUI");
                v183 = PickTeam and PickTeam.Enabled and true or (InGameUI and InGameUI.Enabled and true or v183);
            end;

            if not v183 then
                HUD.Enabled = true;
            end;
        end;
    end;

    if Visible then
        p180:StartAcademyCamera();

        return;
    end;

    p180:StopAcademyCamera();
    p180:RestoreClothing();
end;

function v2.Refresh(u184) -- Line: 1097
    task.spawn(function() -- Line: 1098
        -- upvalues: u184 (copy)
        local NELState = u184.Service:GetNELState();

        if not NELState then
            return;
        end;

        u184._state = NELState;
        u184:RefreshSwapButton();
        u184:RenderSeasonPage();

        if NELState.AcademyChosen then
            u184:BindTeamHub(NELState);
            u184:BindOverallQuests(NELState);
            u184:BindNelLeaderboard(NELState);
        end;

        if u184.MainGui.Visible and u184.ContractGui.Visible then
            u184:BindContract(NELState.PendingOffer);
        end;

        u184:RefreshEnabled();
    end);
end;

function v2.Open(u185) -- Line: 1116
    task.spawn(function() -- Line: 1117
        -- upvalues: u185 (copy)
        if u185._uiController then
            u185._uiController:CloseMenus();
        end;

        local NELState = u185.Service:GetNELState();

        if not NELState then
            return;
        end;

        u185._state = NELState;
        u185:RefreshSwapButton();
        u185:RenderSeasonPage();

        if NELState.AcademyChosen and not NELState.PendingTeamSwap then
            u185:BindTeamHub(NELState);
            u185:BindOverallQuests(NELState);
            u185:BindNelLeaderboard(NELState);
            u185.MainGui.Visible = true;
            u185:Tab("TeamHub");

            if NELState.PendingOffer then
                u185:BindContract(NELState.PendingOffer);
            end;
        else
            u185.MainGui.Visible = false;
            u185:OpenAcademy();
        end;

        u185:RefreshEnabled();
    end);
end;

function v2.BindPositionPicker(u186) -- Line: 1141
    local u187 = u186.Gui and u186.Gui:WaitForChild("NELPosition", 10);

    if not u187 then
        return nil;
    end;

    if u186._positionPickerBoundGui == u187 then
        return u187;
    end;

    u186._positionPickerBoundGui = u187;
    u186.PositionFrame = u187;
    u187.Visible = false;
    local Frame = u187:FindFirstChild("Frame");

    if Frame then
        Frame = Frame:FindFirstChild("PositionList");
    end;

    if not Frame then
        return nil;
    end;

    for i, v in {
        Attacker = "Attacker",
        Midfielder = "Midfielder",
        Defender = "Defender",
        GoalKeeper = "Goalkeeper"
    } do
        local v188 = Frame:FindFirstChild(i);

        if v188 then
            v188 = v188:FindFirstChild("SelectPosition");
        end;

        if v188 then
            v188.Activated:Connect(function() -- Line: 1156
                -- upvalues: u186 (copy), u187 (copy), v (copy)
                local _positionCallback = u186._positionCallback;
                u186._positionCallback = nil;
                u187.Visible = false;
                u186:RefreshEnabled();

                if _positionCallback then
                    _positionCallback(v);
                end;
            end);
        end;
    end;

    local Header = u187:FindFirstChild("Header");

    if Header then
        Header = Header:FindFirstChild("CloseButton");
    end;

    if Header then
        Header.Activated:Connect(function() -- Line: 1168
            -- upvalues: u186 (copy), u187 (copy)
            local _positionCallback = u186._positionCallback;
            u186._positionCallback = nil;
            u187.Visible = false;
            u186:RefreshEnabled();

            if _positionCallback then
                _positionCallback(nil);
            end;
        end);
    end;

    return u187;
end;

function v2.OpenPositionPicker(p189, p190) -- Line: 1179
    local PositionFrame = p189.PositionFrame;

    if not (PositionFrame and PositionFrame.Parent) then
        PositionFrame = p189:BindPositionPicker();
    end;

    if not PositionFrame then
        return false;
    end;

    p189._positionCallback = p190;
    PositionFrame.Visible = true;
    p189:RefreshEnabled();

    return true;
end;

function v2.RenderSeasonPage(u191) -- Line: 1191
    -- upvalues: SalaryConfig (copy)
    local v192 = u191.Views and u191.Views.SeasonMatchups;

    if not (v192 and v192.Visible) then
        return;
    end;

    local _state = u191._state;
    local v193;

    if _state then
        v193 = _state.Season;
    else
        v193 = _state;
    end;

    local MatchupsFrame = v192:FindFirstChild("MatchupsFrame");

    if not MatchupsFrame then
        return;
    end;

    local SelectATeamToRepresent = v192:FindFirstChild("SelectATeamToRepresent");

    if SelectATeamToRepresent then
        local v194;

        if _state then
            v194 = _state.AcademyChosen;
        else
            v194 = _state;
        end;

        SelectATeamToRepresent.Visible = not v194;
    end;

    if not v193 then
        return;
    end;

    if _state.AcademyChosen and (v193.Position == "" and not _state.PendingOffer) then
        if not (u191.PositionFrame and u191.PositionFrame.Parent and u191.PositionFrame.Visible) then
            u191:OpenPositionPicker(function(p195) -- Line: 1204
                -- upvalues: u191 (copy)
                if p195 then
                    u191.Service:SetSeasonPosition(p195);
                end;
            end);
        end;
    end;

    local Matches = MatchupsFrame:FindFirstChild("Matches");
    local v196;

    if Matches then
        v196 = Matches:FindFirstChild("PreviousGames");
    else
        v196 = Matches;
    end;

    if v196 then
        local v197 = (v193.FixtureIndex or 1) - 1;
        local EmptyGamesLabel = Matches:FindFirstChild("EmptyGamesLabel");

        if not EmptyGamesLabel then
            EmptyGamesLabel = Instance.new("TextLabel");
            EmptyGamesLabel.Name = "EmptyGamesLabel";
            EmptyGamesLabel.BackgroundTransparency = 1;
            EmptyGamesLabel.AnchorPoint = Vector2.new(0.5, 0.5);
            EmptyGamesLabel.Position = UDim2.fromScale(0.5, 0.55);
            EmptyGamesLabel.Size = UDim2.fromScale(0.9, 0.35);
            EmptyGamesLabel.Text = "Your Last Few Games Will Appear Here";
            EmptyGamesLabel.TextScaled = true;
            EmptyGamesLabel.TextColor3 = Color3.fromRGB(180, 190, 205);
            EmptyGamesLabel.TextTransparency = 0.25;
            local ScheduleHeaderText = Matches:FindFirstChild("ScheduleHeaderText");

            if ScheduleHeaderText then
                ScheduleHeaderText = ScheduleHeaderText:FindFirstChildWhichIsA("TextLabel", true);
            end;

            if ScheduleHeaderText then
                EmptyGamesLabel.FontFace = ScheduleHeaderText.FontFace;
            end;

            EmptyGamesLabel.Parent = Matches;
        end;

        EmptyGamesLabel.Visible = v197 == 0;
        local math_max_ret = math.max(1, v197 - 5);

        for i = 1, 6 do
            local v198 = v196:FindFirstChild((tostring(i)));
            local v199;

            if v198 then
                local v200 = math_max_ret + i - 1;
                local v201;

                if v200 <= v197 then
                    v201 = v193.Fixtures[v200] or nil;
                else
                    v201 = nil;
                end;

                v198.Visible = v201 ~= nil;

                if v201 then
                    local v202 = v198:FindFirstChild("1");

                    if v202 then
                        local Opponent = v201.Opponent;
                        v202.Image = Opponent and SalaryConfig.TeamIcons[Opponent] or "";
                        local v203 = v202:FindFirstChildWhichIsA("TextLabel");

                        if v203 then
                            v203.Text = string.format("%s <font color=\"%s\">%s</font>", v201.Score, v201.Result == "W" and "rgb(0,255,0)" or "rgb(255,64,64)", v201.Result);
                            v199 = i;
                        else
                            v199 = i;
                        end;
                    else
                        v199 = i;
                    end;
                else
                    v199 = i;
                end;
            else
                v199 = i;
            end;
        end;
    end;

    local ClimbLadder = MatchupsFrame:FindFirstChild("ClimbLadder");

    if ClimbLadder then
        ClimbLadder = ClimbLadder:FindFirstChild("Ladder");
    end;

    if ClimbLadder then
        u191._seasonRankStrokes = u191._seasonRankStrokes or {};

        for _, child in ClimbLadder:GetChildren() do
            if child:IsA("Frame") then
                local v204 = child:FindFirstChildWhichIsA("UIStroke");

                if v204 then
                    if u191._seasonRankStrokes[child] == nil then
                        u191._seasonRankStrokes[child] = {
                            Color = v204.Color,
                            Thickness = v204.Thickness
                        };
                    end;

                    local v205 = u191._seasonRankStrokes[child];
                    local v206;

                    if child.Name == v193.Rank then
                        v206 = v193.Position ~= "";
                    else
                        v206 = false;
                    end;

                    v204.Color = v206 and Color3.fromRGB(255, 255, 255) or v205.Color;
                    v204.Thickness = v206 and math.max(v205.Thickness, 4) or v205.Thickness;
                end;
            end;
        end;
    end;

    local Quests = MatchupsFrame:FindFirstChild("Quests");
    local v207;

    if Quests then
        v207 = Quests:FindFirstChild("QuestsHeaderText");
    else
        v207 = Quests;
    end;

    if v207 then
        v207 = v207:FindFirstChild("QuestsText");
    end;

    if v207 then
        if v193.Position == "" then
            v207.Text = "Quests";
        else
            v207.Text = string.format("Quests (%s, %s)", ({
                Attacker = "ATK",
                Midfielder = "MID",
                Defender = "DEF",
                Goalkeeper = "GK"
            })[v193.Position] or v193.Position, (v193.SetName == nil or v193.SetName == "") and "Beginner" or (v193.SetName or "Beginner"));
        end;
    end;

    if Quests then
        Quests = Quests:FindFirstChild("List");
    end;

    if Quests then
        for i = 1, 4 do
            local v208 = Quests:FindFirstChild((tostring(i)));
            local v209;

            if v208 then
                local v210 = v193.Quests and v193.Quests[i];
                v208.Visible = v210 ~= nil;

                if v210 then
                    v209 = i;
                    local v211 = {};

                    for _, child in ipairs(v208:GetChildren()) do
                        if child:IsA("TextLabel") then
                            table.insert(v211, child);
                        end;
                    end;

                    table.sort(v211, function(p212, p213) -- Line: 1301
                        return p212.Position.Y.Scale * 1000 + p212.Position.Y.Offset < p213.Position.Y.Scale * 1000 + p213.Position.Y.Offset;
                    end);

                    if v211[1] then
                        v211[1].Text = v210.Done and "✓ " .. v210.Title or v210.Title;
                    end;

                    if v211[2] then
                        if v210.Info then
                            v211[2].TextScaled = false;
                            v211[2].TextWrapped = true;
                            v211[2].TextSize = 11;
                            v211[2].Text = v210.Desc;
                        elseif v210.Done then
                            v211[2].Text = "Completed - Resets Tomorrow";
                        else
                            v211[2].Text = string.format("%s (%d/%d)", v210.Desc, v210.Progress, v210.Goal);
                        end;
                    end;
                else
                    v209 = i;
                end;
            else
                v209 = i;
            end;
        end;
    end;

    local NextGame = MatchupsFrame:FindFirstChild("NextGame");

    if NextGame then
        NextGame = NextGame:FindFirstChild("MatchResults");
    end;

    if NextGame then
        local v214 = v193.Fixtures and v193.Fixtures[v193.FixtureIndex];
        local Team1 = NextGame:FindFirstChild("Team1");

        if Team1 then
            local CurrentTeam = _state.CurrentTeam;
            Team1.Image = CurrentTeam and SalaryConfig.TeamIcons[CurrentTeam] or "";
        end;

        local Team2 = NextGame:FindFirstChild("Team2");

        if Team2 then
            local v215;

            if v214 then
                local Opponent = v214.Opponent;
                v215 = Opponent and SalaryConfig.TeamIcons[Opponent] or "" or "";
            else
                v215 = "";
            end;

            Team2.Image = v215;
            Team2.Visible = v214 ~= nil;
        end;

        local VsText = NextGame:FindFirstChild("VsText");

        if VsText then
            VsText.Visible = v214 ~= nil;
        end;

        local YourStatus = NextGame:FindFirstChild("YourStatus");

        if YourStatus then
            YourStatus = YourStatus:FindFirstChild("List");
        end;

        if YourStatus then
            local Rank = YourStatus:FindFirstChild("Rank");

            if Rank then
                Rank.Text = v193.Position == "" and "Pick A Position!" or ("Rank: " .. string.upper(v193.RankDisplay or v193.Rank) or "Pick A Position!");
            end;

            local GamesThisSeason = YourStatus:FindFirstChild("GamesThisSeason");

            if GamesThisSeason then
                GamesThisSeason = GamesThisSeason:FindFirstChild("GamesComplete");
            end;

            if GamesThisSeason then
                GamesThisSeason.Text = "Games This Season: " .. tostring(v193.SeasonLength or 0);
            end;

            local Record = YourStatus:FindFirstChild("Record");

            if Record then
                Record = Record:FindFirstChild("CurrentRecord");
            end;

            if Record then
                Record.Text = string.format("Record: %d-%d", v193.Wins or 0, v193.Losses or 0);
            end;
        end;
    end;
end;

function v2.KnitStart(u216) -- Line: 1358
    -- upvalues: KnitClient (copy), LocalPlayer (copy), Popup (copy)
    u216.Service = KnitClient.GetService("SalaryService");
    u216._uiController = KnitClient.GetController("UIController");
    task.spawn(function() -- Line: 1361
        -- upvalues: u216 (copy)
        u216:SetupAcademyCharacters();
    end);
    u216._contractConns = {};
    local NEL = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("NEL");
    u216.Gui = NEL;
    u216.MainGui = NEL:WaitForChild("TeamLeagues");
    u216.ContractGui = NEL:WaitForChild("Contract");
    u216.AcademyGui = NEL:WaitForChild("SelectAcademy");
    local FriendLeaderboard = u216.MainGui.Frames:FindFirstChild("FriendLeaderboard");

    if FriendLeaderboard then
        FriendLeaderboard = FriendLeaderboard:FindFirstChild("ScrollingFrame");
    end;

    if FriendLeaderboard then
        for _, child in ipairs(FriendLeaderboard:GetChildren()) do
            if child:IsA("Frame") then
                child.Visible = false;
            end;
        end;
    end;

    u216.Darkness = NEL:FindFirstChild("DarknessForFrames(Optional)");

    if not u216.Darkness then
        u216.Darkness = Instance.new("Frame");
        u216.Darkness.Name = "DarknessForFrames(Optional)";
        u216.Darkness.BackgroundTransparency = 1;
        u216.Darkness.Parent = NEL;
    end;

    u216.Darkness.Visible = false;
    u216.ContractGui.Visible = false;
    u216.AcademyGui.Visible = false;
    u216.MainGui.Visible = false;
    NEL.Enabled = false;
    u216.Views = {
        TeamHub = u216.MainGui.Frames.TeamHub,
        TeamQuests = u216.MainGui.Frames.TeamQuests,
        NelLeaderboard = u216.MainGui.Frames.NelLeaderboard,
        SeasonMatchups = u216.MainGui.Frames.SeasonMatchups
    };
    u216.TabButtons = {
        TeamHub = u216.MainGui.BottomButtons.List.TeamHub,
        TeamQuests = u216.MainGui.BottomButtons.List.TeamQuests,
        NelLeaderboard = u216.MainGui.BottomButtons.List.NelLeaderboard,
        SeasonMatchups = u216.MainGui.BottomButtons.List.SeasonMatchup
    };

    for i, v in u216.TabButtons do
        v.Activated:Connect(function() -- Line: 1401
            -- upvalues: u216 (copy), i (copy)
            u216:Tab(i);
        end);
    end;

    u216:Tab("TeamHub");
    u216.SwapButton = u216.MainGui.BottomButtons:FindFirstChild("SwapTeam");

    if u216.SwapButton then
        u216.SwapButton.Activated:Connect(function() -- Line: 1407
            -- upvalues: u216 (copy)
            u216:OnSwapPressed();
        end);
    end;

    for _, v in { u216.MainGui, u216.ContractGui, u216.AcademyGui } do
        local CloseButton = v:FindFirstChild("CloseButton", true);

        if CloseButton then
            CloseButton.Activated:Connect(function() -- Line: 1415
                -- upvalues: v (copy), u216 (copy)
                v.Visible = false;
                u216:RefreshEnabled();
            end);
        end;
    end;

    LocalPlayer:GetPropertyChangedSignal("Team"):Connect(function() -- Line: 1422
        -- upvalues: LocalPlayer (ref), u216 (copy)
        if LocalPlayer.Team ~= game:GetService("Teams").Visitor then
            u216.MainGui.Visible = false;
            u216.ContractGui.Visible = false;
            u216.AcademyGui.Visible = false;

            if u216.PositionFrame then
                u216.PositionFrame.Visible = false;
            end;

            u216:RefreshEnabled();
        end;
    end);

    local function forceClose() -- Line: 1432
        -- upvalues: u216 (copy)
        if not (u216.MainGui.Visible or (u216.ContractGui.Visible or (u216.AcademyGui.Visible or (u216.PositionFrame and u216.PositionFrame.Visible) == true))) then
            return;
        end;

        u216.MainGui.Visible = false;
        u216.ContractGui.Visible = false;
        u216.AcademyGui.Visible = false;

        if u216.PositionFrame then
            u216.PositionFrame.Visible = false;
        end;

        u216:RefreshEnabled();
    end;

    if u216._uiController and u216._uiController.Frames then
        for _, v in u216._uiController.Frames do
            v:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 1443
                -- upvalues: v (copy), forceClose (copy)
                if v.Enabled then
                    forceClose();
                end;
            end);
        end;
    end;

    local PickTeam = LocalPlayer.PlayerGui:FindFirstChild("PickTeam");

    if PickTeam then
        PickTeam:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 1450
            -- upvalues: PickTeam (copy), forceClose (copy)
            if PickTeam.Enabled then
                forceClose();
            end;
        end);
    end;

    local InGameUI = LocalPlayer.PlayerGui:FindFirstChild("InGameUI");

    if InGameUI then
        InGameUI:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 1452
            -- upvalues: InGameUI (copy), forceClose (copy)
            if InGameUI.Enabled then
                forceClose();
            end;
        end);
    end;

    local NelLeaderboard = u216.MainGui.Frames:FindFirstChild("NelLeaderboard");

    if NelLeaderboard then
        local Confirmation = NelLeaderboard:FindFirstChild("Confirmation");

        if Confirmation then
            Confirmation.Visible = false;
        end;

        local button = NelLeaderboard:FindFirstChild("button");

        if button then
            button = button:FindFirstChild("Restart");
        end;

        if button and Confirmation then
            button.Activated:Connect(function() -- Line: 1462
                -- upvalues: Confirmation (copy)
                Confirmation.Visible = true;
            end);
            local Options = Confirmation:FindFirstChild("Options");
            local v217;

            if Options then
                v217 = Options:FindFirstChild("Yes");
            else
                v217 = Options;
            end;

            if Options then
                Options = Options:FindFirstChild("No");
            end;

            if v217 then
                v217.Activated:Connect(function() -- Line: 1466
                    -- upvalues: Confirmation (copy), u216 (copy)
                    Confirmation.Visible = false;
                    u216.Service:ResetTeamOfferCycle();
                    u216:Refresh();
                end);
            end;

            if Options then
                Options.Activated:Connect(function() -- Line: 1467
                    -- upvalues: Confirmation (copy)
                    Confirmation.Visible = false;
                end);
            end;
        end;
    end;

    task.spawn(function() -- Line: 1471
        -- upvalues: u216 (copy)
        u216:BindPositionPicker();
    end);
    u216.Service.NELStateUpdated:Connect(function() -- Line: 1472
        -- upvalues: u216 (copy)
        u216:Refresh();
    end);
    u216.Service.TeamOfferReady:Connect(function() -- Line: 1475
        -- upvalues: Popup (ref), u216 (copy)
        Popup.Popup(nil, "Your NEL contract is complete! Talk to the NEL NPC to renew or switch teams.", 4);
        u216:Refresh();
    end);
    u216.Service.QuestCompleted:Connect(function() -- Line: 1479
        -- upvalues: Popup (ref), u216 (copy)
        Popup.Popup(nil, "NEL Quest complete!");
        u216:Refresh();
    end);
    u216.Service.PerkRewardGranted:Connect(function() -- Line: 1483
        -- upvalues: u216 (copy)
        u216:Refresh();
    end);

    if u216.Service.NewBestCareer then
        u216.Service.NewBestCareer:Connect(function() -- Line: 1484
            -- upvalues: u216 (copy)
            u216:Refresh();
        end);
    end;

    LocalPlayer.CharacterAdded:Connect(function() -- Line: 1486
        task.wait(1);
    end);
    task.spawn(function() -- Line: 1490
        -- upvalues: LocalPlayer (ref), u216 (copy)
        workspace:WaitForChild("GameObjects"):WaitForChild("LobbyNPCs"):WaitForChild("NewEgoistNPC"):WaitForChild("HumanoidRootPart"):WaitForChild("Prox").Triggered:Connect(function(p218) -- Line: 1495
            -- upvalues: LocalPlayer (ref), u216 (ref)
            if p218 ~= LocalPlayer then
                return;
            end;

            u216:Open();
        end);
    end);
    task.spawn(function() -- Line: 1502
        -- upvalues: u216 (copy)
        while true do
            task.wait(1);
            u216:UpdateQuestTimers();
        end;
    end);
    u216:Refresh();
end;

return v2;