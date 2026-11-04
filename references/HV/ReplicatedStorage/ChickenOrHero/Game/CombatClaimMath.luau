 

 

local u3 = {
    finite = function(p1) -- Line: 3, Name: finite
        local v2;

        if type(p1) == "number" and p1 == p1 then
            v2 = math.abs(p1) < (1 / 0);
        else
            v2 = false;
        end;

        return v2;
    end
};

function u3.vector(p4) -- Line: 6
    -- upvalues: u3 (copy)
    local v5;

    if typeof(p4) == "Vector3" then
        v5 = u3.finite(p4.X) and (u3.finite(p4.Y) and u3.finite(p4.Z)) and p4.Magnitude < 1000000;
    else
        v5 = false;
    end;

    return v5;
end;

function u3.compatible(p6, p7) -- Line: 13
    local v8;

    if p6.character == p7.character and (p6.reset == p7.reset and (p6.relocation == p7.relocation and (p6.life == p7.life and p6.lives == p7.lives))) then
        v8 = p6.active and p7.active and not (p6.safe or p7.safe) and p6.role == p7.role;
    else
        v8 = false;
    end;

    return v8;
end;

function u3.locate(p9, u10, p11, p12, u13, u14) -- Line: 25
    -- upvalues: u3 (copy)
    if not (u3.vector(u10) and (u3.finite(p11) and (u3.finite(p12) and (p12 >= p11 and (u3.finite(u14) and u14 >= 0))))) then
        return nil;
    end;

    local u15 = nil;
    local u16 = nil;

    local function consider(p17, p18, p19) -- Line: 37
        -- upvalues: u13 (copy), u10 (copy), u14 (copy), u16 (ref), u15 (ref)
        if not (p17.character == u13.character and (p17.reset == u13.reset and (p17.relocation == u13.relocation and (p17.life == u13.life and (p17.lives == u13.lives and (not u13.role or p17.role == u13.role))))) and (p17.active and not p17.safe)) then
            return;
        end;

        local Magnitude = (p18 - u10).Magnitude;

        if Magnitude <= u14 and not (u16 and (Magnitude >= u16 - 1e-6 and (math.abs(Magnitude - u16) >= 1e-6 or u15.at >= p19))) then
            u16 = Magnitude;
            u15 = {
                at = p19,
                position = p18,
                character = p17.character,
                reset = p17.reset,
                relocation = p17.relocation,
                role = p17.role
            };
        end;
    end;

    for i, v in p9 do
        if p11 <= v.at and v.at <= p12 then
            consider(v, v.position, v.at);
        end;

        local v20 = p9[i - 1];

        if v20 and (p11 <= v.at and (v20.at <= p12 and (u3.compatible(v20, v) and (v.at - v20.at <= 0.15 and (v.position - v20.position).Magnitude <= 20)))) then
            local v21 = v.at - v20.at;

            if v21 > 0 then
                local math_clamp_ret = math.clamp((p11 - v20.at) / v21, 0, 1);
                local math_clamp_ret2 = math.clamp((p12 - v20.at) / v21, 0, 1);
                local v22 = v.position - v20.position;

                if v22:Dot(v22) > 1e-6 then
                    local v23 = (u10 - v20.position):Dot(v22) / v22:Dot(v22);
                    math_clamp_ret2 = math.clamp(v23, math_clamp_ret, math_clamp_ret2) or math_clamp_ret2;
                end;

                consider(v20, v20.position:Lerp(v.position, math_clamp_ret2), v20.at + v21 * math_clamp_ret2);
            end;
        end;
    end;

    return u15, u16;
end;

function u3.segment(p24, p25, p26) -- Line: 97
    -- upvalues: u3 (copy)
    local v27 = u3.vector(p24) and (u3.vector(p25) and u3.finite(p26));

    if v27 then
        if p26 >= 0 and p26 <= 0.08 then
            v27 = (p24 - p25).Magnitude <= 150 * p26 + 1.5;
        else
            v27 = false;
        end;
    end;

    return v27;
end;

function u3.ageLimit(p28) -- Line: 110
    return math.clamp(2 * p28 + 0.15, 0.25, 0.5);
end;

return table.freeze(u3);