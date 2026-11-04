 

 

local Recut = require(script.Parent.Recut);
local Shards = require(script.Parent.Shards);
local Sites = require(script.Parent.Sites);
local v1 = {};

local function placesOf(p2) -- Line: 40
    if not p2.places then
        p2.places = setmetatable({}, {
            __mode = "k"
        });
    end;

    return p2.places;
end;

local function takeNext(u3, u4, u5) -- Line: 47
    -- upvalues: takeNext (copy), Sites (copy), Recut (copy), Shards (copy)
    local u6 = u3.cracks[1];

    if not u6 then
        return;
    end;

    local play = u3.play;
    local record = u6.record;

    local function finish(p7) -- Line: 57
        -- upvalues: u3 (copy), play (copy), record (copy), u6 (copy), u5 (copy), takeNext (ref), u4 (copy)
        table.remove(u3.cracks, 1);
        play.recracking[record] = nil;
        play:kickAgain(record, u6.kicked, p7 or {});
        u5();
        takeNext(u3, u4, u5);
    end;

    if play.phase ~= "live" then
        finish(nil);

        return;
    end;

    local Position = record.field.origin.Position;
    u3.taken = (u3.taken or 0) + 1;
    local v8 = Sites.seedAt(Position) + u3.taken * 104729;
    local u9 = Recut.plan(play, Position, record.field.range, record.pieces or u3.pieceCount, v8, record.field);

    if not u9 then
        finish(nil);

        return;
    end;

    for _, v in ipairs(u9.strikes) do
        v.by = record;
    end;

    if #u9.jobs == 0 then
        finish(Recut.apply(play, u9, {}));

        return;
    end;

    Shards.recut(u9.jobs, function(p10) -- Line: 86
        -- upvalues: u4 (copy), u3 (copy), play (copy), finish (copy), Recut (ref), u9 (copy)
        if not u4() then
            table.clear(u3.cracks);

            return;
        end;

        if play.phase == "live" then
            finish(Recut.apply(play, u9, p10));

            return;
        end;

        finish(nil);
    end);
end;

function v1.request(p11, p12, p13, p14, p15) -- Line: 99
    -- upvalues: placesOf (copy), takeNext (copy)
    if not p13 then
        return;
    end;

    local v16 = placesOf(p11);
    local Position = p12.field.origin.Position;
    local v17 = v16[p12];

    if v17 and (v17 - Position).Magnitude < 1 then
        return;
    end;

    v16[p12] = Position;
    table.insert(p11.cracks, {
        record = p12,
        kicked = p13
    });
    p11.play.recracking[p12] = true;

    if #p11.cracks == 1 then
        takeNext(p11, p14, p15);
    end;
end;

function v1.opened(p18, p19, p20) -- Line: 117
    -- upvalues: placesOf (copy)
    for _, v in ipairs(p19) do
        local Position = v.field.origin.Position;

        if v.actsAs == "Impulse" and (Position - p20).Magnitude < 1 then
            placesOf(p18)[v] = Position;

            return;
        end;
    end;
end;

return v1;