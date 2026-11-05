  

 

local v1 = {};
local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local Core = require(ReplicatedRoot.Core);
require(ReplicatedRoot.Libraries.Classes.Trove);
require(ReplicatedRoot.Libraries.Classes.Promise);
local TableUtil = require(ReplicatedRoot.Libraries.Utility.TableUtil);
local TagService = require(ReplicatedRoot.Services.TagService);
require(ReplicatedRoot.Services.StateService);
require(ReplicatedRoot.Services.SequenceService);

if not Core.Flags.UseNewMeter then
    return v1;
end;

function v1.Init(u2) -- Line: 21
    -- upvalues: TableUtil (copy), TagService (copy)
    function u2.GetMeter(p3) -- Line: 23
        return p3:GetAttribute("URF") and (1 / 0) or p3:GetAttribute("Meter");
    end;

    function u2.GetMaxMeter(p4) -- Line: 27
        return p4:GetAttribute("URF") and (1 / 0) or p4:GetAttribute("MaxMeter");
    end;

    function u2.MeterToLevel(p5) -- Line: 31
        local v6 = math.floor(p5 / 10);

        return math.max(0, v6);
    end;

    function u2.LevelToMeter(p7) -- Line: 35
        return math.max(0, p7 * 10);
    end;

    function u2.GetMeterLevel(p8) -- Line: 39
        -- upvalues: u2 (copy)
        if p8:GetAttribute("URF") then
            return (1 / 0);
        end;

        if not p8:GetAttribute("Experimental") then
            return p8:GetAttribute("MeterLevel");
        end;

        local v9 = u2.GetMeter(p8);
        local v10 = u2.GetMaxMeter(p8);

        return u2.MeterToLevel((math.clamp(v9, 0, v10)));
    end;

    function u2.GetMeterFromLevel(p11, p12) -- Line: 52
        -- upvalues: u2 (copy)
        if p11:GetAttribute("Experimental") then
            local v13 = p12 or u2.GetMeterLevel(p11);

            return u2.LevelToMeter(v13);
        end;

        local v14 = u2.GetMaxMeter(p11);
        local v15 = p12 or p11:GetAttribute("MeterLevel");
        local v16 = v14 * (math.clamp(v15, 0, 4) / 4);

        return p11:GetAttribute("URF") and (1 / 0) or v16;
    end;

    function u2.GetMeterScale(p17, p18, p19) -- Line: 66
        -- upvalues: TableUtil (ref), u2 (copy), TagService (ref)
        local v20 = p18 or {};

        if p19 then
            TableUtil.Reconcile(p19, v20);
        end;

        local v21 = v20.IgnoreExternal or false;
        local v22 = v20.IgnoreTraits or v21;
        local v23 = v20.IgnoreTags or v21;
        local v24 = u2.GetTraitInfo(p17, v20);
        local v25 = TagService.GetContainer(p17);
        local ExternalScaleValue = v20.ExternalScaleValue;
        local v26 = v20.ExternalScaleModifier or 1;
        local v27 = v20.Type or "MeterTrait";
        local v28 = v20.TraitScaleValue or ExternalScaleValue;
        local v29 = v20.TraitScaleModifier or v26;
        local v30 = v20.TagScaleValue or ExternalScaleValue;
        local v31 = v20.TagScaleModifier or v26;
        local v32 = 1;
        local v33 = 1;

        if v23 ~= true and v25 then
            local v34 = TagService.CalculateTagTotal(v25, v30, 1);

            if v34 then
                v33 = v33 * math.lerp(0, v34, v31);
            end;
        end;

        if v22 ~= true then
            local v35 = u2.GetTraitValues(p17, {
                Trait = v24.Trait,
                Hexed = v24.Hexed,
                Type = v27
            })[v28];

            if v35 then
                v32 = v32 * math.lerp(0, v35, v29);
            end;
        end;

        return 1 - (2 - (v32 + v33));
    end;

    function u2.ValidateMeter(p36, p37, p38) -- Line: 114
        -- upvalues: TableUtil (ref), u2 (copy)
        local v39 = p37 or {};

        if p38 then
            TableUtil.Reconcile(p38, v39);
        end;

        local v40 = v39.CurrentMeter or (p36 and (u2.GetMeter(p36) or 0) or 0);
        local v41 = v39.RequiredMeter or (v39.RequiredAmount or 0);
        local v42 = v39.RequiredLevel or 0;
        local v43 = math.max(v41, u2.LevelToMeter(v42)) * u2.GetMeterScale(p36, {
            ExternalScaleValue = "MeterLoss"
        }, v39);
        local v44 = v40 >= v43;
        local v45 = {
            Additive = false,
            Meter = nil,
            IgnoreExternal = true,
            Success = v44,
            Difference = v43 - v40,
            RequiredAmount = v43,
            RequiredMeter = v41,
            RequiredLevel = v42
        };

        if v44 and v43 ~= 0 then
            v45.Additive = true;
            v45.Meter = -v43;
        end;

        return v45;
    end;
end;

return v1;