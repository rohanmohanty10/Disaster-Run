 
 

local TypeRegistry = require(script.Parent.TypeRegistry);
local Events = require(script.Parent.Events);
local Pool = require(script.Parent.Pool);
local VisualHost = require(script.Parent.VisualHost);
local NestedScale = require(script.Parent.NestedScale);

return function(p1) -- Line: 13
    -- upvalues: Events (copy), VisualHost (copy), Pool (copy), NestedScale (copy), TypeRegistry (copy)
    function p1._isLiveRTAnimate(p2, p3) -- Line: 20
        if not p3.IsAnimate then
            return false;
        end;

        local Type = p3.Type;

        return (Type == "Part" or (Type == "Attachment" or (Type == "Beam" or (Type == "Model" or Type == "Highlight")))) and true or Type == "TrailEmitter";
    end;

    function p1._reclaimPData(p4, p5) -- Line: 26
        if p5._nestedAlive then
            p5._nestedAlive[1] = false;
        end;

        if p5._onReclaim then
            p5._onReclaim(p5);
        end;
    end;

    function p1._fireOnDeath(p6, p7) -- Line: 34
        -- upvalues: Events (ref)
        if p7.Events and (p7.Events.OnDeath and (not p7._killedManually or p7._fireOnDeathOverride)) then
            Events.fire(p6, p7, "OnDeath", p7.EventChainCtx, nil);
        end;
    end;

    function p1._fireOnDestruction(p8, p9, p10) -- Line: 42
        -- upvalues: Events (ref)
        if not (p9.Events and p9.Events.OnDestruction) then
            return;
        end;

        local v11 = p10 and p10.Parent or not p10 and Events.getWorldCF(p9) ~= nil;

        if v11 then
            Events.fire(p8, p9, "OnDestruction", p9.EventChainCtx, nil);
        end;
    end;

    function p1._releaseOrDestroy(p12, p13, p14) -- Line: 56
        -- upvalues: VisualHost (ref)
        p12:_releaseVisual(p13, p14);

        if p13._carrier then
            VisualHost.releaseCarrier(p13._carrier);
            p13._carrier = nil;
        end;
    end;

    function p1._releaseVisual(p15, u16, u17) -- Line: 64
        -- upvalues: Pool (ref), NestedScale (ref), TypeRegistry (ref)
        if u16._extraLights then
            for _, v in ipairs(u16._extraLights) do
                pcall(function() -- Line: 69
                    -- upvalues: v (copy)
                    v:Destroy();
                end);
            end;

            u16._extraLights = nil;
        end;

        if u16._impactDisk then
            pcall(function() -- Line: 74
                -- upvalues: u16 (copy)
                u16._impactDisk:Destroy();
            end);
            u16._impactDisk = nil;
        end;

        if p15:_isLiveRTAnimate(u16) then
            if u16.AnimateItem then
                p15:_cancelAnimation(u16.AnimateItem);
            end;

            return;
        end;

        if not u17 then
            return;
        end;

        if not u17.Parent then
            return;
        end;

        if u16.IsAnimate or (u16._noPool or not (u16._sourceRT and u16._poolKind)) then
            Pool.dropCloneMap(u17);
            pcall(function() -- Line: 85
                -- upvalues: u17 (copy)
                u17:Destroy();
            end);

            return;
        end;

        if u16._scaledContent then
            NestedScale.restore(u16._scaledContent);
        end;

        local v18 = nil;
        local _sourceItem = u16._sourceItem;

        if _sourceItem and _sourceItem.Parent then
            local Config = TypeRegistry.getConfig(_sourceItem);

            if Config then
                v18 = Config:GetAttribute("Rate");
            end;
        end;

        Pool.release(u17, u16._sourceRT, u16._poolKind, v18);
    end;
end;