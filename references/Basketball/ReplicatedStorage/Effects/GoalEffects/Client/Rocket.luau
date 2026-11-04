 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Debris = workspace:FindFirstChild("Debris");
local _ = game.Players.LocalPlayer;

local function lerp(p1, p2, p3) -- Line: 13
    return p1 + (p2 - p1) * p3;
end;

local function QuadBezier(p4, p5, p6, p7) -- Line: 17
    local v8 = p5 + (p6 - p5) * p4;

    return v8 + (p6 + (p7 - p6) * p4 - v8) * p4;
end;

local function randNum(p9, p10) -- Line: 24
    return Random.new():NextNumber(p9, p10);
end;

return function(p11, p12) -- Line: 28
    -- upvalues: Debris (copy), VfxManager (copy), RunService (copy), randNum (copy)
    local CFrame2 = p12.CFrame;
    local u13 = 0;
    local u14 = CFrame2 * CFrame.new(0, Random.new():NextNumber(-0.5, 5) * 10, Random.new():NextNumber(-10, 10) * 10);
    local Position = (CFrame.lookAt(u14.Position:Lerp(CFrame2.Position, 0.25), CFrame2.Position) * CFrame.new(0, Random.new():NextNumber(-6, 6) * 10, 0)).Position;
    local u15 = script.Aim:Clone();
    u15.CFrame = CFrame2;
    u15.Parent = Debris;
    VfxManager.Enable(u15, true);
    local u16 = nil;
    u16 = RunService.Heartbeat:Connect(function(p17) -- Line: 41
        -- upvalues: u13 (ref), u14 (copy), Position (copy), CFrame2 (copy), u16 (ref), Debris (ref), VfxManager (ref), randNum (ref), RunService (ref), u15 (copy)
        u13 = u13 + p17 * 1.4;
        local v18 = u13;
        local Position2 = u14.Position;
        local v19 = Position;
        local v20 = Position2 + (v19 - Position2) * v18;
        local v21 = v20 + (v19 + (CFrame2.Position - v19) * v18 - v20) * v18;
        local v22 = u13 + 0.01;
        local Position3 = u14.Position;
        local v23 = Position;
        local v24 = Position3 + (v23 - Position3) * v22;
        local v25 = v24 + (v23 + (CFrame2.Position - v23) * v22 - v24) * v22;

        if u13 < 1 then
            u15.CFrame = CFrame.new(v21, v25);

            return;
        end;

        u16:Disconnect();
        local v26 = script.Release:Clone();
        v26.CFrame = CFrame2;
        v26.Parent = Debris;
        VfxManager.Emit(v26);
        VfxManager.DestroyEffect(v26, 3);

        for i = 1, 6 do
            local u27 = Random.new():NextNumber(1.5, 1.8);
            local u28 = 0;
            local u29 = CFrame2 * CFrame.new(Random.new():NextNumber(-50, -25), Random.new():NextNumber(15, 50), randNum(-50, 50));
            local u30 = CFrame2 * CFrame.new(0, Random.new():NextNumber(-10, 20), randNum(-20, 20));
            local Position4 = (CFrame.lookAt(u29.Position:Lerp(u30.Position, 0.25), u30.Position) * CFrame.new(Random.new():NextNumber(15, 30) * (i % 2 == 0 and 1 or -1), Random.new():NextNumber(0, 20), 0)).Position;
            local u31 = script.Travel:Clone();
            u31.CFrame = u29;
            u31.Parent = Debris;
            VfxManager.Enable(u31, true);
            local u32 = nil;
            u32 = RunService.Heartbeat:Connect(function(p33) -- Line: 69
                -- upvalues: u28 (ref), u27 (copy), u29 (copy), Position4 (copy), u30 (copy), u32 (ref), VfxManager (ref), u31 (copy), Debris (ref), i (copy), u15 (ref)
                u28 = u28 + p33 * u27;
                local v34 = u28;
                local Position5 = u29.Position;
                local v35 = Position4;
                local v36 = Position5 + (v35 - Position5) * v34;
                local v37 = v36 + (v35 + (u30.Position - v35) * v34 - v36) * v34;
                local v38 = u28 + 0.01;
                local Position6 = u29.Position;
                local v39 = Position4;
                local v40 = Position6 + (v39 - Position6) * v38;
                local v41 = v40 + (v39 + (u30.Position - v39) * v38 - v40) * v38;

                if u28 >= 1 then
                    u32:Disconnect();
                    VfxManager.Enable(u31, false);
                    VfxManager.DestroyEffect(u31, 3);
                    local v42 = script.Impact:Clone();
                    v42.CFrame = u31.CFrame;
                    v42.Parent = Debris;
                    VfxManager.Emit(v42);
                    VfxManager.DestroyEffect(v42, 3);

                    if i == 6 then
                        VfxManager.Enable(u15, false);
                        VfxManager.DestroyEffect(u15, 3);
                    end;
                else
                    u31.CFrame = CFrame.new(v37, v41);
                end;
            end);
            task.wait(0.15);
            local _ = i;
        end;
    end);
end;