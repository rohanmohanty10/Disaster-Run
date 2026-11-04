  

local Parent = script.Parent.Parent;
local Enums = require(Parent.Enums);
local State = require(Parent.State);
local Shared = Parent.Parent.Shared;
local React = require(Shared.React);
local ReactSpring = require(Shared.ReactSpring);
local Hooks = Parent.Hooks;
local useClock = require(Hooks.useClock);
local useSettings = require(Hooks.useSettings);
local script_Parent = script.Parent;
local Button = require(script_Parent.Button);
local View3D = require(script_Parent.View3D);
local u1 = {
    {
        Position = UDim2.new(0.5, 0, 0, 2),
        LeftTangent = UDim2.fromScale(-0.27614237491539667, 0),
        RightTangent = UDim2.fromScale(0.27614237491539667, 0)
    },
    {
        Position = UDim2.new(1, -2, 0.5, 0),
        LeftTangent = UDim2.fromScale(0, -0.27614237491539667),
        RightTangent = UDim2.fromScale(0, 0.27614237491539667)
    },
    {
        Position = UDim2.new(0.5, 0, 1, -2),
        LeftTangent = UDim2.fromScale(0.27614237491539667, 0),
        RightTangent = UDim2.fromScale(-0.27614237491539667, 0)
    },
    {
        Position = UDim2.new(0, 2, 0.5, 0),
        LeftTangent = UDim2.fromScale(0, 0.27614237491539667),
        RightTangent = UDim2.fromScale(0, -0.27614237491539667)
    },
    {
        Position = UDim2.new(0.5, 0, 0, 2),
        LeftTangent = UDim2.fromScale(-0.27614237491539667, 0),
        RightTangent = UDim2.fromScale(0.27614237491539667, 0)
    }
};

local function Ring(p2: table) -- Line: 89
    -- upvalues: React (copy), State (copy), u1 (copy), useClock (copy)
    local Spectrogram = React.useContext(State.Context).GetSpectrogram();
    local u3 = React.useRef(0);
    local u4 = assert(u3.current);
    local u5 = React.useRef(nil);
    local u6 = React.useRef(nil);
    local Size0 = p2.Size0;
    local Size1 = p2.Size1;
    local Color0 = p2.Color0;
    local Color1 = p2.Color1;
    local Thickness0 = p2.Thickness0;
    local Thickness1 = p2.Thickness1;
    React.useEffect(function() -- Line: 103
        -- upvalues: u6 (copy), u1 (ref)
        local current = u6.current;

        if current then
            local v7 = {};

            for _, v in u1 do
                local Path2DControlPoint_new_ret = Path2DControlPoint.new(v.Position, v.LeftTangent, v.RightTangent);
                table.insert(v7, Path2DControlPoint_new_ret);
            end;

            current:SetControlPoints(v7);
        end;
    end, {});
    useClock(40, function(p8) -- Line: 123
        -- upvalues: Spectrogram (copy), u4 (ref), Size0 (copy), Size1 (copy), Color0 (copy), Color1 (copy), Thickness0 (copy), Thickness1 (copy), u5 (copy), u6 (copy), u3 (copy)
        if Spectrogram then
            p8 = p8 * (math.clamp(Spectrogram.RmsLevel * 20 + Spectrogram.PeakLevel * 10, 0, 9) / 3);
        end;

        u4 = u4 + p8;
        local v9 = u4 * 2 % 1;
        local v10 = Size0 + (Size1 - Size0) * v9;
        local v11 = Color0:Lerp(Color1, v9);
        local v12 = Thickness0 + (Thickness1 - Thickness0) * v9;
        local current = u5.current;
        local current2 = u6.current;

        if current and current2 then
            current2.Color3 = v11;
            current.GroupTransparency = 1 - v12;
            current.Size = UDim2.fromScale(v10 / 2, v10 / 2);
        end;

        u3.current = u4;
    end, { Spectrogram });

    return React.createElement("CanvasGroup", {
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.one / 2,
        ref = u5
    }, {
        Corner = React.createElement("UICorner", {
            CornerRadius = UDim.new(1, 0)
        }),
        Ring = React.createElement("Path2D", {
            Color3 = p2.Color0,
            ref = u6
        })
    });
end;

local function createModel() -- Line: 167
    local v13 = script.Render:Clone();
    local v14 = {};

    for _, child in v13:GetChildren() do
        if child:IsA("BasePart") then
            local Poses = child:FindFirstChild("Poses");
            local Verts = child:FindFirstChild("Verts");
            local v15 = {
                Poses = {},
                Verts = {}
            };
            local v16;

            if Poses then
                v16 = child;

                for _, child2 in Poses:GetChildren() do
                    local Name = child2.Name;
                    local v17 = {};

                    for _, child3 in child2:GetChildren() do
                        if child3:IsA("Attachment") then
                            v17[child3.Name] = child3.CFrame;
                        end;
                    end;

                    v15.Poses[Name] = v17;
                end;
            else
                v16 = child;
            end;

            if Verts then
                for _, child2 in Verts:GetChildren() do
                    if child2:IsA("Bone") then
                        v15.Verts[child2.Name] = child2;
                    end;
                end;
            end;

            v14[v16] = v15;
        end;
    end;

    return {
        Model = v13,
        Parts = v14
    };
end;

local function PlayIcon(p18: table) -- Line: 219
    -- upvalues: React (copy), State (copy), createModel (copy), ReactSpring (copy), useClock (copy), View3D (copy)
    local v19 = React.useContext(State.Context);
    local v20, v21 = React.useState(createModel);
    local Theme = v19.Theme;

    if #v20.Model:GetChildren() == 0 then
        v21(createModel);
    end;

    local Model = v20.Model;
    local Parts = v20.Parts;
    local Playing = v19.Playing;
    local u22 = -1;
    local u23 = ReactSpring.useSpring({
        from = {
            Lerp = Playing and 0 or 1
        },
        to = {
            Lerp = Playing and 0 or 1
        },
        config = {
            tension = 800,
            friction = 50
        }
    });
    useClock(30, function(p24) -- Line: 249
        -- upvalues: u23 (copy), u22 (ref), Parts (copy)
        local Value = u23.Lerp:getValue();
        local math_clamp_ret = math.clamp(Value, 0, 1);

        if math_clamp_ret == u22 then
            return;
        end;

        u22 = math_clamp_ret;

        for _, v in Parts do
            local Poses = v.Poses;
            local Play = Poses.Play;
            local Pause = Poses.Pause;

            if Play and Pause then
                for i, v2 in v.Verts do
                    v2.CFrame = Pause[i]:Lerp(Play[i], math_clamp_ret);
                end;
            end;
        end;
    end);

    return React.createElement(View3D, {
        FieldOfView = 1,
        Model = Model,
        AnchorPoint = Vector2.one / 2,
        Size = UDim2.fromScale(0.75, 0.75),
        Position = UDim2.fromScale(0.5, 0.5),
        Ambient = Color3.fromHex("#FFFFFF"),
        TintColor = Theme.Colors.CONTROLS
    });
end;

return function(p25: table) -- Line: 286, Name: PlayButton
    -- upvalues: React (copy), State (copy), useSettings (copy), Enums (copy), ReactSpring (copy), Button (copy), PlayIcon (copy), Ring (copy)
    local u26 = React.useContext(State.Context);
    local Playing = u26.Playing;
    local Theme = u26.Theme;
    local ProximityAudio = useSettings().ProximityAudio;

    if u26.Status ~= Enums.UserStatus.BoomboxPurchased then
        ProximityAudio = false;
    end;

    local v27 = ReactSpring.useSpring({
        from = {
            Fade = Playing and 0 or 1,
            ForFriends = Playing and ProximityAudio and 0 or 1
        },
        to = {
            Fade = Playing and 0 or 1,
            ForFriends = Playing and ProximityAudio and 0 or 1
        },
        config = {
            tension = 200,
            friction = 30
        }
    });
    local createElement = React.createElement;
    local v28 = {
        BackgroundTransparency = 1,
        Size = p25.Size or UDim2.fromOffset(50, 50),
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
        Position = p25.Position or UDim2.fromScale(0.5, 0.5),
        AnchorPoint = p25.AnchorPoint or Vector2.one / 2,
        LayoutOrder = p25.LayoutOrder
    };
    local v29 = {};
    local v30 = p25.Scale and React.createElement("UIScale", {
        Scale = p25.Scale
    });
    v29.Scale = v30;
    v29.ForFriends = React.createElement("TextLabel", {
        BackgroundTransparency = 1,
        TextScaled = true,
        Text = "playing for others",
        ZIndex = 2,
        FontFace = Theme.Fonts.Bold,
        Size = v27.ForFriends:map(function(p31) -- Line: 334
            return UDim2.fromScale(3, (1 - p31) / 5);
        end),
        Position = UDim2.fromScale(0.5, 1.025),
        AnchorPoint = Vector2.new(0.5, 0),
        TextColor3 = Theme.Colors.CONTROLS,
        TextStrokeTransparency = v27.ForFriends:map(function(p32) -- Line: 345
            return 0.875 + p32 / 8;
        end),
        TextTransparency = v27.ForFriends
    });
    v29.Button = React.createElement(Button, {
        Size = UDim2.fromScale(1, 1),

        OnActivated = function() -- Line: 356, Name: OnActivated
            -- upvalues: u26 (copy)
            u26.SetPlaying(not u26.Playing);
        end
    }, {
        Image = React.createElement(PlayIcon, {
            Scale = p25.Scale
        }),
        Rings = React.createElement("CanvasGroup", {
            BackgroundTransparency = 1,
            ZIndex = 1,
            GroupTransparency = v27.Fade,
            Size = UDim2.fromScale(2.5, 2.5),
            AnchorPoint = Vector2.one / 2,
            Position = UDim2.fromScale(0.5, 0.5)
        }, {
            Scale = React.createElement("UIScale", {
                Scale = v27.Fade:map(function(p33) -- Line: 373
                    return 1 - p33 / 2;
                end)
            }),
            Ring0 = React.createElement(Ring, {
                Size0 = 0.44,
                Size1 = 0.72,
                Thickness0 = 1,
                Thickness1 = 1,
                Color0 = Theme.Colors.BACKGROUND_HEADER_FOOTER,
                Color1 = Theme.Colors.ACTIVE
            }),
            Ring1 = React.createElement(Ring, {
                Size0 = 0.72,
                Size1 = 1,
                Thickness0 = 1,
                Thickness1 = 1,
                Color0 = Theme.Colors.ACTIVE,
                Color1 = Theme.Colors.LIGHT_ACTIVE
            }),
            Ring2 = React.createElement(Ring, {
                Size0 = 1,
                Size1 = 1.28,
                Thickness0 = 1,
                Thickness1 = 0,
                Color0 = Theme.Colors.LIGHT_ACTIVE,
                Color1 = Theme.Colors.BACKGROUND_HEADER_FOOTER
            })
        })
    });
    v29.MinSize = React.createElement("UISizeConstraint", {
        MinSize = Vector2.new(16, 16)
    });

    return createElement("Frame", v28, v29);
end;