 

 

local u1 = {
    handlers = {},
    available = {},
    states = {},
    wallet = {
        loaded = false,
        coins = 0,
        gems = 0
    },
    Changed = Instance.new("BindableEvent"),
    Opening = Instance.new("BindableEvent"),
    Notice = Instance.new("BindableEvent")
};

function u1.register(p2, p3) -- Line: 6
    -- upvalues: u1 (copy)
    u1.handlers[p2] = p3;
    u1.Changed:Fire(p2);
end;

function u1.setAvailable(p4, p5) -- Line: 7
    -- upvalues: u1 (copy)
    local v6 = p5 == true;

    if u1.available[p4] ~= v6 then
        u1.available[p4] = v6;
        u1.Changed:Fire(p4);
    end;
end;

function u1.setState(p7, p8) -- Line: 11
    -- upvalues: u1 (copy)
    if u1.states[p7] ~= p8 then
        u1.states[p7] = p8;
        u1.Changed:Fire(p7);
    end;
end;

function u1.setWallet(p9, p10, p11) -- Line: 14
    -- upvalues: u1 (copy)
    u1.wallet = {
        loaded = p9 == true,
        coins = p10 or 0,
        gems = p11 or 0
    };
    u1.Changed:Fire("Wallet");
end;

function u1.activate(p12) -- Line: 17
    -- upvalues: u1 (copy)
    if u1.available[p12] and u1.handlers[p12] then
        u1.handlers[p12]();
    end;
end;

function u1.opening(p13) -- Line: 20
    -- upvalues: u1 (copy)
    u1.Opening:Fire(p13);
end;

return u1;