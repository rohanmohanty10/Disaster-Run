 
 

local script_Parent = script.Parent;
local Button = require(script_Parent.Button);
local Parent = script_Parent.Parent;
local Hooks = Parent.Hooks;
local Parent2 = Parent.Parent;
local Shared = Parent2.Shared;
local React = require(Shared.React);
local ReactSpring = require(Shared.ReactSpring);
local u1 = require(Parent2);
local useFavorites = require(Hooks.useFavorites);
local Enums = require(Parent.Enums);
local State = require(Parent.State);

return function(u2: table) -- Line: 27, Name: FavoriteButton
    -- upvalues: React (copy), State (copy), useFavorites (copy), Enums (copy), ReactSpring (copy), Button (copy), u1 (copy)
    local u3 = React.useContext(State.Context);
    local Features = u3.Features;
    local Status = u3.Status;
    local v4 = useFavorites();
    local SongId = u2.SongId;
    local u5 = SongId and table.find(v4, SongId) ~= nil;

    if Status ~= Enums.UserStatus.BoomboxPurchased then
        u5 = false;
    end;

    local Theme = u3.Theme;
    local Colors = Theme.Colors;
    local Images = Theme.Images;
    local v6 = ReactSpring.useSpring({
        from = {
            Fade = u5 and 0 or 1
        },
        to = {
            Fade = u5 and 0 or 1
        },
        config = {
            tension = 800,
            friction = 30
        }
    });
    local Favorites = Features.Favorites;

    if Favorites then
        local createElement = React.createElement;
        local v7 = {
            BackgroundTransparency = 1,
            Size = u2.Size or UDim2.fromScale(32, 32),
            SizeConstraint = Enum.SizeConstraint.RelativeYY,
            ImageColor3 = Colors.GRAY,
            AnchorPoint = u2.AnchorPoint,
            LayoutOrder = u2.LayoutOrder,
            Position = u2.Position,
            Image = Images.Favorite.Off
        };
        v7.OnActivated = u2.SongId and function() -- Line: 66
            -- upvalues: Status (copy), Enums (ref), u3 (copy), u5 (ref), u1 (ref), u2 (copy)
            if Status ~= Enums.UserStatus.BoomboxPurchased then
                u3.SetWindowTab(Enums.WindowTab.Upsell);

                return;
            end;

            local v8;

            if u5 then
                v8 = u1.RemoveFavoriteAsync;
            else
                v8 = u1.AddFavoriteAsync;
            end;

            v8(u2.SongId);
        end;
        v7.ImageTransparency = v6.Fade:map(function(p9) -- Line: 79
            return 1 - p9;
        end);
        Favorites = createElement(Button, v7, {
            Overlay = React.createElement("ImageLabel", {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1),
                Image = Images.Favorite.On,
                ImageTransparency = v6.Fade,
                ImageColor3 = Colors.ACTIVE
            })
        });
    end;

    return Favorites;
end;