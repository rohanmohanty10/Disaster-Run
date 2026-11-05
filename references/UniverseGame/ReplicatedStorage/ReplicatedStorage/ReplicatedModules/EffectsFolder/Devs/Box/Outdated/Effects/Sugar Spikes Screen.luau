  

 

local u1 = {};
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u2 = game:GetService("ReplicatedStorage")["Client Assets"];
local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");

local function CreateInstance(p3, p4) -- Line: 7
    local function CheckProperty(p5, p6) -- Line: 9
        local _ = p5[p6];
    end;

    local u7 = Instance.new(p3);

    for i, v in pairs(p4) do
        if pcall(function() -- Line: 16
            -- upvalues: u7 (copy), i (copy)
            local _ = u7[i];
        end) then
            u7[i] = v;
        end;
    end;

    return u7;
end;

return function() -- Line: 26
    -- upvalues: u1 (copy), LocalPlayer (copy), u2 (copy), CreateInstance (copy), Debris (copy), TweenService (copy)
    if u1[LocalPlayer] then
        u1[LocalPlayer] = 5;

        return;
    end;

    u1[LocalPlayer] = 5;
    local u8 = u2["Candy Cutlass"].HotChocolate.CoffeeColor:Clone();
    u8.TintColor = Color3.fromRGB(218, 72, 74);
    u8.Parent = game.Lighting;
    local u9 = u2["Candy Cutlass"].HotChocolate.CoffeeBlur:Clone();
    u9.Parent = game.Lighting;
    local u10 = u2["Candy Cutlass"].CandySpikesScreen:Clone();
    u10.Parent = LocalPlayer.PlayerGui;
    local v11 = CreateInstance("Sound", {
        SoundId = "rbxassetid://8466469769",
        Volume = 1,
        Parent = workspace
    });
    v11:Play();
    Debris:AddItem(v11, 2);
    TweenService:Create(u10.Goop, TweenInfo.new(0.5), {
        ImageTransparency = 0
    }):Play();
    TweenService:Create(u10.Goop, TweenInfo.new(0.5), {
        Size = UDim2.new(1, 0, 1.004, 0)
    }):Play();
    coroutine.wrap(function() -- Line: 47
        -- upvalues: u1 (ref), LocalPlayer (ref)
        task.wait(0.05);

        while u1[LocalPlayer] ~= nil and (LocalPlayer.Character.Humanoid.Health > 0 and u1[LocalPlayer] > 0) do
            u1[LocalPlayer] = u1[LocalPlayer] - 0.05;
            task.wait(0.05);
        end;
    end)();
    coroutine.wrap(function() -- Line: 59
        -- upvalues: u1 (ref), LocalPlayer (ref), TweenService (ref), u8 (copy), u9 (copy), u10 (copy)
        repeat
            task.wait();
        until u1[LocalPlayer] <= 0 or (LocalPlayer == nil or (LocalPlayer.Character == nil or LocalPlayer.Character.Humanoid.Health <= 0));

        u1[LocalPlayer] = nil;
        TweenService:Create(u8, TweenInfo.new(0.5), {
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        TweenService:Create(u8, TweenInfo.new(0.5), {
            Contrast = 0
        }):Play();
        TweenService:Create(u9, TweenInfo.new(0.5), {
            Size = 0
        }):Play();
        TweenService:Create(u10.Goop, TweenInfo.new(0.5), {
            ImageTransparency = 1
        }):Play();
        task.wait(0.5);
        u8:Destroy();
        u9:Destroy();
        u10:Destroy();
    end)();
end;