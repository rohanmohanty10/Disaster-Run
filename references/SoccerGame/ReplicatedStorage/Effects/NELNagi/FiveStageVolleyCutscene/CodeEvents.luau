  

local u18 = {
    { 56, function() -- Line: 1
            local TweenService = game:GetService("TweenService");
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local v1 = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("GeneralVFX"):WaitForChild("Trap 1");
            VfxManager.Emit(v1);

            for _, descendant in ipairs(v1:GetDescendants()) do
                if descendant:IsA("Beam") and (descendant.Attachment0 and descendant.Attachment1) then
                    descendant.Enabled = true;
                    local Color3Value = Instance.new("Color3Value");
                    Color3Value.Value = Color3.fromRGB(240, 240, 240);
                    Color3Value:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 15
                        -- upvalues: Color3Value (copy), descendant (copy)
                        local Value = Color3Value.Value;
                        descendant.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Value), ColorSequenceKeypoint.new(1, Value) });
                    end);
                    TweenService:Create(Color3Value, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Value = Color3.new(0, 0, 0)
                    }):Play();
                    descendant.TextureSpeed = 6;
                    local v2 = TweenService:Create(descendant, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        TextureSpeed = 3
                    });
                    local u3 = TweenService:Create(descendant, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        TextureSpeed = 0
                    });
                    v2:Play();
                    v2.Completed:Connect(function() -- Line: 37
                        -- upvalues: u3 (copy)
                        u3:Play();
                    end);
                    task.delay(1, function() -- Line: 41
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end },
    { 60, function() -- Line: 47
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local Thought = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("GeneralVFX"):WaitForChild("Thought");
            VfxManager.Emit(Thought);
        end },
    { 143, function() -- Line: 52
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local BG5 = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("GeneralVFX"):WaitForChild("BG5");
            VfxManager.Emit(BG5);
        end },
    { 165, function() -- Line: 57
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local NagiBreathe = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("GeneralVFX"):WaitForChild("NagiBreathe");
            VfxManager.Emit(NagiBreathe);
        end },
    { 274, function() -- Line: 62
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local Step = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("GeneralVFX"):WaitForChild("Step");
            VfxManager.Emit(Step);
        end },
    { 325, function() -- Line: 67
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local v4 = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("GeneralVFX"):WaitForChild("Grass Emit");
            VfxManager.Emit(v4);
        end },
    { 336, function() -- Line: 72
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local BG1 = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("GeneralVFX"):WaitForChild("BG1");
            VfxManager.Emit(BG1);
        end },
    { 476, function() -- Line: 77
            local TweenService = game:GetService("TweenService");
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local v5 = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("GeneralVFX"):WaitForChild("Trap 2");
            VfxManager.Emit(v5);

            for _, descendant in ipairs(v5:GetDescendants()) do
                if descendant:IsA("Beam") and (descendant.Attachment0 and descendant.Attachment1) then
                    descendant.Enabled = true;
                    local Color3Value = Instance.new("Color3Value");
                    Color3Value.Value = Color3.fromRGB(240, 240, 240);
                    Color3Value:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 91
                        -- upvalues: Color3Value (copy), descendant (copy)
                        local Value = Color3Value.Value;
                        descendant.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Value), ColorSequenceKeypoint.new(1, Value) });
                    end);
                    TweenService:Create(Color3Value, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Value = Color3.new(0, 0, 0)
                    }):Play();
                    descendant.TextureSpeed = 6;
                    local v6 = TweenService:Create(descendant, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        TextureSpeed = 3
                    });
                    local u7 = TweenService:Create(descendant, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        TextureSpeed = 0
                    });
                    v6:Play();
                    v6.Completed:Connect(function() -- Line: 113
                        -- upvalues: u7 (copy)
                        u7:Play();
                    end);
                    task.delay(1, function() -- Line: 117
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end },
    { 577, function() -- Line: 123
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local NagiBreathe = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("GeneralVFX"):WaitForChild("NagiBreathe");
            VfxManager.Emit(NagiBreathe);
        end },
    { 718, function() -- Line: 128
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local Kick1 = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("GeneralVFX"):WaitForChild("Kick1");
            VfxManager.Emit(Kick1);
        end },
    { 807, function() -- Line: 133
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local v8 = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("GeneralVFX"):WaitForChild("Rose Summon");
            VfxManager.Emit(v8);
        end },
    { 837, function() -- Line: 138
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local v9 = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("GeneralVFX"):WaitForChild("Rose Summon2");
            VfxManager.Emit(v9);
        end },
    { 840, function() -- Line: 143
        end },
    { 1022, function() -- Line: 146
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local BG1 = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("GeneralVFX"):WaitForChild("BG1");
            VfxManager.Emit(BG1);
        end },
    { 1208, function() -- Line: 151
            local TweenService = game:GetService("TweenService");
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local v10 = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("GeneralVFX"):WaitForChild("Trap 3");
            VfxManager.Emit(v10);

            for _, descendant in ipairs(v10:GetDescendants()) do
                if descendant:IsA("Beam") and (descendant.Attachment0 and descendant.Attachment1) then
                    descendant.Enabled = true;
                    local Color3Value = Instance.new("Color3Value");
                    Color3Value.Value = Color3.fromRGB(240, 240, 240);
                    Color3Value:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 165
                        -- upvalues: Color3Value (copy), descendant (copy)
                        local Value = Color3Value.Value;
                        descendant.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Value), ColorSequenceKeypoint.new(1, Value) });
                    end);
                    TweenService:Create(Color3Value, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Value = Color3.new(0, 0, 0)
                    }):Play();
                    descendant.TextureSpeed = 6;
                    local v11 = TweenService:Create(descendant, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        TextureSpeed = 3
                    });
                    local u12 = TweenService:Create(descendant, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        TextureSpeed = 0
                    });
                    v11:Play();
                    v11.Completed:Connect(function() -- Line: 187
                        -- upvalues: u12 (copy)
                        u12:Play();
                    end);
                    task.delay(1, function() -- Line: 191
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end },
    { 1304, function() -- Line: 197
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local Step1 = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("GeneralVFX"):WaitForChild("Step1");
            VfxManager.Emit(Step1);
        end },
    { 1320, function() -- Line: 202
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local Step2 = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("GeneralVFX"):WaitForChild("Step2");
            VfxManager.Emit(Step2);
        end },
    { 1344, function() -- Line: 207
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local Step3 = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("GeneralVFX"):WaitForChild("Step3");
            VfxManager.Emit(Step3);
        end },
    { 1351, function() -- Line: 212
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local BG3 = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("GeneralVFX"):WaitForChild("BG3");
            VfxManager.Emit(BG3);
        end },
    { 1537, function() -- Line: 217
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local View = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("GeneralVFX"):WaitForChild("View");
            VfxManager.Emit(View);
        end },
    { 1765, function() -- Line: 222
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local Kick2 = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("GeneralVFX"):WaitForChild("Kick2");
            VfxManager.Emit(Kick2);
        end },
    { 475, function() -- Line: 227
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CamVFX = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("CamVFX");

            for _, v in ipairs({ "1", "2", "3" }) do
                local v13 = CamVFX:FindFirstChild(v);

                if v13 and v13:IsA("BasePart") then
                    VfxManager.Emit(v13);
                end;
            end;
        end },
    { 625, function() -- Line: 240
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local v14 = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("CamVFX"):FindFirstChild("4");

            if v14 and v14:IsA("BasePart") then
                VfxManager.Emit(v14);
            end;
        end },
    { 1111, function() -- Line: 250
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local v15 = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("CamVFX"):FindFirstChild("5");

            if v15 and v15:IsA("BasePart") then
                VfxManager.Emit(v15);
            end;
        end },
    { 1382, function() -- Line: 260
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local v16 = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("CamVFX"):FindFirstChild("6");

            if v16 and v16:IsA("BasePart") then
                VfxManager.Emit(v16);
            end;
        end },
    { 1384, function() -- Line: 270
            local CutsceneVFX = workspace:FindFirstChild("VFX"):FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("CutsceneVFX folder NOT found in Workspace.");

                return;
            end;

            local BGBEAMS = CutsceneVFX:FindFirstChild("BGBEAMS");

            if not BGBEAMS then
                warn("BGBEAMS folder NOT found under CutsceneVFX.");

                for _, child in ipairs(CutsceneVFX:GetChildren()) do
                    print("Found under CutsceneVFX:", child.Name);
                end;

                return;
            end;

            local function setBeamsEnabled(p17) -- Line: 294
                -- upvalues: BGBEAMS (copy)
                for _, descendant in ipairs(BGBEAMS:GetDescendants()) do
                    if descendant:IsA("Beam") then
                        descendant.Enabled = p17;
                    end;
                end;
            end;

            local function onMoonEvent() -- Line: 303
                -- upvalues: setBeamsEnabled (copy)
                print("Moon event triggered, enabling beams...");
                setBeamsEnabled(true);
                task.delay(2.37, function() -- Line: 306
                    -- upvalues: setBeamsEnabled (ref)
                    print("Disabling beams after", 2.37, "seconds");
                    setBeamsEnabled(false);
                end);
            end;

            print("Moon event triggered, enabling beams...");
            setBeamsEnabled(true);
            task.delay(2.37, function() -- Line: 306
                -- upvalues: setBeamsEnabled (copy)
                print("Disabling beams after", 2.37, "seconds");
                setBeamsEnabled(false);
            end);
        end }
};

return function(u19) -- Line: 316
    -- upvalues: u18 (copy)
    task.spawn(function() -- Line: 317
        -- upvalues: u19 (copy), u18 (ref)
        local v20 = 0;

        while u19:IsPlaying() do
            local CurrentFrame = u19.CurrentFrame;

            for _, v in u18 do
                local v21 = v[1];
                local v22 = v[2];

                if v21 <= CurrentFrame and v20 < v21 then
                    task.spawn(v22);
                end;
            end;

            task.wait();
            v20 = CurrentFrame;
        end;
    end);
end;