  

 

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = nil;
Knit:OnStart():andThen(function() -- Line: 9
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("AdventureService");
end);
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u2 = {};
local u14 = {
    Destroy = function(p3) -- Line: 23, Name: Destroy
        p3.Destroyed = true;
        p3.Stepped:Disconnect();
        p3.Caravan:Destroy();
    end,

    GetCFrame = function(p4) -- Line: 28, Name: GetCFrame
        return p4.LastCFrame:Lerp(p4.TargetCFrame, p4.CFrameLerp);
    end,

    GetCaravanCFrame = function(p5) -- Line: 31, Name: GetCaravanCFrame
        -- upvalues: TweenService (copy)
        local v6 = p5:GetCFrame();

        return (v6 * CFrame.new(math.noise(p5.NoiseX1, p5.NoiseY1, p5.Time) * 0.3, math.noise(p5.NoiseX2, p5.NoiseY2, p5.Time), math.noise(p5.NoiseX3, p5.NoiseY3, p5.Time) * 0.3)):Lerp(v6 * CFrame.new(0, -4.5, 0), TweenService:GetValue(p5.DownLerp, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut));
    end,

    SetTargetCFrame = function(p7, p8) -- Line: 39, Name: SetTargetCFrame
        if p8 == p7.LastCFrame then
            return;
        end;

        p7.LastCFrame = p7.LastCFrame:Lerp(p7.TargetCFrame, p7.CFrameLerp);
        p7.TargetCFrame = p8;
        p7.CFrameLerp = 0;
    end,

    SetDowned = function(p9, p10) -- Line: 45, Name: SetDowned
        p9.Downed = p10;
    end,

    Initialize = function(u11) -- Line: 48, Name: Initialize
        -- upvalues: RunService (copy)
        if u11.Stepped then
            return;
        end;

        u11.Stepped = RunService.PreSimulation:Connect(function(p12) -- Line: 50
            -- upvalues: u11 (copy)
            local v13 = u11;
            v13.Time = v13.Time + p12;
            u11.CFrameLerp = math.min(u11.CFrameLerp + p12 * 2, 1);
            u11.DownLerp = math.clamp(u11.DownLerp + p12 * 2 * (u11.Downed and 1 or -1), 0, 1);
            u11.Caravan.CFrame = u11:GetCaravanCFrame();
        end);
    end
};
u14.__index = u14;

local function CaravanNew(p15, p16) -- Line: 60
    -- upvalues: u14 (copy)
    local v17 = {
        Caravan = nil,
        CFrameLerp = 1,
        Downed = false,
        DownLerp = 1,
        Stepped = nil,
        Time = 0,
        Destroyed = false,
        Id = p15,
        LastCFrame = p16,
        TargetCFrame = p16,
        NoiseX1 = math.random() * 10000,
        NoiseY1 = math.random() * 10000,
        NoiseX2 = math.random() * 10000,
        NoiseY2 = math.random() * 10000,
        NoiseX3 = math.random() * 10000,
        NoiseY3 = math.random() * 10000
    };
    setmetatable(v17, u14);

    return v17;
end;

local u30 = {
    [0] = function(p18, p19) -- Line: 90
        p18:SetTargetCFrame(p19);
    end,

    [1] = function(p20, p21) -- Line: 93
        p20:SetDowned(p21);
    end,

    [2] = function(p22, p23) -- Line: 96
        local v24 = p22.Caravan:FindFirstChild(p23);

        if v24 then
            v24:Play();
        end;
    end,

    [3] = function(p25, p26) -- Line: 100
        local v27 = p25.Caravan:FindFirstChild(p26);

        if v27 then
            v27:Stop();
        end;
    end,

    [4] = function(p28, p29) -- Line: 104
        p28.Caravan.BillboardGui.Clock.Text = p29;
    end
};

return function(u31, p32, ...) -- Line: 109
    -- upvalues: u2 (copy), CaravanNew (copy), PathShortcuts (copy), LocalPlayer (copy), u1 (ref), u30 (copy)
    local v33 = u2[u31];

    if v33 and v33.Destroyed then
        return;
    end;

    if p32 == nil then
        if v33 then
            v33:Destroy();
            task.delay(3, function() -- Line: 116
                -- upvalues: u2 (ref), u31 (copy)
                u2[u31] = nil;
            end);
        end;
    else
        if typeof(p32) == "CFrame" then
            if v33 then
                v33:SetTargetCFrame(p32);

                return;
            end;

            local v34 = CaravanNew(u31, p32);
            local v35 = PathShortcuts.ClientAssets.CaravanPayload:Clone();
            v34.Caravan = v35;
            v35.CFrame = v34:GetCaravanCFrame();
            v35.Parent = workspace.Effects;
            u2[u31] = v34;

            if ({ ... })[1] == LocalPlayer then
                local ProximityPrompt = Instance.new("ProximityPrompt");
                ProximityPrompt.Name = "CaravanPrompt";
                ProximityPrompt.ActionText = "Begin Caravan";
                ProximityPrompt.RequiresLineOfSight = false;
                ProximityPrompt.Parent = v35:FindFirstChildWhichIsA("Attachment", true);
                ProximityPrompt.Triggered:Connect(function() -- Line: 136
                    -- upvalues: ProximityPrompt (copy), u1 (ref)
                    ProximityPrompt:Destroy();
                    u1:StartCaravan();
                end);
            end;

            v34:Initialize();

            return;
        end;

        if v33 then
            if v33.Destroyed then
                return;
            end;

            local v36 = u30[p32];

            if v36 then
                v36(v33, ...);
            end;
        end;
    end;
end;