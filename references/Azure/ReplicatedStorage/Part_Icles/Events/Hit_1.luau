 
 

local EventsCollision = require(script.Parent.Parent.EventsCollision);

return function(u1) -- Line: 8
    -- upvalues: EventsCollision (copy)
    function u1.afterUpdate(p2, p3, p4, p5) -- Line: 17
        -- upvalues: u1 (copy), EventsCollision (ref)
        if not (p3.Events and p3.Events.OnHit) then
            return;
        end;

        if p3._ownsOnHit then
            return;
        end;

        if p3._lastEffectiveDt and p3._lastEffectiveDt < 0 then
            p3.LastHitCheckPos = u1.getWorldPosition(p3);
            p3.LastHitCheckTime = p5;

            return;
        end;

        local WorldPosition = u1.getWorldPosition(p3);

        if not WorldPosition then
            return;
        end;

        if not p3.LastHitCheckPos then
            p3.LastHitCheckPos = WorldPosition;
            p3.LastHitCheckTime = p5;

            return;
        end;

        local v6 = p3.Events.OnHit.HitCheckInterval or 0;

        if v6 > 0 and (p5 - (p3.LastHitCheckTime or 0) < v6 and (WorldPosition - p3.LastHitCheckPos).Magnitude <= (p3._sleepRadius or 1)) then
            return;
        end;

        local LastHitCheckPos = p3.LastHitCheckPos;
        local v7 = p5 - (p3.LastHitCheckTime or p5);
        local v8 = v7 <= 0 and 0.016666666666666666 or v7;
        local v9 = WorldPosition - LastHitCheckPos;

        if v9.Magnitude > 0.05 then
            local v10 = workspace:Raycast(LastHitCheckPos, v9, p3.HitParams);

            if v10 then
                if not p3._hitFired then
                    local v11 = u1.makePayload(p2, p3, "OnHit", nil);
                    v11.HitInstance = v10.Instance;
                    v11.Other = v10.Instance;
                    v11.HitPosition = v10.Position;
                    v11.HitNormal = v10.Normal;
                    u1.fire(p2, p3, "OnHit", p3.EventChainCtx, v11);

                    if EventsCollision.handle(p2, p3, v10, v9, v8) == "snap" then
                        return;
                    end;
                end;
            elseif not p3._collisionStopped then
                p3._hitFired = false;
            end;

            p3.LastHitCheckPos = WorldPosition;
            p3.LastHitCheckTime = p5;
        end;
    end;
end;