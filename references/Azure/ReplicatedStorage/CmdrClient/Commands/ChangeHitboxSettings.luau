 

 

local u1 = { "historyCapacity", "interpolationDelay", "maxRewind", "maxPing", "ballRadius", "maxBallRewind", "hurtboxViewRate", "viewerRefresh", "serverDrawLifetime", "minSweepStep", "maxSweepSteps", "predictionEnabled", "predictionStrength", "maxPredictionTime", "maxPredictionDistance", "predictionCatchUpSpeed", "predictionSnapDistance", "predictionRamp", "maxPredictionSpeed", "attackPushRatio", "strafeClamp", "strafeLeadScale", "simulateMovement", "simulationLead", "simulationMaxLead", "simulationMinSpeed", "simulationSpeedTolerance", "simulationSnapDistance", "jitterTolerance", "jitterRange", "jitterMinScale", "velocityGuard", "velocityGuardBase", "velocityGuardRatio", "velocityGuardWindow", "lagGuard", "lagGap", "lagDistance", "lagStale", "lagGrace", "rewindEnabled", "list", "reset" };

local function findSettings(p2: string) -- Line: 47
    -- upvalues: u1 (copy)
    local string_lower_ret = string.lower(p2);
    local v3 = {};
    local v4 = {};

    for _, v in u1 do
        local string_lower_ret2 = string.lower(v);

        if string_lower_ret2 == string_lower_ret then
            return { v }, v;
        end;

        if string.sub(string_lower_ret2, 1, #string_lower_ret) == string_lower_ret then
            table.insert(v3, v);
        elseif string.find(string_lower_ret2, string_lower_ret, 1, true) then
            table.insert(v4, v);
        end;
    end;

    local v5;

    if #v3 == 1 then
        v5 = v3[1];
    elseif #v3 == 0 and #v4 == 1 then
        v5 = v4[1];
    else
        v5 = nil;
    end;

    if v5 == "reset" then
        v5 = nil;
    end;

    for _, v in v4 do
        table.insert(v3, v);
    end;

    return v3, v5;
end;

return {
    Description = "changes hitbox settings on this server (reset, list, or setting value)",
    Name = script.Name,
    Aliases = { "hitboxsettings" },
    Group = script.Parent.Name,
    Args = {
        {
            Name = "setting",
            Description = "setting name, or reset / list",
            Type = {
                DisplayName = "Hitbox Setting",

                Validate = function(p6: string) -- Line: 72, Name: Validate
                    -- upvalues: findSettings (copy)
                    local v7, v8 = findSettings(p6);

                    if v8 then
                        return true;
                    end;

                    if #v7 == 0 then
                        return false, `"{p6}" is not an editable hitbox setting`;
                    end;

                    if #v7 == 1 and v7[1] == "reset" then
                        return false, "type reset in full to reset every setting";
                    end;

                    return false, `"{p6}" matches {#v7} settings, keep typing or press Tab`;
                end,

                Autocomplete = function(p9: string) -- Line: 85, Name: Autocomplete
                    -- upvalues: findSettings (copy)
                    return findSettings(p9);
                end,

                Parse = function(p10: string) -- Line: 88, Name: Parse
                    -- upvalues: findSettings (copy)
                    local _, v11 = findSettings(p10);

                    return v11;
                end
            }
        },
        {
            Name = "value",
            Description = "new value (numbers, fractions like 1/30, true / false), or reset",
            Optional = true,
            Type = {
                DisplayName = "Value",

                Validate = function(p12: string) -- Line: 96, Name: Validate
                    return p12 ~= "", "enter a number, a fraction like 1/30, or reset";
                end,

                Autocomplete = function(p13: string) -- Line: 99, Name: Autocomplete
                    local string_lower_ret = string.lower(p13);
                    local v14 = {};

                    for _, v in { "true", "false", "reset" } do
                        if string.sub(v, 1, #string_lower_ret) == string_lower_ret then
                            table.insert(v14, v);
                        end;
                    end;

                    return v14;
                end,

                Parse = function(p15: string) -- Line: 109, Name: Parse
                    return p15;
                end
            }
        }
    }
};