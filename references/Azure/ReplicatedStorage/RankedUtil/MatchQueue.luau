 

 

local u3 = {
    ensure = function(p1) -- Line: 14, Name: ensure
        if type(p1.pendingRankedMatches) ~= "table" then
            p1.pendingRankedMatches = {};
        end;

        return p1.pendingRankedMatches;
    end,

    migrate = function(p2) -- Line: 21, Name: migrate
        if type(p2.pendingRankedMatches) == "table" and #p2.pendingRankedMatches > 0 then
            return;
        end;

        if type(p2.lastRankedMatch) == "table" then
            p2.pendingRankedMatches = { p2.lastRankedMatch };
        end;
    end
};

function u3.append(p4: any, p5: table, p6: number?) -- Line: 30
    -- upvalues: u3 (copy)
    u3.migrate(p4);
    local v7 = u3.ensure(p4);
    local table_clone_ret = table.clone(p5);

    if typeof(p6) == "number" then
        table_clone_ret.elo_after = p6;
    end;

    table.insert(v7, table_clone_ret);
    p4.lastRankedMatch = table_clone_ret;
end;

function u3.peek_first(p8) -- Line: 41
    -- upvalues: u3 (copy)
    u3.migrate(p8);
    local pendingRankedMatches = p8.pendingRankedMatches;

    if type(pendingRankedMatches) == "table" and #pendingRankedMatches > 0 then
        return pendingRankedMatches[1];
    end;

    if type(p8.lastRankedMatch) == "table" then
        return p8.lastRankedMatch;
    end;

    return nil;
end;

function u3.peek_last(p9) -- Line: 53
    -- upvalues: u3 (copy)
    u3.migrate(p9);
    local pendingRankedMatches = p9.pendingRankedMatches;

    if type(pendingRankedMatches) == "table" and #pendingRankedMatches > 0 then
        return pendingRankedMatches[#pendingRankedMatches];
    end;

    if type(p9.lastRankedMatch) == "table" then
        return p9.lastRankedMatch;
    end;

    return nil;
end;

function u3.mark_read(p10) -- Line: 65
    -- upvalues: u3 (copy)
    u3.migrate(p10);
    local pendingRankedMatches = p10.pendingRankedMatches;

    if type(pendingRankedMatches) ~= "table" or #pendingRankedMatches == 0 then
        p10.pendingRankedMatches = nil;
        p10.lastRankedMatch = nil;

        return nil;
    end;

    table.remove(pendingRankedMatches, 1);

    if #pendingRankedMatches ~= 0 then
        p10.lastRankedMatch = pendingRankedMatches[#pendingRankedMatches];

        return pendingRankedMatches[1];
    end;

    p10.pendingRankedMatches = nil;
    p10.lastRankedMatch = nil;

    return nil;
end;

function u3.clear(p11) -- Line: 83
    p11.pendingRankedMatches = nil;
    p11.lastRankedMatch = nil;
end;

function u3.count_pending(p12) -- Line: 88
    -- upvalues: u3 (copy)
    u3.migrate(p12);

    return type(p12.pendingRankedMatches) == "table" and #p12.pendingRankedMatches or (type(p12.lastRankedMatch) == "table" and 1 or 0);
end;

return table.freeze(u3);