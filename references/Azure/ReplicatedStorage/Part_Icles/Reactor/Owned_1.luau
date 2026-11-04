 
 

local Display = require(script.Parent.Display);

return {
    mark = function(p1, p2) -- Line: 42, Name: mark
        for _, v in ipairs(p1) do
            if not (v.shard or v.blockSize) then
                v.own = true;
            end;

            v.fixed = nil;
            v.partStands = nil;

            if p2.whole then
                v.uncut = true;
            end;
        end;
    end,

    adopt = function(p3, p4) -- Line: 55, Name: adopt
        -- upvalues: Display (copy)
        p3.owner = p4;
        p4.entry = p3;
        local play = p3.play;
        local pieces = play.pieces;
        play.settings.Collapse = false;
        local v5;

        if #pieces == 1 and pieces[1].own == true then
            v5 = pieces[1].part == p4.copy;
        else
            v5 = false;
        end;

        if not v5 then
            Display.quiet(p4.copy);
            local _nestedAlive = p4.particle._nestedAlive;

            if _nestedAlive then
                _nestedAlive[1] = false;
            end;
        end;

        play:place();

        for i in ipairs(pieces) do
            play:_push(i, p4.velocity);
        end;

        play.placed = false;
    end,

    spent = function(p6) -- Line: 79, Name: spent
        local v7;

        if p6.owner == nil then
            v7 = false;
        else
            v7 = p6.play.awake <= 0;
        end;

        return v7;
    end,

    gone = function(p8, p9, p10) -- Line: 83, Name: gone
        if not p9 or p9.released then
            return;
        end;

        p9.released = true;
        local table_find_ret = table.find(p8._reacted, p9);

        if table_find_ret then
            table.remove(p8._reacted, table_find_ret);
        end;

        local particle = p9.particle;
        local copy = p9.copy;

        if p10 then
            p8:_fireOnDeath(particle);
            p8:_fireOnDestruction(particle, copy);
        end;

        p8:_releaseOrDestroy(particle, copy);
        p8:_reclaimPData(particle);
    end
};