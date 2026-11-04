 
 

local v1 = {};
game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;

({}).Trash = function(u2, p3) -- Line: 8, Name: Trash
    task.delay(p3 or 1, function() -- Line: 9
        -- upvalues: u2 (copy)
        pcall(game.Destroy, u2);
    end);
end;

local script_ScreenFlip = require(script.ScreenFlip);

local function emit(p4) -- Line: 15
    for _, v in p4:QueryDescendants("ParticleEmitter") do
        v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
    end;
end;

local function enable(p5, p6) -- Line: 20
    for _, v in p5:QueryDescendants("ParticleEmitter, Beam, Trail, SurfaceLight, SpotLight, PointLight") do
        v.Enabled = true;
        task.delay(p6, function() -- Line: 23
            -- upvalues: v (copy)
            v.Enabled = false;
        end);
    end;
end;

function v1.template(p7: table) -- Line: 27
    p7.Character:FindFirstChild("HumanoidRootPart");
end;

function v1.Comp2(p8: table) -- Line: 33
    -- upvalues: enable (copy)
    game:GetService("Lighting");
    local HumanoidRootPart = p8.Character:FindFirstChild("HumanoidRootPart");
    local u9 = script.VFX.LightComp2:Clone();
    u9:PivotTo(HumanoidRootPart.CFrame);
    u9.Parent = HumanoidRootPart;
    enable(u9, 1.8);
    task.delay(1.8, function() -- Line: 9
        -- upvalues: u9 (copy)
        pcall(game.Destroy, u9);
    end);
end;

function v1.Comp1(p10: table) -- Line: 47
    -- upvalues: enable (copy), LocalPlayer (copy), script_ScreenFlip (copy)
    game:GetService("Lighting");
    local HumanoidRootPart = p10.Character:FindFirstChild("HumanoidRootPart");
    local u11 = script.VFX.LightComp1:Clone();
    u11:PivotTo(HumanoidRootPart.CFrame);
    u11.Parent = HumanoidRootPart;
    enable(u11, 3);
    task.delay(3, function() -- Line: 9
        -- upvalues: u11 (copy)
        pcall(game.Destroy, u11);
    end);
    task.spawn(function() -- Line: 56
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Parent = game.Lighting;
        ColorCorrectionEffect.Name = "CCEffect";
        ColorCorrectionEffect.Enabled = true;
        ColorCorrectionEffect.Contrast = 0.1;
        ColorCorrectionEffect.Brightness = -0.1;
        ColorCorrectionEffect.Saturation = -0.1;
        wait(2.2);
        game.TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Brightness = 0,
            Contrast = 0,
            Saturation = 0
        }):Play();
        task.delay(3, function() -- Line: 9
            -- upvalues: ColorCorrectionEffect (copy)
            pcall(game.Destroy, ColorCorrectionEffect);
        end);
    end);
    task.spawn(function() -- Line: 69
        -- upvalues: LocalPlayer (ref), script_ScreenFlip (ref)
        local v12 = LocalPlayer.PlayerGui:FindFirstChild("ScreenGui"):FindFirstChildWhichIsA("ImageLabel");
        script_ScreenFlip.ScreenFlip(v12, { "rbxassetid://88304304622500", "rbxassetid://133210737125726", "rbxassetid://139891343843826", "rbxassetid://83347812156437", "rbxassetid://73609435024272", "rbxassetid://135670191570230", "rbxassetid://97661303623404", "rbxassetid://101289804867945", "rbxassetid://115393204096459", "rbxassetid://73467965160370", "rbxassetid://88487757292530", "rbxassetid://104022364024895", "rbxassetid://92161812101790", "rbxassetid://133755047319122", "rbxassetid://112372307289847", "rbxassetid://138918488402548" }, 0.015);
    end);
    local TweenService = game:GetService("TweenService");
    local u13 = script.VFX.Comp1:Clone();
    u13:PivotTo(HumanoidRootPart.CFrame);
    u13.Parent = HumanoidRootPart;
    enable(u13, 2.834);
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Parent = u13;
    local u14 = {};
    local u15 = {};

    for _, descendant in u13:GetDescendants() do
        if descendant:IsA("Beam") then
            descendant.Enabled = true;
            local Keypoints = descendant.Transparency.Keypoints;
            u14[descendant] = Keypoints[math.ceil(#Keypoints / 2)].Value;
            local v17 = NumberValue.Changed:Connect(function(p16) -- Line: 121
                -- upvalues: u14 (copy), descendant (copy)
                descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, u14[descendant] + (1 - u14[descendant]) * p16), NumberSequenceKeypoint.new(1, 1) });
            end);
            table.insert(u15, v17);
        end;
    end;

    NumberValue.Value = 0;
    task.wait(0.8);
    local v18 = TweenService:Create(NumberValue, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Value = 1
    });
    v18:Play();
    v18.Completed:Connect(function() -- Line: 137
        -- upvalues: u15 (copy), NumberValue (copy), u13 (copy)
        task.wait(1);

        for _, v in u15 do
            v:Disconnect();
        end;

        NumberValue:Destroy();

        for _, descendant in u13:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(3, function() -- Line: 9
        -- upvalues: u13 (copy)
        pcall(game.Destroy, u13);
    end);
end;

function v1.Shine(p19: table) -- Line: 153
    -- upvalues: emit (copy)
    local HumanoidRootPart = p19.Character:FindFirstChild("HumanoidRootPart");
    local u20 = script.VFX.Shine:Clone();
    u20.Parent = HumanoidRootPart;
    u20:PivotTo(HumanoidRootPart.CFrame);
    emit(u20);
    task.delay(3, function() -- Line: 9
        -- upvalues: u20 (copy)
        pcall(game.Destroy, u20);
    end);
end;

return v1;