 

 

local u19 = {
    _hermite = function(p1: vector, p2: vector, p3: vector, p4: vector, p5: number, p6: number) -- Line: 18, Name: _hermite
        local v7 = p5 * p5;
        local v8 = v7 * p5;

        return p1 * (v8 * 2 - v7 * 3 + 1) + p3 * p6 * (v8 - v7 * 2 + p5) + p2 * (v8 * -2 + v7 * 3) + p4 * p6 * (v8 - v7);
    end,

    new = function(p9: number, p10: number?) -- Line: 28, Name: new
        return {
            head = 0,
            count = 0,
            times = table.create(p9, 0),
            cframes = table.create(p9, CFrame.identity),
            velocities = table.create(p9, Vector3.new(0, 0, 0)),
            capacity = p9,
            spacing = p10 or 0.016666666666666666
        };
    end,

    clear = function(p11: table) -- Line: 40, Name: clear
        p11.head = 0;
        p11.count = 0;
    end,

    latest = function(p12: table) -- Line: 45, Name: latest
        if p12.count == 0 then
            return nil, nil;
        end;

        return p12.times[p12.head], p12.cframes[p12.head];
    end,

    stallGap = function(p13: table) -- Line: 52, Name: stallGap
        return math.max(p13.spacing * 3, 0.15);
    end,

    _insert = function(p14: table, p15: number, p16, p17: vector) -- Line: 56, Name: _insert
        local v18 = p14.head % p14.capacity + 1;
        p14.head = v18;
        p14.times[v18] = p15;
        p14.cframes[v18] = p16;
        p14.velocities[v18] = p17;

        if p14.count < p14.capacity then
            p14.count = p14.count + 1;
        end;
    end
};

function u19.push(p20: table, p21: number, p22) -- Line: 67
    -- upvalues: u19 (copy)
    if p20.count == 0 then
        u19._insert(p20, p21, p22, Vector3.new(0, 0, 0));

        return true;
    end;

    local v23 = p20.times[p20.head];

    if p21 <= v23 then
        return false;
    end;

    local v24 = p20.cframes[p20.head];
    local v25 = p21 - v23;
    local spacing = p20.spacing;
    local v26 = p22.Position - v24.Position;

    if u19.stallGap(p20) >= v25 then
        u19._insert(p20, p21, p22, v26 / math.max(v25, spacing));

        return true;
    end;

    local v27 = p21 - spacing;

    if v23 < v27 then
        u19._insert(p20, v27, v24, Vector3.new(0, 0, 0));
    end;

    u19._insert(p20, p21, p22, v26 / v25);

    return true;
end;

function u19.sample(p28: table, p29: number) -- Line: 93
    -- upvalues: u19 (copy)
    local count = p28.count;

    if count == 0 then
        return nil;
    end;

    local capacity = p28.capacity;
    local head = p28.head;
    local v30 = p28.times[head];
    local v31 = p28.cframes[head];
    local v32 = p28.velocities[head];

    if v30 <= p29 or count == 1 then
        return v31;
    end;

    for i = 2, count do
        head = (head - 2) % capacity + 1;
        local v33 = p28.times[head];
        local v34 = p28.cframes[head];

        if v33 <= p29 then
            local v35 = v30 - v33;

            if v35 <= 0 then
                return v31;
            end;

            local v36 = (p29 - v33) / v35;

            if u19.stallGap(p28) < v35 then
                return v34:Lerp(v31, v36);
            end;

            local v37 = u19._hermite(v34.Position, v31.Position, p28.velocities[head], v32, v36, v35);

            return CFrame.new(v37) * v34.Rotation:Lerp(v31.Rotation, v36);
        end;

        v32 = p28.velocities[head];
        v30 = v33;
        local _ = i;
        v31 = v34;
    end;

    return v31;
end;

function u19.sampleLinear(p38: table, p39: number) -- Line: 131
    local count = p38.count;

    if count == 0 then
        return nil;
    end;

    local capacity = p38.capacity;
    local head = p38.head;
    local v40 = p38.times[head];
    local v41 = p38.cframes[head];

    if v40 <= p39 or count == 1 then
        return v41;
    end;

    for i = 2, count do
        head = (head - 2) % capacity + 1;
        local v42 = p38.times[head];
        local v43 = p38.cframes[head];

        if v42 <= p39 then
            local v44 = v40 - v42;

            if v44 <= 0 then
                return v41;
            end;

            return v43:Lerp(v41, (p39 - v42) / v44);
        end;

        v40 = v42;
        local _ = i;
        v41 = v43;
    end;

    return v41;
end;

return u19;