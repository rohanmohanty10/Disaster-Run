  

 

local Response = require(script.Response);
local u1 = {};

function u1.new() -- Line: 5
    -- upvalues: u1 (copy)
    local v2 = {
        _Title = "",
        _Text = "",
        _Responses = {},
        _Callbacks = {},
        _NPCS = {},

        _CheckStep = function() -- Line: 12, Name: _CheckStep
        end
    };

    for i, v in pairs(u1) do
        v2[i] = v;
    end;

    return v2;
end;

function u1.AddResponse(p3, p4, p5) -- Line: 21
    -- upvalues: Response (copy)
    local v6 = Response.new(p4, p5);
    table.insert(p3._Responses, v6);

    return v6;
end;

function u1.AddCallback(p7, p8, p9) -- Line: 27
    if not p7._Callbacks[p8] then
        p7._Callbacks[p8] = {};
    end;

    table.insert(p7._Callbacks[p8], p9);
end;

function u1.RunCallbacks(p10, p11, ...) -- Line: 34
    if not p10._Callbacks[p11] then
        return;
    end;

    for _, v in ipairs(p10._Callbacks[p11]) do
        task.spawn(v, p10, ...);
    end;
end;

function u1.CheckStep(p12, ...) -- Line: 41
    return p12._CheckStep(...);
end;

function u1.SetCheckStep(p13, p14) -- Line: 45
    p13._CheckStep = p14;
end;

function u1.SetText(p15, p16) -- Line: 49
    p15._Text = p16;
    p15:RunCallbacks("TextChanged", p16);
end;

function u1.SetStarterText(p17, p18) -- Line: 54
    p17._StarterText = p18;
    p17:SetText(p18);
end;

function u1.SetStarterTitle(p19, p20) -- Line: 59
    p19._StarterTitle = p20;
    p19:SetTitle(p20);
end;

function u1.SetTitle(p21, p22) -- Line: 64
    p21._Title = p22;
    p21:RunCallbacks("TitleChanged", p22);
end;

function u1.GetText(p23) -- Line: 69
    return p23._Text;
end;

function u1.GetTitle(p24) -- Line: 73
    return p24._Title;
end;

function u1.GetResponses(p25, p26) -- Line: 77
    local v27 = p26 or 1;
    local v28 = {};

    for _, v in ipairs(p25._Responses) do
        if v:GetStep() == v27 or v:GetStep() == true then
            table.insert(v28, v);
        end;
    end;

    return v28;
end;

function u1.BindNPC(p29, p30, p31, p32) -- Line: 89
    if p29._NPCS[p30] then
        warn(debug.traceback(p30 .. " already has a npc"));

        return;
    end;

    p29._NPCS[p30] = {
        NPC = p31,
        Texts = p32
    };
end;

function u1.GetNPC(p33, p34) -- Line: 97
    return p33._NPCS[p34];
end;

function u1.SetNPCName(p35, p36) -- Line: 101
    p35._NPCName = p36;
end;

function u1.GetNPCName(p37) -- Line: 105
    return p37._NPCName;
end;

function u1.SetNPCModel(p38, p39) -- Line: 109
    p38._NPCModel = p39;
end;

function u1.GetNPCModel(p40) -- Line: 113
    return p40._NPCModel;
end;

function u1.Destroy(p41) -- Line: 118
    p41:RunCallbacks("OnDestroy");
    table.clear(p41._Callbacks);
    p41._Text = p41._StarterText or p41._Text;
    p41._Title = p41._StarterTitle or p41._Title;
end;

return u1;