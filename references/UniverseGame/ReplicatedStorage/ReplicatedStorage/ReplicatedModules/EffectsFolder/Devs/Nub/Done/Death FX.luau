  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local Sound = Instance.new("Sound");

local function createsound(p2, p3) -- Line: 3
    -- upvalues: Sound (copy)
    local v4 = Sound:Clone();

    for i, v in pairs(p3) do
        v4[i] = v;
    end;

    v4.SoundId = "rbxassetid://" .. p2;

    return v4;
end;

return function(p5, p6, p7) -- Line: 11
    -- upvalues: u1 (copy), Sound (copy)
    if p5:IsA("Player") then
        p5 = p5.Character or p5;
    end;

    local _ = u1.DeathAssets;
    local v8 = p5:FindFirstChild("Stand") and p5.Stand:FindFirstChild("StandHumanoidRootPart");
    p5.HumanoidRootPart.Anchored = true;
    local DeathSound = p5.HumanoidRootPart:FindFirstChild("DeathSound");

    if DeathSound then
        v8 = DeathSound;
    elseif v8 then
        v8 = v8:FindFirstChild("DeathSound");
    end;

    if v8 then
        v8:Play();
    end;

    if p6 then
        local v9 = p5:GetChildren();

        for i = 1, #v9 do
            if v9[i]:IsA("BasePart") then
                v9[i].CanCollide = v9[i].Transparency < 0.9;

                if v9[i]:FindFirstChild("FakeAvatarObject") then
                    v9[i].FakeAvatarObject.CanCollide = true;
                end;
            elseif v9[i]:IsA("Accessory") and v9[i]:FindFirstChildWhichIsA("Part", true) then
                v9[i]:FindFirstChildWhichIsA("Part", true).CanCollide = true;
            end;
        end;

        return;
    end;

    local v10 = {
        Volume = 5,
        Parent = p5.HumanoidRootPart
    };
    local v11 = Sound:Clone();

    for i, v in pairs(v10) do
        v11[i] = v;
    end;

    v11.SoundId = "rbxassetid://" .. 2892218731;
    v11:Play();
    wait(1.5);
    local v12 = {
        Volume = 1,
        Parent = p5.HumanoidRootPart
    };
    local v13 = Sound:Clone();

    for i, v in pairs(v12) do
        v13[i] = v;
    end;

    v13.SoundId = "rbxassetid://" .. 6883696417;
    v13:Play();
end;