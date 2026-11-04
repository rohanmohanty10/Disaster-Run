 

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local JourneyConfig = require(ChickenOrHero.Progression:WaitForChild("JourneyConfig"));
local HudNavigation = require(ChickenOrHero.Presentation:WaitForChild("HudNavigation"));
local u1 = { "CreatorPanelOpen", "CreatorUIHidden", "CreatorCameraActive", "TutorialSession", "ScreenPresentationActive", "GlobalWheelOpen", "BalloonOfferOpen", "ArmoryOpen", "ServerBrowserOpen", "AdminConsoleActive", "MapVoteOpen", "MatchSummaryVisible" };

local function canOpen() -- Line: 11
    -- upvalues: JourneyConfig (copy), LocalPlayer (copy), u1 (copy)
    if not (JourneyConfig.Enabled and (JourneyConfig.Visible and (workspace:GetAttribute("JourneyVisible") ~= false and (LocalPlayer:GetAttribute("ClientReady") == true and LocalPlayer:GetAttribute("InMatch") ~= true)))) then
        return false;
    end;

    for _, v in u1 do
        if LocalPlayer:GetAttribute(v) then
            return false;
        end;
    end;

    return true;
end;

local u2 = false;

local function available() -- Line: 17
    -- upvalues: u2 (ref), HudNavigation (copy), canOpen (copy)
    if not u2 then
        HudNavigation.setAvailable("Journey", (canOpen()));
    end;
end;

local u3 = nil;

for _, v in u1 do
    LocalPlayer:GetAttributeChangedSignal(v):Connect(available);
end;

for _, v in { "ClientReady", "InMatch" } do
    LocalPlayer:GetAttributeChangedSignal(v):Connect(available);
end;

workspace:GetAttributeChangedSignal("JourneyVisible"):Connect(available);
HudNavigation.register("Journey", function() -- Line: 21
    -- upvalues: u2 (ref), u3 (ref), HudNavigation (copy)
    if u2 then
        return;
    end;

    u2 = true;
    u3();
    HudNavigation.activate("Journey");
end);

u3 = function() -- Line: 25
    local Players = game:GetService("Players");
    local MarketplaceService = game:GetService("MarketplaceService");
    local UserInputService = game:GetService("UserInputService");
    local GamepadService = game:GetService("GamepadService");
    local LocalPlayer2 = Players.LocalPlayer;
    local ChickenOrHero2 = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
    local JourneyConfig2 = require(ChickenOrHero2.Progression:WaitForChild("JourneyConfig"));
    local JourneyMath = require(ChickenOrHero2.Progression:WaitForChild("JourneyMath"));
    local SkinCatalog = require(ChickenOrHero2.Weapons:WaitForChild("SkinCatalog"));
    local CurrencyTopUp = require(ChickenOrHero2.Weapons:WaitForChild("CurrencyTopUp"));
    local EmoteCatalog = require(ChickenOrHero2:WaitForChild("Emotes"):WaitForChild("EmoteCatalog"));
    local EmotePose = require(ChickenOrHero2:WaitForChild("Interface"):WaitForChild("EmotePose"));
    local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
    local Panels = Skin.Panels;
    local Theme = Skin.Theme;
    local Palette = Skin.Palette;
    local HudNavigation2 = require(ChickenOrHero2.Presentation:WaitForChild("HudNavigation"));
    local JourneyEvent = ChickenOrHero2.Progression:WaitForChild("JourneyEvent");
    local WheelIcon = ChickenOrHero2:WaitForChild("Interface"):FindFirstChild("WheelIcon");
    local u4 = Panels.screen(LocalPlayer2, "ValleyJourney", 67);
    u4.IgnoreGuiInset = true;
    u4.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets;
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera and (workspace_CurrentCamera.ViewportSize.X < 700 or workspace_CurrentCamera.ViewportSize.Y < 500) then
        u4:SetAttribute("SelfManagedText", true);
        u4.DescendantAdded:Connect(function(u5) -- Line: 56
            if not (u5:IsA("TextLabel") or u5:IsA("TextButton")) or u5.Name:sub(1, 4) == "Skin" then
                return;
            end;

            local UITextSizeConstraint = Instance.new("UITextSizeConstraint");
            UITextSizeConstraint.Name = "PhoneCap";
            local math_round_ret = math.round(u5.TextSize * 1.25);
            UITextSizeConstraint.MaxTextSize = math.max(1, math_round_ret);
            u5.TextScaled = true;
            UITextSizeConstraint.Parent = u5;
            u5:GetPropertyChangedSignal("TextSize"):Connect(function() -- Line: 60, Name: fit
                -- upvalues: UITextSizeConstraint (copy), u5 (copy)
                local math_round_ret2 = math.round(u5.TextSize * 1.25);
                UITextSizeConstraint.MaxTextSize = math.max(1, math_round_ret2);
            end);
        end);
    end;

    local u6 = Panels.make("Frame", u4, "Shade", {
        BackgroundTransparency = 0.38,
        BorderSizePixel = 0,
        Visible = false,
        Active = false,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Panels.Ink
    });
    Panels.fullscreenShade(u4, u6);
    local u7 = Panels.make("Frame", u6, "Journal", {
        BackgroundTransparency = 0.08,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        BackgroundColor3 = Panels.Ink
    });
    Theme.surface(u7, Panels.Ink, Panels.Gold, 10, 0.62);
    Skin.shade(u6);
    Skin.panel(u7, {
        radius = UDim.new(0, 15)
    });

    local function label(p8, p9, p10, p11, p12) -- Line: 71
        -- upvalues: Panels (copy)
        local v13 = Panels.text(p8, p9, p10, 0, 0, 100, 20, p11, p12);
        v13.TextWrapped = false;
        v13.TextTruncate = Enum.TextTruncate.AtEnd;

        return v13;
    end;

    local u14 = Panels.text(u7, "Edition", "SEASON " .. JourneyConfig2.SeasonNumber .. "  /  " .. JourneyConfig2.SeasonName, 0, 0, 100, 20, 12, Panels.Gold);
    u14.TextWrapped = false;
    u14.TextTruncate = Enum.TextTruncate.AtEnd;
    local u15 = Panels.text(u7, "Heading", "VALLEY JOURNEY", 0, 0, 100, 20, 28, nil);
    u15.TextWrapped = false;
    u15.TextTruncate = Enum.TextTruncate.AtEnd;
    u15.Font = Enum.Font.GothamBold;
    local u16 = Panels.button(u7, "Close", "×", 0, 0, 40, 40);
    u16.Modal = true;
    u16.TextSize = 24;
    Skin.button(u16, "close");
    local u17 = Panels.text(u7, "EndsTimer", "", 0, 0, 100, 20, 12, Panels.Gold);
    u17.TextWrapped = false;
    u17.TextTruncate = Enum.TextTruncate.AtEnd;
    u17.Font = Enum.Font.GothamBold;
    u17.TextXAlignment = Enum.TextXAlignment.Right;
    u17.Visible = JourneyConfig2.endsIn(0) ~= nil;
    Skin.text(u17, "gold");
    local u18 = Panels.text(u7, "Tier", "TIER 1 / " .. JourneyConfig2.MaxTier, 0, 0, 100, 20, 14, Panels.Gold);
    u18.TextWrapped = false;
    u18.TextTruncate = Enum.TextTruncate.AtEnd;
    u18.Font = Enum.Font.GothamBold;
    local u19 = Panels.text(u7, "XP", "Earn XP by playing matches", 0, 0, 100, 20, 12, Panels.Muted);
    u19.TextWrapped = false;
    u19.TextTruncate = Enum.TextTruncate.AtEnd;
    local u20 = Panels.make("Frame", u7, "Progress", {
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(39, 57, 68)
    });
    Panels.corner(u20, 3);
    local u21 = Panels.make("Frame", u20, "Fill", {
        BorderSizePixel = 0,
        Size = UDim2.fromScale(0, 1),
        BackgroundColor3 = Panels.Gold
    });
    Panels.corner(u21, 3);
    Skin.bar(u20, u21, "xp");
    local u22 = Panels.button(u7, "TrackTab", "REWARDS", 0, 0, 110, 32);
    local u23 = Panels.button(u7, "BadgesTab", "MY TITLES", 0, 0, 110, 32);
    local u24 = Panels.button(u7, "FreeLane", "FREE", 0, 0, 84, 30);
    local u25 = Panels.button(u7, "PremiumLane", "PREMIUM", 0, 0, 104, 30);
    local u26 = Panels.make("ScrollingFrame", u7, "Track", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Active = true,
        ScrollBarThickness = 4,
        ClipsDescendants = true,
        CanvasSize = UDim2.new(),
        ScrollingDirection = Enum.ScrollingDirection.X,
        ScrollBarImageColor3 = Panels.Gold
    });
    local u27 = Panels.make("ScrollingFrame", u7, "Badges", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Active = true,
        Visible = false,
        ScrollBarThickness = 4,
        ClipsDescendants = true,
        CanvasSize = UDim2.new(),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y
    });
    local u28 = Panels.make("UIGridLayout", u27, "Grid", {
        CellSize = UDim2.fromOffset(190, 112),
        CellPadding = UDim2.fromOffset(10, 10),
        SortOrder = Enum.SortOrder.LayoutOrder
    });

    local function tabs() -- Line: 97
        -- upvalues: Skin (copy), u22 (copy), u26 (copy), u23 (copy), u27 (copy)
        Skin.tab(u22, u26.Visible);
        Skin.tab(u23, u27.Visible);
    end;

    Skin.tab(u22, u26.Visible);
    Skin.tab(u23, u27.Visible);
    Skin.scroll(u26);
    Skin.scroll(u27);
    local u29 = Panels.button(u7, "ClaimAll", "CLAIM ALL", 0, 0, 220, 42, Color3.fromRGB(61, 99, 88));
    local u30 = Panels.button(u7, "Premium", "CHECKING PREMIUM…", 0, 0, 280, 42, Color3.fromRGB(69, 51, 93));
    local u31 = Panels.button(u7, "Rebirth", "REBIRTH", 0, 0, 220, 42, Color3.fromRGB(69, 51, 93));
    local u32 = Panels.button(u7, "RebirthCoins", "REBIRTH", 0, 0, 220, 42, Color3.fromRGB(81, 67, 39));
    local u33 = 0;
    local u34 = nil;
    local u35 = nil;
    local u36 = 0;
    local u37 = nil;
    Skin.button(u30, "robux");
    local u38 = nil;
    local u39 = Panels.text(u7, "Policy", "Season progress restarts next season. Player level and earned items stay.", 0, 0, 100, 20, 11, Panels.Muted);
    u39.TextWrapped = false;
    u39.TextTruncate = Enum.TextTruncate.AtEnd;
    local u40 = Panels.text(u7, "Notice", "One claim collects every unlocked reward. Swipe the track →", 0, 0, 100, 20, 12, Panels.Muted);
    u40.TextWrapped = false;
    u40.TextTruncate = Enum.TextTruncate.AtEnd;
    local u41 = {
        loaded = false,
        tier = 1,
        xp = 0,
        premium = false,
        claims = {},
        badges = {}
    };
    local u42 = {};
    local u43 = {};
    local u44 = {};
    local u45 = false;
    local u46 = nil;
    local u47 = false;
    local u48 = false;
    local u49 = "Free";
    local u50 = false;
    local u51 = nil;

    local function lanes() -- Line: 117
        -- upvalues: Skin (copy), u24 (copy), u49 (ref), u25 (copy)
        Skin.tab(u24, u49 == "Free");
        Skin.tab(u25, u49 == "Premium");
    end;

    Skin.tab(u24, u49 == "Free");
    Skin.tab(u25, u49 == "Premium");
    local u52 = 218;
    local u53 = nil;
    local u54 = nil;
    local u55 = false;

    local function complete(p56) -- Line: 121
        -- upvalues: u41 (ref), JourneyConfig2 (copy)
        local v57;

        if u41.claims[JourneyConfig2.TrackId .. ":" .. p56.Key] == true and (not p56.EmoteId or (u41.emotes or {})[p56.EmoteId] == true) then
            v57 = not p56.SkinId or (u41.skins or {})[p56.SkinId] == true;
        else
            v57 = false;
        end;

        return v57;
    end;

    local function signature(p58) -- Line: 127
        return table.concat({
            p58.SkinId or "",
            p58.EmoteId or "",
            p58.Badge or "",
            tostring(p58.Spins or 0),
            p58.Icon or "",
            tostring(p58.CandyCorn or 0),
            tostring(p58.Keys or 0),
            p58.Note or ""
        }, "|");
    end;

    local function rewardText(p59) -- Line: 130
        -- upvalues: SkinCatalog (copy), EmoteCatalog (copy), JourneyConfig2 (copy)
        local v60 = {};

        if p59.SkinId then
            local v61 = SkinCatalog.get(p59.SkinId);
            table.insert(v60, v61 and v61.Name or "EXCLUSIVE DAGGER");
        elseif p59.KnifeSlot then
            table.insert(v60, "DAGGER SLOT · COMING LATER");
        end;

        if p59.EmoteId then
            local v62 = EmoteCatalog.get(p59.EmoteId);
            local v63 = string.upper(v62 and v62.Name or "NEW") .. " EMOTE";
            table.insert(v60, v63);
        end;

        if p59.Badge and JourneyConfig2.Badges[p59.Badge] then
            table.insert(v60, "TITLE: " .. JourneyConfig2.Badges[p59.Badge].Name);
        end;

        if (p59.Spins or 0) > 0 then
            table.insert(v60, "+" .. p59.Spins .. (p59.Spins == 1 and " WHEEL SPIN" or " WHEEL SPINS"));
        end;

        if (p59.Keys or 0) > 0 then
            table.insert(v60, "x" .. p59.Keys .. (p59.Keys == 1 and " EMOTE CRATE KEY" or " EMOTE CRATE KEYS"));
        end;

        if p59.Note then
            table.insert(v60, p59.Note);
        end;

        local v64 = {};

        if (p59.Gems or 0) > 0 then
            table.insert(v64, "+" .. p59.Gems .. " GEMS");
        end;

        if (p59.Coins or 0) > 0 then
            table.insert(v64, "+" .. p59.Coins .. " COINS");
        end;

        if (p59.CandyCorn or 0) > 0 then
            table.insert(v64, "+" .. p59.CandyCorn .. " CANDY CORN");
        end;

        if #v64 > 0 then
            table.insert(v60, table.concat(v64, "  ·  "));
        end;

        if #v60 == 0 and p59.Owned then
            table.insert(v60, "ALREADY OWNED");
        end;

        return table.concat(v60, "\n");
    end;

    local function imageArt(p65, p66) -- Line: 153
        -- upvalues: Panels (copy)
        local v67 = Panels.make("Frame", p65, "RewardArt", {
            BackgroundTransparency = 1
        });
        Panels.make("ImageLabel", v67, "Picture", {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            ScaleType = Enum.ScaleType.Fit,
            Image = p66
        });

        return v67;
    end;

    local function makeArt(p68, p69, p70) -- Line: 160
        -- upvalues: Panels (copy), ChickenOrHero2 (copy), Skin (copy), JourneyConfig2 (copy), imageArt (copy), WheelIcon (copy)
        local v71 = nil;
        local v72 = nil;
        local u73;

        if p69.SkinId then
            u73 = Panels.make("ViewportFrame", p68, "RewardArt", {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                LightDirection = Vector3.new(-1, -1, -1),
                Ambient = Color3.fromRGB(210, 210, 218),
                LightColor = Color3.fromRGB(255, 245, 227)
            });
            local Models = ChickenOrHero2.Weapons:FindFirstChild("Models");

            if Models then
                Models = Models:FindFirstChild(p69.SkinId);
            end;

            if Models and Models:IsA("Model") then
                v72 = function() -- Line: 166
                    -- upvalues: Models (copy), u73 (ref)
                    local v74 = Models:Clone();

                    for _, descendant in v74:GetDescendants() do
                        if descendant:IsA("LuaSourceContainer") or (descendant:IsA("Sound") or (descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or (descendant:IsA("Beam") or descendant:IsA("Light"))))) then
                            descendant:Destroy();
                        elseif descendant:IsA("BasePart") then
                            if descendant.Transparency >= 0.99 or descendant.Name:find("Stowed", 1, true) then
                                descendant:Destroy();
                            else
                                descendant.Anchored = true;
                            end;
                        end;
                    end;

                    v74.Parent = u73;
                    local BoundingBox, v75 = v74:GetBoundingBox();
                    local Camera = Instance.new("Camera");
                    Camera.FieldOfView = 35;
                    local Blade = v74:FindFirstChild("Blade");
                    local Attribute = Models:GetAttribute("ThumbAxis");
                    local Attribute2 = Models:GetAttribute("ThumbNormal");

                    if Blade and (typeof(Attribute) == "Vector3" and (typeof(Attribute2) == "Vector3" and (Attribute.Magnitude > 0 and Attribute2.Magnitude > 0))) then
                        local Unit = Blade.CFrame:VectorToWorldSpace(Attribute).Unit;
                        local v76 = Blade.CFrame:VectorToWorldSpace(Attribute2);
                        local Unit2 = (v76 - Unit * v76:Dot(Unit)).Unit;
                        local v77 = Unit2:Cross(Unit);
                        Camera.CFrame = CFrame.fromMatrix(BoundingBox.Position + Unit2 * math.max(1, v75.Magnitude) * 0.85, Unit * 0.9396926207859084 - v77 * 0.3420201433256687, Unit * 0.3420201433256687 + v77 * 0.9396926207859084, Unit2);
                    else
                        Camera.CFrame = CFrame.lookAt(BoundingBox.Position + (Vector3.new(0.5, 0.25, 1)).Unit * math.max(1, v75.Magnitude) * 0.95, BoundingBox.Position);
                    end;

                    Camera.Parent = u73;
                    u73.CurrentCamera = Camera;
                end;
            end;
        elseif p69.EmoteId then
            u73 = Panels.make("ViewportFrame", p68, "RewardArt", {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                LightDirection = Vector3.new(-1, -1, -1),
                Ambient = Color3.fromRGB(210, 210, 218),
                LightColor = Color3.fromRGB(255, 245, 227)
            });
            v71 = Panels.text(u73, "Fallback", "☺", 0, 0, 100, 20, 34, Panels.Purple);
            v71.TextWrapped = false;
            v71.TextTruncate = Enum.TextTruncate.AtEnd;
            v71.Font = Enum.Font.GothamBold;
            v71.Size = UDim2.fromScale(1, 1);
            v71.TextXAlignment = Enum.TextXAlignment.Center;
            v71.TextYAlignment = Enum.TextYAlignment.Center;
            v71.TextScaled = true;
            Skin.icon(v71, "emote");
        elseif p69.Badge and JourneyConfig2.Badges[p69.Badge] then
            local v78 = JourneyConfig2.Badges[p69.Badge];
            local v79 = Panels.text(p68, "RewardArt", v78.Icon or "✦", 0, 0, 100, 20, 34, v78.Color or p70);
            v79.TextWrapped = false;
            v79.TextTruncate = Enum.TextTruncate.AtEnd;
            u73 = v79;
            u73.Font = Enum.Font.GothamBold;
            u73.TextXAlignment = Enum.TextXAlignment.Center;
            u73.TextYAlignment = Enum.TextYAlignment.Center;
            u73.TextScaled = true;
        elseif (p69.Keys or 0) > 0 then
            local v80 = require(ChickenOrHero2.Crates.CrateCatalog).get(p69.KeyCrate or "HalloweenEmote");
            local CrateModels = ChickenOrHero2.Crates:FindFirstChild("CrateModels");
            local v81;

            if v80 and (type(v80.Icon) == "string" and v80.Icon ~= "") then
                v81 = v80.Icon or nil;
            else
                v81 = nil;
            end;

            local v82 = not v81;

            if v82 then
                if v80 then
                    if CrateModels then
                        CrateModels = CrateModels:FindFirstChild(v80.WorldModel);
                    end;
                else
                    CrateModels = v80;
                end;
            else
                CrateModels = v82;
            end;

            if CrateModels then
                u73 = Panels.make("ViewportFrame", p68, "RewardArt", {
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LightDirection = Vector3.new(-1, -1, -1),
                    Ambient = Color3.fromRGB(200, 195, 210),
                    LightColor = Color3.fromRGB(255, 245, 227)
                });

                v72 = function() -- Line: 205
                    -- upvalues: CrateModels (copy), u73 (ref)
                    local v83 = CrateModels:Clone();
                    v83.Parent = u73;
                    local BoundingBox, v84 = v83:GetBoundingBox();
                    local Attribute = CrateModels:GetAttribute("Front");
                    local v85 = typeof(Attribute) == "Vector3" and Attribute.Magnitude > 0 and (Attribute.Unit or Vector3.new(0, 0, -1)) or Vector3.new(0, 0, -1);
                    local Camera = Instance.new("Camera");
                    Camera.FieldOfView = 35;
                    Camera.CFrame = CFrame.lookAt(BoundingBox.Position + (v85 + Vector3.new(0, 0.15, 0)).Unit * math.max(v84.X, v84.Y, v84.Z) * 1.75, BoundingBox.Position);
                    Camera.Parent = u73;
                    u73.CurrentCamera = Camera;
                end;
            else
                u73 = imageArt(p68, v81 or "");
            end;
        elseif (p69.CandyCorn or 0) > 0 then
            u73 = imageArt(p68, require(ChickenOrHero2.Game.CandyCorn).Icon);
        elseif (p69.Spins or 0) > 0 and WheelIcon then
            u73 = Panels.make("Frame", p68, "RewardArt", {
                BackgroundTransparency = 1
            });
            WheelIcon:Clone().Parent = u73;
        elseif (p69.Gems or 0) > 0 then
            u73 = imageArt(p68, "rbxassetid://137046122108742");
        elseif (p69.Coins or 0) > 0 then
            u73 = imageArt(p68, "rbxassetid://78008558948307");
        else
            local v86 = Panels.text(p68, "RewardArt", p69.KnifeSlot and "?" or "✦", 0, 0, 100, 20, 34, p70);
            v86.TextWrapped = false;
            v86.TextTruncate = Enum.TextTruncate.AtEnd;
            u73 = v86;
            u73.Font = Enum.Font.GothamBold;
            u73.TextXAlignment = Enum.TextXAlignment.Center;
            u73.TextScaled = true;
        end;

        return u73, v71, v72;
    end;

    local function show3D(p87, p88) -- Line: 232
        if p88 and (p87.fill and not p87.filled) then
            p87.filled = true;
            local success, result = pcall(p87.fill);

            if not success then
                warn("[Journey] reward art failed: " .. tostring(result));
            end;
        elseif not p88 and p87.filled then
            p87.filled = false;

            for _, child in p87.art:GetChildren() do
                if not child:IsA("GuiObject") then
                    child:Destroy();
                end;
            end;

            p87.art.CurrentCamera = nil;
        end;
    end;

    local u89 = nil;

    local function claim(p90, p91) -- Line: 246
        -- upvalues: u50 (ref), u41 (ref), u40 (copy), u89 (ref), JourneyEvent (copy), JourneyConfig2 (copy)
        if u50 or not u41.loaded then
            return;
        end;

        u50 = true;
        u40.Text = "Saving your rewards…";
        u89();
        JourneyEvent:FireServer(p90, p91, JourneyConfig2.SeasonId);
        task.delay(10, function() -- Line: 250
            -- upvalues: u50 (ref), u40 (ref), u89 (ref)
            if u50 then
                u50 = false;
                u40.Text = "Still waiting for confirmation. You can retry safely.";
                u89();
            end;
        end);
    end;

    local u92 = nil;

    for i, v in JourneyConfig2.Rewards do
        local v93 = Panels.make("Frame", u26, "Tier" .. i, {
            BackgroundTransparency = 1
        });
        local v94 = Panels.text(v93, "Tier", "TIER " .. i, 0, 0, 100, 20, 12, Panels.Gold);
        v94.TextWrapped = false;
        v94.TextTruncate = Enum.TextTruncate.AtEnd;
        v94.Font = Enum.Font.GothamBold;
        local v95 = i;
        local v96 = v;

        for _, v2 in { "Free", "Premium" } do
            local u97 = v96[v2];

            if u97 then
                local v98 = Panels.make("Frame", v93, v2, {
                    BackgroundTransparency = 0.22,
                    BorderSizePixel = 0
                });
                local v99 = v2 == "Free" and Panels.Blue or Panels.Purple;
                Theme.surface(v98, Panels.Ink:Lerp(v99, 0.1), v99, 7, 0.72);
                Skin.card(v98, v99, {
                    radius = UDim.new(0, 10)
                });
                local v100 = v2:upper();
                local v101 = Panels.text(v98, "Route", v100, 0, 0, 100, 20, 10, v99);
                v101.TextWrapped = false;
                v101.TextTruncate = Enum.TextTruncate.AtEnd;
                local v102 = Panels.text(v98, "Reward", rewardText(u97), 12, 29, 172, 52, 12);
                v102.Font = Enum.Font.GothamBold;
                local v103, v104, v105 = makeArt(v98, u97, v99);
                local u106 = Panels.button(v98, "Claim", "LOCKED", 10, 88, 180, 32);
                u106.TextSize = 11;
                local Key = u97.Key;
                local v107 = {
                    button = u106,
                    reward = u97,
                    shown = u97,
                    sig = signature(u97),
                    accent = v99,
                    tier = v95,
                    lane = v2,
                    column = v93,
                    card = v98,
                    number = v94,
                    label = v102,
                    route = v101,
                    art = v103
                };
                local v108;

                if u97.SkinId then
                    v108 = nil;
                else
                    v108 = u97.EmoteId or nil;
                end;

                v107.emote = v108;
                v107.glyph = v104;
                v107.fill = v105;
                u42[Key] = v107;
                u106.InputBegan:Connect(function(p109) -- Line: 267
                    -- upvalues: u51 (ref), u106 (copy), u26 (copy)
                    if p109.UserInputType == Enum.UserInputType.Touch or p109.UserInputType == Enum.UserInputType.MouseButton1 then
                        u51 = {
                            input = p109,
                            button = u106,
                            position = Vector2.new(p109.Position.X, p109.Position.Y),
                            canvas = u26.CanvasPosition
                        };
                    end;
                end);
                u106.Activated:Connect(function(p110) -- Line: 270
                    -- upvalues: u106 (copy), u51 (ref), u26 (copy), claim (copy), u97 (copy)
                    if not u106.Active then
                        return;
                    end;

                    if p110 and (p110.UserInputType == Enum.UserInputType.Touch or p110.UserInputType == Enum.UserInputType.MouseButton1) and (u51 and (u51.button == u106 and (u51.dragged or (u26.CanvasPosition - u51.canvas).Magnitude > 6))) then
                        return;
                    end;

                    claim("Claim", u97.Key);
                end);
            end;
        end;
    end;

    UserInputService.InputChanged:Connect(function(p111) -- Line: 279
        -- upvalues: u51 (ref)
        if u51 and (p111 == u51.input or p111.UserInputType == Enum.UserInputType.MouseMovement) and (Vector2.new(p111.Position.X, p111.Position.Y) - u51.position).Magnitude > 10 then
            u51.dragged = true;
        end;
    end);
    local v112 = {};

    for i in JourneyConfig2.Badges do
        table.insert(v112, i);
    end;

    table.sort(v112);

    for i, v in v112 do
        local v113 = JourneyConfig2.Badges[v];
        local v114 = Panels.make("Frame", u27, v, {
            BorderSizePixel = 0,
            BackgroundColor3 = Panels.Ink:Lerp(v113.Color, 0.1),
            LayoutOrder = i
        });
        Panels.corner(v114, 7);
        Skin.card(v114, v113.Color);
        local v115 = Panels.text(v114, "Title", v113.Icon .. "  " .. v113.Name, 12, 10, 160, 40, 13, v113.Color);
        v115.Font = Enum.Font.GothamBold;
        v115.Size = UDim2.new(1, -24, 0, 40);
        local u116 = Panels.button(v114, "Equip", "LOCKED", 12, 64, 160, 34);
        u116.Size = UDim2.new(1, -24, 0, 34);
        u116.TextSize = 11;
        u43[v] = u116;
        u116.Activated:Connect(function() -- Line: 290
            -- upvalues: u116 (copy), JourneyEvent (copy), u41 (ref), v (copy)
            if u116.Active then
                JourneyEvent:FireServer("EquipBadge", u41.badge == v and "" or v);
            end;
        end);
    end;

    u89 = function() -- Line: 292
        -- upvalues: u41 (ref), u14 (copy), JourneyConfig2 (copy), u42 (copy), signature (copy), makeArt (copy), u45 (ref), rewardText (copy), u92 (ref), JourneyMath (copy), u18 (copy), u21 (copy), u19 (copy), complete (copy), u50 (ref), Skin (copy), Palette (copy), u29 (copy), u38 (ref), u43 (copy), u44 (copy), u48 (ref), u30 (copy), u32 (copy), u33 (ref), u34 (ref), u31 (copy), u35 (ref), MarketplaceService (copy), u89 (ref), u36 (ref), u37 (ref)
        local v117 = u41.rebirths or 0;
        u14.Text = "SEASON " .. JourneyConfig2.SeasonNumber .. "  /  " .. JourneyConfig2.SeasonName .. (v117 > 0 and ("  ·  REBIRTH " .. v117 or "") or "");
        local v118 = {
            skins = u41.skins,
            emotes = u41.emotes,
            badges = u41.badges
        };
        local v119 = false;

        for _, v in u42 do
            local v120 = JourneyConfig2.effective(v.reward, v117, v118);

            if signature(v120) ~= v.sig then
                if v.pose then
                    v.pose:destroy();
                    v.pose = nil;
                end;

                v.tried = nil;
                v.art:Destroy();
                local v121, v122, v123 = makeArt(v.card, v120, v.accent);
                v.art = v121;
                v.glyph = v122;
                v.fill = v123;
                v.filled = false;

                if u45 and (v.fill and not v.filled) then
                    v.filled = true;
                    local success, result = pcall(v.fill);

                    if not success then
                        warn("[Journey] reward art failed: " .. tostring(result));
                    end;
                end;

                local v124;

                if v120.SkinId then
                    v124 = nil;
                else
                    v124 = v120.EmoteId or nil;
                end;

                v.emote = v124;
                v.label.Text = rewardText(v120);
                local v125 = signature(v120);
                v.shown = v120;
                v.sig = v125;
                v119 = true;
            end;
        end;

        if v119 and u92 then
            u92();
        end;

        local v126 = JourneyMath.state(u41.xp, JourneyConfig2);
        u18.Text = "TIER " .. v126.tier .. " / " .. JourneyConfig2.MaxTier;
        u21.Size = UDim2.fromScale(v126.ratio, 1);
        u19.Text = v126.complete and "SEASON TRACK COMPLETE" or string.format("%d / %d SEASON XP · NEXT TIER", v126.earned, v126.needed);
        local v127 = 0;

        for _, v in u42 do
            local v128 = complete(v.reward);
            local loaded = u41.loaded;

            if loaded then
                if (u41.tier or 1) >= v.tier then
                    loaded = v.lane == "Free" and true or u41.premium;
                else
                    loaded = false;
                end;
            end;

            if loaded and not v128 then
                v127 = v127 + 1;
            end;

            v.button.Text = v128 and "COLLECTED ✓" or (u41.loaded and ((u41.tier or 1) < v.tier and "TIER " .. v.tier or (v.lane == "Premium" and not u41.premium and "SEASON PREMIUM" or "CLAIM THROUGH HERE")) or "LOADING…");
            v.button.Active = loaded and not v128 and not u50;
            v.button.AutoButtonColor = v.button.Active;
            local v129 = v128 and "dark" or (loaded and "primary" or (v.lane == "Premium" and not u41.premium and "robux" or "secondary"));

            if v.look ~= v129 then
                v.look = v129;
                Skin.button(v.button, v129);
                Skin.select(v.button, v128, Palette.green);
                Skin.select(v.card, v128, Palette.green);
            end;
        end;

        u29.Text = u50 and "SAVING…" or (v127 > 0 and ("CLAIM ALL  ·  " .. v127 or "ALL COLLECTED ✓") or "ALL COLLECTED ✓");

        if not u41.loaded then
            u29.Text = "LOADING…";
        end;

        local loaded = u41.loaded;

        if loaded then
            if v127 > 0 then
                loaded = not u50;
            else
                loaded = false;
            end;
        end;

        u29.Active = loaded;
        u29.AutoButtonColor = u29.Active;
        local v130 = u29.Active and "primary" or "secondary";

        if u38 ~= v130 then
            u38 = v130;
            Skin.button(u29, v130);
        end;

        for i, v in u43 do
            v.Text = u41.badge == i and "EQUIPPED · REMOVE" or (u41.badges[i] and "EQUIP" or "LOCKED");
            v.Active = u41.badges[i] == true;
            v.AutoButtonColor = v.Active;
            v.Parent.Visible = v.Active or not JourneyConfig2.Badges[i].Hidden;
            local v131 = u41.badge == i and "unequip" or (u41.badges[i] and "equip" or "locked");

            if u44[i] ~= v131 then
                u44[i] = v131;
                Skin.button(v, v131);
            end;
        end;

        local v132;

        if JourneyConfig2.PremiumPassId > 0 then
            v132 = JourneyConfig2.PurchasesEnabledUniverses[game.GameId] == true;
        else
            v132 = false;
        end;

        local v133;

        if type(u48) == "table" and u48.IsForSale == true then
            v133 = type(u48.PriceInRobux) == "number";
        else
            v133 = false;
        end;

        u30.Text = u41.premium and "SEASON " .. JourneyConfig2.SeasonNumber .. " PREMIUM ✓" or (v132 and (v133 and "SEASON PREMIUM ·  " .. u48.PriceInRobux or "PREMIUM UNAVAILABLE") or "SEASON PREMIUM · PREVIEW");
        local v134 = not u41.premium;

        if v134 then
            if not v132 then
                v133 = v132;
            end;
        else
            v133 = v134;
        end;

        u30.Active = v133;
        u30.AutoButtonColor = u30.Active;
        local v135 = u41.rebirthCoins or JourneyConfig2.RebirthCoins;
        u32.Text = os.clock() < u33 and "RESTART AT TIER 1?" or "REBIRTH  ·  " .. tostring(v135):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. " COINS";
        u32.Active = u41.loaded and not u50;
        u32.AutoButtonColor = u32.Active;
        local v136 = u32.Active and "buy-coins" or "secondary";

        if u34 ~= v136 then
            u34 = v136;
            Skin.button(u32, v136);
        end;

        local rebirthProductId = u41.rebirthProductId;

        if u31.Visible ~= (rebirthProductId ~= nil) then
            u31.Visible = rebirthProductId ~= nil;

            if u92 then
                task.defer(u92);
            end;
        end;

        if rebirthProductId and u35 == nil then
            u35 = "loading";
            task.spawn(function() -- Line: 346
                -- upvalues: MarketplaceService (ref), rebirthProductId (copy), u35 (ref), u89 (ref)
                local success, result = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, rebirthProductId, Enum.InfoType.Product);

                if not (success and (type(result) == "table" and result)) then
                    result = false;
                end;

                u35 = result;
                u89();
            end);
        end;

        local v137;

        if type(u35) == "table" and (u35.IsForSale == true and type(u35.PriceInRobux) == "number") then
            v137 = u35.PriceInRobux;
        else
            v137 = false;
        end;

        u31.Text = os.clock() < u36 and "RESTART AT TIER 1?" or (v137 and ("REBIRTH  ·  " .. utf8.char(57346) .. " " .. v137 or "REBIRTH") or "REBIRTH");
        local v138 = u41.loaded and not u50;

        if v138 then
            if v137 == nil then
                v138 = false;
            else
                v138 = v137 ~= false;
            end;
        end;

        u31.Active = v138;
        u31.AutoButtonColor = u31.Active;
        local v139 = u31.Active and "robux" or "secondary";

        if u37 ~= v139 then
            u37 = v139;
            Skin.button(u31, v139);
        end;
    end;

    local function nearView(p140) -- Line: 359
        -- upvalues: u26 (copy), u52 (ref)
        local X = u26.CanvasPosition.X;
        local Offset = p140.column.Position.X.Offset;
        local v141;

        if Offset + u52 >= X - u52 then
            v141 = Offset <= X + u26.AbsoluteSize.X + u52;
        else
            v141 = false;
        end;

        return v141;
    end;

    local function syncPoses() -- Line: 363
        -- upvalues: u42 (copy), u45 (ref), u26 (copy), u52 (ref), EmotePose (copy)
        for _, v in u42 do
            if v.emote then
                local v142 = u45 and u26.Visible and (v.card.Visible and v.art.Visible);

                if v142 then
                    local X = u26.CanvasPosition.X;
                    local Offset = v.column.Position.X.Offset;

                    if Offset + u52 >= X - u52 then
                        v142 = Offset <= X + u26.AbsoluteSize.X + u52;
                    else
                        v142 = false;
                    end;
                end;

                if v142 and not (v.pose or v.tried) then
                    v.tried = true;
                    local success, result = pcall(EmotePose.new, v.art, v.emote);
                    local v143;

                    if success then
                        v.pose = result;
                        v143 = v;
                    else
                        v143 = v;

                        for _, child in v.art:GetChildren() do
                            if child ~= v143.glyph then
                                child:Destroy();
                            end;
                        end;

                        v143.art.CurrentCamera = nil;
                    end;

                    v143.glyph.Visible = v143.pose == nil;
                elseif not v142 then
                    if v.pose then
                        v.pose:destroy();
                        v.pose = nil;
                        v.glyph.Visible = true;
                    end;

                    v.tried = nil;
                end;
            end;
        end;
    end;

    local function layout() -- Line: 382
        -- upvalues: u4 (copy), u7 (copy), u17 (copy), u14 (copy), u15 (copy), u16 (copy), u18 (copy), u19 (copy), u20 (copy), u22 (copy), u23 (copy), u26 (copy), u25 (copy), u24 (copy), u27 (copy), u52 (ref), u42 (copy), u49 (ref), JourneyConfig2 (copy), u28 (copy), u29 (copy), u30 (copy), u32 (copy), u31 (copy), u40 (copy), u39 (copy), syncPoses (copy)
        local AbsoluteSize = u4.AbsoluteSize;

        if AbsoluteSize.X <= 0 or AbsoluteSize.Y <= 0 then
            return;
        end;

        local math_min_ret = math.min(1040, AbsoluteSize.X * 0.94);
        local math_min_ret2 = math.min(640, AbsoluteSize.Y * 0.92);
        local v144 = math_min_ret < 520;
        local v145 = math_min_ret2 < 440;
        u7.Size = UDim2.fromOffset(math_min_ret, math_min_ret2);
        local v146 = v144 and 14 or 22;
        local v147 = math_min_ret - v146 * 2;
        local v148 = u17.Visible and (v144 and 96 or 150) or 0;
        local v149 = v147 - 48 - (v148 > 0 and (v148 + 8 or 0) or 0);
        u14.Position = UDim2.fromOffset(v146, 12);
        u14.Size = UDim2.fromOffset(v149, 18);
        u14.TextSize = v145 and 10 or 12;
        u15.Position = UDim2.fromOffset(v146, 31);
        u15.Size = UDim2.fromOffset(v149, 33);
        u15.TextSize = v144 and 23 or (v145 and 24 or 28);
        u16.Position = UDim2.fromOffset(math_min_ret - v146 - 40, 12);
        u17.Position = UDim2.fromOffset(math_min_ret - v146 - 48 - v148, 22);
        u17.Size = UDim2.fromOffset(v148, 20);
        u17.TextSize = v144 and 10 or 12;
        u18.Position = UDim2.fromOffset(v146, v145 and 64 or 73);
        u18.Size = UDim2.fromOffset(126, 20);
        u18.TextSize = v145 and 12 or 14;
        u19.Position = UDim2.fromOffset(v146 + 132, v145 and 64 or 73);
        u19.Size = UDim2.fromOffset(v147 - 132, 20);
        u19.TextSize = v144 and 10 or 12;
        u20.Position = UDim2.fromOffset(v146, v145 and 89 or 101);
        u20.Size = UDim2.fromOffset(v147, 4);
        local v150 = v145 and 100 or 115;
        u22.Position = UDim2.fromOffset(v146, v150);
        u23.Position = UDim2.fromOffset(v146 + 100, v150);
        u22.Size = UDim2.fromOffset(92, 30);
        u23.Size = UDim2.fromOffset(92, 30);
        local v151;

        if v145 then
            v151 = u26.Visible;
        else
            v151 = v145;
        end;

        u25.Position = UDim2.fromOffset(math_min_ret - v146 - 104, v150);
        u25.Size = UDim2.fromOffset(104, 30);
        u25.Visible = v151;
        u24.Position = UDim2.fromOffset(math_min_ret - v146 - 104 - 8 - 84, v150);
        u24.Size = UDim2.fromOffset(84, 30);
        u24.Visible = v151;
        local v152 = v150 + 42;
        local v153 = math_min_ret2 - v152 - (v145 and 74 or 102);
        u26.Position = UDim2.fromOffset(v146, v152);
        u26.Size = UDim2.fromOffset(v147, v153);
        u27.Position = u26.Position;
        u27.Size = u26.Size;
        local v154 = v145 and 210 or (v144 and 200 or 218);
        u52 = v154;
        local v155 = v145 and v153 - 8 or (v153 - 34) / 2;

        for _, v in u42 do
            v.column.Position = UDim2.fromOffset((v.tier - 1) * (v154 + 12), 0);
            v.column.Size = UDim2.fromOffset(v154, v153 - 6);
            v.number.Visible = not v145;
            v.number.Size = UDim2.fromOffset(v154, 20);
            v.card.Visible = not v145 or v.lane == u49;
            v.card.Size = UDim2.fromOffset(v154, v155);
            v.card.Position = UDim2.fromOffset(0, v145 and 0 or (v.lane == "Free" and 24 or v155 + 32));
            v.route.Text = v145 and "TIER " .. v.tier .. "  /  " .. v.lane:upper() or v.lane:upper();
            v.route.Position = UDim2.fromOffset(12, 7);
            v.route.Size = UDim2.fromOffset(v154 - 24, 15);
            local v156 = v145 and 20 or 24;
            local math_max_ret = math.max(30, v155 - 20 - v156 - 32);
            v.art.Visible = true;
            v.art.Position = UDim2.fromOffset(8, 20);
            v.art.Size = UDim2.fromOffset(v154 - 16, math_max_ret);
            v.label.Position = UDim2.fromOffset(10, math_max_ret + 20);
            v.label.Size = UDim2.fromOffset(v154 - 20, v156);
            v.label.TextScaled = true;
            v.label.TextWrapped = true;
            v.label.TextXAlignment = Enum.TextXAlignment.Center;
            v.button.Position = UDim2.fromOffset(14, v155 - 29);
            v.button.Size = UDim2.fromOffset(v154 - 28, 24);
        end;

        u26.CanvasSize = UDim2.fromOffset(JourneyConfig2.MaxTier * (v154 + 12) - 12, 0);
        local math_floor_ret = math.floor((v147 + 10) / 190);
        local math_max_ret = math.max(1, math_floor_ret);
        u28.CellSize = UDim2.fromOffset((v147 - (math_max_ret - 1) * 10) / math_max_ret, 108);
        local v157 = math_min_ret2 - (v145 and 68 or 93);
        local v158 = (v147 - 20) / 3;
        u29.Position = UDim2.fromOffset(v146, v157);
        u29.Size = UDim2.fromOffset(v158, 38);
        u29.TextSize = v144 and 11 or 13;
        u30.Position = UDim2.fromOffset(v146 + v158 + 10, v157);
        u30.Size = UDim2.fromOffset(v158, 38);
        u30.TextSize = v144 and 12 or 15;
        u32.Position = UDim2.fromOffset(v146 + 2 * (v158 + 10), v157);
        u32.Size = UDim2.fromOffset(v158, 38);
        u32.TextSize = v144 and 12 or 15;
        u31.Position = UDim2.fromOffset(v146 + 2 * (v158 + 10), v157 + 42);
        u31.Size = UDim2.fromOffset(v158, v145 and 24 or 28);
        u31.TextSize = v144 and 11 or 13;
        u40.Position = UDim2.fromOffset(v146, v157 + 43);
        u40.Size = UDim2.fromOffset(v147 - v158 - 10, 18);
        u40.TextSize = v145 and 10 or 11;
        u39.Visible = not v145;
        u39.Position = UDim2.fromOffset(v146, math_min_ret2 - 25);
        u39.Size = UDim2.fromOffset(v147 - v158 - 10, 20);
        u39.TextSize = v144 and 9 or 11;
        syncPoses();
    end;

    u92 = layout;
    local u159 = { "CreatorPanelOpen", "CreatorUIHidden", "CreatorCameraActive", "TutorialSession", "ScreenPresentationActive", "GlobalWheelOpen", "BalloonOfferOpen", "ArmoryOpen", "ServerBrowserOpen", "AdminConsoleActive", "MapVoteOpen", "MatchSummaryVisible" };

    local function allowed() -- Line: 432
        -- upvalues: JourneyConfig2 (copy), LocalPlayer2 (copy), u159 (copy)
        if not (JourneyConfig2.Enabled and (JourneyConfig2.Visible and (workspace:GetAttribute("JourneyVisible") ~= false and (LocalPlayer2:GetAttribute("ClientReady") == true and LocalPlayer2:GetAttribute("InMatch") ~= true)))) then
            return false;
        end;

        for _, v in u159 do
            if LocalPlayer2:GetAttribute(v) then
                return false;
            end;
        end;

        return true;
    end;

    local function queuePoses() -- Line: 437
        -- upvalues: u55 (ref), u45 (ref), syncPoses (copy)
        if u55 then
            return;
        end;

        u55 = true;
        task.delay(0.2, function() -- Line: 440
            -- upvalues: u55 (ref), u45 (ref), syncPoses (ref)
            u55 = false;

            if u45 then
                syncPoses();
            end;
        end);
    end;

    local function characterSpawned(u160) -- Line: 442
        -- upvalues: u45 (ref), LocalPlayer2 (copy), u42 (copy), syncPoses (copy)
        task.spawn(function() -- Line: 443
            -- upvalues: u45 (ref), LocalPlayer2 (ref), u160 (copy), u42 (ref), syncPoses (ref)
            local v161 = os.clock() + 5;

            while u45 and (LocalPlayer2.Character == u160 and not (u160:FindFirstChildOfClass("Humanoid") and u160:FindFirstChild("HumanoidRootPart"))) and os.clock() < v161 do
                task.wait(0.1);
            end;

            if not u45 or LocalPlayer2.Character ~= u160 then
                return;
            end;

            for _, v in u42 do
                if v.emote and not v.pose then
                    v.tried = nil;
                end;
            end;

            syncPoses();
        end);
    end;

    local function watchPoses(p162) -- Line: 452
        -- upvalues: u53 (ref), u26 (copy), queuePoses (copy), u54 (ref), LocalPlayer2 (copy), characterSpawned (copy)
        if p162 then
            if not u53 then
                u53 = u26:GetPropertyChangedSignal("CanvasPosition"):Connect(queuePoses);
            end;

            if not u54 then
                u54 = LocalPlayer2.CharacterAdded:Connect(characterSpawned);
            end;
        else
            if u53 then
                u53:Disconnect();
                u53 = nil;
            end;

            if u54 then
                u54:Disconnect();
                u54 = nil;
            end;
        end;
    end;

    local u163 = 0;

    local function startEnds() -- Line: 462
        -- upvalues: u17 (copy), u163 (ref), u45 (ref), JourneyConfig2 (copy)
        if not u17.Visible then
            return;
        end;

        u163 = u163 + 1;
        local u164 = u163;
        task.spawn(function() -- Line: 465
            -- upvalues: u45 (ref), u164 (copy), u163 (ref), JourneyConfig2 (ref), u17 (ref)
            while u45 and u164 == u163 do
                local v165 = JourneyConfig2.endsIn(workspace:GetServerTimeNow());
                u17.Text = v165 and "ENDS IN " .. v165 or "SEASON ENDED";
                task.wait(1);
            end;
        end);
    end;

    local u166 = nil;
    local JourneyHalloween = require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).JourneyHalloween;

    if JourneyHalloween == true or JourneyHalloween == "Test" and game.PlaceId == 130574217370467 then
        local success, result = pcall(require, ChickenOrHero2.OldUIReskin:WaitForChild("JourneyHalloween"));

        if success then
            local success2, result2 = pcall(result.apply, {
                gui = u4,
                shade = u6,
                panel = u7,
                heading = u15,
                edition = u14,
                ends = u17,
                tierText = u18,
                xpText = u19,
                progress = u20,
                fill = u21,
                notice = u40,
                policy = u39,
                cards = u42
            });

            if success2 then
                u166 = result2;
            else
                warn("[Journey] the Halloween look failed: " .. tostring(result2));
            end;
        else
            warn("[Journey] the Halloween look is missing: " .. tostring(result));
        end;
    end;

    local function setOpen(p167) -- Line: 487
        -- upvalues: HudNavigation2 (copy), allowed (copy), u45 (ref), u46 (ref), u6 (copy), LocalPlayer2 (copy), u166 (ref), JourneyEvent (copy), layout (copy), u17 (copy), u163 (ref), JourneyConfig2 (copy), u47 (ref), UserInputService (copy), GamepadService (copy), u7 (copy), u41 (ref), complete (copy), u26 (copy), u42 (copy), u53 (ref), queuePoses (copy), u54 (ref), characterSpawned (copy), syncPoses (copy), show3D (copy)
        if p167 then
            HudNavigation2.opening("Journey");
        end;

        if p167 and not allowed() then
            return;
        end;

        if p167 and not u45 then
            local success, result = pcall(function() -- Line: 491
                return game.StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList);
            end);
            u46 = success and result and result or nil;
            pcall(function() -- Line: 492
                game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
            end);
        elseif not (p167 or (not u45 or u46 == nil)) then
            pcall(function() -- Line: 493
                -- upvalues: u46 (ref)
                game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, u46);
            end);
        end;

        u45 = p167;
        u6.Visible = p167;
        LocalPlayer2:SetAttribute("JourneyOpen", p167 or nil);

        if u166 then
            u166:open(p167);
        end;

        if not p167 then
            if u53 then
                u53:Disconnect();
                u53 = nil;
            end;

            if u54 then
                u54:Disconnect();
                u54 = nil;
            end;

            syncPoses();

            for _, v in u42 do
                show3D(v, false);
            end;

            if u47 then
                u47 = false;

                if GamepadService.GamepadCursorEnabled then
                    pcall(GamepadService.DisableGamepadCursor, GamepadService);
                end;
            end;

            return;
        end;

        LocalPlayer2:SetAttribute("SpectateRequestedExit", os.clock());
        JourneyEvent:FireServer("Get");
        layout();

        if u17.Visible then
            u163 = u163 + 1;
            local u168 = u163;
            task.spawn(function() -- Line: 465
                -- upvalues: u45 (ref), u168 (copy), u163 (ref), JourneyConfig2 (ref), u17 (ref)
                while u45 and u168 == u163 do
                    local v169 = JourneyConfig2.endsIn(workspace:GetServerTimeNow());
                    u17.Text = v169 and "ENDS IN " .. v169 or "SEASON ENDED";
                    task.wait(1);
                end;
            end);
        end;

        task.defer(function() -- Line: 501
            -- upvalues: u45 (ref), u47 (ref), UserInputService (ref), GamepadService (ref), u7 (ref)
            if u45 and not (u47 or (UserInputService.PreferredInput ~= Enum.PreferredInput.Gamepad or GamepadService.GamepadCursorEnabled)) then
                u47 = pcall(GamepadService.EnableGamepadCursor, GamepadService, u7);
            end;
        end);
        local math_max_ret = math.max(1, (u41.tier or 1) - 1);

        for i = 1, u41.tier or 1 do
            local v170 = JourneyConfig2.Rewards[i];

            if v170 and not (complete(v170.Free) and (not u41.premium or complete(v170.Premium))) then
                math_max_ret = i;
                break;
            end;

            local _ = i;
        end;

        local v171 = u26:FindFirstChild("Tier" .. math_max_ret);

        if v171 then
            u26.CanvasPosition = Vector2.new(math.max(0, v171.Position.X.Offset), 0);
        end;

        for _, v in u42 do
            if v.fill and not v.filled then
                v.filled = true;
                local success, result = pcall(v.fill);

                if not success then
                    warn("[Journey] reward art failed: " .. tostring(result));
                end;
            end;
        end;

        if not u53 then
            u53 = u26:GetPropertyChangedSignal("CanvasPosition"):Connect(queuePoses);
        end;

        if not u54 then
            u54 = LocalPlayer2.CharacterAdded:Connect(characterSpawned);
        end;

        syncPoses();
    end;

    HudNavigation2.register("Journey", function() -- Line: 523
        -- upvalues: setOpen (copy), u45 (ref)
        setOpen(not u45);
    end);
    HudNavigation2.Opening.Event:Connect(function(p172) -- Line: 524
        -- upvalues: setOpen (copy)
        if p172 ~= "Journey" then
            setOpen(false);
        end;
    end);
    u16.Activated:Connect(function() -- Line: 525
        -- upvalues: setOpen (copy)
        setOpen(false);
    end);
    u29.Activated:Connect(function() -- Line: 526
        -- upvalues: u29 (copy), claim (copy)
        if u29.Active then
            claim("ClaimAll");
        end;
    end);
    u22.Activated:Connect(function() -- Line: 527
        -- upvalues: u26 (copy), u27 (copy), Skin (copy), u22 (copy), u23 (copy), layout (copy)
        u26.Visible = true;
        u27.Visible = false;
        Skin.tab(u22, u26.Visible);
        Skin.tab(u23, u27.Visible);
        layout();
    end);
    u23.Activated:Connect(function() -- Line: 528
        -- upvalues: u26 (copy), u27 (copy), Skin (copy), u22 (copy), u23 (copy), layout (copy)
        u26.Visible = false;
        u27.Visible = true;
        Skin.tab(u22, u26.Visible);
        Skin.tab(u23, u27.Visible);
        layout();
    end);

    local function pickLane(p173) -- Line: 529
        -- upvalues: u49 (ref), Skin (copy), u24 (copy), u25 (copy), layout (copy)
        if u49 ~= p173 then
            u49 = p173;
            Skin.tab(u24, u49 == "Free");
            Skin.tab(u25, u49 == "Premium");
            layout();
        end;
    end;

    u24.Activated:Connect(function() -- Line: 530
        -- upvalues: u49 (ref), Skin (copy), u24 (copy), u25 (copy), layout (copy)
        if u49 ~= "Free" then
            u49 = "Free";
            Skin.tab(u24, u49 == "Free");
            Skin.tab(u25, u49 == "Premium");
            layout();
        end;
    end);
    u25.Activated:Connect(function() -- Line: 531
        -- upvalues: u49 (ref), Skin (copy), u24 (copy), u25 (copy), layout (copy)
        if u49 ~= "Premium" then
            u49 = "Premium";
            Skin.tab(u24, u49 == "Free");
            Skin.tab(u25, u49 == "Premium");
            layout();
        end;
    end);
    u30.Activated:Connect(function() -- Line: 532
        -- upvalues: u30 (copy), MarketplaceService (copy), LocalPlayer2 (copy), JourneyConfig2 (copy)
        if u30.Active then
            MarketplaceService:PromptGamePassPurchase(LocalPlayer2, JourneyConfig2.PremiumPassId);
        end;
    end);
    u32.Activated:Connect(function() -- Line: 533
        -- upvalues: u32 (copy), u50 (ref), u41 (ref), JourneyConfig2 (copy), HudNavigation2 (copy), u33 (ref), CurrencyTopUp (copy), u89 (ref), u40 (copy), JourneyEvent (copy)
        if not u32.Active or u50 then
            return;
        end;

        local v174 = u41.rebirthCoins or JourneyConfig2.RebirthCoins;
        local wallet = HudNavigation2.wallet;
        local v175 = wallet.loaded and wallet.coins or (u41.coins or 0);

        if v175 >= v174 then
            if os.clock() < u33 then
                u33 = 0;
                u50 = true;
                u40.Text = "Rebirthing your Journey…";
                JourneyEvent:FireServer("RebirthCoins", nil, JourneyConfig2.SeasonId);
                task.delay(10, function() -- Line: 542
                    -- upvalues: u50 (ref), u40 (ref), u89 (ref)
                    if u50 then
                        u50 = false;
                        u40.Text = "Still waiting for confirmation. You can retry safely.";
                        u89();
                    end;
                end);
            else
                u33 = os.clock() + 4;
                task.delay(4.1, function() -- Line: 544
                    -- upvalues: u89 (ref)
                    u89();
                end);
            end;

            u89();

            return;
        end;

        u33 = 0;
        CurrencyTopUp.prompt("coins", v174, v175);
        u89();
    end);
    HudNavigation2.Changed.Event:Connect(function(p176) -- Line: 548
        -- upvalues: u89 (ref)
        if p176 == "Wallet" then
            u89();
        end;
    end);
    u31.Activated:Connect(function() -- Line: 549
        -- upvalues: u41 (ref), u31 (copy), u36 (ref), MarketplaceService (copy), LocalPlayer2 (copy), u89 (ref)
        local rebirthProductId = u41.rebirthProductId;

        if not (rebirthProductId and u31.Active) then
            return;
        end;

        if os.clock() < u36 then
            u36 = 0;
            pcall(MarketplaceService.PromptProductPurchase, MarketplaceService, LocalPlayer2, rebirthProductId);
        else
            u36 = os.clock() + 4;
            task.delay(4.1, function() -- Line: 555
                -- upvalues: u89 (ref)
                u89();
            end);
        end;

        u89();
    end);
    MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(p177, p178, p179) -- Line: 559
        -- upvalues: LocalPlayer2 (copy), JourneyConfig2 (copy), JourneyEvent (copy)
        if p177 == LocalPlayer2 and (p178 == JourneyConfig2.PremiumPassId and p179) then
            task.delay(1, function() -- Line: 559
                -- upvalues: JourneyEvent (ref)
                JourneyEvent:FireServer("Refresh");
            end);
        end;
    end);

    local function celebrate(p180) -- Line: 562
        -- upvalues: u42 (copy), complete (copy), u45 (ref), u26 (copy), u29 (copy), ChickenOrHero2 (copy), u4 (copy)
        local v181 = {};

        for i, v in u42 do
            if not p180[i] and complete(v.reward) then
                table.insert(v181, v);
            end;
        end;

        if #v181 == 0 then
            return;
        end;

        table.sort(v181, function(p182, p183) -- Line: 566
            if p182.tier ~= p183.tier then
                return p182.tier < p183.tier;
            end;

            local v184;

            if p182.lane == "Free" then
                v184 = p183.lane ~= "Free";
            else
                v184 = false;
            end;

            return v184;
        end);
        local v185 = {};

        for i, v in v181 do
            v185[i] = v.shown or v.reward;
        end;

        local v186 = nil;
        local v187;

        if #v181 == 1 and (u45 and v181[1].card.Visible) then
            local card = v181[1].card;
            v187 = card.AbsolutePosition + card.AbsoluteSize * 0.5;
            local AbsolutePosition = u26.AbsolutePosition;
            local AbsoluteSize = u26.AbsoluteSize;

            if v187.X >= AbsolutePosition.X and (v187.X <= AbsolutePosition.X + AbsoluteSize.X and v187.Y >= AbsolutePosition.Y) then
                if v187.Y > AbsolutePosition.Y + AbsoluteSize.Y then
                    v187 = v186;
                end;
            else
                v187 = v186;
            end;
        else
            v187 = v186;
        end;

        if not v187 and u45 then
            v187 = u29.AbsolutePosition + u29.AbsoluteSize * 0.5;
        end;

        local v188 = ChickenOrHero2:FindFirstChild("Interface") and ChickenOrHero2.Interface:FindFirstChild("ClaimPop");
        local success, result = pcall(require, v188);

        if success and result then
            result.journey(v185, v187, {
                displayOrder = u4.DisplayOrder + 1
            });
        end;
    end;

    JourneyEvent.OnClientEvent:Connect(function(p189, p190) -- Line: 579
        -- upvalues: JourneyConfig2 (copy), u50 (ref), u42 (copy), complete (copy), u41 (ref), u40 (copy), u89 (ref), celebrate (copy)
        if p189 == "State" and (type(p190) == "table" and p190.seasonId == JourneyConfig2.SeasonId) then
            local v191 = u50 and {} or nil;

            if v191 then
                for i, v in u42 do
                    v191[i] = complete(v.reward);
                end;
            end;

            u41 = p190;

            if p190.message then
                u50 = false;
                u40.Text = p190.message;
            end;

            u89();

            if v191 then
                celebrate(v191);
            end;
        end;
    end);
    UserInputService.InputBegan:Connect(function(p192, p193) -- Line: 587
        -- upvalues: u45 (ref), setOpen (copy)
        if not p193 and (u45 and (p192.KeyCode == Enum.KeyCode.Escape or p192.KeyCode == Enum.KeyCode.ButtonB)) then
            setOpen(false);
        end;
    end);

    local function visibility() -- Line: 588
        -- upvalues: HudNavigation2 (copy), allowed (copy), u45 (ref), setOpen (copy)
        HudNavigation2.setAvailable("Journey", (allowed()));

        if u45 and not allowed() then
            setOpen(false);
        end;
    end;

    for _, v in u159 do
        LocalPlayer2:GetAttributeChangedSignal(v):Connect(visibility);
    end;

    for _, v in { "ClientReady", "InMatch" } do
        LocalPlayer2:GetAttributeChangedSignal(v):Connect(visibility);
    end;

    workspace:GetAttributeChangedSignal("JourneyVisible"):Connect(visibility);
    u4:GetPropertyChangedSignal("AbsoluteSize"):Connect(layout);
    task.spawn(function() -- Line: 593
        -- upvalues: JourneyConfig2 (copy), MarketplaceService (copy), u48 (ref), u89 (ref)
        if JourneyConfig2.PremiumPassId > 0 then
            local success, result = pcall(function() -- Line: 594
                -- upvalues: MarketplaceService (ref), JourneyConfig2 (ref)
                return MarketplaceService:GetProductInfoAsync(JourneyConfig2.PremiumPassId, Enum.InfoType.GamePass);
            end);
            u48 = success and result and result or false;
        end;

        u89();
    end);
    HudNavigation2.setAvailable("Journey", (allowed()));

    if u45 and not allowed() then
        setOpen(false);
    end;

    u89();
    layout();
    JourneyEvent:FireServer("Get");
    script.Destroying:Connect(function() -- Line: 598
        -- upvalues: setOpen (copy), u166 (ref), u4 (copy)
        setOpen(false);

        if u166 then
            u166:destroy();
        end;

        u4:Destroy();
    end);
end;

if not u2 then
    HudNavigation.setAvailable("Journey", (canOpen()));
end;