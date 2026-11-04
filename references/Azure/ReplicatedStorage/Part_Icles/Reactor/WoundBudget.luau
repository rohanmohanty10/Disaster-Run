 

 

local Recut = require(script.Parent.Recut);
local v1 = {};
local v2 = {};
v1.methods = v2;

function v1.livePieces(p3) -- Line: 32
    local v4 = 0;

    for _, v in ipairs(p3.play.pieces) do
        if not v.retired then
            v4 = v4 + 1;
        end;
    end;

    return v4;
end;

local livePieces = v1.livePieces;

function v2._held(p5) -- Line: 46
    -- upvalues: livePieces (copy)
    local v6 = 0;

    for _, v in ipairs(p5.open) do
        if not v.group.leaving then
            if v.play then
                v6 = v6 + livePieces(v);
            else
                v6 = v6 + v.expected;
            end;
        end;
    end;

    return v6;
end;

function v2._send(p7, p8, p9, p10) -- Line: 62
    p8.sent = true;

    for _, v in ipairs(p8.wounds) do
        local play = v.play;

        if play and play.phase == "live" then
            play.settings.After = p9;
            play.settings.AfterDelay = 0;

            if p10 then
                play.settings.AfterTime = p10;
            end;
        end;
    end;
end;

local function beingCut(p11) -- Line: 76
    for _, v in ipairs(p11.wounds) do
        if not v.play then
            return true;
        end;
    end;

    return false;
end;

function v2._sweep(p12, p13) -- Line: 88
    local v14 = p12:_held() + p13 - p12.maxPieces;

    for _, v in ipairs(p12.open) do
        local play = v.play;

        if play and play.phase == "live" then
            for i, v3 in ipairs(play.pieces) do
                if v14 <= 0 then
                    return;
                end;

                if v3.bit and (not v3.retired and play.state[i] == 2) then
                    v3.retired = true;
                    play.state[i] = 3;
                    play.display.drop(i);
                    play.awake = play.awake - 1;
                    v14 = v14 - 1;
                end;
            end;
        end;
    end;
end;

local function staying(p15, p16) -- Line: 111
    -- upvalues: livePieces (copy)
    local v17 = 0;

    for _, v in ipairs(p15.groups) do
        if not v.leaving then
            local v18;

            if v == p16 then
                v18 = v;

                for i, v3 in ipairs(v18.wounds) do
                    if v3.play then
                        v17 = v17 + livePieces(v3);
                    end;
                end;
            else
                v18 = v;
                local v19 = false;

                for _, v3 in ipairs(v.wounds) do
                    if not v3.play then
                        v19 = true;
                        break;
                    end;
                end;

                if v19 then
                    for i, v3 in ipairs(v18.wounds) do
                        if v3.play then
                            v17 = v17 + livePieces(v3);
                        end;
                    end;
                end;
            end;
        end;
    end;

    return v17;
end;

function v2._makeRoom(p20, p21, p22) -- Line: 129
    -- upvalues: staying (copy)
    p20:_sweep(p21);

    if staying(p20, p22) + p21 > p20.maxPieces then
        return;
    end;

    local v23 = 1;

    while true do
        while true do
            if v23 > #p20.groups or p20:_held() + p21 <= p20.maxPieces then
                return;
            end;

            local v24 = p20.groups[v23];

            if v24 == p22 or v24.leaving then
                break;
            end;

            local v25 = false;

            for _, v in ipairs(v24.wounds) do
                if not v.play then
                    v25 = true;
                    break;
                end;
            end;

            if v25 then
                v23 = v23 + 1;
            else
                p20:_leave(v24);

                if p20.groups[v23] == v24 then
                    v23 = v23 + 1;
                end;
            end;
        end;

        v23 = v23 + 1;
    end;
end;

function v2._room(p26, p27) -- Line: 149
    -- upvalues: livePieces (copy), Recut (copy)
    local settings = p27.play.settings;
    local v28 = livePieces(p27);
    local v29 = p26:_held();
    settings.MaxPieces = v28 + math.max(p26.maxPieces - v29, 0);
    settings.MostPieces = v28 + math.max(p26.maxPieces * Recut.PLATE_ROOM - v29, 0);
end;

return v1;