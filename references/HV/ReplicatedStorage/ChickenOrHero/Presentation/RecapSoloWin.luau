 

 

local TweenService = game:GetService("TweenService");
local AvatarPortraits = require(script.Parent.AvatarPortraits);
local VerifiedName = require(script.Parent.VerifiedName);
local u1 = {};
u1.__index = u1;

function u1.winner(p2) -- Line: 7
    if type(p2.soloWinnerUserId) ~= "number" then
        return;
    end;

    for _, v in p2.participants do
        if v.userId == p2.soloWinnerUserId and (v.won == true and not (v.left or (v.caught or not v.hasRun))) then
            return v;
        end;
    end;
end;

function u1.new(p3, p4) -- Line: 13
    -- upvalues: AvatarPortraits (copy), u1 (copy)
    local v5 = {
        frame = p3,
        cue = p4,
        portraits = AvatarPortraits.new(),
        tweens = {}
    };

    return setmetatable(v5, u1);
end;

function u1.hide(p6) -- Line: 16
    for _, v in p6.tweens do
        v:Cancel();
    end;

    table.clear(p6.tweens);
    p6.portraits:clear();
    p6.frame.Visible = false;
end;

function u1.show(p7, p8) -- Line: 20
    -- upvalues: VerifiedName (copy), TweenService (copy)
    p7:hide();
    local frame = p7.frame;
    frame.PlayerName.RichText = true;
    frame.PlayerName.Text = VerifiedName.format(p8.name, p8.verified, p8.userId);
    frame.Visible = true;
    frame.GroupTransparency = 1;
    frame.RevealScale.Scale = 0.94;
    p7.portraits:bind(frame, p8);
    local v9 = TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    });
    local v10 = TweenService:Create(frame.RevealScale, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    });
    table.insert(p7.tweens, v9);
    table.insert(p7.tweens, v10);
    v9:Play();
    v10:Play();
    p7.cue("RecapOpen", 0.9);
end;

function u1.destroy(p11) -- Line: 31
    p11:hide();
    p11.portraits:destroy();
end;

return u1;