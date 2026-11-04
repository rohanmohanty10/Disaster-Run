 

 

local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4, p5) -- Line: 3
    -- upvalues: u1 (copy)
    return setmetatable({
        level = 0,
        playback = p2,
        player = p3,
        session = p4,
        cfg = p5
    }, u1);
end;

function u1.update(p6, p7, p8) -- Line: 6
    local player = p6.player;
    local cfg = p6.cfg;
    local Character = player.Character;
    local v9;

    if Character then
        v9 = Character:FindFirstChildOfClass("Humanoid");
    else
        v9 = Character;
    end;

    local Attribute = p6.session:GetAttribute("Phase");
    local Enabled = cfg.Enabled;

    if Enabled then
        if player:GetAttribute("DangerAudioMuted") == true or (player:GetAttribute("InMatch") ~= true or (player:GetAttribute("GameRole") ~= "Runner" or player:GetAttribute("RunState") ~= "Active")) then
            v9 = false;
        elseif v9 then
            if v9.Health > 0 then
                v9 = not (Character:GetAttribute("MovementLocked") or (player:GetAttribute("ChoiceSpotlightActive") or player:GetAttribute("ScreenPresentationActive"))) and ((Attribute == "HeroRun" or Attribute == "GroupRun") and true or Attribute == "FinalRun");
            else
                v9 = false;
            end;
        end;
    else
        v9 = Enabled;
    end;

    local v10;

    if v9 and p8 - (player:GetAttribute("CatcherThreatUpdatedAt") or (-1 / 0)) <= cfg.SampleTimeout then
        local v11 = player:GetAttribute("CatcherThreatIntensity") or 0;
        v10 = math.clamp(v11, 0, 1) or 0;
    else
        v10 = 0;
    end;

    local level = p6.level;
    local v12 = v10 - p6.level;
    local v13 = -p7 / math.max(0.01, not v9 and cfg.InactiveFadeTime or (p6.level < v10 and cfg.AttackTime or cfg.ReleaseTime));
    p6.level = level + v12 * (1 - math.exp(v13));

    if p6.level < 0.002 then
        p6.level = 0;
    end;

    local v14 = p6.level ^ 1.35;
    p6.playback:loop("Danger", v14 > 0.001 and "DangerPulse" or nil, nil, v14, cfg.MinRate + (cfg.MaxRate - cfg.MinRate) * p6.level);
end;

function u1.destroy(p15) -- Line: 25
    p15.level = 0;
    p15.playback:loop("Danger", nil);
end;

return u1;