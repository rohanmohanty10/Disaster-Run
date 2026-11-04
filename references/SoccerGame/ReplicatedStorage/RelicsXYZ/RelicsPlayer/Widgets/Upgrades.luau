  

local Parent = script.Parent.Parent;
local State = require(Parent.State);
local Enums = require(Parent.Enums);
local Parent2 = Parent.Parent;
local Shared = Parent2.Shared;
local Hooks = Parent.Hooks;
local Components = Parent.Components;
local Button = require(Components.Button);
local View3D = require(Components.View3D);
local MiniPlayer = require(Components.MiniPlayer);
local ScrollFrame = require(Components.ScrollFrame);
local useBoomboxData = require(Hooks.useBoomboxData);
local useWorldAvatar = require(Hooks.useWorldAvatar);
local useAttribute = require(Hooks.useAttribute);
local useHeartbeat = require(Hooks.useHeartbeat);
local useOwnership = require(Hooks.useOwnership);
local useProperty = require(Hooks.useProperty);
local useTagged = require(Hooks.useTagged);
local useSignal = require(Hooks.useSignal);
local useChild = require(Hooks.useChild);
local useClock = require(Hooks.useClock);
local u1 = require(Parent2);
local React = require(Shared.React);
require(Shared.Promise);
local RunContext = require(Shared.RunContext);
local MarketplaceService = game:GetService("MarketplaceService");
local LocalPlayer = game:GetService("Players").LocalPlayer;

local function EmotePreview(u2) -- Line: 72
    -- upvalues: useTagged (copy), React (copy), useWorldAvatar (copy), useChild (copy), RunContext (copy), useHeartbeat (copy), View3D (copy)
    local u3 = useTagged("RelicsEmote");
    local u4, u5 = React.useState(function() -- Line: 75
        -- upvalues: u2 (copy), u3 (copy)
        if u2.Emote then
            return u2.Emote;
        end;

        return #u3 > 0 and u3[math.random(1, #u3)] or nil;
    end);
    local v6 = useWorldAvatar(u2.LoadDelay);
    local u7 = useChild(v6, "Player");
    local u8 = useChild(useChild(u7, "Humanoid"), "Animator");
    React.useEffect(function() -- Line: 89
        -- upvalues: u4 (copy), u8 (copy), u3 (copy), u5 (copy)
        if u4 and u4:IsA("Animation") then
            if u8 and u8:IsA("Animator") then
                for _, v in u8:GetPlayingAnimationTracks() do
                    v:Stop();
                end;

                local v9 = u8:LoadAnimation(u4);

                if v9 then
                    v9.Looped = true;
                    v9:Play();
                end;
            end;
        elseif u4 == nil and #u3 > 0 then
            u5(u3[math.random(1, #u3)]);
        end;
    end, { u4, u7 });
    React.useEffect(function() -- Line: 111
        -- upvalues: u7 (copy), u2 (copy)
        if u7 and not u2.NoMask then
            for _, descendant in u7:GetDescendants() do
                if descendant:IsA("CharacterAppearance") or descendant:IsA("SurfaceAppearance") then
                    descendant:Destroy();
                elseif descendant:IsA("BasePart") then
                    descendant.Color = Color3.new(1, 1, 1);

                    if descendant:IsA("MeshPart") then
                        descendant.TextureID = "";
                    end;
                elseif descendant:IsA("Decal") then
                    descendant.Texture = "";
                elseif descendant:IsA("FileMesh") then
                    descendant.TextureId = "";
                end;
            end;
        end;
    end, { u7, u2.NoMask });

    if RunContext.IsEdit then
        useHeartbeat(function(p10) -- Line: 138
            -- upvalues: u8 (copy), u7 (copy)
            if u8 and u8:IsA("Animator") then
                u8:StepAnimations(p10);
            end;

            if u7 then
                local os_clock_ret = os.clock();
                local v11 = math.cos(os_clock_ret) / 2;
                u7:PivotTo(CFrame.Angles(0, v11, 0));
            end;
        end);
    end;

    local createElement = React.createElement;
    local v12 = {
        FieldOfView = 1,
        ZoomScale = 1.1,
        Model = v6,
        Size = u2.Size,
        Position = u2.Position,
        AnchorPoint = u2.AnchorPoint,
        Ambient = Color3.new(1, 1, 1),
        LightColor = Color3.new(1, 1, 1),
        EdgeColor = u2.BackgroundColor or Color3.fromHex("#430FA2")
    };
    local v13;

    if u2.NoMask then
        v13 = nil;
    else
        v13 = u2.FigureColor or Color3.fromHex("#7D37FF");
    end;

    v12.TintColor = v13;

    return createElement(View3D, v12);
end;

local function BoomboxPreview(u14) -- Line: 166
    -- upvalues: useBoomboxData (copy), React (copy), useClock (copy), View3D (copy)
    local u15 = useBoomboxData();
    local u16, u17 = React.useState(nil);
    React.useEffect(function() -- Line: 170
        -- upvalues: u15 (copy), u16 (copy), u17 (copy)
        if u15 then
            if u16 and u16 ~= u15.Model then
                u16:Destroy();
            end;

            u17(u15.Model);
        end;
    end, { u15 });
    React.useEffect(function() -- Line: 180
        -- upvalues: u16 (copy), u14 (copy)
        local v18 = u16 and u16:FindFirstChildOfClass("MeshPart");

        if v18 then
            if u14.Skin then
                local TextureID = v18.TextureID;

                if not v18:GetAttribute("DefaultSkin") then
                    v18:SetAttribute("DefaultSkin", TextureID);
                end;

                v18.TextureID = `rbxassetid://{u14.Skin}`;

                return;
            end;

            local Attribute = v18:GetAttribute("DefaultSkin");

            if Attribute then
                v18.TextureID = Attribute;

                return;
            end;

            v18:SetAttribute("DefaultSkin", v18.TextureID);
        end;
    end, { u16, u14.Skin });
    useClock(30, function() -- Line: 207
        -- upvalues: u16 (copy)
        if u16 then
            local v19 = os.clock() % 6.282;
            u16:PivotTo(CFrame.Angles(0, v19, 0));
        end;
    end, { u16 });

    return React.createElement(View3D, {
        FieldOfView = 1,
        ZoomScale = 1.2,
        Transparency = 0.1,
        Model = u16,
        Size = u14.Size,
        Position = u14.Position,
        AnchorPoint = u14.AnchorPoint,
        Ambient = Color3.new(1, 1, 1),
        LightColor = Color3.new(1, 1, 1),
        EdgeColor = Color3.fromHex("#c592af"),
        TintColor = Color3.fromHex("#c5b6bf")
    });
end;

local function EmoteItem(u20: table) -- Line: 231
    -- upvalues: React (copy), State (copy), useOwnership (copy), EmotePreview (copy), Button (copy), LocalPlayer (copy), MarketplaceService (copy)
    local Theme = React.useContext(State.Context).Theme;
    local u21 = useOwnership({
        {
            Id = u20.AssetId,
            InfoType = Enum.InfoType.Asset
        }
    });
    local v22;

    if u21 then
        v22 = Color3.fromHex("4512A3");
    else
        v22 = Color3.fromHex("1A1A1A");
    end;

    local createElement = React.createElement;
    local v23 = {
        BackgroundColor3 = v22,
        AnchorPoint = Vector2.one / 2
    };
    local v24 = {
        Corner = React.createElement("UICorner", {
            CornerRadius = Theme.Tweaks.PanelCornerRadius
        })
    };
    local createElement2 = React.createElement;
    local v25 = {
        Emote = u20.Emote,
        Size = UDim2.fromScale(1, 1),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        LoadDelay = u20.LoadDelay
    };
    local v26;

    if u21 then
        v26 = Color3.fromHex("7D37FF");
    else
        v26 = Color3.fromHex("9F9F9F");
    end;

    v25.FigureColor = v26;
    v25.BackgroundColor = v22;
    v24.Preview = createElement2(EmotePreview, v25);
    v24.Title = React.createElement("TextLabel", {
        BackgroundTransparency = 1,
        LineHeight = 1.2,
        TextWrap = true,
        TextSize = 10,
        TextColor3 = Theme.Colors.WHITE,
        Position = UDim2.new(0.5, 0, 0, 6),
        AnchorPoint = Vector2.new(0.5, 0),
        Size = UDim2.new(1, -10, 0.5, 0),
        FontFace = Theme.Fonts.Bold,
        TextYAlignment = Enum.TextYAlignment.Top,
        Text = u20.Emote.Name
    });
    v24.Button = React.createElement(Button, {
        BackgroundTransparency = 0,
        ZIndex = 3,
        AnchorPoint = Vector2.one / 2,
        Size = UDim2.fromOffset(40, 10),
        Position = UDim2.new(0.5, 0, 1, -10),
        BackgroundColor3 = Theme.Colors.WHITE,

        OnActivated = function() -- Line: 288, Name: OnActivated
            -- upvalues: u21 (copy), LocalPlayer (ref), u20 (copy), MarketplaceService (ref)
            if u21 then
                local v27 = LocalPlayer and LocalPlayer.Character;

                if v27 then
                    v27 = v27:FindFirstChild("Animate");
                end;

                if v27 then
                    v27 = v27:FindFirstChild("PlayEmote");
                end;

                if v27 and v27:IsA("BindableFunction") then
                    v27:Invoke(u20.Emote);
                end;
            elseif LocalPlayer then
                MarketplaceService:PromptPurchase(LocalPlayer, u20.AssetId);
            end;
        end
    }, {
        Corner = React.createElement("UICorner", {
            CornerRadius = UDim.new(1, 0)
        }),
        Text = React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            Text = u21 and "USE" or "BUY",
            FontFace = Theme.Fonts.Bold,
            TextColor3 = Theme.Colors.BLACK,
            Size = UDim2.fromScale(1, 1)
        })
    });

    return createElement("Frame", v23, v24);
end;

local function UgcSkinItem(p28: table) -- Line: 317
    -- upvalues: React (copy), State (copy), useProperty (copy), useAttribute (copy), useOwnership (copy), BoomboxPreview (copy), Button (copy), u1 (copy), LocalPlayer (copy), MarketplaceService (copy)
    local Theme = React.useContext(State.Context).Theme;
    local Config = p28.Config;
    local u30 = useProperty(Config, function(p29) -- Line: 322
        return p29 and p29.Name or nil;
    end);
    local u32 = useAttribute(Config, "ItemId", function(p31) -- Line: 326
        -- upvalues: Config (copy)
        return not Config and 0 or (type(p31) == "number" and p31 and p31 or nil);
    end);
    local u34 = useAttribute(Config, "ItemType", function(p33) -- Line: 334
        if typeof(p33) == "EnumItem" then
            return p33:IsA("InfoType") and p33 and p33 or nil;
        end;

        return nil;
    end);
    local v36 = useAttribute(Config, "LegacyId", function(p35) -- Line: 342
        return type(p35) == "number" and p35 and p35 or nil;
    end);
    local v38 = useAttribute(Config, "TextureId", function(p37) -- Line: 346
        return type(p37) == "number" and p37 and p37 or nil;
    end);
    local v40 = useAttribute(Config, "DisplayName", function(p39) -- Line: 350
        -- upvalues: Config (copy), u30 (copy)
        return not Config and "Default Boombox" or (type(p39) == "string" and p39 and p39 or u30);
    end);
    local v41 = {
        {
            Id = u32,
            InfoType = u34 or Enum.InfoType.Asset
        }
    };

    if v36 then
        table.insert(v41, {
            Id = v36,
            InfoType = u34 or Enum.InfoType.Asset
        });
    end;

    local v42 = useOwnership(v41);
    local u43 = u32 == 0 and true or v42;
    local v44;

    if u43 then
        v44 = Color3.fromHex("CB3A8C");
    else
        v44 = Color3.fromHex("1A1A1A");
    end;

    return React.createElement("Frame", {
        BackgroundColor3 = v44,
        AnchorPoint = Vector2.one / 2,
        LayoutOrder = v38 and 1 or -1,
        Size = UDim2.fromScale(0.35, 0.35),
        SizeConstraint = Enum.SizeConstraint.RelativeXX
    }, {
        Corner = React.createElement("UICorner", {
            CornerRadius = Theme.Tweaks.PanelCornerRadius
        }),
        Preview = React.createElement(BoomboxPreview, {
            Skin = v38,
            Size = UDim2.fromScale(1, 1),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            BackgroundColor = v44
        }),
        Title = React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            LineHeight = 1.2,
            TextWrap = true,
            TextSize = 20,
            TextColor3 = Theme.Colors.WHITE,
            Position = UDim2.new(0.5, 0, 0, 6),
            AnchorPoint = Vector2.new(0.5, 0),
            Size = UDim2.new(1, -10, 0.5, 0),
            FontFace = Theme.Fonts.Bold,
            TextYAlignment = Enum.TextYAlignment.Top,
            Text = v40
        }),
        Button = React.createElement(Button, {
            BackgroundTransparency = 0,
            ZIndex = 3,
            AnchorPoint = Vector2.one / 2,
            Size = UDim2.fromOffset(80, 20),
            Position = UDim2.new(0.5, 0, 1, -20),
            BackgroundColor3 = Theme.Colors.WHITE,

            OnActivated = function() -- Line: 421, Name: OnActivated
                -- upvalues: u43 (ref), u1 (ref), Config (copy), LocalPlayer (ref), u34 (copy), MarketplaceService (ref), u32 (copy)
                if not u43 then
                    if LocalPlayer then
                        if u34 == Enum.InfoType.Asset then
                            MarketplaceService:PromptPurchase(LocalPlayer, u32);

                            return;
                        end;

                        if u34 == Enum.InfoType.GamePass then
                            MarketplaceService:PromptGamePassPurchase(LocalPlayer, u32);

                            return;
                        end;

                        warn("Unsupported item type", u34);
                    end;

                    return;
                end;

                u1.FireServer("EquipSkin", Config and Config.Name);
            end
        }, {
            Corner = React.createElement("UICorner", {
                CornerRadius = UDim.new(1, 0)
            }),
            Text = React.createElement("TextLabel", {
                TextSize = 12,
                BackgroundTransparency = 1,
                Text = u43 and "EQUIP" or "BUY",
                FontFace = Theme.Fonts.Bold,
                TextColor3 = Theme.Colors.BLACK,
                Size = UDim2.fromScale(1, 1)
            })
        })
    });
end;

local u68 = {
    {
        Title = "EMOTES",
        Feature = "Emotes",
        Color = Color3.fromHex("#430FA2"),
        Preview = EmotePreview,

        Widget = function(p45) -- Line: 451, Name: EmotesGrid
            -- upvalues: React (copy), State (copy), useTagged (copy), Enums (copy), EmoteItem (copy), useSignal (copy), ScrollFrame (copy)
            local u46 = React.useContext(State.Context);
            local u47, u48 = React.useState(16);
            local u49 = React.useRef(nil);
            local u50 = useTagged("RelicsEmote");

            if u46.Status ~= Enums.UserStatus.BoomboxPurchased then
                u46.SetWindowTab(Enums.WindowTab.Upsell);

                return nil;
            end;

            table.sort(u50, function(p51, p52) -- Line: 464
                return p51.Name < p52.Name;
            end);
            local v53 = {};

            for i, v in u50 do
                local v54 = tonumber(v:GetAttribute("AssetId"));

                if v54 and v:IsA("Animation") then
                    if u47 < i then
                        break;
                    end;

                    v53[v.Name] = React.createElement(EmoteItem, {
                        AssetId = v54,
                        LoadDelay = i / 30,
                        Emote = v
                    });
                end;
            end;

            useSignal(u46.ReturnEvent, function() -- Line: 490
                -- upvalues: u49 (copy), u46 (copy)
                local current = u49.current;

                if current and current.CanvasPosition.Y > 0 then
                    current.CanvasPosition = Vector2.zero;

                    return;
                end;

                u46.WidgetReturn();
            end);

            return React.createElement(ScrollFrame, {
                Transparency = 1,
                ZIndex = 0,
                CanvasSize = UDim2.fromScale(1, 0),
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ScrollingDirection = Enum.ScrollingDirection.Y,
                Position = p45.Position,
                AnchorPoint = p45.AnchorPoint,
                Size = p45.Size or UDim2.new(1, -45, 1, -90),
                Grid = {
                    FillDirectionMaxCells = 4,
                    CellSize = UDim2.fromOffset(80, 72),
                    CellPadding = UDim2.fromOffset(9, 9),
                    FillDirection = Enum.FillDirection.Horizontal,
                    VerticalAlignment = Enum.VerticalAlignment.Top,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder
                },

                OnPositionChanged = function(p55: userdata) -- Line: 522, Name: OnPositionChanged
                    -- upvalues: u50 (copy), u47 (copy), u48 (copy)
                    local v56;

                    if p55 then
                        v56 = p55.CanvasPosition;
                    else
                        v56 = p55;
                    end;

                    if v56 and v56.Y >= p55.AbsoluteCanvasSize.Y - p55.AbsoluteSize.Y then
                        local math_min_ret = math.min(#u50, u47 + 12);

                        if u47 ~= math_min_ret then
                            u48(math_min_ret);
                        end;
                    end;
                end,

                ref = u49
            }, v53);
        end
    },
    {
        Title = "UGC SKINS",
        Feature = "Skins",
        Color = Color3.fromHex("#CB3A8C"),
        Preview = BoomboxPreview,

        Widget = function(p57) -- Line: 538, Name: UgcSkinGrid
            -- upvalues: React (copy), State (copy), useTagged (copy), Enums (copy), UgcSkinItem (copy), useSignal (copy), ScrollFrame (copy)
            local u58 = React.useContext(State.Context);
            local u59, u60 = React.useState(16);
            local u61 = useTagged("RelicsUGCSkin");

            if u58.Status ~= Enums.UserStatus.BoomboxPurchased then
                u58.SetWindowTab(Enums.WindowTab.Upsell);

                return nil;
            end;

            table.sort(u61, function(p62, p63) -- Line: 550
                return p62.Name < p63.Name;
            end);
            local v64 = {};

            for _, v in u61 do
                v64[v.Name] = React.createElement(UgcSkinItem, {
                    Config = v
                });
            end;

            local u65 = React.useRef(nil);
            v64.Default = React.createElement(UgcSkinItem);
            useSignal(u58.ReturnEvent, function() -- Line: 567
                -- upvalues: u65 (copy), u58 (copy)
                local current = u65.current;

                if current and current.CanvasPosition.Y > 0 then
                    current.CanvasPosition = Vector2.zero;

                    return;
                end;

                u58.WidgetReturn();
            end);

            return React.createElement(ScrollFrame, {
                BackgroundTransparency = 1,
                ClipsDescendants = true,
                BorderSizePixel = 0,
                ZIndex = 0,

                OnPositionChanged = function(p66: userdata) -- Line: 579, Name: OnPositionChanged
                    -- upvalues: u61 (copy), u59 (copy), u60 (copy)
                    local v67;

                    if p66 then
                        v67 = p66.CanvasPosition;
                    else
                        v67 = p66;
                    end;

                    if v67 and v67.Y >= p66.AbsoluteCanvasSize.Y - p66.AbsoluteSize.Y then
                        local math_min_ret = math.min(#u61, u59 + 4);

                        if u59 ~= math_min_ret then
                            u60(math_min_ret);
                        end;
                    end;
                end,

                Position = p57.Position,
                AnchorPoint = p57.AnchorPoint,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ScrollingDirection = Enum.ScrollingDirection.Y,
                Size = p57.Size or UDim2.new(1, -45, 1, -90),
                CanvasSize = UDim2.fromScale(1, 0),
                List = {
                    Wraps = true,
                    Padding = UDim.new(0, 18),
                    FillDirection = Enum.FillDirection.Horizontal,
                    VerticalAlignment = Enum.VerticalAlignment.Top,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder
                },
                ref = u65
            }, v64);
        end
    }
};

local function UpgradeList(p69) -- Line: 646
    -- upvalues: React (copy), State (copy), Enums (copy), u68 (copy), Button (copy)
    local u70 = React.useContext(State.Context);
    local Features = u70.Features;
    local Status = u70.Status;
    local Theme = u70.Theme;

    if not (Features.Emotes or Features.Skins) then
        u70.SetWindowTab(Enums.WindowTab.Play);

        return nil;
    end;

    React.useRef(nil);
    React.useRef(nil);
    local v71 = {};

    for i, v in ipairs(u68) do
        local v72 = not v.Feature and true or Features[v.Feature];
        local Title = v.Title;

        if v72 then
            local createElement = React.createElement;
            local v73 = {
                BackgroundTransparency = 1,
                LayoutOrder = i,
                Size = UDim2.fromScale(1, 1),
                AnchorPoint = Vector2.one / 2,
                SizeConstraint = Enum.SizeConstraint.RelativeYY
            };
            local v74 = {};
            local createElement2 = React.createElement;
            local v75 = {
                BackgroundTransparency = 0,
                AutoButtonColor = false,
                Size = UDim2.fromScale(1, 1),
                AnchorPoint = Vector2.one / 2,
                BackgroundColor3 = v.Color,
                Position = UDim2.fromScale(0.5, 0.5),

                OnActivated = function() -- Line: 686, Name: OnActivated
                    -- upvalues: Status (copy), Enums (ref), u70 (copy), v (copy)
                    if Status ~= Enums.UserStatus.BoomboxPurchased then
                        u70.SetWindowTab(Enums.WindowTab.Upsell);

                        return;
                    end;

                    local Widget = u70.Widget;
                    local Widget2 = v.Widget;

                    if Widget2 then
                        u70.SetWidget({
                            Widget = Widget2,
                            ReturnText = v.Title,

                            ReturnFunc = function() -- Line: 700, Name: ReturnFunc
                                -- upvalues: u70 (ref), Widget (copy)
                                u70.SetWidget(Widget);
                            end
                        });
                    end;
                end
            };
            local v76 = {
                Corner = React.createElement("UICorner", {
                    CornerRadius = Theme.Tweaks.PanelCornerRadius
                }),
                Title = React.createElement("TextLabel", {
                    TextScaled = true,
                    BackgroundTransparency = 1,
                    TextStrokeTransparency = 0.8,
                    Text = v.Title,
                    TextColor3 = v.TextColor or Color3.new(1, 1, 1),
                    TextStrokeColor3 = Color3.new(1, 1, 1),
                    FontFace = Theme.Fonts.Card,
                    Position = UDim2.fromScale(0.5, 0.5),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Size = UDim2.fromScale(0.75, 0.3)
                })
            };
            local v77 = v.Preview and React.createElement(v.Preview, {
                Size = UDim2.fromScale(1, 1),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5)
            });
            v76.Preview = v77;
            v74.Button = createElement2(Button, v75, v76);
            v74.MinSize = React.createElement("UISizeConstraint", {
                MinSize = Vector2.new(1, 1)
            });
            v72 = createElement("Frame", v73, v74);
        end;

        v71[Title] = v72;
    end;

    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        ClipsDescendants = false,
        BorderSizePixel = 0,
        ZIndex = 0,
        Position = p69.Position,
        AnchorPoint = p69.AnchorPoint,
        Size = p69.Size or UDim2.new(1, -45, 1, -90)
    }, v71, {
        List = React.createElement("UIListLayout", {
            Padding = UDim.new(0, 9),
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        })
    });
end;

return function(p78) -- Line: 760, Name: UpgradesWidget
    -- upvalues: React (copy), State (copy), Enums (copy), UpgradeList (copy), MiniPlayer (copy)
    local v79 = React.useContext(State.Context).WindowState == Enums.WindowState.Full;
    local createElement = React.createElement;
    local v80 = {
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Size = p78.Size,
        Position = p78.Position,
        AnchorPoint = p78.AnchorPoint
    };
    local v81 = {
        UpgradeList = React.createElement(UpgradeList, {
            Size = UDim2.new(1, -45, 1, v79 and -90 or -16),
            Position = UDim2.new(0.5, 0, 0, 8),
            AnchorPoint = Vector2.xAxis / 2
        })
    };

    if v79 then
        v79 = React.createElement(MiniPlayer, {
            Position = UDim2.new(0.5, 0, 1, -10),
            AnchorPoint = Vector2.new(0.5, 1)
        });
    end;

    v81.MiniPlayer = v79;

    return createElement("Frame", v80, v81);
end;