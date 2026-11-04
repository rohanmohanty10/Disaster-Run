 

 

local TweenService = game:GetService("TweenService");
local HttpService = game:GetService("HttpService");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4, p5) -- Line: 6
    -- upvalues: u1 (copy)
    local EscapeStreak = p2.MainFrame.NotificationsF:WaitForChild("EscapeStreak");
    EscapeStreak.Visible = false;
    EscapeStreak.GroupTransparency = 1;

    return setmetatable({
        raw = nil,
        count = 0,
        serial = 0,
        allowed = false,
        alive = true,
        view = EscapeStreak,
        session = p3,
        player = p4,
        colors = p5,
        snapshot = {},
        tweens = {}
    }, u1);
end;

function u1.cancel(p6) -- Line: 12
    p6.serial = p6.serial + 1;

    for _, v in p6.tweens do
        v:Cancel();
    end;

    table.clear(p6.tweens);

    if p6.pulse then
        p6.pulse:Cancel();
        p6.pulse = nil;
    end;

    p6.view.Count.TextTransparency = 0;
end;

function u1.tween(p7, p8, p9, p10, p11) -- Line: 19
    -- upvalues: TweenService (copy)
    local v12 = TweenService:Create(p8, TweenInfo.new(p9, p11 or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), p10);
    table.insert(p7.tweens, v12);
    v12:Play();

    return v12;
end;

function u1.hide(p13) -- Line: 24
    p13:cancel();
    p13.view.Visible = false;
    p13.view.GroupTransparency = 1;
end;

function u1.updateHint(p14) -- Line: 27
    local v15 = p14.snapshot.count or 0;
    local v16 = p14.snapshot.goal or 3;

    if v16 <= v15 then
        p14.view.Hint.Text = "RUNNERS WIN!";

        return;
    end;

    if v15 == v16 - 1 then
        p14.view.Hint.Text = p14.player:GetAttribute("GameRole") == "Catcher" and "Catch someone to break the streak!" or "One more clean escape to win!";

        return;
    end;

    p14.view.Hint.Text = ("Runners win at %d clean escapes in a row."):format(v16);
end;

function u1.show(p17) -- Line: 37
    -- upvalues: TweenService (copy)
    local view = p17.view;
    local count = p17.snapshot.count;
    local goal = p17.snapshot.goal;
    local v18 = not view.Visible;
    p17:cancel();
    view.Visible = true;
    view.Caption.Text = "CLEAN ESCAPES";
    view.Count.Text = ("%d/%d"):format(count, goal);
    local v19 = count == goal - 1 and p17.colors.Gold or p17.colors.Mint;
    view.Caption.TextColor3 = p17.colors.Text;
    view.Count.TextColor3 = v19;
    view.Hint.TextColor3 = p17.colors.Text;

    if v18 then
        view.GroupTransparency = 1;
        view.Reveal.Scale = 0.96;

        for i = 1, 3 do
            view.Segments["Segment" .. i].Fill.Size = UDim2.fromScale(0, 1);
            local _ = i;
        end;
    end;

    p17:tween(view, 0.22, {
        GroupTransparency = 0
    });
    p17:tween(view.Reveal, 0.32, {
        Scale = 1
    }, Enum.EasingStyle.Back);

    for i = 1, 3 do
        local Fill = view.Segments["Segment" .. i].Fill;
        Fill.BackgroundColor3 = v19;
        p17:tween(Fill, 0.38, {
            Size = UDim2.fromScale(i <= count and 1 or 0, 1)
        });
        local _ = i;
    end;

    p17:updateHint();

    if count == goal - 1 then
        p17.pulse = TweenService:Create(view.Count, TweenInfo.new(0.85, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            TextTransparency = 0.3
        });
        p17.pulse:Play();
    end;
end;

function u1.broken(u20, p21) -- Line: 62
    local view = u20.view;
    u20:cancel();
    local serial = u20.serial;
    view.Visible = true;
    view.GroupTransparency = 0;
    view.Reveal.Scale = 1;
    view.Caption.Text = p21 == "RunnerLeft" and "ESCAPE STREAK RESET" or "ESCAPE STREAK BROKEN";
    view.Caption.TextColor3 = u20.colors.Text;
    view.Count.Text = "0/" .. tostring(u20.snapshot.goal or 3);
    view.Count.TextColor3 = u20.colors.Text;
    view.Hint.Text = p21 == "RunnerLeft" and "A runner left the match." or "Build another streak next round.";

    for i = 1, 3 do
        u20:tween(view.Segments["Segment" .. i].Fill, 0.3, {
            Size = UDim2.fromScale(0, 1)
        });
        local _ = i;
    end;

    task.delay(1, function() -- Line: 71
        -- upvalues: u20 (copy), serial (copy), view (copy)
        if not u20.alive or u20.serial ~= serial then
            return;
        end;

        u20:tween(view, 0.35, {
            GroupTransparency = 1
        });
        task.delay(0.35, function() -- Line: 74
            -- upvalues: u20 (ref), serial (ref), view (ref)
            if u20.alive and u20.serial == serial then
                view.Visible = false;
            end;
        end);
    end);
end;

function u1.update(p22, p23) -- Line: 79
    -- upvalues: HttpService (copy)
    local Attribute = p22.session:GetAttribute("EscapeStreakState");
    local v24 = Attribute ~= p22.raw;
    local matchId = p22.snapshot.matchId;

    if v24 then
        p22.raw = Attribute;
        local success, result = pcall(HttpService.JSONDecode, HttpService, Attribute or "{}");
        p22.snapshot = not (success and (type(result) == "table" and result)) and {} or result;
    end;

    local snapshot = p22.snapshot;
    local v25 = snapshot.count or 0;
    local v26;

    if p22.player:GetAttribute("InMatch") == true and (p22.player:GetAttribute("GameRole") ~= "Lobby" and (p23 ~= "Lobby" and (p23 ~= "Countdown" and p23 ~= "FinalRun"))) then
        v26 = p23 ~= "Results" and true or snapshot.event == "Won";
    else
        v26 = false;
    end;

    if not v26 then
        if p22.allowed or p22.view.Visible then
            p22:hide();
        end;

        p22.allowed = false;
        p22.count = v25;

        return;
    end;

    if v24 or not p22.allowed then
        if matchId ~= snapshot.matchId then
            p22:hide();
            p22.count = 0;
        end;

        if v25 > 0 then
            p22:show();
        elseif p22.count > 0 and (snapshot.event == "Broken" or (snapshot.event == "RunnerLeft" or snapshot.event == "Interrupted")) then
            p22:broken(snapshot.event);
        else
            p22:hide();
        end;
    end;

    p22.allowed = true;
    p22.count = v25;

    if v25 > 0 then
        p22:updateHint();
    end;
end;

function u1.destroy(p27) -- Line: 107
    p27.alive = false;
    p27:hide();
end;

return u1;