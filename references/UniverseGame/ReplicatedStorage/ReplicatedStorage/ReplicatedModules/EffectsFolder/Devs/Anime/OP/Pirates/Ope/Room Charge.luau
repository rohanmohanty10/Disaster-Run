  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local _ = game:GetService("Players").LocalPlayer;
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
Random.new();

return function(p1) -- Line: 11
    -- upvalues: TweenService (copy), ParticleHandler (copy)
    local Pose = p1.Pose;
    local Character = p1.Character;
    local v2 = workspace.Effects:WaitForChild(Character.Name .. " Room", 5);

    if not (v2:IsDescendantOf(game) and v2:FindFirstChild("Weld")) then
        return;
    end;

    local v3 = 0;
    local C1 = v2.Weld.C1;
    local v4 = TweenService:Create(v2, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, (1 / 0), true), {
        Size = Vector3.new(0.875, 0.875, 0.875)
    });

    if not Pose then
        v4:Play();
        ParticleHandler.Emit(v2.Summon, ParticleHandler.GenerateEmitInfo(v2.Summon));
    end;

    while true do
        local v5 = task.wait();
        local v6 = v5 * 60;

        if v2:IsDescendantOf(game) then
            if v2:FindFirstChild("Rotate") then
                TweenService:Create(v2.Rotate.Weld, TweenInfo.new(v5, Enum.EasingStyle.Linear), {
                    C1 = v2.Rotate.Weld.C1 * CFrame.Angles(0, 0.07853981633974483 * v6, 0)
                }):Play();
            end;

            if v2:FindFirstChild("Weld") then
                v3 = v3 + 0.20943951023931953 * v6;
                TweenService:Create(v2.Weld, TweenInfo.new(v5, Enum.EasingStyle.Linear), {
                    C1 = C1 * CFrame.new(0, math.sin(v3) * 0.05, 0)
                }):Play();
            end;
        end;

        if not v2:IsDescendantOf(game) or (not Character:IsDescendantOf(game) or Character:GetAttribute("Room")) then
            v4:Cancel();

            if v2:IsDescendantOf(game) and v2:FindFirstChild("Summon") then
                v2:FindFirstChild("Summon"):Destroy();
            end;

            return;
        end;
    end;
end;