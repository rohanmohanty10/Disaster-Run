  

local Parent = script.Parent.Parent;
local Parent2 = Parent.Parent;
local Players = game:GetService("Players");
local u1 = require(Parent2);
local Shared = Parent2.Shared;
local Hooks = Parent.Hooks;
local Enums = require(Parent.Enums);
local State = require(Parent.State);
local React = require(Shared.React);
local RunContext = require(Shared.RunContext);
local Components = Parent.Components;
local Button = require(Components.Button);
local View3D = require(Components.View3D);
local MiniPlayer = require(Components.MiniPlayer);
local ScrollFrame = require(Components.ScrollFrame);
require(Components.Button.Props);
local useProductInfo = require(Hooks.useProductInfo);
local useOwnership = require(Hooks.useOwnership);
local useAttribute = require(Hooks.useAttribute);
local useAuraData = require(Hooks.useAuraData);
local useTagged = require(Hooks.useTagged);
local useSignal = require(Hooks.useSignal);
local u2 = { "OOF!", "MISS!", "NOPE!", "SORRY!", "ALMOST!", "NO DICE!", "UNLUCKY!", "SO CLOSE!", "TRY AGAIN!", "NOT QUITE!" };
local MarketplaceService = game:GetService("MarketplaceService");

local function TextButton(p3) -- Line: 73
    -- upvalues: React (copy), State (copy), Button (copy)
    local Theme = React.useContext(State.Context).Theme;

    if not p3.BackgroundColor3 then
        p3.BackgroundColor3 = Theme.Colors.WHITE;
    end;

    p3.BackgroundTransparency = 0;
    p3.BorderSizePixel = 0;

    return React.createElement(Button, p3, {
        Corner = React.createElement("UICorner", {
            CornerRadius = UDim.new(1, 0)
        }),
        Text = React.createElement("TextLabel", {
            TextScaled = true,
            BackgroundTransparency = 1,
            Text = p3.Text,
            TextColor3 = Theme.Colors.BLACK,
            FontFace = Theme.Fonts.Bold,
            Size = UDim2.fromScale(1, p3.TextScale or 0.7),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5)
        })
    });
end;

local function AuraPreview(u4) -- Line: 102
    -- upvalues: useTagged (copy), React (copy), View3D (copy)
    local u5 = useTagged("RelicsAura");
    local v6, u7 = React.useState(nil);
    local u8 = React.useRef(nil);
    React.useEffect(function() -- Line: 107
        -- upvalues: u8 (copy), u5 (copy), u4 (copy), u7 (copy)
        local current = u8.current;

        for _, v in u5 do
            if v.Name == u4.Aura then
                local v9 = v:FindFirstChildOfClass("Part");

                if v9 then
                    v9 = v9:Clone();
                    v9.Anchored = true;
                    v9.Transparency = 1;
                    v9.CanCollide = false;
                    v9.CanQuery = false;
                    v9.CanTouch = false;
                    v9.Locked = true;
                end;

                if v9 then
                    local Model = Instance.new("Model");
                    Model.Name = "AuraPreview";

                    for _, descendant in v9:GetDescendants() do
                        if descendant:IsA("BasePart") then
                            descendant.Parent = Model;
                        elseif descendant:IsA("Trail") then
                            descendant.Enabled = false;
                        elseif descendant:IsA("ParticleEmitter") then
                            local Speed = descendant.Speed;

                            if Speed.Min < 0.01 then
                                local math_max_ret = math.max(0.01, Speed.Max);
                                descendant.Speed = NumberRange.new(0.01, math_max_ret);
                            end;

                            descendant.TimeScale = 0.5;
                            descendant.LockedToPart = true;
                            descendant.Enabled = true;
                            descendant.ZOffset = descendant.ZOffset / 20;
                        end;
                    end;

                    local BillboardGui = Instance.new("BillboardGui");
                    BillboardGui.StudsOffsetWorldSpace = Vector3.new(-0, -0, -3);
                    BillboardGui.Size = UDim2.fromOffset(180, 245);
                    BillboardGui.Adornee = v9;
                    BillboardGui.Parent = v9;
                    local ImageLabel = Instance.new("ImageLabel");
                    ImageLabel.Size = UDim2.fromScale(1, 1);
                    ImageLabel.BackgroundTransparency = 1;
                    ImageLabel.Image = "rbxassetid://17732143513";
                    ImageLabel.ScaleType = Enum.ScaleType.Crop;
                    ImageLabel.Parent = BillboardGui;

                    if current then
                        local PropertyChangedSignal = current:GetPropertyChangedSignal("AbsoluteSize");
                        local AbsoluteSize = current.AbsoluteSize;
                        BillboardGui.Size = UDim2.fromOffset(AbsoluteSize.X * 1.03 + 2, AbsoluteSize.Y * 1.06 + 2);
                        PropertyChangedSignal:Connect(function() -- Line: 170, Name: update
                            -- upvalues: current (copy), BillboardGui (copy)
                            local AbsoluteSize2 = current.AbsoluteSize;
                            BillboardGui.Size = UDim2.fromOffset(AbsoluteSize2.X * 1.03 + 2, AbsoluteSize2.Y * 1.06 + 2);
                        end);
                    end;

                    v9.Size = v9.Size * 3.5;
                    v9.Parent = Model;
                    Model.PrimaryPart = v9;
                    Model:ScaleTo(0.03);
                    u7(Model);

                    return;
                end;
            end;
        end;
    end, { u5, u4.Aura });

    return React.createElement(View3D, {
        RenderInWorld = true,
        Model = v6,
        Size = u4.Size,
        Position = u4.Position,
        AnchorPoint = u4.AnchorPoint,
        ViewportRef = u8
    });
end;

local function AuraTitleButton(u10: table) -- Line: 204
    -- upvalues: React (copy), State (copy), Button (copy)
    local u11 = React.useContext(State.Context);
    local Theme = u11.Theme;

    return React.createElement(Button, {
        Size = UDim2.fromScale(1, 1),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.one / 2,
        Image = u10.Image,

        OnActivated = function() -- Line: 214, Name: OnActivated
            -- upvalues: u11 (copy), u10 (copy)
            local Widget = u11.Widget;
            u11.SetWidget({
                Widget = u10.Widget,
                ReturnText = u10.Title,

                ReturnFunc = function() -- Line: 221, Name: ReturnFunc
                    -- upvalues: u11 (ref), Widget (copy)
                    u11.SetWidget(Widget);
                end
            });
        end
    }, {
        Title = React.createElement("TextLabel", {
            TextScaled = true,
            BackgroundTransparency = 1,
            LineHeight = 0.8,
            Text = u10.Title,
            TextColor3 = Color3.fromHex("#FFFFFF"),
            FontFace = Theme.Fonts.Card,
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Size = UDim2.fromScale(0.75, 0.5)
        }),
        Corner = React.createElement("UICorner", {
            CornerRadius = UDim.new(0, 9)
        }),
        Stroke = React.createElement("UIStroke", {
            Transparency = 0.25,
            Thickness = 1,
            Color = Color3.fromHex("#E51BE7")
        })
    });
end;

local function AuraPage(u12) -- Line: 252
    -- upvalues: useAuraData (copy), React (copy), State (copy), Enums (copy), useTagged (copy), useAttribute (copy), useProductInfo (copy), useOwnership (copy), TextButton (copy), u1 (copy), Players (copy), MarketplaceService (copy), AuraPreview (copy)
    local u13 = useAuraData().Aura == u12.Aura;
    local v14 = React.useContext(State.Context);
    local v15 = v14.WindowState == Enums.WindowState.Compact;
    local Theme = v14.Theme;
    local v16 = nil;

    for _, v in useTagged("RelicsAura") do
        if v.Name == u12.Aura then
            v16 = v;
            break;
        end;
    end;

    local v17 = useAttribute(v16, "Image", tostring);
    local u18 = useAttribute(v16, "GamePass", tonumber);
    local v19 = useProductInfo(u18, Enum.InfoType.GamePass);
    local v20 = useOwnership({
        {
            Id = u18,
            InfoType = Enum.InfoType.GamePass
        }
    });
    local u21 = u12.Owned or (v14.Features.Demo and true or v20);
    local v23 = useAttribute(v16, "TitleColor", function(p22) -- Line: 284
        return typeof(p22) == "Color3" and p22 and p22 or Color3.new(1, 1, 1);
    end);

    if v14.Status == Enums.UserStatus.BoomboxPurchased then
        return React.createElement(React.Fragment, {}, {
            Background = React.createElement("CanvasGroup", {
                BackgroundTransparency = 1,
                ZIndex = 0,
                Position = UDim2.fromOffset(0, -9),
                Size = UDim2.new(1, 0, 1, 9)
            }, {
                Gradient = React.createElement("UIGradient", {
                    Rotation = 90,
                    Color = Theme.Colors.BACKGROUND_GRADIENT
                }),
                LeftFrame = React.createElement("Frame", {
                    BorderSizePixel = 0,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Position = UDim2.fromScale(0.25, 0.5),
                    Size = UDim2.fromScale(0.5, 1)
                }),
                RightFrame = React.createElement("Frame", {
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.75, 0.5),
                    Size = UDim2.new(0.5, -24, 1, -32)
                }, {
                    Stroke = React.createElement("UIStroke", {
                        Thickness = 32,
                        Color = Color3.fromRGB(255, 255, 255),
                        LineJoinMode = Enum.LineJoinMode.Bevel
                    }),
                    Corner = React.createElement("UICorner")
                })
            }),
            Widget = React.createElement("Frame", {
                BackgroundTransparency = 1,
                Size = u12.Size,
                Position = u12.Position,
                AnchorPoint = u12.AnchorPoint
            }, {
                Padding = React.createElement("UIPadding", {
                    PaddingBottom = UDim.new(0, 10),
                    PaddingRight = UDim.new(0, 10),
                    PaddingLeft = UDim.new(0, 10),
                    PaddingTop = UDim.new(0, 10)
                }),
                List = React.createElement("UIListLayout", {
                    Wraps = true,
                    Padding = UDim.new(0, 10),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center
                }),
                MinSize = React.createElement("UISizeConstraint", {
                    MinSize = Vector2.new(100, 160)
                }),
                BaseTile = React.createElement("ImageLabel", {
                    BackgroundTransparency = 1,
                    LayoutOrder = 1,
                    Image = v17,
                    ScaleType = Enum.ScaleType.Crop,
                    SizeConstraint = Enum.SizeConstraint.RelativeXX,
                    Size = UDim2.new(0.5, -5, v15 and 0.15 or 0.2, 0)
                }, {
                    Corner = React.createElement("UICorner", {
                        CornerRadius = UDim.new(0, 9)
                    }),
                    Title = React.createElement("TextLabel", {
                        TextScaled = true,
                        BackgroundTransparency = 1,
                        Text = u12.Aura:upper() .. "\nAURA",
                        TextColor3 = v23,
                        FontFace = Theme.Fonts.Card,
                        Position = UDim2.fromScale(0.5, 0.5),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Size = UDim2.fromScale(1, 0.875)
                    }, {
                        Stroke = React.createElement("UIStroke", {
                            Transparency = 0.4,
                            Thickness = 0.75
                        })
                    })
                }),
                StatePanel = React.createElement("Frame", {
                    LayoutOrder = 2,
                    BackgroundColor3 = Color3.fromHex("0D0727"),
                    Size = UDim2.new(0.5, -5, 0.4, 0)
                }, {
                    Flex = React.createElement("UIFlexItem", {
                        FlexMode = Enum.UIFlexMode.Fill
                    }),
                    Corner = React.createElement("UICorner", {
                        CornerRadius = UDim.new(0, 9)
                    }),
                    List = React.createElement("UIListLayout", {
                        Padding = UDim.new(),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        FillDirection = Enum.FillDirection.Vertical,
                        VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly,
                        VerticalAlignment = Enum.VerticalAlignment.Top,
                        HorizontalAlignment = Enum.HorizontalAlignment.Center
                    }),
                    Equip = React.createElement(TextButton, {
                        AutoButtonColor = false,
                        TextScale = 0.5,
                        LayoutOrder = 1,
                        BackgroundColor3 = u21 and Theme.Colors.WHITE or Theme.Colors.GRAY,
                        Size = UDim2.fromScale(0.9, v15 and 0.1 or 0.2),
                        SizeConstraint = Enum.SizeConstraint.RelativeXX,
                        Text = u13 and "UNEQUIP" or "EQUIP",

                        OnActivated = function() -- Line: 416, Name: OnActivated
                            -- upvalues: u21 (copy), u1 (ref), u13 (copy), u12 (copy)
                            if u21 then
                                local v24;

                                if u13 then
                                    v24 = nil;
                                else
                                    v24 = u12.Aura;
                                end;

                                u1.FireServer("EquipAura", v24);
                                task.delay(0.1, function() -- Line: 420
                                    -- upvalues: u1 (ref)
                                    u1.GetAuraDataAsync();
                                end);
                            end;
                        end
                    }),
                    Buy = React.createElement(TextButton, {
                        TextScale = 0.5,
                        AutoButtonColor = false,
                        LayoutOrder = 2,
                        Text = "BUY (" .. (not (v19 and v19.PriceInRobux) and "...)" or `{v19.PriceInRobux})`),
                        BackgroundColor3 = u21 and Theme.Colors.GRAY or Theme.Colors.WHITE,
                        Size = UDim2.fromScale(0.9, v15 and 0.1 or 0.2),
                        SizeConstraint = Enum.SizeConstraint.RelativeXX,
                        OnActivated = not u21 and function() -- Line: 439
                            -- upvalues: Players (ref), u18 (copy), MarketplaceService (ref)
                            local LocalPlayer = Players.LocalPlayer;

                            if LocalPlayer and u18 then
                                MarketplaceService:PromptGamePassPurchase(LocalPlayer, u18);
                            end;
                        end or nil
                    })
                }),
                PreviewPanel = React.createElement("Frame", {
                    BackgroundTransparency = 1,
                    ClipsDescendants = true,
                    LayoutOrder = 3,
                    Size = UDim2.new(0.5, -10, 1, 0)
                }, {
                    Preview = React.createElement(AuraPreview, {
                        Aura = u12.Aura,
                        Size = UDim2.fromScale(1, 1),
                        Position = UDim2.fromScale(0.5, 0.5),
                        AnchorPoint = Vector2.new(0.5, 0.5)
                    }),
                    MinSize = React.createElement("UISizeConstraint", {
                        MinSize = Vector2.new(100, 100)
                    })
                })
            })
        });
    end;

    v14.SetWindowTab(Enums.WindowTab.Upsell);

    return nil;
end;

local function AuraItem(p25: table) -- Line: 470
    -- upvalues: useAttribute (copy), React (copy), State (copy), useOwnership (copy), Button (copy), AuraPage (copy)
    local Item = p25.Item;
    local v26 = useAttribute(Item, "Image", tostring);
    local u27 = React.useContext(State.Context);
    local Theme = u27.Theme;
    local v29 = useAttribute(Item, "TitleColor", function(p28) -- Line: 477
        return typeof(p28) == "Color3" and p28 and p28 or Color3.new(1, 1, 1);
    end);
    local v31 = useAttribute(Item, "Chance", function(p30) -- Line: 481
        return tonumber(p30) or 0;
    end);
    local v32 = useOwnership({
        {
            Id = useAttribute(Item, "GamePass", tonumber),
            InfoType = Enum.InfoType.GamePass
        }
    });
    local u33 = p25.Owned and true or v32;
    local createElement = React.createElement;
    local v34 = {
        BackgroundTransparency = 1,
        Size = p25.Size or UDim2.new(0.2833333333333333, -12, 0.2833333333333333, -12),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
        LayoutOrder = not p25.SortByRarity and 0 or -v31 * 1000000
    };
    local v35 = {};
    local createElement2 = React.createElement;
    local v36 = {
        ZIndex = 0,
        Size = UDim2.fromScale(1, 1),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Image = v26
    };
    local v37 = {};
    local v38 = not (u33 or p25.Upsell) and React.createElement("Frame", {
        BackgroundTransparency = 0.5,
        ZIndex = 2,
        Size = UDim2.new(1, -4, 1, -4),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    }, {
        Corner = React.createElement("UICorner", {
            CornerRadius = UDim.new(0.085, 0)
        }),
        Icon = React.createElement("ImageLabel", {
            BackgroundTransparency = 1,
            ZIndex = 3,
            Size = UDim2.fromScale(0.4, 0.4),
            SizeConstraint = Enum.SizeConstraint.RelativeYY,
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Image = Theme.Images.Locked
        })
    });
    v37.Locked = v38;
    v37.Title = React.createElement("TextLabel", {
        TextScaled = true,
        BackgroundTransparency = 1,
        LineHeight = 0.8,
        Text = Item.Name:upper() .. "\nAURA",
        TextColor3 = v29,
        FontFace = Theme.Fonts.Card,
        Position = UDim2.fromScale(0.5, 0.375),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.fromScale(0.8, 0.6666666666666666)
    }, {
        Stroke = React.createElement("UIStroke", {
            Transparency = 0.25,
            Thickness = 0.5,
            Color = Color3.fromRGB():Lerp(v29, 0.2)
        })
    });
    v37.Corner = React.createElement("UICorner", {
        CornerRadius = UDim.new(0.1, 0)
    });
    v35.Image = createElement2("ImageLabel", v36, v37);
    v35.Button = React.createElement(Button, {
        BackgroundTransparency = 0,
        ZIndex = 3,
        AnchorPoint = Vector2.one / 2,
        Size = UDim2.fromOffset(60, 15),
        Position = UDim2.new(0.5, 0, 1, -15),
        BackgroundColor3 = Theme.Colors.WHITE,

        OnActivated = function() -- Line: 568, Name: OnActivated
            -- upvalues: u27 (copy), React (ref), AuraPage (ref), Item (copy), u33 (ref)
            local Widget = u27.Widget;
            u27.SetWidget({
                HideBackground = true,

                Widget = function(p39) -- Line: 574, Name: Widget
                    -- upvalues: React (ref), AuraPage (ref), Item (ref), u33 (ref)
                    return React.createElement(AuraPage, {
                        Aura = Item.Name,
                        Owned = u33,
                        Size = p39.Size,
                        Position = p39.Position,
                        AnchorPoint = p39.AnchorPoint
                    });
                end,

                ReturnFunc = function() -- Line: 585, Name: ReturnFunc
                    -- upvalues: u27 (ref), Widget (copy)
                    u27.SetWidget(Widget);
                end,

                ReturnText = Item.Name:upper() .. " AURA"
            });
        end
    }, {
        Corner = React.createElement("UICorner", {
            CornerRadius = UDim.new(1, 0)
        }),
        Text = React.createElement("TextLabel", {
            TextScaled = true,
            BackgroundTransparency = 1,
            Text = p25.Upsell and not u33 and "BUY" or "VIEW",
            FontFace = Theme.Fonts.Bold,
            TextColor3 = Theme.Colors.BLACK,
            Size = UDim2.fromScale(1, 0.75),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5)
        }),
        Stroke = React.createElement("UIStroke", {
            Transparency = 0.75,
            Thickness = 0.5,
            Color = Theme.Colors.BLACK
        })
    });

    return createElement("Frame", v34, v35);
end;

local function RollForAuras(u40) -- Line: 620
    -- upvalues: React (copy), State (copy), Enums (copy), useAuraData (copy), useTagged (copy), AuraItem (copy), useOwnership (copy), u2 (copy), u1 (copy), TextButton (copy), Players (copy), MarketplaceService (copy), RunContext (copy), AuraPage (copy)
    local u41 = React.useContext(State.Context);
    local Status = u41.Status;
    local v42 = u41.WindowState == Enums.WindowState.Compact;
    local u43, u44 = useAuraData();
    local u45 = useTagged("RelicsAura");
    local v46 = u44.RollsWithGamePass - u44.RollsPerDay;
    local v49 = React.useState(function() -- Line: 632
        -- upvalues: u45 (copy)
        local table_clone_ret = table.clone(u45);
        table.sort(table_clone_ret, function(p47, p48) -- Line: 635
            return (tonumber(p47:GetAttribute("Chance")) or 1) > (tonumber(p48:GetAttribute("Chance")) or 1);
        end);
        local table_remove_ret = table.remove(table_clone_ret);
        local table_remove_ret2 = table.remove(table_clone_ret);

        if #table_clone_ret <= 0 then
            return {};
        end;

        local math_random_ret = math.random(1, #table_clone_ret);

        return { table.remove(table_clone_ret, math_random_ret), table_remove_ret, table_remove_ret2 };
    end);
    local Theme = u41.Theme;
    local u50 = React.useRef(false);
    local u51 = React.useRef(0);
    local v52 = 0;
    local u53 = React.useRef(nil);
    local u54 = React.useRef(nil);
    local v55 = {};
    local v56 = {};

    if not v42 then
        for i, v in v49 do
            local v57 = u43.Unlocks[v.Name];
            v56[`Aura{i}`] = React.createElement(AuraItem, {
                Upsell = true,
                Item = v,
                Owned = v57,
                Size = UDim2.fromScale(0.225, 0.206)
            });
        end;
    end;

    local v58 = useOwnership({
        {
            Id = u44.RollGamePass,
            InfoType = Enum.InfoType.GamePass
        }
    });
    local v60 = React.useState(function() -- Line: 692
        -- upvalues: u2 (ref)
        local v59 = {};

        for i = 1, 2 do
            local table_clone_ret = table.clone(u2);
            local _ = i;

            while #table_clone_ret > 0 do
                local math_random_ret = math.random(1, #table_clone_ret);
                local table_remove_ret = table.remove(table_clone_ret, math_random_ret);
                table.insert(v59, assert(table_remove_ret));
            end;
        end;

        return v59;
    end);

    for i = -3.05, 1, 0.05 do
        local v61 = v60[(v52 - 1) % #v60 + 1];
        local v62;

        if v52 % 20 == 1 then
            v61 = "AURA REVEAL!\n<font size=\"4\" weight=\"400\" color=\"#4E059E\">5% CHANCE</font>";
            v62 = true;
        else
            v62 = false;
        end;

        v55[`Label_{v52}`] = React.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Position = UDim2.fromScale(0, i * 20)
        }, {
            Text = React.createElement("TextLabel", {
                TextScaled = true,
                BackgroundTransparency = 1,
                Text = v61,
                RichText = v62,
                TextColor3 = Color3.fromHex("#130736"),
                FontFace = Theme.Fonts.Bold,
                Size = UDim2.fromScale(1, v62 and 1.1 or 0.7),
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5)
            })
        });
        v52 = v52 + 1;
        local _ = i;
    end;

    React.useEffect(function() -- Line: 740
        -- upvalues: u54 (copy), u43 (copy), u1 (ref)
        local current = u54.current;

        if current then
            local task_spawn_ret = task.spawn(function() -- Line: 747
                -- upvalues: u43 (ref), current (copy), u1 (ref)
                while true do
                    if u43.Rolls < 1 then
                        local v63 = 86400 - (os.time() - u43.LastRenew);
                        local math_clamp_ret = math.clamp(v63, 0, 86400);
                        local math_floor_ret = math.floor(math_clamp_ret / 3600);
                        local math_floor_ret2 = math.floor(math_clamp_ret % 3600 / 60);
                        current.Text = string.format("<font size=\"4\" weight=\"600\">ROLLS RENEW IN:</font>\n<b>%02d:%02d:%02d</b>", math_floor_ret, math_floor_ret2, math_clamp_ret % 60);

                        if math_clamp_ret == 0 then
                            u1.GetAuraDataAsync();
                        end;
                    end;

                    task.wait(1);
                end;
            end);

            return function() -- Line: 769
                -- upvalues: task_spawn_ret (copy)
                task.cancel(task_spawn_ret);
            end;
        end;
    end, { u43 });

    if Status ~= Enums.UserStatus.BoomboxPurchased then
        u41.SetWindowTab(Enums.WindowTab.Upsell);

        return nil;
    end;

    local createElement = React.createElement;
    local Fragment = React.Fragment;
    local v64 = {
        List = React.createElement("UIListLayout", {
            Padding = UDim.new(0, 10),
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center
        }),
        Padding = React.createElement("UIPadding", {
            PaddingBottom = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10),
            PaddingLeft = UDim.new(0, 10),
            PaddingTop = UDim.new(0, 10)
        })
    };
    local createElement2 = React.createElement;
    local v65 = {
        Transparency = 1,
        LayoutOrder = -1,
        Size = UDim2.new(1, -16, 0, 0)
    };
    local v66 = {
        List = React.createElement("UIListLayout", {
            Wraps = true,
            Padding = UDim.new(0.025, 0),
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly,
            HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Left
        }),
        SlotDisplay = React.createElement("Frame", {
            ClipsDescendants = true,
            LayoutOrder = 2,
            Size = UDim2.fromScale(v42 and 0.741 or 1, 0.206),
            SizeConstraint = Enum.SizeConstraint.RelativeXX,
            BackgroundColor3 = Color3.new(1, 1, 1)
        }, {
            Corner = React.createElement("UICorner", {
                CornerRadius = UDim.new(0, 9)
            }),
            Gradient = React.createElement("UIGradient", {
                Rotation = 90,
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromHex("#7753aa")),
                    ColorSequenceKeypoint.new(0.3, Color3.fromHex("FFFFFF")),
                    ColorSequenceKeypoint.new(0.7, Color3.fromHex("FFFFFF")),
                    ColorSequenceKeypoint.new(1, Color3.fromHex("7753aa"))
                }),
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0.5),
                    NumberSequenceKeypoint.new(0.3, 0),
                    NumberSequenceKeypoint.new(0.7, 0.3),
                    NumberSequenceKeypoint.new(1, 0.5)
                })
            }),
            LeftWave = React.createElement("ImageLabel", {
                BackgroundTransparency = 1,
                Image = "rbxassetid://89948083083415",
                Size = UDim2.fromScale(0.6, 0.3),
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.fromScale(0, 0.5),
                ScaleType = Enum.ScaleType.Fit,
                SizeConstraint = Enum.SizeConstraint.RelativeYY
            }),
            RightWave = React.createElement("ImageLabel", {
                BackgroundTransparency = 1,
                Image = "rbxassetid://114028734806103",
                Size = UDim2.fromScale(0.6, 0.3),
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.fromScale(1, 0.5),
                ScaleType = Enum.ScaleType.Fit,
                SizeConstraint = Enum.SizeConstraint.RelativeYY
            }),
            RollTable = React.createElement("Frame", {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 0.2),
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5),
                ref = u53
            }, v55, {
                Scale = React.createElement("UIScale", {
                    Scale = 2.5
                })
            })
        }),
        AddRolls = React.createElement("ImageLabel", {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(0.225, 0.206),
            SizeConstraint = Enum.SizeConstraint.RelativeXX,
            Image = Theme.Images.Background,
            ScaleType = Enum.ScaleType.Crop,
            LayoutOrder = v42 and 2 or 1
        }, {
            Corner = React.createElement("UICorner", {
                CornerRadius = UDim.new(0.1, 0)
            }),
            Text = React.createElement("TextLabel", {
                TextScaled = true,
                BackgroundTransparency = 1,
                LayoutOrder = 1,
                Text = `ADD {v46}\nROLLS\nPER DAY`,
                TextColor3 = Theme.Colors.WHITE,
                FontFace = Theme.Fonts.Bold,
                Size = UDim2.fromScale(1, 0.6),
                Position = UDim2.fromScale(0.5, 0.35),
                AnchorPoint = Vector2.new(0.5, 0.5)
            }),
            Button = React.createElement(TextButton, {
                BackgroundTransparency = 1,
                LayoutOrder = 2,
                Text = v58 and "OWNED" or "BUY",
                BackgroundColor3 = v58 and Theme.Colors.GRAY or Theme.Colors.WHITE,
                Position = UDim2.new(0.5, 0, 1, -15),
                Size = UDim2.fromOffset(60, 15),
                OnActivated = not v58 and function() -- Line: 905
                    -- upvalues: Players (ref), u44 (copy), MarketplaceService (ref)
                    local LocalPlayer = Players.LocalPlayer;
                    local RollGamePass = u44.RollGamePass;

                    if LocalPlayer and RollGamePass then
                        MarketplaceService:PromptGamePassPurchase(LocalPlayer, RollGamePass);
                    end;
                end or nil
            })
        })
    };
    local createElement3 = React.createElement;
    local v67 = {
        BackgroundTransparency = 1,
        LayoutOrder = 4,
        Size = UDim2.fromScale(1, 0.206),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
        Image = Theme.Images.Background,
        ScaleType = Enum.ScaleType.Crop
    };
    local v68 = {};
    local createElement4 = React.createElement;
    local v69 = {
        Padding = UDim.new(0.1, 0),
        SortOrder = Enum.SortOrder.LayoutOrder
    };
    local v70;

    if u43.Rolls > 0 then
        v70 = Enum.UIFlexAlignment.SpaceEvenly;
    else
        v70 = Enum.UIFlexAlignment.Fill;
    end;

    v69.HorizontalFlex = v70;
    v69.FillDirection = Enum.FillDirection.Horizontal;
    v69.VerticalAlignment = Enum.VerticalAlignment.Center;
    v69.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    v68.List = createElement4("UIListLayout", v69);
    v68.Corner = React.createElement("UICorner", {
        CornerRadius = UDim.new(0, 9)
    });
    v68.Padding = React.createElement("UIPadding", {
        PaddingRight = UDim.new(0.1, 0),
        PaddingLeft = UDim.new(0.1, 0),
        PaddingBottom = UDim.new(),
        PaddingTop = UDim.new()
    });
    local v71;

    if u43.Rolls > 0 then
        v71 = React.createElement(TextButton, {
            Text = "ROLL",
            LayoutOrder = 1,
            ZIndex = 2,
            Size = UDim2.fromScale(1, 0.4166666666666667),
            SizeConstraint = Enum.SizeConstraint.RelativeYY,
            Flex = {
                FlexMode = Enum.UIFlexMode.Fill
            },

            OnActivated = function() -- Line: 959, Name: OnActivated
                -- upvalues: u53 (copy), u50 (copy), RunContext (ref), u1 (ref), u51 (copy), u41 (copy), React (ref), AuraPage (ref), u40 (copy)
                local current = u53.current;

                if u50.current or not current then
                    return;
                end;

                u50.current = not RunContext.IsEdit;
                local v72, v73 = u1.RollForAura();
                local u74 = v73;

                if RunContext.IsEdit and v72 then
                    print(u74);
                end;

                if not (v72 and u74.Rolled) then
                    u50.current = false;

                    return;
                end;

                local v75 = assert(u74.Roll) * 20;
                local v76 = math.ceil(v75) - 1;
                current.Position = UDim2.fromScale(0.5, 0.5 - (u51.current or 0) / 2);
                u51.current = v76;
                current.Position = current.Position + UDim2.fromScale(0, 30);

                if u74.UnlockedAura then
                    local Sound = Instance.new("Sound");
                    Sound.SoundId = "rbxassetid://1842442567";
                    Sound.Parent = current;
                    task.delay(2, function() -- Line: 990
                        -- upvalues: Sound (copy)
                        Sound:Play();
                        Sound.Ended:Connect(function() -- Line: 993
                            -- upvalues: Sound (ref)
                            Sound:Destroy();
                        end);
                    end);
                    task.delay(5, function() -- Line: 998
                        -- upvalues: u41 (ref), current (copy), React (ref), AuraPage (ref), u74 (ref), u40 (ref)
                        local Widget = u41.Widget;
                        local Sound2 = Instance.new("Sound");
                        Sound2.Parent = current:FindFirstAncestorWhichIsA("LayerCollector");
                        Sound2.SoundId = "rbxassetid://1843648200";
                        Sound2.Playing = true;
                        Sound2.Ended:Connect(function() -- Line: 1006
                            -- upvalues: Sound2 (copy)
                            Sound2:Destroy();
                        end);
                        u41.SetWidget({
                            HideBackground = true,
                            Confetti = true,

                            Widget = function() -- Line: 1011, Name: Widget
                                -- upvalues: React (ref), AuraPage (ref), u74 (ref), u40 (ref)
                                return React.createElement(AuraPage, {
                                    Owned = true,
                                    Aura = u74.UnlockedAura,
                                    Size = u40.Size,
                                    Position = u40.Position,
                                    AnchorPoint = u40.AnchorPoint
                                });
                            end,

                            ReturnFunc = function() -- Line: 1021, Name: ReturnFunc
                                -- upvalues: u41 (ref), Widget (copy)
                                u41.SetWidget(Widget);
                            end,

                            ReturnText = `{u74.UnlockedAura:upper()} AURA UNLOCKED! 🎉`
                        });
                    end);
                end;

                current:TweenPosition(UDim2.fromScale(0.5, 0.5 - v76 / 2), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 6, true, function(p77) -- Line: 1039
                    -- upvalues: u50 (ref)
                    u50.current = false;
                end);
            end
        });
    else
        v71 = false;
    end;

    v68.Roll = v71;
    v68.RollInfo = React.createElement("Frame", {
        LayoutOrder = 2,
        BackgroundColor3 = Color3.new(1, 1, 1),
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
        Size = UDim2.fromScale(1.2, 0.6)
    }, {
        Stroke = React.createElement("UIStroke", {
            Thickness = 1,
            Color = Theme.Colors.BLACK
        }),
        Corner = React.createElement("UICorner", {
            CornerRadius = UDim.new(0, 9)
        }),
        Rolls = React.createElement("TextLabel", {
            RichText = true,
            LineHeight = 1,
            TextScaled = true,
            BackgroundTransparency = 1,
            Text = u43.Rolls <= 0 and "" or `<b><font size="20">{u43.Rolls}</font></b>\n<b>ROLLS LEFT</b>`,
            Size = UDim2.fromScale(1, 0.75),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            FontFace = Theme.Fonts.Main,
            TextColor3 = Theme.Colors.BLACK,
            ref = u54
        })
    });
    v66.SlotCountdown = createElement3("ImageLabel", v67, v68);
    v66.Flex = React.createElement("UIFlexItem", {
        FlexMode = Enum.UIFlexMode.Fill
    });
    v64.View = createElement2("Frame", v65, v66, v56);

    return createElement(Fragment, nil, v64);
end;

local function AuraInventory(p78) -- Line: 1094
    -- upvalues: React (copy), State (copy), useTagged (copy), useAuraData (copy), AuraItem (copy), useSignal (copy), Enums (copy), ScrollFrame (copy)
    local u79 = React.useContext(State.Context);
    local Status = u79.Status;
    local u80 = React.useRef(nil);
    local Features = u79.Features;
    local v81 = useTagged("RelicsAura");
    local v82 = useAuraData();
    local v83 = {};

    for _, v in v81 do
        v83[v.Name] = React.createElement(AuraItem, {
            SortByRarity = true,
            Owned = v82.Unlocks[v.Name] or Features.Demo,
            Item = v
        });
    end;

    useSignal(u79.ReturnEvent, function() -- Line: 1116
        -- upvalues: u80 (copy), u79 (copy)
        local current = u80.current;

        if current and current.CanvasPosition.Y > 0 then
            current.CanvasPosition = Vector2.zero;

            return;
        end;

        u79.WidgetReturn();
    end);

    if Status ~= Enums.UserStatus.TryBeforeBuy and Status ~= Enums.UserStatus.TrialExpired then
        return React.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = p78.Size,
            Position = p78.Position,
            AnchorPoint = p78.AnchorPoint
        }, {
            Items = React.createElement(ScrollFrame, {
                Transparency = 1,
                ScrollBarThickness = 12,
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.one / 2,
                Size = UDim2.fromScale(1, 0.9),
                ScrollingDirection = Enum.ScrollingDirection.Y,
                ScrollRef = u80,
                CanvasSize = UDim2.fromScale(1, 0),
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                List = {
                    Wraps = true,
                    Padding = UDim.new(0, 12),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Horizontal,
                    VerticalAlignment = Enum.VerticalAlignment.Top,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center
                }
            }, v83)
        });
    end;

    u79.SetWindowTab(Enums.WindowTab.Upsell);

    return nil;
end;

return function(p84) -- Line: 1163, Name: AurasWidget
    -- upvalues: React (copy), State (copy), Enums (copy), AuraTitleButton (copy), RollForAuras (copy), AuraInventory (copy), MiniPlayer (copy)
    local v85 = React.useContext(State.Context);

    if v85.Features.Auras then
        return React.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = p84.Size,
            Position = p84.Position,
            AnchorPoint = p84.AnchorPoint
        }, {
            Content = React.createElement("Frame", {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, -64)
            }, {
                List = React.createElement("UIListLayout", {
                    Padding = UDim.new(0, 10),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Horizontal,
                    VerticalAlignment = Enum.VerticalAlignment.Top,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly
                }),
                RollForAuras = React.createElement("Frame", {
                    Transparency = 1,
                    Size = UDim2.fromScale(0.9, 0.9),
                    SizeConstraint = Enum.SizeConstraint.RelativeYY
                }, {
                    Button = React.createElement(AuraTitleButton, {
                        Title = "ROLL FOR AURAS",
                        Image = "rbxassetid://117630538212934",
                        Widget = RollForAuras
                    })
                }),
                Inventory = React.createElement("Frame", {
                    Transparency = 1,
                    Size = UDim2.fromScale(0.9, 0.9),
                    SizeConstraint = Enum.SizeConstraint.RelativeYY
                }, {
                    Button = React.createElement(AuraTitleButton, {
                        Title = "AURA INVENTORY",
                        Image = "rbxassetid://120281741386682",
                        Widget = AuraInventory
                    })
                })
            }),
            MiniPlayer = React.createElement(MiniPlayer, {
                Position = UDim2.new(0.5, 0, 1, -10),
                AnchorPoint = Vector2.new(0.5, 1)
            })
        });
    end;

    v85.SetWindowTab(Enums.WindowTab.Play);

    return nil;
end;