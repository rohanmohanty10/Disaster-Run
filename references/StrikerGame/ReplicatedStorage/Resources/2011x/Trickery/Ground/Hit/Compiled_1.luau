 
 

local Part_Icles = require(game:GetService("ReplicatedStorage").Part_Icles);
local LocalPlayer = game:GetService("Players").LocalPlayer;

local function emit(...) -- Line: 4
    -- upvalues: LocalPlayer (copy), Part_Icles (copy)
    local v1 = LocalPlayer and LocalPlayer:FindFirstChild("setting");

    if v1 then
        v1 = v1:FindFirstChild("NoVFXAtAll");
    end;

    if v1 and v1.Value then
        return;
    end;

    for _, v in { ... } do
        Part_Icles:AbsoluteEmit(v);
    end;
end;

return {
    { 36, function(p2, p3, p4, p5) -- Line: 18
            -- upvalues: emit (copy)
            emit(p3.Victim.HIT);
        end },
    { 37, function(p6, p7, p8, p9) -- Line: 23
            -- upvalues: emit (copy)
            emit(p6.KICK);
        end },
    { 69, function(p10, p11, p12, p13) -- Line: 28
            -- upvalues: emit (copy)
            emit(p10.Fall);

            if p13 then
                emit(p10.VV);
            end;
        end },
    { 70, function(p14, p15, p16, p17) -- Line: 36
            -- upvalues: emit (copy)
            emit(p15.User.TP, p14["TP GLITCH"]);

            if p17 then
                emit(p16.Effect1);
            end;
        end },
    { 111, function(p18, p19, p20, p21) -- Line: 44
            -- upvalues: emit (copy)
            emit(p18.TpEffect);
        end },
    { 112, function(p22, p23, p24, p25) -- Line: 49
            -- upvalues: emit (copy)
            if p25 then
                emit(p22.VV, p24.Effect1);
            end;
        end },
    { 122, function(p26, p27, p28, p29) -- Line: 56
            -- upvalues: emit (copy)
            emit(p27.User.TP, p26["TP GLITCH"]);
        end },
    { 138, function(p30, p31, p32, p33) -- Line: 61
            -- upvalues: emit (copy)
            emit(p31.Victim.HIT2, p31.Victim.HIT);
        end },
    { 139, function(p34, p35, p36, p37) -- Line: 66
            -- upvalues: emit (copy)
            local Torso = p35.Victim.HIT.Adornee:FindFirstChild("Torso");

            if Torso then
                p34.BloodEndHit.Shock.CFrame = Torso.CFrame * CFrame.new(
                    0.000347137451171875,
                    0,
                    -0.00006771087646484375,
                    -0.9996241927146912,
                    0.020113814622163773,
                    0.01846534013748169,
                    -0.015504258684813976,
                    0.13837401568889618,
                    -0.990250825881958,
                    -0.02247738465666771,
                    -0.9901718497276306,
                    -0.13801349699497223
                );
            end;

            emit(p34.BloodEndHit);
        end }
};