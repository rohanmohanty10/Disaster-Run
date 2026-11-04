 
 

local AdService = game:GetService("AdService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Signal = require(ReplicatedStorage.Packages.Signal);
require(ReplicatedStorage.Shared.Utility.Effects);
local v1 = Knit.CreateController({
    Name = "VideoAdController",
    AdAvailabilityChanged = Signal.new()
});

function v1._checkAvailability(p2) -- Line: 14
    -- upvalues: AdService (copy)
    local success, result = pcall(function() -- Line: 15
        -- upvalues: AdService (ref)
        return AdService:GetAdAvailabilityNowAsync(Enum.AdFormat.RewardedVideo).AdAvailabilityResult;
    end);

    if success then
        success = result == Enum.AdAvailabilityResult.IsAvailable;
    end;

    if p2.AdAvailable ~= success then
        p2.AdAvailable = success;
        p2.AdAvailabilityChanged:Fire(p2.AdAvailable);
    end;

    if not success then
        task.delay(60, p2._checkAvailability, p2);
    end;
end;

function v1.ShowAd(p3) -- Line: 31
    p3.VideoAdService:ShowAd();
end;

function v1.KnitStart(u4) -- Line: 35
    -- upvalues: Knit (copy)
    u4.VideoAdService = Knit.GetService("VideoAdService");
    u4.AdAvailable = false;
    u4.VideoAdService.Eligible:Observe(function(p5) -- Line: 40
        -- upvalues: u4 (copy)
        if p5 then
            task.delay(60, u4._checkAvailability, u4);

            return;
        end;

        u4.AdAvailable = false;
        u4.AdAvailabilityChanged:Fire(false);
    end);
end;

return v1;