  

local Parent = script.Parent.Parent;
local Shared = Parent.Parent.Shared;
local Button = require(script.Parent.Button);
local Hooks = Parent.Hooks;
local State = require(Parent.State);
local Enums = require(Parent.Enums);
local React = require(Shared.React);
local Upsell = require(Parent.Widgets.Upsell);
local usePlaylist = require(Hooks.usePlaylist);

return function(u1: table) -- Line: 23, Name: Playlist
    -- upvalues: usePlaylist (copy), React (copy), State (copy), Enums (copy), Button (copy), Upsell (copy)
    local Index = u1.Index;
    local u2 = usePlaylist(u1.Playlist);
    local u3 = React.useContext(State.Context);
    local Theme = u3.Theme;
    local u4 = u3.Status == Enums.UserStatus.BoomboxPurchased and true or u2.IsFree;
    local createElement = React.createElement;
    local v5 = {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        AnchorPoint = Vector2.one / 2,
        SizeConstraint = Enum.SizeConstraint.RelativeYY
    };

    if u2.IsFree then
        Index = Index + -1000 or Index;
    end;

    v5.LayoutOrder = Index;
    local v6 = {};
    local createElement2 = React.createElement;
    local v7 = {
        BackgroundTransparency = 0,
        AutoButtonColor = false,
        HoverScale = 1.025,
        PressScale = 0.925
    };
    local v8;

    if u4 then
        v8 = u2.Image;
    else
        v8 = Theme.Images.LockedPlaylist;
    end;

    v7.Image = v8;
    v7.Size = UDim2.fromScale(0.9, 0.9);
    v7.AnchorPoint = Vector2.one / 2;
    v7.BackgroundColor3 = Color3.new();
    v7.Position = UDim2.fromScale(0.5, 0.5);

    function v7.OnActivated() -- Line: 58
        -- upvalues: u3 (copy), u4 (copy), u1 (copy), u2 (copy), Upsell (ref), Enums (ref)
        local Widget = u3.Widget;

        if u4 then
            u1.SetPlaylist(u2.Name, u2.Songs);

            return;
        end;

        u3.SetWidget({
            ReturnText = "Browse",
            Widget = Upsell,

            ReturnFunc = function() -- Line: 70, Name: ReturnFunc
                -- upvalues: u3 (ref), Enums (ref), Widget (copy)
                u3.SetWindowTab(Enums.WindowTab.Browse);
                u3.SetWidget(Widget);
            end
        });
        u3.SetWindowTab(Enums.WindowTab.Upsell);
    end;

    local v9 = {
        Corner = React.createElement("UICorner", {
            CornerRadius = Theme.Tweaks.PanelCornerRadius
        })
    };

    if u4 then
        u4 = React.createElement("TextLabel", {
            TextScaled = true,
            BackgroundTransparency = 1,
            Text = u2.Name:upper(),
            TextColor3 = Color3.new(1, 1, 1),
            FontFace = Theme.Fonts.Card,
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Size = UDim2.fromScale(0.75, 0.25)
        });
    end;

    v9.Title = u4;
    v9.Stroke = React.createElement("UIStroke", {
        Thickness = 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
        Color = Color3.fromHex("#7D1BDD")
    });
    v6.Button = createElement2(Button, v7, v9);

    return createElement("Frame", v5, v6);
end;