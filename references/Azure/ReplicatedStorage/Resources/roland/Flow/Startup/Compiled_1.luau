 
 

local TweenService = game:GetService("TweenService");

local function setLights(p1, p2) -- Line: 3
    if not p1 then
        return;
    end;

    for _, descendant in p1:GetDescendants() do
        if descendant:IsA("Light") then
            descendant.Enabled = p2;
        end;
    end;
end;

return {
    { 0, function(p3, p4, p5, p6) -- Line: 16
            -- upvalues: setLights (copy)
            shared.vfx.emit(p3.Start);
            setLights(p3.Start.lights, true);
        end },
    { 40, function(p7, p8, p9, p10) -- Line: 23
            -- upvalues: TweenService (copy)
            for _, descendant in p7.Start.lights:GetDescendants() do
                if descendant:IsA("Light") and not descendant:GetAttribute("Dimming") then
                    local Brightness = descendant.Brightness;
                    descendant:SetAttribute("Dimming", true);
                    TweenService:Create(descendant, TweenInfo.new(0.45), {
                        Brightness = 0
                    }):Play();
                    task.delay(0.8, function() -- Line: 29
                        -- upvalues: descendant (copy), Brightness (copy)
                        descendant:SetAttribute("Dimming", nil);
                        descendant.Brightness = Brightness;
                    end);
                end;
            end;
        end },
    { 87, function(p11, p12, p13, p14) -- Line: 39
            -- upvalues: setLights (copy)
            shared.vfx.emit(p11.ClenchStart.box);
            setLights(p11.Start.lights, false);
        end },
    { 99, function(p15, p16, p17, p18) -- Line: 46
            shared.vfx.emit(p15.Clench);
        end },
    { 144, function(p19, p20, p21, p22) -- Line: 52
            shared.vfx.emit(p19.Angry);
        end },
    { 247, function(p23, p24, p25, p26) -- Line: 58
            -- upvalues: setLights (copy)
            shared.vfx.emit(p23.FootZoom);
            setLights(p23.FootZoom.lights, true);
        end },
    { 248, function(p27, p28, p29, p30) -- Line: 65
            shared.vfx.emit(p27.Steps["0"]);
        end },
    { 268, function(p31, p32, p33, p34) -- Line: 71
            shared.vfx.emit(p31.Steps["1"]);
        end },
    { 298, function(p35, p36, p37, p38) -- Line: 77
            shared.vfx.emit(p35.Steps["2"]);
        end },
    { 308, function(p39, p40, p41, p42) -- Line: 83
            -- upvalues: setLights (copy)
            shared.vfx.emit(p39.FootZoom);
            setLights(p39.FootZoom.lights, false);
            setLights(p39.Close2.lights, true);
        end },
    { 351, function(p43, p44, p45, p46) -- Line: 91
            -- upvalues: setLights (copy)
            setLights(p43.Close2.lights, false);
        end },
    { 352, function(p47, p48, p49, p50) -- Line: 97
            -- upvalues: setLights (copy)
            shared.vfx.emit(p47.End);
            setLights(p47.End.lights, true);
        end },
    { 420, function(p51, p52, p53, p54) -- Line: 104
            -- upvalues: setLights (copy)
            setLights(p51.End.lights, false);
        end }
};