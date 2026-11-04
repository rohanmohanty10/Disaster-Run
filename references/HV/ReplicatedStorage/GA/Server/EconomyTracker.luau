 

 

local Types = require(script.Parent.Parent.Shared.Types);
local v1 = {};
local u2 = nil;

function v1._init(p3) -- Line: 20
    -- upvalues: u2 (ref)
    u2 = p3;
end;

function v1.currencyEarned(p4: table, p5: userdata, p6: string, p7: number, p8: string?, p9: string?) -- Line: 33
    -- upvalues: u2 (ref), Types (copy)
    u2:trackEconomy(p5, Types.EconomyFlow.SOURCE, p6, p7, p8, p9);
end;

function v1.currencySpent(p10: table, p11: userdata, p12: string, p13: number, p14: string?, p15: string?) -- Line: 52
    -- upvalues: u2 (ref), Types (copy)
    u2:trackEconomy(p11, Types.EconomyFlow.SINK, p12, p13, p14, p15);
end;

function v1.gamepassPurchased(p16: table, p17: userdata, p18: string, p19: number, p20: string?) -- Line: 69
    -- upvalues: u2 (ref), Types (copy)
    u2:trackBusiness(p17, Types.BusinessType.GAMEPASS, p18, p19, p20);
end;

function v1.devProductPurchased(p21: table, p22: userdata, p23: string, p24: number, p25: string?) -- Line: 81
    -- upvalues: u2 (ref), Types (copy)
    u2:trackBusiness(p22, Types.BusinessType.DEV_PRODUCT, p23, p24, p25);
end;

return v1;