  

 

local u1 = {};

function u1.new(p2, p3) -- Line: 3
    -- upvalues: u1 (copy)
    local v4 = {
        _Step = 1,
        _Text = p2,
        _Callback = p3,
        _Linked = {}
    };

    for i, v in pairs(u1) do
        v4[i] = v;
    end;

    return v4;
end;

function u1.GetText(p5) -- Line: 16
    return p5._Text;
end;

function u1.GetCallback(p6) -- Line: 20
    return p6._Callback;
end;

function u1.GetStep(p7) -- Line: 24
    return p7._Step;
end;

function u1.SetStep(p8, p9) -- Line: 28
    p8._Step = p9;

    return p8;
end;

function u1.GetLinkedResponses(p10) -- Line: 33
    return p10._Linked;
end;

function u1.LinkResponse(p11, p12, p13) -- Line: 37
    -- upvalues: u1 (copy)
    local v14 = u1.new(p12, p13);
    table.insert(p11._Linked, v14);

    return v14;
end;

function u1.AddLinkedResponse(p15, p16) -- Line: 43
    table.insert(p15._Linked, p16);

    return p16;
end;

function u1.ClearLinkedResponses(p17) -- Line: 48
    -- upvalues: u1 (copy)
    table.clear(p17._Linked, u1);
end;

return u1;