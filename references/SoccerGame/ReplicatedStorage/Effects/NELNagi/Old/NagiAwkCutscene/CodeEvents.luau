  

local u4 = {
    { 18, function() -- Line: 1
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local v1 = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("CamVFX"):FindFirstChild("4");

            if v1 and v1:IsA("BasePart") then
                VfxManager.Emit(v1);
            end;
        end },
    { 219, function() -- Line: 11
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local v2 = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("CamVFX"):FindFirstChild("5");

            if v2 and v2:IsA("BasePart") then
                VfxManager.Emit(v2);
            end;
        end },
    { 221, function() -- Line: 21
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local View = workspace:FindFirstChild("VFX"):WaitForChild("CutsceneVFX"):WaitForChild("GeneralVFX"):WaitForChild("View");
            VfxManager.Emit(View);
        end },
    { 217, function() -- Line: 26
            local CutsceneVFX = workspace:FindFirstChild("VFX"):FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("CutsceneVFX folder NOT found  .");

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

            local function setBeamsEnabled(p3) -- Line: 50
                -- upvalues: BGBEAMS (copy)
                for _, descendant in ipairs(BGBEAMS:GetDescendants()) do
                    if descendant:IsA("Beam") then
                        descendant.Enabled = p3;
                    end;
                end;
            end;

            local function onMoonEvent() -- Line: 59
                -- upvalues: setBeamsEnabled (copy)
                print("Moon event triggered, enabling beams...");
                setBeamsEnabled(true);
                task.delay(4.37, function() -- Line: 62
                    -- upvalues: setBeamsEnabled (ref)
                    print("Disabling beams after", 4.37, "seconds");
                    setBeamsEnabled(false);
                end);
            end;

            print("Moon event triggered, enabling beams...");
            setBeamsEnabled(true);
            task.delay(4.37, function() -- Line: 62
                -- upvalues: setBeamsEnabled (copy)
                print("Disabling beams after", 4.37, "seconds");
                setBeamsEnabled(false);
            end);
        end },
    { 379, function() -- Line: 71
            local WindBeamz = workspace:FindFirstChild("VFX"):FindFirstChild("WindBeamz");

            if not WindBeamz then
                warn("WindBeamz not found !");

                return;
            end;

            for _, child in ipairs(WindBeamz:GetChildren()) do
                if child:IsA("Beam") then
                    child.Enabled = true;
                end;
            end;

            task.wait(3);

            for _, child in ipairs(WindBeamz:GetChildren()) do
                if child:IsA("Beam") then
                    child.Enabled = false;
                end;
            end;
        end }
};

return function(u5) -- Line: 93
    -- upvalues: u4 (copy)
    task.spawn(function() -- Line: 94
        -- upvalues: u5 (copy), u4 (ref)
        local v6 = 0;

        while u5:IsPlaying() do
            local CurrentFrame = u5.CurrentFrame;

            for _, v in u4 do
                local v7 = v[1];
                local v8 = v[2];

                if v7 <= CurrentFrame and v6 < v7 then
                    task.spawn(v8);
                end;
            end;

            task.wait();
            v6 = CurrentFrame;
        end;
    end);
end;