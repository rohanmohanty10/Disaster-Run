 

 

local TweenService = game:GetService("TweenService");
local AvatarPortraits = require(script.Parent.AvatarPortraits);
local VerifiedName = require(script.Parent.VerifiedName);
local u1 = {};
u1.__index = u1;
local u2 = {
    {
        key = "mvp",
        title = "MATCH MVP",
        empty = "No scoring actions this match",
        color = Color3.fromRGB(255, 205, 112)
    },
    {
        key = "survival",
        title = "LONGEST SURVIVAL",
        empty = "No Runner time recorded",
        color = Color3.fromRGB(107, 226, 186)
    },
    {
        key = "catches",
        title = "MOST CATCHES",
        empty = "Everyone got away",
        color = Color3.fromRGB(255, 130, 136)
    }
};

local function timeText(p3) -- Line: 12
    local v4 = math.floor(p3 * 10 + 0.5) / 10;
    local math_max_ret = math.max(0, v4);

    return math_max_ret >= 60 and ("%dm %04.1fs"):format(math.floor(math_max_ret / 60), math_max_ret % 60) or ("%.1fs"):format(math_max_ret);
end;

function u1.new(p5, u6, p7) -- Line: 16
    -- upvalues: AvatarPortraits (copy), u1 (copy), u2 (copy)
    local v8 = {
        revision = 0,
        panel = p5,
        cfg = u6,
        cue = p7,
        portraits = AvatarPortraits.new(),
        cards = {},
        connections = {},
        tweens = {}
    };
    local u9 = setmetatable(v8, u1);

    for i, v in { "First", "Second", "Third" } do
        local v10 = p5.Stage[v];
        u9.cards[i] = {
            view = v10,
            position = v10.Position
        };
    end;

    for i, v in u2 do
        table.insert(u9.connections, p5.Tabs[v.key].Activated:Connect(function() -- Line: 23
            -- upvalues: u9 (copy), i (copy), u6 (copy)
            if u9.active then
                u9.manual = i;
                u9.manualUntil = workspace:GetServerTimeNow() + u6.StageSeconds;
                u9:setStage(i, workspace:GetServerTimeNow());
            end;
        end));
    end;

    return u9;
end;

function u1.cancel(p11) -- Line: 29
    p11.revision = p11.revision + 1;

    for _, v in p11.tweens do
        v:Cancel();
    end;

    table.clear(p11.tweens);
    p11.portraits:clear();
end;

function u1.tween(p12, p13, p14, p15, p16) -- Line: 34
    -- upvalues: TweenService (copy)
    local v17 = TweenService:Create(p13, TweenInfo.new(p14, p16 or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), p15);
    table.insert(p12.tweens, v17);
    v17:Play();
end;

function u1.setStage(u18, p19, p20) -- Line: 38
    -- upvalues: u2 (copy), VerifiedName (copy)
    if u18.index == p19 then
        return;
    end;

    u18:cancel();
    u18.index = p19;
    u18.stageAt = p20;
    local revision = u18.revision;
    local v21 = u2[p19];
    local v22 = u18.data.rankings[v21.key] or {};
    u18.panel.StageTitle.Text = v21.title;
    u18.panel.StageTitle.TextColor3 = v21.color;
    u18.panel.Stage.GroupTransparency = 1;
    u18:tween(u18.panel.Stage, u18.cfg.StageFade, {
        GroupTransparency = 0
    });
    u18.panel.Stage.Empty.Text = v21.empty;
    u18.panel.Stage.Empty.Visible = #v22 == 0;

    for i, v in u18.cards do
        local view = v.view;
        local v23 = v22[i];
        local v24;

        if v23 then
            v24 = u18.rows[v23.userId];
        else
            v24 = v23;
        end;

        v.award = v24 and v23 and v23 or nil;
        view.Visible = v24 ~= nil;
        view.Position = v.position;
        u18.portraits:bind(view, v24);

        if v24 then
            view.PlayerName.RichText = true;
            view.PlayerName.Text = VerifiedName.format(v24.name, v24.verified, v24.userId);
            view.Rank.Text = (v23.tiedCount > 1 and "JOINT #" or "#") .. v23.rank;
            view.Rank.TextColor3 = v21.color;
            view.Metric.TextColor3 = v21.color;
            view.Metric.Text = "";
            view.GroupTransparency = 1;
            view.Position = UDim2.fromScale(i == 1 and 0.5 or (i == 2 and 0.37 or 0.63), v.position.Y.Scale + 0.025);

            local function reveal() -- Line: 55
                -- upvalues: u18 (copy), revision (copy), view (copy), v (copy)
                if not u18.active or revision ~= u18.revision then
                    return;
                end;

                u18:tween(view, 0.32, {
                    GroupTransparency = 0,
                    Position = v.position
                }, Enum.EasingStyle.Back);
            end;

            if i == 1 then
                reveal();
            else
                task.delay(u18.cfg.SideRevealDelay, reveal);
            end;
        end;
    end;

    for i, v in u2 do
        local v25 = u18.panel.Tabs[v.key];
        v25.TextColor3 = i == p19 and v21.color or Color3.fromRGB(159, 177, 190);
        v25.Underline.BackgroundColor3 = v21.color;
        v25.Underline.Visible = i == p19;
    end;

    u18.cue("RecapOpen");
end;

function u1.show(p26, p27, p28) -- Line: 69
    p26.active = true;
    p26.data = p27;
    p26.rows = {};
    p26.index = nil;
    p26.manual = nil;

    for _, v in p27.participants do
        p26.rows[v.userId] = v;
    end;

    p26:update(p28);
end;

function u1.update(p29, p30) -- Line: 74
    -- upvalues: u2 (copy)
    if not p29.active then
        return;
    end;

    local v31 = math.max(0, p30 - p29.data.shownAt) / p29.cfg.StageSeconds;
    local v32 = math.floor(v31) + 1;
    local math_clamp_ret = math.clamp(v32, 1, #u2);

    if p29.manual and p30 < p29.manualUntil then
        math_clamp_ret = p29.manual;
    else
        p29.manual = nil;
    end;

    p29:setStage(math_clamp_ret, p30);
    local v33 = 1 - (1 - math.clamp((p30 - p29.stageAt) / 0.9, 0, 1)) ^ 3;
    local key = u2[math_clamp_ret].key;

    for _, v in p29.cards do
        if v.award then
            local v34 = key == "survival" and 10 or 1;
            local v35 = math.floor(v.award.value * v33 * v34 + 0.5) / v34;
            local Metric = v.view.Metric;
            local v36 = key == "mvp" and v35 .. " XP";

            if not v36 then
                if key == "survival" then
                    local v37 = math.floor(v35 * 10 + 0.5) / 10;
                    local math_max_ret = math.max(0, v37);
                    v36 = math_max_ret >= 60 and ("%dm %04.1fs"):format(math.floor(math_max_ret / 60), math_max_ret % 60) or ("%.1fs"):format(math_max_ret) or v35 .. " " .. (v35 == 1 and "CATCH" or "CATCHES");
                else
                    v36 = v35 .. " " .. (v35 == 1 and "CATCH" or "CATCHES");
                end;
            end;

            Metric.Text = v36;
        end;
    end;
end;

function u1.hide(p38) -- Line: 89
    p38.active = false;
    p38:cancel();
end;

function u1.destroy(p39) -- Line: 92
    p39:hide();
    p39.portraits:destroy();

    for _, v in p39.connections do
        v:Disconnect();
    end;
end;

return u1;