  

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;

return function(p1) -- Line: 6
    -- upvalues: LocalPlayer (copy), RunService (copy)
    local v2 = p1 or {};
    local Character = v2.Character;
    local u3 = v2.Range or 80;
    local u4 = v2.MinSpeed or 25;
    local u5 = v2.Cooldown or 1.4;
    local v6 = v2.Duration or 0;
    local v7 = v2.CheckRate or 0;

    if table.find(v2.Exclude or {}, LocalPlayer) then
        return;
    end;

    local Character2 = LocalPlayer.Character;

    if not Character2 then
        return;
    end;

    if Character2 == Character then
        return;
    end;

    local u8 = 0;
    local v9 = os.clock();

    local function TryWhizz() -- Line: 28
        -- upvalues: Character2 (ref), LocalPlayer (ref), Character (copy), u4 (copy), u3 (copy), u8 (ref), u5 (copy)
        Character2 = LocalPlayer.Character;

        if not Character2 then
            return;
        end;

        if Character2 == Character then
            return;
        end;

        local HumanoidRootPart = Character2:FindFirstChild("HumanoidRootPart");
        local v10 = Character and Character:FindFirstChild("HumanoidRootPart");

        if not (HumanoidRootPart and v10) then
            return;
        end;

        local AssemblyLinearVelocity = v10.AssemblyLinearVelocity;

        if AssemblyLinearVelocity.Magnitude < u4 then
            return;
        end;

        if u3 < (HumanoidRootPart.Position - v10.Position).Magnitude then
            return;
        end;

        if os.clock() - u8 < u5 then
            return;
        end;

        u8 = os.clock();
        local Unit = AssemblyLinearVelocity.Unit:Cross(Vector3.new(0, 1, 0)).Unit;
        local v11 = (HumanoidRootPart.Position - v10.Position):Dot(Unit) >= 0 and 1 or -1;
        local u12 = script.Whizz:Clone();
        u12.Position = HumanoidRootPart.Position + Unit * v11 * 5 + Vector3.new(0, 1.5, 0);
        u12.Parent = workspace.Effects;
        local v13 = u12:FindFirstChildOfClass("Sound");

        if not v13 then
            u12:Destroy();

            return;
        end;

        v13.RollOffMode = Enum.RollOffMode.Inverse;
        v13.RollOffMaxDistance = u3;
        v13.PlaybackSpeed = v13.PlaybackSpeed * (math.random(95, 115) / 100);
        v13:Play();
        task.delay(math.max(v13.TimeLength, 1) + 1, function() -- Line: 71
            -- upvalues: u12 (copy)
            if u12 then
                u12:Destroy();
            end;
        end);
    end;

    if v6 <= 0 then
        TryWhizz();

        return;
    end;

    local v14 = 0;

    while os.clock() - v9 < v6 do
        if v7 <= 0 or v7 <= os.clock() - v14 then
            v14 = os.clock();
            TryWhizz();
        end;

        RunService.Heartbeat:Wait();
    end;
end;