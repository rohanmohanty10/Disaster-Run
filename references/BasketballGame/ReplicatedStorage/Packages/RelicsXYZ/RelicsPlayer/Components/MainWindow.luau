 
 

local script_Parent = script.Parent;
local Parent = script_Parent.Parent;
local Widgets = require(Parent.Widgets);
local State = require(Parent.State);
local Enums = require(Parent.Enums);
local Shared = Parent.Parent.Shared;
local React = require(Shared.React);
local ReactSpring = require(Shared.ReactSpring);
local HeaderBar = require(script_Parent.HeaderBar);
local NavigationBar = require(script_Parent.NavigationBar);
local Hooks = Parent.Hooks;
local useClock = require(Hooks.useClock);
local useFormFactor = require(Hooks.useFormFactor);
local u1 = {
    [Enums.WindowState.Full] = 345,
    [Enums.WindowState.Compact] = 260,
    [Enums.WindowState.Minimized] = 60
};

local function Confetti() -- Line: 38
    -- upvalues: React (copy), useClock (copy)
    local u2 = React.useRef(nil);
    local u3 = {};
    local u4 = nil;
    local v5 = {};

    for i = 1, 128 do
        local Frame = Instance.new("Frame");
        Frame.Size = UDim2.fromOffset(20, 8);
        Frame.Rotation = math.random() * 360;
        Frame.BorderSizePixel = 0;
        Frame.BackgroundColor3 = Color3.fromHSV(0.6 + math.random() / 4, 0.8 + math.random() / 5, 1);
        Frame.Position = UDim2.fromScale(0.4 + math.random() / 5, 0.4 + math.random() / 5);
        u3[Frame] = {
            Velocity = Vector2.new(-1 + math.random() * 2, -1 + math.random() * 2) * 2,
            RotVelocity = (math.random() * 2 - 1) * 360
        };
        local _ = i;
    end;

    React.useEffect(function() -- Line: 80
        -- upvalues: u2 (copy), u4 (ref), u3 (copy)
        local current = u2.current;

        if current then
            if not u4 then
                u4 = current:FindFirstAncestorWhichIsA("LayerCollector");
            end;

            for i in u3 do
                i.Parent = current;
            end;
        end;
    end, {});
    useClock(45, function(p6) -- Line: 94
        -- upvalues: u3 (copy)
        local ViewportSize = workspace.CurrentCamera.ViewportSize;

        for i in u3 do
            local v7 = u3[i];
            local AbsolutePosition = i.AbsolutePosition;
            local v8 = v7.Velocity + Vector2.new(0, p6);
            v7.Velocity = v8;
            i.Rotation = (i.Rotation + v7.RotVelocity * p6) % 360;
            i.Position = i.Position + UDim2.fromScale(v8.X * p6, v8.Y * p6);

            if AbsolutePosition.X < 0 or (AbsolutePosition.Y < 0 or (AbsolutePosition.X > ViewportSize.X or AbsolutePosition.Y > ViewportSize.Y)) then
                i:Destroy();
                u3[i] = nil;
            end;
        end;
    end);

    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        ZIndex = 3,
        ref = u2,
        Size = UDim2.fromScale(1, 1)
    }, v5);
end;

return function(p9: table) -- Line: 126, Name: MainWindow
    -- upvalues: React (copy), State (copy), useFormFactor (copy), Enums (copy), Widgets (copy), u1 (copy), ReactSpring (copy), HeaderBar (copy), NavigationBar (copy), Confetti (copy)
    local u10 = React.useContext(State.Context);
    local v11 = useFormFactor();
    local Theme = u10.Theme;
    local v12, v13 = React.useState(nil);
    local WindowState = u10.WindowState;

    if v12 ~= u10.WindowTab then
        local v14 = Widgets[Enums.GetName(Enums.WindowTab, u10.WindowTab)];

        if v14 then
            u10.SetWidget({
                Widget = v14
            });
        end;

        v13(u10.WindowTab);
    end;

    local v15 = WindowState == Enums.WindowState.Full and Theme.Tweaks.UseTallWindow and 470 or u1[WindowState];
    local v16 = ReactSpring.useSpring({
        from = {
            Height = Theme.Tweaks.ShowCollapseButton and 100 or v15
        },
        to = {
            Height = v15
        },
        config = {
            tension = 500,
            friction = 30
        }
    });

    if u10.Status == Enums.UserStatus.TrialExpired then
        u10.SetWindowState(Enums.WindowState.Hidden);

        return nil;
    end;

    if WindowState == Enums.WindowState.Hidden then
        return nil;
    end;

    local v17 = WindowState == Enums.WindowState.Minimized;
    local Widget = u10.Widget;
    local v18, v19;

    if Widget and Widget.Widget then
        v18 = Widget.HideBackground;
        v19 = React.createElement(Widget.Widget, {
            Size = UDim2.fromScale(1, 1),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.one / 2
        });
    else
        v18 = false;
        v19 = nil;
    end;

    local createElement = React.createElement;
    local v22 = {
        Active = true,
        Draggable = true,

        [React.Event.DragStopped] = function(p20: userdata) -- Line: 197
            -- upvalues: u10 (copy)
            u10.SetPosition(p20.Position);
        end,

        BackgroundTransparency = 1,
        AnchorPoint = p9.AnchorPoint or Theme.Window.AnchorPoint,
        Position = p9.Position or (u10.Position or Theme.Window.Position),
        Size = v16.Height:map(function(p21) -- Line: 205
            -- upvalues: Theme (copy)
            return UDim2.fromOffset(Theme.Tweaks.CoreWidth, p21);
        end)
    };
    local v23 = {
        Header = React.createElement(HeaderBar, {
            Size = UDim2.new(1, 0, 0, v17 and 60 or 43),
            Branding = Theme.Branding,
            MockBrand = p9.MockBrand
        })
    };
    local v26 = not v17 and React.createElement(NavigationBar, {
        Position = UDim2.fromScale(0.5, 1),
        AnchorPoint = Vector2.new(0.5, 1),
        Size = UDim2.new(1, 0, 0, 56),

        OnActivated = function(p24, p25) -- Line: 220, Name: OnActivated
            -- upvalues: u10 (copy)
            if u10.WindowTab == p25 then
                u10.ReturnEvent:Fire();

                return;
            end;

            u10.SetWindowTab(p25);
        end
    });
    v23.NavBar = v26;
    v23.Scale = React.createElement("UIScale", {
        Scale = (p9.Scale or (Theme.Window.Scale or 1)) * (v11 == "Phone" and 0.8 or 1)
    });
    local v27 = not v18 and React.createElement("Frame", {
        ZIndex = 0,
        BackgroundColor3 = Color3.new(1, 1, 1),
        Size = UDim2.new(1, 0, 1, v17 and 0 or -32)
    }, {
        Gradient = React.createElement("UIGradient", {
            Rotation = 90,
            Color = Theme.Colors.BACKGROUND_GRADIENT
        }),
        Corner = React.createElement("UICorner", {
            CornerRadius = UDim.new(0, 9)
        })
    });
    v23.Background = v27;
    local v28;

    if Widget and Widget.Confetti then
        v28 = React.createElement(Confetti);
    else
        v28 = nil;
    end;

    v23.Confetti = v28;
    local v29 = not v17 and React.createElement("Frame", {
        BackgroundTransparency = 1,
        ZIndex = 2,
        Size = UDim2.new(1, 0, 1, -99),
        Position = UDim2.new(0, 0, 0, 43)
    }, {
        Widget = v19
    });
    v23.Body = v29;

    return createElement("Frame", v22, v23);
end;