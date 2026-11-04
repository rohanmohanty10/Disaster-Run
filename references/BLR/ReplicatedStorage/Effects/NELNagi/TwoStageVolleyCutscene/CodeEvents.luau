  

local u3 = {
    { 104, function() -- Line: 1
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local IsagiEmit = workspace:FindFirstChild("VFX").IsagiEmit;
            VfxManager.Emit(IsagiEmit);
        end },
    { 272, function() -- Line: 6
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local Step3 = workspace:FindFirstChild("VFX").Step3;
            VfxManager.Emit(Step3);
        end },
    { 362, function() -- Line: 11
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local IsagiEmit = workspace:FindFirstChild("VFX").IsagiEmit;
            VfxManager.Emit(IsagiEmit);
        end },
    { 367, function() -- Line: 16
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local Step1 = workspace:FindFirstChild("VFX").Step1;
            VfxManager.Emit(Step1);
        end },
    { 383, function() -- Line: 21
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local Step2 = workspace:FindFirstChild("VFX").Step2;
            VfxManager.Emit(Step2);
        end },
    { 414, function() -- Line: 26
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local Lines = workspace:FindFirstChild("VFX").Lines;
            VfxManager.Emit(Lines);
        end },
    { 417, function() -- Line: 31
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local Fake = workspace:FindFirstChild("VFX").Fake;
            VfxManager.Emit(Fake);
        end },
    { 499, function() -- Line: 36
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local BG2 = workspace:FindFirstChild("VFX").BG2;
            VfxManager.Emit(BG2);
        end },
    { 553, function() -- Line: 41
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local v1 = workspace:FindFirstChild("VFX")["1"];
            VfxManager.Emit(v1);
        end },
    { 626, function() -- Line: 46
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local v2 = workspace:FindFirstChild("VFX")["2"];
            VfxManager.Emit(v2);
        end }
};

return function(u4) -- Line: 52
    -- upvalues: u3 (copy)
    task.spawn(function() -- Line: 53
        -- upvalues: u4 (copy), u3 (ref)
        local v5 = 0;

        while u4:IsPlaying() do
            local CurrentFrame = u4.CurrentFrame;

            for _, v in u3 do
                local v6 = v[1];
                local v7 = v[2];

                if v6 <= CurrentFrame and v5 < v6 then
                    task.spawn(v7);
                end;
            end;

            task.wait();
            v5 = CurrentFrame;
        end;
    end);
end;