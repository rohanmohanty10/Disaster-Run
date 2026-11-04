 
 

local RunService = game:GetService("RunService");
require(script.Parent.SharedTypes);

return {
    Nausea = {
        OnCreate = function(u1, p2) -- Line: 9, Name: OnCreate
            -- upvalues: RunService (copy)
            p2:AddConnection((RunService.RenderStepped:Connect(function(p3: number) -- Line: 10
                -- upvalues: u1 (copy)
                local os_clock_ret = os.clock();
                local v4 = math.sin(os_clock_ret) / 4;
                local os_clock_ret2 = os.clock();
                local v5 = math.cos(os_clock_ret2) / 4;
                local v6 = os.clock() * 1.25;
                local v7 = math.sin(v6) / 10 + 1;
                local v8 = os.clock() * 1.25;
                local v9 = math.cos(v8) / 10 + 1;
                local os_clock_ret3 = os.clock();
                local v10 = math.sin(os_clock_ret3) / 6;
                local os_clock_ret4 = os.clock();
                local v11 = math.cos(os_clock_ret4) / 6;
                u1:SetShear(v4, v5);
                u1:SetScale(v7, v9);
                u1:SetStretch(v10, v11);
            end)));
        end,

        OnDestroying = function() -- Line: 28, Name: OnDestroying
        end
    },
    IntenseShake = {
        DistortionParams = {
            EaseTime = 0
        },

        OnCreate = function(u12, p13) -- Line: 38, Name: OnCreate
            -- upvalues: RunService (copy)
            p13:AddConnection((RunService.RenderStepped:Connect(function(p14: number) -- Line: 39
                -- upvalues: u12 (copy)
                u12:SetTranslation(math.random(-100, 100) / 10000, math.random(-100, 100) / 10000);
            end)));
        end,

        OnDestroying = function() -- Line: 51, Name: OnDestroying
        end
    },
    Invert = {
        OnCreate = function(p15, p16) -- Line: 57, Name: OnCreate
            p15:SetScale(-1, 1);
        end
    },
    DollyZoom = {
        DistortionParams = {
            EaseTime = 0
        },

        OnCreate = function(u17, p18) -- Line: 67, Name: OnCreate
            -- upvalues: RunService (copy)
            p18:AddConnection((RunService.RenderStepped:Connect(function(p19: number) -- Line: 68
                -- upvalues: u17 (copy)
                local os_clock_ret = os.clock();
                local v20 = 1 - (math.sin(os_clock_ret) / 3 + 0.3333333333333333);
                u17.Camera.FieldOfView = (1 - v20) * 50 + 70;
                u17:SetZoom(v20);
            end)));
        end
    },
    ExtremeFOV = {
        DistortionParams = {
            EaseTime = 0.2
        },

        OnCreate = function(p21, p22) -- Line: 85, Name: OnCreate
            p21.Camera.FieldOfView = 120;
            p21:SetScale(0.25, 0.25);
        end
    }
};