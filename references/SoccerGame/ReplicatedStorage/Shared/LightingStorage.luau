  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Packages.TableUtil);
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local Lighting = game:GetService("Lighting");

return {
    ResetColors = function() -- Line: 22, Name: ResetColors
        -- upvalues: Essentials (copy), Lighting (copy), TweenService (copy)
        local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        local InitialData = Essentials:GetInitialData(Lighting);

        if InitialData then
            for i, v in pairs(InitialData) do
                if i == "TimeOfDay" then
                    Lighting[i] = v;
                elseif Lighting[i] ~= v then
                    TweenService:Create(Lighting, TweenInfo_new_ret, {
                        [i] = v
                    }):Play();
                end;
            end;
        end;

        for _, child in Lighting:GetChildren() do
            local InitialData2 = Essentials:GetInitialData(child);

            if InitialData2 then
                local v1 = child;

                for i, v in pairs(InitialData2) do
                    if v1[i] ~= v then
                        TweenService:Create(v1, TweenInfo_new_ret, {
                            [i] = v
                        }):Play();
                    end;
                end;
            end;
        end;
    end
};