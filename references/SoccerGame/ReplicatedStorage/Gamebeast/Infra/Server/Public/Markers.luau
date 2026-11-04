  

local v1 = {};
local Players = game:GetService("Players");
local EngagementMarkers = require(script.Parent.Parent.Modules.EngagementMarkers);
local PurchaseAnalytics = require(script.Parent.Parent.Modules.InternalMarkers.PurchaseAnalytics);

function v1.SendMarker(p2: table, p3: string, p4: any, p5: vector?) -- Line: 38
    -- upvalues: EngagementMarkers (copy)
    EngagementMarkers:FireMarker(p3, p4, {
        position = p5
    });
end;

function v1.SendPlayerMarker(p6: table, p7: userdata, p8: string, p9: any, p10: vector?) -- Line: 42
    -- upvalues: EngagementMarkers (copy)
    EngagementMarkers:FireMarker(p8, p9, {
        player = p7,
        position = p10
    });
end;

function v1.SendNewPurchaseGrantedMarker(p11: table, u12: table, u13: vector?) -- Line: 47
    -- upvalues: Players (copy), PurchaseAnalytics (copy)
    if not Players:GetPlayerByUserId(u12.PlayerId) then
        return false;
    end;

    task.spawn(function() -- Line: 52
        -- upvalues: PurchaseAnalytics (ref), u12 (copy), u13 (copy)
        PurchaseAnalytics:DevProductPurchased(true, u12.PlayerId, u12.ProductId, u13);
    end);
end;

function v1.OnMarkersFailed(p14: table, p15: function) -- Line: 57
    -- upvalues: EngagementMarkers (copy)
    return EngagementMarkers.MarkersFailed:Connect(p15);
end;

function v1.RetryFailedMarkersAsync(p16: table, p17: table) -- Line: 62
    -- upvalues: EngagementMarkers (copy)
    return EngagementMarkers:SendMarkers(p17);
end;

return v1;