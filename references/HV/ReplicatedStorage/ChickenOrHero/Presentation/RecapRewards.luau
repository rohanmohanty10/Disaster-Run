 

 

local ProgressionMath = require(script.Parent.Parent.Progression.ProgressionMath);
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4, p5) -- Line: 5
    -- upvalues: u1 (copy)
    return setmetatable({
        frame = p2,
        cfg = p3,
        cue = p4,
        player = p5
    }, u1);
end;

function u1.show(p6, p7, p8) -- Line: 8
    p6.active = true;
    p6.row = p7;
    p6.started = p8 + p6.cfg.CountDelay;
    p6.lastTick = (-1 / 0);
    p6.lastEarned = 0;
    p6.completed = false;
    p6.levelCue = false;
    p6.frame.LevelUp.Visible = false;
    p6:update(p8);
end;

function u1.update(p9, p10) -- Line: 14
    -- upvalues: ProgressionMath (copy)
    if not p9.active then
        return;
    end;

    local row = p9.row;
    local frame = p9.frame;
    local math_clamp_ret = math.clamp((p10 - p9.started) / p9.cfg.CountDuration, 0, 1);
    local v11 = 1 - (1 - math_clamp_ret) ^ 3;
    local math_round_ret = math.round((row and (row.crossingXP or 0) or 0) * v11);
    local math_round_ret2 = math.round((row and (row.catchXP or 0) or 0) * v11);
    local math_round_ret3 = math.round((row and (row.winXP or 0) or 0) * v11);
    local math_round_ret4 = math.round((row and (row.bonusXP or 0) or 0) * v11);
    local v12 = math_round_ret + math_round_ret2 + math_round_ret3 + math_round_ret4;
    frame.Amount.Text = row and ("YOU EARNED +" .. v12 .. " XP" or "READY FOR THE NEXT MATCH") or "READY FOR THE NEXT MATCH";
    local v13 = {};

    if row then
        if row.crossingXP > 0 then
            table.insert(v13, "Crossings +" .. math_round_ret);
        end;

        if row.catchXP > 0 then
            table.insert(v13, "Catches +" .. math_round_ret2);
        end;

        if row.winXP > 0 then
            table.insert(v13, "Win +" .. math_round_ret3);
        end;

        if (row.bonusXP or 0) > 0 then
            table.insert(v13, "Bonus +" .. math_round_ret4);
        end;
    end;

    frame.Breakdown.Text = table.concat(v13, "  ·  ");
    local v14;

    if row then
        v14 = row.xpBefore;
    else
        v14 = row;
    end;

    if v14 == nil and p9.player:GetAttribute("StatsLoaded") == true then
        local v15 = p9.player:GetAttribute("TotalXP") or 0;
        v14 = math.max(0, v15 - (row and row.earnedXP or 0));
    end;

    local v16 = false;
    frame.Track.Visible = v14 ~= nil;

    if v14 == nil then
        frame.Level.Text = "";
        frame.Progress.Text = "PROGRESS SYNCING";
    else
        local v17 = ProgressionMath.state(v14);
        local v18 = ProgressionMath.state(v14 + v12);
        frame.Level.Text = "LVL " .. v18.level;
        frame.Progress.Text = ("%d / %d XP"):format(v18.earned, v18.needed);
        frame.Track.Fill.Size = UDim2.fromScale(v18.ratio, 1);
        v16 = v18.level > v17.level;
        frame.Level.TextColor3 = v16 and Color3.fromRGB(255, 205, 112) or Color3.fromRGB(233, 243, 247);
    end;

    if math_clamp_ret > 0 and (math_clamp_ret < 1 and (v12 ~= p9.lastEarned and p10 - p9.lastTick >= p9.cfg.CountTickInterval)) then
        p9.cue("RecapTick", v11 * 0.3 + 0.92);
        p9.lastTick = p10;
    end;

    p9.lastEarned = v12;

    if math_clamp_ret >= 1 then
        if v16 and not p9.levelCue then
            p9.levelCue = true;
            frame.LevelUp.Visible = true;
            p9.cue("RecapLevelUp");
        end;

        if not p9.completed then
            p9.completed = true;

            if v12 > 0 and not v16 then
                p9.cue("RecapComplete");
            end;
        end;
    end;
end;

function u1.hide(p19) -- Line: 63
    p19.active = false;
end;

function u1.destroy(p20) -- Line: 64
    p20:hide();
end;

return u1;