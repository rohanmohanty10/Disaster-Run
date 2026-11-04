  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local v1 = require(ReplicatedStorage.Packages.Knit).CreateController({
    Name = "BallVisibilityFix"
});

local function restoreVisible(p2) -- Line: 19
    if not p2 then
        return;
    end;

    if p2:IsA("BasePart") then
        p2.LocalTransparencyModifier = 0;
    end;
end;

local function fullyRestoreBall() -- Line: 26
    -- upvalues: ReplicatedStorage (copy)
    local Football = ReplicatedStorage:FindFirstChild("Football");

    if Football then
        Football = Football.Value;
    end;

    if not Football then
        return;
    end;

    if not Football:IsDescendantOf(workspace) then
        return;
    end;

    if Football:IsA("BasePart") then
        Football.LocalTransparencyModifier = 0;
        Football.Transparency = 0;
    end;

    local BallSkinBall = Football:FindFirstChild("BallSkinBall", true);

    if BallSkinBall then
        if BallSkinBall:IsA("BasePart") then
            BallSkinBall.LocalTransparencyModifier = 0;
            BallSkinBall.Transparency = 0;
        end;

        for _, descendant in BallSkinBall:GetDescendants() do
            if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                descendant.LocalTransparencyModifier = 0;

                if descendant.Transparency == 1 then
                    descendant.Transparency = 0;
                end;
            end;
        end;
    end;
end;

function v1.KnitStart(p3) -- Line: 54
    -- upvalues: ReplicatedStorage (copy), fullyRestoreBall (copy)
    local GameValues = ReplicatedStorage:FindFirstChild("GameValues");

    if GameValues then
        GameValues = GameValues:FindFirstChild("State");
    end;

    if not GameValues then
        return;
    end;

    GameValues:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 59
        -- upvalues: fullyRestoreBall (ref)
        task.defer(fullyRestoreBall);
    end);
    local Football = ReplicatedStorage:FindFirstChild("Football");

    if Football then
        Football:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 65
            -- upvalues: fullyRestoreBall (ref)
            task.defer(fullyRestoreBall);
        end);
    end;

    task.defer(fullyRestoreBall);
    task.spawn(function() -- Line: 78
        -- upvalues: Football (copy)
        while true do
            task.wait(0.5);
            local v4 = Football and Football.Value;

            if v4 and (v4:IsA("BasePart") and v4:IsDescendantOf(workspace)) then
                local OnPlayer = v4:FindFirstChild("OnPlayer");

                if not (OnPlayer and OnPlayer.Value) then
                    if v4.LocalTransparencyModifier > 0 then
                        print(string.format("[BALLDIAG F6] cleared stuck ball LTM=%.3f", v4.LocalTransparencyModifier));
                        v4.LocalTransparencyModifier = 0;
                    end;

                    local BallSkinBall = v4:FindFirstChild("BallSkinBall", true);

                    if BallSkinBall and (BallSkinBall:IsA("BasePart") and BallSkinBall.LocalTransparencyModifier > 0) then
                        print(string.format("[BALLDIAG F6] cleared stuck skin LTM=%.3f", BallSkinBall.LocalTransparencyModifier));
                        BallSkinBall.LocalTransparencyModifier = 0;
                    end;
                end;
            end;
        end;
    end);
end;

return v1;