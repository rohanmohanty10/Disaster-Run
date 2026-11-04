 

 

local Registry = require(script.Parent.Parent.Force.Registry);
local Index = require(script.Parent.Index);
local Entries = require(script.Parent.Entries);
local Play = require(script.Parent.Play);
local Owned = require(script.Parent.Owned);
local Reach = require(script.Parent.Reach);
local Momentum = require(script.Parent.Momentum);
local Blade = require(script.Parent.Blade);
local Shards = require(script.Parent.Shards);
local Batch = require(script.Parent.Batch);

return function(u1) -- Line: 60
    -- upvalues: Shards (copy), Reach (copy), Blade (copy), Index (copy), Entries (copy), Owned (copy), Momentum (copy), Registry (copy), Batch (copy), Play (copy)
    u1._watched = {};
    u1._reacted = {};
    local u2 = setmetatable({}, {
        __mode = "k"
    });
    local u3 = {};
    local u4 = {};

    local function unwatch(p5) -- Line: 74
        -- upvalues: u1 (copy)
        local _watched = u1._watched;
        local _watchIndex = p5._watchIndex;

        if not _watchIndex or _watched[_watchIndex] ~= p5 then
            return;
        end;

        local v6 = #_watched;
        local v7 = _watched[v6];
        _watched[_watchIndex] = v7;
        v7._watchIndex = _watchIndex;
        _watched[v6] = nil;
        p5._watchIndex = nil;
    end;

    function u1._watchForForces(p8, p9, p10, p11) -- Line: 88
        -- upvalues: Shards (ref), unwatch (copy)
        if p11 and p10.Break ~= "None" then
            p10 = table.clone(p10);
            p10.Break = "None";
        end;

        p9._reacts = p10;
        p9._reactWhole = p11 == true;
        local VisualPart = p9.VisualPart;

        if VisualPart and not p11 then
            Shards.judge(VisualPart);
        end;

        p9._reactHold = p10.Hold * (1 + p10.HoldSpread * (math.random() * 2 - 1));
        local _watched = p8._watched;
        p9._watchIndex = #_watched + 1;
        _watched[p9._watchIndex] = p9;
        p9._onReclaim = unwatch;
    end;

    local function cutBy(p12, p13, p14, p15, p16) -- Line: 108
        -- upvalues: Reach (ref), u2 (copy), Blade (ref)
        if not Reach.inBlade(p12, p14, p15, p16) then
            return false;
        end;

        local origin = p12.field.origin;
        local v17 = u2[p12];

        if not v17 then
            v17 = {};
            u2[p12] = v17;
        end;

        if v17.at ~= origin then
            v17.at = origin;
            v17.blade = Blade.of(p12.field, p12.cut);
        end;

        local v18;

        if v17.blade == nil then
            v18 = false;
        else
            v18 = Blade.touches(v17.blade, p13.ExtentsCFrame, p13.ExtentsSize);
        end;

        return v18;
    end;

    local function reachedBy(p19, p20, p21, p22, p23) -- Line: 127
        -- upvalues: Index (ref), u3 (copy), u4 (copy), Reach (ref), cutBy (copy)
        local Group = p19._reacts.Group;
        local v24 = nil;
        local v25 = nil;
        local v26 = 0;

        for i = 1, p22 do
            local v27 = p21[i];
            local v28;

            if Index.groupMatches(v27.group, Group) then
                if not v24 then
                    v24 = p20.CFrame.Position;
                    v25 = p20.Size;
                    v26 = v25.Magnitude / 2;
                end;

                if (v24 - u3[i]).Magnitude <= v26 + u4[i] then
                    local v29 = p23 - p19.StartTime;

                    if Reach.moved(v27, v24, v25, p19._reactHold, v29) then
                        return v27;
                    end;

                    if v27.cut and (not p19._reactWhole and cutBy(v27, p20, v24, v26, v29)) then
                        return v27;
                    end;

                    v28 = i;
                else
                    v28 = i;
                end;
            else
                v28 = i;
            end;
        end;

        return nil;
    end;

    local function release(p30, p31) -- Line: 153
        -- upvalues: Entries (ref), Owned (ref)
        Entries.forget(p30._reactorCutting[p31.copy]);

        if p31.entry and p30._reactorPlays[p31.copy] == p31.entry then
            Entries.discard(p30, p31.entry);
        end;

        Owned.gone(p30, p31, false);
    end;

    local function piecesOf(p32) -- Line: 162
        local entry = p32.entry;

        return not entry and 1 or math.max(entry.play.awake, 1);
    end;

    local function leave(p33, p34) -- Line: 172
        -- upvalues: release (copy), Entries (ref)
        p34.leaving = true;
        local entry = p34.entry;

        if not (entry and (not entry.pData and entry.play.phase == "live")) then
            release(p33, p34);

            return;
        end;

        local settings = entry.play.settings;
        settings.After = "Fade";
        settings.AfterDelay = 0;
        settings.AfterTime = 0.25;
        entry.play.idleFor = 0;

        if not Entries.resume(p33, entry) then
            release(p33, p34);
        end;
    end;

    local function keepWithin(p35, p36) -- Line: 190
        -- upvalues: leave (copy)
        local source = p36.source;
        local math_max_ret = math.max(p36.settings.MaxPieces, 1);
        local _reacted = p35._reacted;
        local v37 = 0;

        for _, v in ipairs(_reacted) do
            if v.source == source and not v.leaving then
                local entry = v.entry;
                v37 = v37 + (not entry and 1 or math.max(entry.play.awake, 1));
            end;
        end;

        local v38 = 1;

        while math_max_ret < v37 and v38 <= #_reacted do
            local v39 = _reacted[v38];

            if v39 ~= p36 and (v39.source == source and not v39.leaving) then
                local entry = v39.entry;
                v37 = v37 - (not entry and 1 or math.max(entry.play.awake, 1));
                leave(p35, v39);
            end;

            if _reacted[v38] == v39 then
                v38 = v38 + 1;
            end;
        end;
    end;

    local function handOver(p40, p41, p42, p43) -- Line: 214
        -- upvalues: u1 (copy), Momentum (ref), keepWithin (copy), Entries (ref), release (copy)
        local VisualPart = p41.VisualPart;
        local ActiveEmits = p40.ActiveEmits;
        local table_find_ret = table.find(ActiveEmits, p41);
        local _watched = u1._watched;
        local _watchIndex = p41._watchIndex;

        if _watchIndex and _watched[_watchIndex] == p41 then
            local v44 = #_watched;
            local v45 = _watched[v44];
            _watched[_watchIndex] = v45;
            v45._watchIndex = _watchIndex;
            _watched[v44] = nil;
            p41._watchIndex = nil;
        end;

        if not table_find_ret then
            return;
        end;

        local v46 = Momentum.of(p40, p41, p43);
        local v47 = #ActiveEmits;
        ActiveEmits[table_find_ret] = ActiveEmits[v47];
        ActiveEmits[v47] = nil;
        p41._onReclaim = nil;
        p41._handedOver = true;
        p41._noPool = true;
        local _playToken = p41._playToken;
        local v48 = {
            copy = VisualPart,
            particle = p41,
            source = p41._sourceItem,
            settings = p41._reacts,
            velocity = v46,
            whole = p41._reactWhole,
            context = _playToken and {
                _playToken = _playToken
            } or nil
        };
        table.insert(p40._reacted, v48);
        keepWithin(p40, v48);
        local v49;

        if v48.whole then
            v49 = nil;
        else
            v49 = p42;
        end;

        local v50, v51 = Entries.entryFor(p40, VisualPart, nil, v49, v48);

        if v51 then
            Entries.owe(v51, p42);

            return;
        end;

        if v50 then
            p40:_tellEntry(v50, p42, true);

            return;
        end;

        release(p40, v48);
    end;

    local function handOverAll(p52, p53, p54, p55, p56, p57) -- Line: 265
        -- upvalues: reachedBy (copy), handOver (copy)
        for i = p54, 1, -1 do
            local v58 = p53[i];
            local VisualPart = v58.VisualPart;
            local v59;

            if VisualPart and VisualPart.Parent then
                local v60 = reachedBy(v58, VisualPart, p55, p56, p57);

                if v60 then
                    handOver(p52, v58, v60, p57);
                    v59 = i;
                else
                    v59 = i;
                end;
            else
                v59 = i;
            end;
        end;
    end;

    function u1._handOverReached(p61, p62) -- Line: 278
        -- upvalues: Registry (ref), u3 (copy), u4 (copy), Index (ref), Batch (ref), handOverAll (copy)
        local _watched = p61._watched;
        local v63 = #_watched;

        if v63 == 0 then
            return;
        end;

        local v64 = Registry.list();
        local v65 = #v64;

        if v65 == 0 then
            return;
        end;

        for i = 1, v65 do
            local field = v64[i].field;
            u3[i] = field.origin.Position;
            u4[i] = Index.reachOf(field);
            local _ = i;
        end;

        Batch.pass(handOverAll, p61, _watched, v63, v64, v65, p62);
    end;

    local function couldReach(p66, p67) -- Line: 299
        -- upvalues: Play (ref), Index (ref)
        local play = p67.play;
        local field = p66.field;

        for i, v in ipairs(play.pieces) do
            if play.state[i] ~= Play.GONE and Index.reaches(field, play:_position(i), v.reach) then
                return true;
            end;
        end;

        return false;
    end;

    function u1._followReacted(p68, p69) -- Line: 310
        -- upvalues: release (copy), Index (ref), couldReach (copy)
        local _reacted = p68._reacted;

        for i = #_reacted, 1, -1 do
            local v70 = _reacted[i];
            local entry = v70.entry;
            local v71;

            if v70.copy.Parent then
                if entry and (not v70.leaving and (Index.groupMatches(p69.group, entry.group) and couldReach(p69, entry))) then
                    p68:_tellEntry(entry, p69, false);
                    v71 = i;
                else
                    v71 = i;
                end;
            else
                release(p68, v70);
                v71 = i;
            end;
        end;
    end;

    function u1._endReacted(p72, p73, p74) -- Line: 323
        -- upvalues: release (copy)
        local _reacted = p72._reacted;

        for i = #_reacted, 1, -1 do
            local v75 = _reacted[i];
            local v76;

            if v75 and not ((p73 == nil or v75.source ~= p73) and (p74 == nil or v75.particle._playToken ~= p74)) then
                release(p72, v75);
                v76 = i;
            else
                v76 = i;
            end;
        end;
    end;
end;